Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65E1A9B4F
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739007494; cv=none; b=NstESx0NsCtKHARKcr355j7c5h+pZlET+KKhFpwWB3e+bAIudLRSdhYkYBd9ysi96/zflrywuwEDyYBvh3Wovb3V5t+TZOzMEA0p2mkcEtJX2ojHY+cYy+++E1q9FMUZ4i7ny+XwbCqi3mDTDPZdNW1mtirhXDQZVxkKljYptHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739007494; c=relaxed/simple;
	bh=LtJpE0ARPACKmbxEEIDsovyxGSuqUXkHP74Rp1ZBNjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e63vV4XpyLUgvCqzLgz0ccX/t9R3A8otLxMdLodWJR8PErvJZmGMCVMqMQwtsnXB1Qk/gmIEy23Mh4ZLnvRWTyJQI9tF9wmoyIb9+/NcDxcnyngcWko2BeqT1l9BfZ/zzjblXY89/tdMOr+7BMKTbTbh/lPm6ORwdXvIS86xMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4YqlsJ2HYZz1sB7f;
	Sat,  8 Feb 2025 10:29:08 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4YqlsJ257Dz1qqlS;
	Sat,  8 Feb 2025 10:29:08 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 5Ma4u5_3tzsy; Sat,  8 Feb 2025 10:28:58 +0100 (CET)
X-Auth-Info: c45JKX6IhmK+Cdqx5W5gwQ7QyFXfT10+vsiMCg5PhLtdjfKGcYU26feDjZnzqyVB
Received: from tiger.home (aftr-82-135-83-7.dynamic.mnet-online.de [82.135.83.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat,  8 Feb 2025 10:28:58 +0100 (CET)
Received: by tiger.home (Postfix, from userid 1000)
	id D7A8432F1FB; Sat,  8 Feb 2025 10:28:57 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Config timezone to prevent chaos when DST/changing timezone
In-Reply-To: <CANM0SV3DXQeNinmy1Spj7n6G=5s3jMcFrAb0Ayun6ago7F3qWw@mail.gmail.com>
	(Devste Devste's message of "Fri, 7 Feb 2025 23:02:19 +0100")
References: <CANM0SV3DXQeNinmy1Spj7n6G=5s3jMcFrAb0Ayun6ago7F3qWw@mail.gmail.com>
X-Yow: ..  Once upon a time, four AMPHIBIOUS HOG CALLERS attacked a family
 of DEFENSELESS, SENSITIVE COIN COLLECTORS and brought DOWN their
 PROPERTY VALUES!!
Date: Sat, 08 Feb 2025 10:28:57 +0100
Message-ID: <87seooss2u.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Feb 07 2025, Devste Devste wrote:

> With DST or manual timezone changes (e.g. travelling) you can end up
> with commits that are illogically sorted - newer commits have an
> author/committer date that is older than older commits.

The time stamps in commits are recorded in Universal Time, so neither
DST nor timezone changes (both are essentially equivalent) have an
influence on how the time stamp is interpreted as a point in time.

> There should be an easy way to force a specific timezone - or in
> absence of that at least force UTC - to prevent this

You can use --date=local to show all dates in your local time zone,
instead of the recorded time zone of the author/committer.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
