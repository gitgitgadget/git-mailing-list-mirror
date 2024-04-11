Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C531E892
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857019; cv=none; b=G27AUIgxluskzDF7VUFtmPXPPjGHjLdZWpqxSiYtC3hY5yeDsVu8eO5kRaa78tD93cvEoyH0PC3R8GDivy92lo1ejy8eAUKsVgGozYb5XGeUbNnSdFnPhUgwodliZITjBldqyzNzcfflvFzUlLhH/YQoxlsRQUOavOr/LeR7pP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857019; c=relaxed/simple;
	bh=nrYKqRht0GSHZba4IpMRt7z5YeOSkiWYJxT9tLxJvRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNHwL2zIE34ZZGaaQ+wGXNN462+MrnTjupLVMoEFFi+GFfAEznkdMYXi2y64gVlpGB5WOuBdhvWc8ChBoLFG4gkJZu0p72C6ScpxuBMCzfN+yWbwIbpS/qfR5fEx5T6EgeL15RD+hedzyBHSi+D+bqj0QRtvQAACq4AFziASBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1ruyLy-0000so-81; Thu, 11 Apr 2024 20:36:50 +0300
From: Kipras Melnikovas <kipras@kipras.org>
To: wyattscarpenter@gmail.com
Cc: git@vger.kernel.org
Subject: Re: Short form of --force-with-lease
Date: Thu, 11 Apr 2024 20:36:40 +0300
Message-ID: <20240411173639.81152-2-kipras@kipras.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CADwVmK293eQ5VFkn-J68tXQ=64u3H79ScMW7H_ukSmtwLwA4wA@mail.gmail.com>
References: <CADwVmK293eQ5VFkn-J68tXQ=64u3H79ScMW7H_ukSmtwLwA4wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

I have also thought about this.

I'd suggest a config option "push.forceFlagBehavior" that would allow to
configure the behavior, one of:
- "default" / "overwrite", which is currently -f,
- "lease" for --force-with-lease,
- "lease-includes"  for --force-with-lease --force-if-includes,
- possibly others.

Then, upon `git push -f`, the config option would be consulted to determine the
behavior.

To get the default behavior, `-f -f` or `-F` could be used.

