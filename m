Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6D5437FE
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923391; cv=none; b=oTHoKsSFwM8M7kTojXwCKtv9c3KH1siqSVLv2bda7tIWMStj8cNr3zQHugrEkhnYm33as2XPOiD0BzjooWxZv5wdBdLbaVjm8xdYHj1cPPBI1oU9iOT5RrWSACH0EKiULwkIW1giySQ4wDDyycZahbuvrKsoShGX22P0C2ECj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923391; c=relaxed/simple;
	bh=VW2JwPY8j90IhPJdNOWvdSvRgPHghYlZcdHOOayqMLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8ISjDPc/wbCkufj/8bItAwMsfwPk56J982waPXWgwJUAz/SQVGYHidVo3YC/qVonWhGKeAiET/A6qYRidJyIDG116glvahxme9SMomcIUUm10NrnoRqJu6m3AVEM6WzZEbOcoaniza05ui/n/ukelymxjamQgzBorXogyXEXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eejHGAkX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdYYn9Qv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eejHGAkX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdYYn9Qv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EFEBA1D0027A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 16:29:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 16:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791923388; x=1792009788; bh=ziW4Ht5yfY
	LAbKOQhdiZGB4XVMCr12ulC1hH7eZbfao=; b=eejHGAkX4YBR8JR6qVx+26V476
	2AxKRWZL6/wq4JcV7WSVUcskx0VJqcU63KbnI/chKWt3uIyEigi+3kBrizxGb2sX
	BWipStw4jBCIcrEaBoXRUfh4enql54Snae4Y5fx45rUBKOlz6wPaYNqjOctysc3V
	l+vmP5vwg6GRANTvng9xX59hQLjOFQfkIev7SGHA7tt7A4kgoA03ZDRkgkQQdY8S
	v3EDQwSPHPy+3djRolWtlGqbkdCXyo8qpZbDG9fnvDZVcSSp3jF4IsfOXUhMy9cq
	xnxTymtc8MIW/Ke0KsxVXChXb9Ve1LR+T8YKpgCvP0iGj/lqCTYBLFTrfioA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791923388; x=1792009788; bh=ziW4Ht5yfYLAbKOQhdiZGB4XVMCr12ulC1h
	H7eZbfao=; b=EdYYn9QvXZs0KlYIld/oqkNaI4bQte+ffwNL7FLu2mOX9N1wBbd
	aQ8XO2pp4JQQ1rSwo6KFExKzIf+xpyAiuJshyV7Zue2+rTQg9gekNe/O4OYTcDPu
	N9jrhv6YqfcO/j4RJlabgJ+v6V3YFHDFMfgyODHpNJiCSUX+43tLw06iEbmHuA1c
	NNtDJpTjXd5b00mSHzHRPiGuHkZJ+m0s3X56ChGuYfkPj2FvLpvMtEyBsROkokHI
	97bD1aCK9pHOLe0j2NT6voT9sigAHwQnmO0RBYJ3n/BWTgemZY1BQ/J/to+8HAox
	cURPa9G8gmfWOWxYR8orER1kZOeaVOAtmAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791923388; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eN2nuehDb+ddDZSqhXXmG8hUpXm4JhgPmFOLIXza6AB5GZ9
	v6a9WX4DVfx3lPLoOJJbStvwmmKWAjlzR+Z2uaSSHM5dvfWBUtro97uYFDi3odIg
	JOVHc2gqtiTArsZihpPjshsqeadnlMIyqnTP1CpxpycPDLFY8BElxUdeN4CZ117z
	RNVvgIm7iyApt9ilbu9nLHnhQgGOZTqZhDZVk0imaEdyd5zdGmL6oDQrPn/i+soi
	R+LKJbjntHQ0/kEUjurEelylBt9q5CPtGgVOLcNH9yNNF9+Kg/ghNVQDzm0J43as
	Fug2itsRmEFCGFY4mm/il01L41l4UXPm0xh9Bhg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bG5HV3o52deeaN9wy3Yrzr4DMjqpVAXh+m2uZbMtsZM=:VW2JwPY8j90IhPJdNOWvdSvRgPHghYlZcdHOOayqMLg=;
X-ME-Sender: <xms:vJTOauR0VGMkZQ9h-d_bl-iCRrLPq0RuHKOc1eoYQgDyIEmrGlVnFQ>
    <xme:vJTOaqqDV8FC9-yAYC66rfcJolvcHd4HfD9t9ueZGuyBfRKK8Aoz4XXT7-lL_3dao
    6snZ6DVrkV5kErLpUcRBWEqTpa64df7P3mqr-fDISA1yFMxw5A>
X-ME-Received: <xmr:vJTOakJeWGKf9ZDUt4wgqDZ8Wv_73w4fX39vQKpHW5-fAcT_zpvKlULd_ZmzTmtvivrxF0QckD9bYut2sJRRM0qnMy9w9f3NUCKE>
X-ME-Proxy-Cause: dmFkZTFOjdqng1RLT/xUHr2YsJXx9HielSPDeKlDRrTbxvzyll/PPs6O9Nz0+IwBGkz6Tr
    cFV6PQXaoxf8Eil9PACN4vcYW8KpuvxpGdpBa9mi0d0LP6B187BgTNdg2aAsCOSgtj3S1s
    4Q4zhC9mGE2fjJLHoysZx54Gt2q8kPHtPK73R5U/Ww0b51L2fW7UhTHXQUZEOSum7H/SGx
    ZKG4TogH4v1qV+z4zYo7mnJgHQnen/OJSOK7S8+Mnmx4U6tysJHTznxuVzNtdAqf++JGm1
    60TWeBMqkhvbQIQdYYHPYuOldLAaaEaERFsEJMoaQiG+yg+PrUJaytt+Wc1oAu4w/4Z2Sn
    if06/r3Ga7n9T08XYHoH8Y1KThBSM7Zcg9Vt3Ye3BPWIRPRbOTRxpbEkwL57YOQxCItRB7
    V+kSWR+SyMHbT7Bz6nNG9mJu8pAXAW7GdiEOt/8UleIk9xqe009ofBhVTm8Wyb9ltgQoKa
    9ZmZVaxvWFQoVy2hckoXcFjcZwv4W3zfikkH987ai4mqssI6mSxsbwwwZ2EkBSAYJ3et+b
    moD6LkoRCybQ7ETpyBweZVv3595rooZTcplFXn55vSbEikDrh3O+Z/SlJEH7bi6EZ2X6NW
    6GlxIarXFpBs/ZM9DM8SvWqfBo8AvCcVCa+IrHq4qUQGsK65gm5UFUFYvRww
X-ME-Proxy: <xmx:vJTOalqYyOp4zKBFY80sBn5Ww5pFYLOjBsKaqbVD35DmILjhVu3-PA>
    <xmx:vJTOakx3V-S69641nBpRiC-tk9hDUG2xDfK71MvDpQIHk3giYQfFSQ>
    <xmx:vJTOahNteLRHF6pQlYOyXWGVt48JTM7yht-L9_OJHnLvFpQ5LJXZDw>
    <xmx:vJTOah7LAmefIREwP-x9ssk0klY6GCsOlgL2n9NvvxeD5XW12UQ1Sw>
    <xmx:vJTOarExyiU-tiG87zi-1JtW69fUW-LuZVD5iTQLWPhw8WTvoA1LHQ7G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 16:29:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Curtis Allen Smith <curtis.allen.smith@gmail.com>
Cc: git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] read-cache: do not trust a size change when
 conversion is active
In-Reply-To: <20261013180206.610-1-curtis.allen.smith@gmail.com> (Curtis Allen
	Smith's message of "Tue, 13 Oct 2026 12:02:04 -0600")
References: <20261013065915.879-1-curtis.allen.smith@gmail.com>
	<20261013180206.610-1-curtis.allen.smith@gmail.com>
Date: Tue, 13 Oct 2026 13:29:46 -0700
Message-ID: <xmqq1p9twdhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Curtis Allen Smith <curtis.allen.smith@gmail.com> writes:

> 	git status --short      # ->  M file.txt
> 	git diff                # -> empty
> 	git add file.txt        # -> nothing to commit

I do not think "git add" would ever say nothing to commit.

	git commit file.txt

may say "nothing added to commit" when there is no modification made
to file.txt to indicate that there is no change worth comitting.

There are code paths that make performance trade-offs (see the
introductory part of Documentation/technical/racy-git.adoc for
examples) and are designed to tolerate false positives from
ie_modified(), filtering them out themselves.  I am somewhat
hesitant to butcher code paths at this low level to make
unconditional changes that reduce false positives without thinking
things through.  For example, we may want to disable this new code
when the 'CE_MATCH_RACY_IS_DIRTY' bit is set.  But the goal
nevertheless should be to avoid surfacing these false positives,
which are deliberately allowed as performance trade-offs, to code
paths like 'git status' that do not further filter them out (as you
demonstrated above).

There may be other cases where this patch unknowingly breaks
carefully made performance trade-offs.

> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index fd1cae09e..9c8d07cfc 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -397,4 +397,43 @@ test_expect_success 'New CRLF file gets LF in repo' '
>  	test_cmp alllf alllf2
>  '
>  
> +test_expect_success 'status does not report a CRLF-only rewrite as modified' '
> +	test_when_finished "git reset --hard autocrlf-checkpoint" &&
> +	echo "eol.txt text eol=lf" >.gitattributes &&
> +	printf "one\ntwo\nthree\n" >eol.txt &&
> +	git add .gitattributes eol.txt &&
> +	git commit -m "eol.txt" &&
> +
> +	# a generator rewrites the file with CRLF, same content
> +	printf "one\r\ntwo\r\nthree\r\n" >eol.txt &&
> +	git status --porcelain -uno >actual &&
> +	test_must_be_empty actual &&
> +	git diff --exit-code &&
> +
> +	# a real change is still reported
> +	printf "one\r\ntwo\r\nfour\r\n" >eol.txt &&
> +	git status --porcelain -uno >actual &&
> +	echo " M eol.txt" >expect &&
> +	test_cmp expect actual
> +'
>
> +test_expect_success 'status sees through a CRLF rewrite of a file with a lone CR' '
> +	test_when_finished "git reset --hard autocrlf-checkpoint" &&
> +	echo "cr.txt text eol=lf" >.gitattributes &&
> +	printf "one\rtwo\nthree\n" >cr.txt &&
> +	git add .gitattributes cr.txt &&
> +	git commit -m "cr.txt" &&
> +
> +	# "git add" keeps the lone CR and drops the others
> +	printf "one\rtwo\r\nthree\r\n" >cr.txt &&
> +	git status --porcelain -uno >actual &&
> +	test_must_be_empty actual &&
> +
> +	# the converted length matches the blob, the content does not
> +	printf "one\rtwo\nthrEE\r\n" >cr.txt &&
> +	git status --porcelain -uno >actual &&
> +	echo " M cr.txt" >expect &&
> +	test_cmp expect actual
> +'

Tests like these may run fast enough to trigger "oops, we may be in
the racy-git situation so make the comparison differently from the
normal code paths (usually spends extra cycles to compare the
contents)", which may hide existing problems, so these tests need to
be extra careful.

> +
>  test_done

Thanks.
