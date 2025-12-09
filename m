Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62E179A3
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765253030; cv=none; b=DqEae/GolXsfLTQxUOPG0yZLC8q5G6j8Zy8w9Yk6OtMyGY7kuFRasyBMAx2wgYKQeSjpdnuIFoTVFoWpa8rDv0P/NOQts9zoytbGzqY1dsBHm4d+vfAoVR2E5aCu+7g+M8pVAXUEnEzDbLQq7FuJ09w+1gOYUrfPus0/pZy9MXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765253030; c=relaxed/simple;
	bh=vn7qxWLIiFY9IxfNybreicRJME2KC4MJn0n63n1Lb0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FUC/vmEzFaIu1R72BigsOiWyGMS7XpgLmass9GGDszOJvkUB1P6OiC4RDWO0RhoXTVlCbYZXWjv5QCepxottJrbN15b8vVV6d3LgszHPAdb4whpaowX67fRbdK795yYCwsX+G0TVW0UxqSg1YoMI0uPKg1YjJ778Grv06Ybt2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQRObvJA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQRObvJA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297ef378069so47577015ad.3
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 20:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765253029; x=1765857829; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEakywZwrp5jqjSRsFhBsdvfkV6DGXu7+QVPs39a7pk=;
        b=fQRObvJAntdBhtHKQKMBObXBp0/aEpYh2ffoi63AoUzU+r2BUqSqqJcz91RKiEXh9N
         /j1FCynaEfCm+XEkN9v6h3Mwda85GjoSdSNH/9ZW43CqnS9OcmqK9eGbpTEpqi3WV1Y0
         OJj9cdNt7NzVDPFgn7jAP7o7R1bdqpSEf/DbYzoiQ/jKVA1HgpRCJpK+vA75fVYjnecI
         Y2DAaimEhGxEArtY3Z7bUxiVPfqB33gHVb8cW67AN4vhjohz5OusDEIfoLrYFhBJvHbc
         gbpOb3tpvmmPoGJJ4RaSVK52AjofEPtSnuzU0kaJDPRLuwK5uxKk6up+2ijQDp/eFdbg
         Ifcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765253029; x=1765857829;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEakywZwrp5jqjSRsFhBsdvfkV6DGXu7+QVPs39a7pk=;
        b=nKHL8je3t0/S+s34DzxdzNHhlCyDWoaFa12Gnq8pvr3IoYLzhfzKq6P/yTINZOB7Mf
         zJdbe6wtwu0qRGgXwyap7IgGTFXjkavMnMbl8ZvDYd1hBgUfm5a9K6GK+k/uMhcQoXiP
         6Z1ktGmDAbw07u0bvDweDXsaw0Emyls64NCAZWtcStL0EOHNpcc6QKpRBy3F0MG7k0jb
         zOr0uLVNiwkgsOwvr//4mOpBwFLUGNaW5QQBBvhHVUuZ801fAbhERDEjPTgP/2tcePuk
         LLFmjdcsh2TZmYLuw3hCOa233Y9jNKctcFvYEB5PPlM9lL/W7xy1zuANhTRIwh/1sfvy
         FwJA==
X-Forwarded-Encrypted: i=1; AJvYcCVRlILbmV5OvP4zY4h0IA9E0PCfLGHRjNW7j2a1FSJbWFj+mhS+eLG2mP5P+ji8KgSF4Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNGhkM6LfPHAG2U+8z11ERGgxitgrcUF9cENb2DzhITZZHKow
	9EvNcPwZJj16/zSbIuPu4HLL9pGPo6DZkBnXLcsr4DM9TTCpjGfCSfdCwQwEwQ==
X-Gm-Gg: ASbGncsAdaqgrfudKU03TuvuTEh4mUyrwaIfGD45hnCtBngMFAoZxE4nzz6mw7+XIy2
	4oWcx/oFDuI+JfglFISNcZOWE6fCG1mEtvhmXneSIpr/L5iLZ2T0t+oxw6A+XLzpkc0LHlWFkfg
	zWafDmzSTqPMvV/26AxSX82cwvNfV6jO6/G5SlhTzy837jvKmm8LvaRQH4UGPQ61q5sTrKfO09n
	4mz8wSv9BXK8tG1vweDDvOIrtRCWVRXPzbYzSl0Hd8T/0PqY4zvcyFYvQStZTVVqxlLxMKbnWwC
	3BVbc3fIc5btgUSn18OnH4jzSn5ShQeVd4MJ+xSpoGoECaSjCZrVvZjImQZHgJwWcLPEztByRyb
	cjTR2AW/cUfzc6FHl9uMQ87/VRVt+ZE4392qYrR6AygL4iGihfGUXbLkV1uKPac7NKzVj
X-Google-Smtp-Source: AGHT+IG88Jveucl2P8AcD9SXVNO1LQOtLBrPzf5yRf9bzO6+xlNxVBH7H1cWRs82ytg9eJreR+cZtg==
X-Received: by 2002:a05:7022:248b:b0:11b:a514:b64f with SMTP id a92af1059eb24-11e031693eamr7410653c88.13.1765253028502;
        Mon, 08 Dec 2025 20:03:48 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::d056])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm66504544c88.4.2025.12.08.20.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 20:03:48 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Yee Cheng Chin <ychin.macvim@gmail.com>
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,
  Git List <git@vger.kernel.org>
Subject: Re: t3900 failure on macOS, iconv(3) broken?
In-Reply-To: <CAHTeOx-By55enMxt7YkCd6e=TbE7v+1ipN3wSFQc2n+9F_L7_Q@mail.gmail.com>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<CAOTNsDzmGypKNOg-pFuW45qst+g8=LHQbdNAgtVYJvD8pxa6_Q@mail.gmail.com>
	<CAHTeOx-By55enMxt7YkCd6e=TbE7v+1ipN3wSFQc2n+9F_L7_Q@mail.gmail.com>
Date: Mon, 08 Dec 2025 20:03:47 -0800
Message-ID: <87sedkjo7w.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yee Cheng Chin <ychin.macvim@gmail.com> writes:

>> * macOS 14.8.2
>>   * These tests pass.
>> It looks like the system iconv is broken on macOS 15 or later.
>
> I'm a little surprised that these tests pass in macOS 14 with native
> (aka not from Homebrew) iconv. Apple replaced GNU iconv with a custom
> version in macOS 14, which also caused a fair bit of breakages among
> other third-party software. I would have expected this CI test to
> break on macOS 14 unless this is a new behavior change / bug
> introduced in macOS 15.
>
> But yes, one way to fix it is to just provide the Homebrew GNU iconv
> via ICONVDIR.

FWIW, the GNU iconv maintainer expressed frustration with the buggy
iconv implementation in macOS 14 [1]. He blamed Apple-specific patches
on FreeBSD's implementation.

Collin

[1] https://lists.gnu.org/archive/html/bug-gnulib/2024-05/msg00375.html
