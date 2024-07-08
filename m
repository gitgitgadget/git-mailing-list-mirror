Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295E2E64A
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470785; cv=none; b=nP6q5Y3UyR+5FNVSSMuCkconsTuAUY2P6qICQ2r0rH7uxlPvVvpadWE0WyNCSC5QUtQjqRK54rMs1GHiN5b8QUE3dE9WPkdhq1iEEzp2M9xfPo1s2R0v1cMoQ3UqS2HeZ5fj7CAJuGGiXptCODc4CuteENl/gsmy9HlX245aCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470785; c=relaxed/simple;
	bh=WMlf0OgSxhiN2ofxQB4IwvfGKtGIeGVYSPKRZHtWOk8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yujw6Qm/tKhHA4uJVT4yTJWczJL8E7KTPTrSpuDmfDohh7NmpCNVcbTdJiYo7ofcIUDPATkRQMS6ja+XqD4O90HA8ArB4WW+zNcmLZKGm++fkREUvFJRkchJzMM0+VVK5XcHcSVogxgSIXQW+ia/NAehWPtyGslG0A6qxlv22Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+GFuNyk; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+GFuNyk"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25e15406855so2774880fac.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720470783; x=1721075583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7X2BvkbF8cUlBBSOVLLDBLywdXCAFNS+HjN4tm+3aPw=;
        b=O+GFuNyketSnT8GFeDZ5Tlg0d53BIOBBiuE1HJz7ucggqzeYWFasERMyJSZVS8epwM
         +pcIvi8lumDyKGHMJlShUZIYV//NQCklPCx+wm2Aj0yhxRrQhWUgjrKbNLV91+7a9RQg
         wVDy18Bo0tlbXSY7ze9B+DCL9vgTjqpYo51qHaXRj+vYMhGP++Y6S5vh/X12PJGVTsbl
         psMLNo5F4dU1BIOj63cbyz3RXumEIb5YXnlF4wchj7MwLMXXnaQEoroVbDJjtmBWZ8hF
         HNl6USN4ReYLtb3CqL284cAdufdlXlLM189by+1Jdw1TMIPj41oklB3ytFsf4Tjpxjvp
         DrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720470783; x=1721075583;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7X2BvkbF8cUlBBSOVLLDBLywdXCAFNS+HjN4tm+3aPw=;
        b=A0ntz6KMBOP2k38AuEoe5+eAvb6OXK6KyRH7/HL+kZTt5N3rHa8xVhua5W0cqk1KCp
         LTNSZpsMpQJnBdThFjQUWDcD0cxlZwlHo739S/DMI50LrZREFl/by68quN9bafrZbI7k
         1DioLFD6lAHlrFvITwUTRnOXseR3TB6UXzbn8JSHo9UbrCf4pJaJp+vXnUczmQUwqXpD
         Wx/nXXLqJ0i7BSAh0hViGVTB/wZy0yvPvP1wO8if85b6xrEnhPwtwIsJQQs0/hUJ6G+Q
         BIhbrrNLHXsvlRf1T4+A6Tk+SWo91su27ze7mdSXBGVI+QKN2ZPiC2l+rYTy0rNqCrR4
         RB3w==
X-Gm-Message-State: AOJu0Yzkyis3QH8cqDMmEp7w8mKeUUCSIEV/dr/Svh5Mg9w9p0qK9l2D
	mSri7G1spBFf5b0M77p0cdo7jI0cioNBWAhn2Zxdd5mwoJ9zlga2x592BK3Zz29GUEjm57VnqiV
	X/uXVjhIHFUAswckq6gssarajfcY=
X-Google-Smtp-Source: AGHT+IEQpjk4NFlPh7DFPSFE09sT/MnrZBdQzyNGpWt/2U/CmOs/LEiz4yVtW0+7RZY1ycP64eCz3epu3kL0XDCajmQ=
X-Received: by 2002:a05:6870:2010:b0:254:c777:6327 with SMTP id
 586e51a60fabf-25eaebe4886mr365783fac.36.1720470783030; Mon, 08 Jul 2024
 13:33:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 15:33:02 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqle2bkg5i.fsf@gitster.g>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-2-karthik.188@gmail.com> <xmqqle2bkg5i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 15:33:02 -0500
Message-ID: <CAOLa=ZTrVGekoh0z2H0WpKCqhHLuWSeZShCkkSA_NGSrj_Tb7g@mail.gmail.com>
Subject: Re: [PATCH 1/8] clang-format: indent preprocessor directives after hash
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000de9852061cc25102"

--000000000000de9852061cc25102
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> We do not have a rule around the indentation of preprocessor directives.
>> This was also discussed on the list [1], noting how there is often
>> inconsistency in the styling. While there was discussion, there was no
>> conclusion around what is the preferred style here. One style being
>> indenting after the hash:
>>
>>     #if FOO
>>     #  if BAR
>>     #    include <foo>
>>     #  endif
>>     #endif
>>
>> The other being before the hash:
>>
>>     #if FOO
>>       #if BAR
>>         #include <foo>
>>       #endif
>>     #endif
>>
>> Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
>> our '.clang-format'. There is no clear reason to pick one over the
>> other, but it would definitely be nicer to be consistent.
>
> When I experimented with reindenting the CPP directives in
> <git-compat-util.h> [*], I think I saw an existing violation in an
> early part of the file.  Outside the borrowed code in compat/, we
> have these:
>
>     $ git grep -e '^[ 	]\{1,\}#' master -- ':!compat/' \*.[ch]
>     blame.c:	#define FINGERPRINT_FILE_THRESHOLD	10
>     block-sha1/sha1.c:  #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
>     block-sha1/sha1.c:  #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
>     block-sha1/sha1.c:  #define setW(x, val) (W(x) = (val))
>     diff.h:	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
>     diff.h:	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
>     diff.h:	#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
>     diff.h:	#define COLOR_MOVED_WS_ERROR (1<<0)
>     git-compat-util.h: #define GIT_GNUC_PREREQ(maj, min) 0
>     pkt-line.c:	#define hex(a) (hexchar[(a) & 15])
>     pkt-line.c:	#undef hex
>     sha1dc/sha1.c:	#define sha1_load(m, t, temp)  { temp = m[t]; }
>     sha1dc/sha1.c:	#define sha1_load(m, t, temp)  { temp = m[t]; sha1_bswap32(temp); }
>
> Should we clean them up before we start adding these rules to the
> file, especially if we plan to run the rules for stylistic check?
> Otherwise wouldn't we see noises coming from the existing lines that
> may dwarf the new ones, whose addition we want prevent?
>

Making syntax changes just so the rule works was something I did
consider, but I avoided it mostly because the CI only applies to the
changes made and not pre-existing files.

This also allows us to apply the boy scout rule and cleanup as we go.

> If we were to run the check in CI to help contributors, I would
> assume that you are arranging it to only complain about the lines
> touched by the commits they are contributing, not about the existing
> style violations.  This comment is not limited to the CPP directive
> indentation but any other style rules .clang-format defines.
>

Yes exactly, the usage of 'git-clang-format' allows us to only check for
lines changed.

> If we are not checking only for lines affected by commits being
> contributed, then perhaps we should exclude compat/ from these
> rules?
>
> Thanks for working on this.
>
> [Reference]
>
>  * https://lore.kernel.org/git/xmqqjzim197j.fsf@gitster.g/

--000000000000de9852061cc25102
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 13a72848c85bc170_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTVRQd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzRRREFDWitua2tENTFVVFlaTytuOStpRXlJb2U4cQpXeElaTmxyRXlU
Z2lpYnhnOTl4Y2x4RHdmc3hXOEkzUEk4UW9QZjRmNksvWUUycW5OeEJNUnBXOGhVcEJWa05KCkV6
eldpak9aVDhhbHNCRDJNTDlxQkhuWGtXUUU0Z2drUVBrdlVJazFoSWZIcjcwS2ZOTHhSa2xGRlJ5
UU9VYlAKS3F2LzdmMUR5QzVhM3k0ZlJ3Ui9VMWNXbUdJbk95UDNxbmdNd3BMUEd0Mm4vTktDOUVi
L1JoR3g0Q2tJMFh6VgpyTlJkQXU0QkZyZVJFU0tNWnQ2UmtpL2hLYlFFdmM3K3lzMlJKdTV1MzZs
RHAyMlp4S09DNHNjeThnZjAyQzBYCkdIYkVIaDYzckM5QjFCN3Y4YWRiMHArVmh2d0dKUFZQRUk4
c1NxZmVBOWo3TTIwM0hMbXliNEcxcnF6WVdZVzMKdWhyYVNjdXB1Q21tWVhhc3IvOUFmQytzYVha
dVBMU2dYYVF0dTBCQ1pZRkg4TkpFdWxhSnJrUTloMm9NQXp1dAo3RWlRYXlEVG5rakIyMWZJb1RZ
cEtkOTV0S2FOVXhlZm1JUW9RZnVBMFAvbUNmMmhpZ0tEOG5pVEh3N3NHdmlTCkNveWZiWTRuOWtp
K2VWenE3OHJzMS9jc1pwSzNzU2VlRi82OWx5OD0KPXFsbU4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000de9852061cc25102--
