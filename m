Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61F3F0A8C
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998475; cv=none; b=Ayqz7yhzdv0FZYtLE8YZGEzSl2t6c2E/wom+r+i+6f5PCA9M0tOmJ8duNYcZ8OZ5JE2cIjTGb70O4nfcp9VwMZ23A3Ku8hMtHRMQ0BmrhrYdjoKyCwb6cn9kvqOBHBV/VxI/D25dmOYphN+SAVTUFSnfKuLxDOKvCilN9Amfwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998475; c=relaxed/simple;
	bh=oKWmmZLhHRdLip26mzSNtfQq4bEqazifSQ/lBYsVQyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r0Mj1qoPLug+xoOP/DlWH3guGiK+gnAC9g4uOQjODEnRUPXkw49e9NkHilpAyS88pudSMkWhCNUUjKQ7whFTqxy4ROuQx3G6l3ZXh52SWSeK8OX/BfaSLhEhGkHiPMfjM3Tx4gtEappJIqskie9TeYzV8LwVhjQG6E2zulWhaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DdL40Acp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F88e0++I; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DdL40Acp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F88e0++I"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA4BB14000A4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:21:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 13:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791998465; x=1792084865; bh=e6POEi3GR5
	nVFw/03FPFZbsWW4qMYatiVkHulso1Mf8=; b=DdL40Acpr9ItLgkJFMXyd9lwXG
	pUjbPezwAs3QQOooMuaYCUfrsfhb+Vyi2YpzMCSEzx2jiIA5udO/6mR+VolQcyvg
	Twfh5T58S9rTxtUSrXZRSiyiMMkT8MNRJRfvcrpuJ4/PnxjWb8W8oLwavUtXcjfl
	MKsKGR7zle4t1c4fnmH7W12QMBvKSSAoiD7GAznvlfkw0w0YSUFUb40oiX84WxCT
	hOQkKAKaUnY3cMgYnZtcLgytV5c3jH78HG08t7W3US1b0664YpCHUJ3S1yMcIy+H
	2fgZ6+r09b1VfNh/Z20+Tvodt2bfRAWNLTKx0aIT2/AlexgWS6l8AagydI1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791998465; x=1792084865; bh=e6POEi3GR5nVFw/03FPFZbsWW4qMYatiVkH
	ulso1Mf8=; b=F88e0++IkAlbSNWt39jEd0He0x0WJ+vjMmoi8Kk+85KOTDDvxiX
	SMTdL89MUh5k40VYC0WTIhNeVWXGBCpNAfWbdjorQJfHktcJSuAeKqHGqZWVX5KG
	EFogcAZHVLU6OTRsw7/pdSd0pJ2G1/ed1KslTl64Nr3Klp9/efTskdvyjEY5FfSJ
	NSYfBVFZU/l2S+IrkZJc5FtDlrNVuLt9Y4ONFYwLcOiD8AgHof3Z09YScUwOqF2N
	ZlretYTUG2usNcw7O8SgsKQUIQXaNAIKqC0MNKBM64Z40/6M2ww3xH6QK25jL8+/
	OHUDILUuh1dolgX8NnQggnswTi8qcrWpw5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791998465; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Gu3XYFJmLKgJZlQYHc2X6UTdFVZqUngTu5+9fMtupsAZwoi
	1sHHetiviC1ISqgGHPfaGueNIqZSVIaIAsZR/i2xOimS0Utmu2XNIW4q2yXv5kKN
	OTGXhe1yIbauQvWD9Q5czFhaDVhMV72KzbZzC+FVBnZrqMG0+a12d4yx2yojtbo9
	yl4VafWgjywVxAgB9M3cvSIHvTBMY0NLyigr3n3fOYDeDLSf3I4AKPHfG5qn4g3k
	JBi/ng2vwxDFZO+17bAv59vTolvE8Hf8fCShvwV9us/znsYnxfib+p9dNcrZ/Zey
	Ru/z6CWipYtyV29w4oMRzAC/AFahOdqcQ+aKUrw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tyyQiiHy3ATQQUw869Osnh3jV/7W5SJoUZ4SeiEbecE=:oKWmmZLhHRdLip26mzSNtfQq4bEqazifSQ/lBYsVQyg=;
X-ME-Sender: <xms:AbrPagP9iLuctQiglOhBKQk4swpS-roLLDCJbUcmxXB6G5X5fC9q0A>
    <xme:AbrPat8slygO_dl_5cDtZIzQC0LrEeNjZ9_2fHfqhz7GUORYQC9SwBiTpheKIpUGO
    V8szZAoMhd_LjGswwQfXE1pqO9y5AXVEmRD6KLEVynthujeoz7jSiKt>
X-ME-Received: <xmr:AbrPasSCLEhkAXOmGa_dM-sZnJz0k8RTyAFtreCkALKu2IXdC7wwxRiKbH2jG9kgaMgVQlEMaxH2rW93eqod9bP57EUoZKKUDJe8>
X-ME-Proxy-Cause: dmFkZTEgYiFDNy9pu6rhM5R3PNmcUZnzI6onFv8sfnAUY11sUP3vQ2Hi9jydNQZy7CA1Jg
    f+133WjyfX+EoG8QyOp1dnoRTjoNXDmePOd1CmpX+cwDW0iGVcubNGyNndVDR7oeWsDIXa
    deJmJj7l5ZQjITkTPBN+7qeeeX1fODxvJapW7HhieU86rCP+AFn80xUOJjryICC3BshEfc
    aEQzKUlEf6sD3BBCTCyWxZfLj1Ss3lfguFD4J69jKB0t0sbwHtrHWwkw16xCQrC3QKqgHT
    v+EPY/7C8COTEm+Xa2h5HvsF/NJyTpp6jJt/Mkp7xNkG47XKkK1SZQ5N7qLlKor9Pe4Jqb
    5ooa7Ub77t9uWkNgRi1Lf1zMpbccf9/iui6tw+DBpLXcinpPvAk9/NUraJX5KSeQgGSREb
    X4r3MyzjDC1v74Z1z2nzWtveQpArSLp/+J/exOsikHcfaEjQpJ3ZWk3/zk44DxxN0xb6FD
    dEQ0EASypgPuMvD4g7tjUe2MqfyNhi94sx2Tow0PZxULr9niRKRi0pzfvI+xs5zrZrDBOK
    Y7kND+WeGki/PG87fYLjI0PAELnbXHBUa7p6p3jyTV6Gp7Qe0dIGV5KRvsgPhPwOstg0+Z
    dTkZghmmJsz/c49Ho63ow4ezW5iPzB/NhcQfCLVof0e3ixQj1XldKSaRhs9A
X-ME-Proxy: <xmx:AbrPannTPxbU2dCrSLiJvRqSsSt_95MtEHs8Omjp3JHIb6PqEu1NHQ>
    <xmx:AbrPakT2-F9Jhe-_lYCaE-9VQDOI5BShpOk2YsFdg7_r7CboKxcq1g>
    <xmx:AbrPatNAiNdshXFDj-IRBEEqmOPm1LmQVGUYuh-yNQh_CACPY-UJyg>
    <xmx:AbrPalU_sHMkHJje0DZ4XVK5FtWlyb0lzaS36E25vumHXibV3uxf9w>
    <xmx:AbrPavxFQaF09ySzDyx5cI3-E7omaY1T9ENVJB0nCHWB5ExKLDQ5llPu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 13:21:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?B?QW5kcsOpIETDvHdlbA==?=
 <duewel1982@googlemail.com>
Subject: Re: [PATCH] pack-check: fix bogus corruption report with
 core.bigFileThreshold
In-Reply-To: <20261014-b4-pks-pack-check-matching-large-file-threshold-v1-1-de6d8455eaaa@pks.im>
	(Patrick Steinhardt's message of "Wed, 14 Oct 2026 12:49:19 +0200")
References: <20261014-b4-pks-pack-check-matching-large-file-threshold-v1-1-de6d8455eaaa@pks.im>
Date: Wed, 14 Oct 2026 10:21:04 -0700
Message-ID: <xmqq8q40tczj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When verifying packed blobs for consistency we have two different paths:
>
>   - When the blob is larger than or equal to "core.bigFileThreshold"
>     we verify its object ID by streaming it.
>
>   - Otherwise we read the object's data into memory and then hash it.
>
> When a packed blob is exactly at the threshold then we'll also take the
> streaming path. This is at odds with the rest of the codebase though,
> where we consider an object large only when it exceeds the threshold.

> diff --git a/pack-check.c b/pack-check.c
> index c7275f4b92..605811b7b0 100644
> --- a/pack-check.c
> +++ b/pack-check.c
> @@ -134,7 +134,7 @@ static int verify_packfile(struct repository *r,
>  		unuse_pack(w_curs);
>  
>  		if (type == OBJ_BLOB &&
> -		    repo_settings_get_big_file_threshold(r) <= size) {
> +		    repo_settings_get_big_file_threshold(r) < size) {
>  			/*
>  			 * Let stream_object_signature() check it with
>  			 * the streaming interface; no point slurping

OK, this signals a later step with the (data==NULL, data_valid==0)
that the size of the pack entry is sufficiently large that we do not
want to hold it in-core only to verify the object name.  And the later
step calls packfile_read_object_stream() to prepare an istream.

I agree with you that "Use the streaming interface only for objects
larger than what we are willing to hold in core" is a policy thing,
and checking the policy in packfile_read_object_stream() is dubious,
but since the above is checking the same policy, so we should do the
comparison the same way.

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 1b4074304c..16cc5d5dcb 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -1152,4 +1152,17 @@ test_expect_success 'fsck reports problems in current worktree index without fil
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'fsck with blob size equal to core.bigFileThreshold' '
> +	test_when_finished rm -rf big-blob-fsck &&
> +	git init big-blob-fsck &&
> +	(
> +		cd big-blob-fsck &&
> +		test-tool genzeros 1024 >blob &&
> +		git add blob &&
> +		git commit -m "blob equal to threshold" &&
> +		git repack -ad &&
> +		git -c core.bigFileThreshold=1k fsck --no-dangling
> +	)
> +'

Looks obviously correct.  Will queue.  Thanks.

> +
>  test_done
>
> ---
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
> change-id: 20261014-b4-pks-pack-check-matching-large-file-threshold-fd7be721d6a4
