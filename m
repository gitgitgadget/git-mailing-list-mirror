Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43C4B1E71
	for <git@vger.kernel.org>; Thu, 15 May 2025 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747287376; cv=none; b=HAS5iO9WDbdDj6UP4stN3v0rNOQTMUjngSWZcF0ZDX/E+xq+pO+SiGuJlZXc2s9GRTlc40lGeM6y9ss9NI/nBc3JP+MDXkCp0kjJ2Xy7Wj1NEzcqjMXGUeZT+9lgYtuuNJvHjPVKf/jFfZiVpag3Mdb00nQV4iNBbz/na2Kz88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747287376; c=relaxed/simple;
	bh=OmWxqtdlT62AxmGvePQruqhLnKShNykvKxXGovGL9/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOXoydM8ln2wsYwnQWPtRshtLbSHn+JOBt+pcWiHkkZsTfzDhDrhsHoJ4ajNiDaI4yii2ml42Zj7jkLCoxgwwBl+ifS2HDAaCd6iQhfLJo/0sN5z26sdO6QdyAFlZHnf+W6MFZSpbcDd3ZvpZ8jXVNQyFOJlJ9f+EnlNANa2wxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Zyf851dwkzRq22;
	Thu, 15 May 2025 07:36:04 +0200 (CEST)
Message-ID: <049648a9-5580-4214-bd00-c905127939b5@kdbg.org>
Date: Thu, 15 May 2025 07:36:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: do not end the commit message with an empty line
To: Junio C Hamano <gitster@pobox.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Gareth Fenn <garethfenn@gmail.com>, Git Mailing List <git@vger.kernel.org>
References: <ed1ca9fa-15f0-4601-be31-8a578c7fb788@kdbg.org>
 <xmqqv7q27v49.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqv7q27v49.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.25 um 23:14 schrieb Junio C Hamano:
> As git-gui uses plumbing commit-tree to create the
> commit object, it has to be more careful not to have extra blank
> lines, as it cannot assume stripspace internal to "git commit"?

Correct. We had used git stripspace for about a month, introduced by
b9a4386, reverted by c0698df. The reasons not to use it were old Tcl
versions and MacOS. We may revisit this case after we raise version
requirements.

-- Hannes

