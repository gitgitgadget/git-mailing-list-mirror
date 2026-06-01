Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC845377541
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316596; cv=none; b=bbeHlmR7QAu9fKjRQCXVSbudZLy67Mj7zhtnvYdwCPOyh4ixIrvAJy6YRZorX+enOzNsnTA7+vPECI8Rorw0eJu5pWflRS222whhhKNBeMlVgj2Z54pw/zVpkw3iJOCo9PvsLcTAz2NnhX9IBc09S4nqG0w8YWOaSGDyqPWUAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316596; c=relaxed/simple;
	bh=X1gnoyqnQj8C0gINFEmrTZIMPFiqgQ1DiyTPaN3OJdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n6JKYdtpjwIWHb4QalaAdoiK9hQJN4QeaankhYDA7YUzihvjC5sMnW/U+hocggHRJ3GzaPvsXJRkMSXkexn24SvT+dXW1omEoJQCS1FCGdlxc0jWrJ4bVh/+yWitj9ipxq6XdaMfXTUYDJYxPWVLMFIAesa5lKRTh6DBZKjTEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mhxQORNx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Snwsc/yy; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mhxQORNx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Snwsc/yy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D89FB7A036D;
	Mon,  1 Jun 2026 08:23:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 08:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780316593; x=1780402993; bh=+fUSP1kbht
	IqEr3BUwy2a7cePpTOhhwCfoiZVgl5WdM=; b=mhxQORNxyuAe/mCVx514Q8/a5m
	T9xReeA9hXl9pn9RUVU891akCyOnEge6CqnmVgTqOf3kwOUhZGyUCrR7evGRjN1h
	ifUTIMUcGbCcK+C7L+r1Ss8TsOlfyk4XDi6H+99aC5rXc1grQ+YAnXxyRLm4mq46
	O8lI9UUf+sc8mpo4VMv/+rr6SSFMLpYWyNhQBt5s0HGzF0CtPf9JHR/Aohia8asw
	XXUDR2R5XXHzcOsgHG6tgolc0n2ozwWDVAPXD1WCaDdQrqCQDCYVHwj0/T8/Eiqh
	MU4ervIwlBlgiMe/hQnVxvzweajMRHHnNeiVT4FvdoVgeYn8WpeT0P+m4Ilw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780316593; x=1780402993; bh=+fUSP1kbhtIqEr3BUwy2a7cePpTOhhwCfoi
	ZVgl5WdM=; b=Snwsc/yycXq9Oj1Kt8bQUMSMwIptM//6pCxeF7O5veNv//1+UfX
	6DXWQP1ZiranLmSF7D+tr97hj60M6pq7owahAodTCqdC8PPEdUjnGOwNy7UKu+ba
	ZsbBZ4s7/FpWWuFdpmEolISo6QCr+XFdk3E8cqKhyUgAmaxg+fLCLAvDFeEF1a13
	F13IgS9e0hGJ0hFbr7/TLGNXp0YERafYWq8N71PYBpG7KGcQQZBVURu2hKv38OO/
	yDvNYnVrMJnchGmDS3/cYf+Wlyx3AZbbP+dYh4BELUK6Y87+965WyWCdanqBh4uT
	BEJpgdMDZxt+d1Ks3iA/VEdwZ69wAtIy8/g==
X-ME-Sender: <xms:sXkdaiItuNUi023_NkPUm5ePgTYDvzdkSUJMwZakNU7ektbE-vj1-Q>
    <xme:sXkdahKEfvLVd2cU9EoSZFvPqrOdnd35N3xRWRZEjkvXi-E4R6kXAjjEo3rkmPojy
    L27bl3EpDLLX_wNiYFUi7qa_JHZWhw6U_IxgXb58gAmGBfXTiqt>
X-ME-Received: <xmr:sXkdant1CLXsJc3pzNMjf6BJSpWk9HMn4-V6F8K8u0oXhMTb870vdPPFp8vYNa5F4vBqvKwrOxKJQXeU74mymvo3oJz5h9kXvS7Y>
X-ME-Proxy-Cause: dmFkZTFU0uNpxw5mXyXttPkI/3cwLj/YdmpiIWQkuyuaFozrhLvKIsOmm2wE89wP9ueWaw
    YRXXIcPSJEvNc6saHzd3rZY29YsjhSjU05rS54/iS5nL1o4nREXSrTdueq/ndYp2hUPdiF
    ine+G90HoqFP8Gwl+LoRcGG2RXZlE4bPghPDX+boYWPHg62KqDIcMafFG0hUkd/eNg3LT3
    BC/1W7jET7pYmsXbB6FpGpSwIPEIbg+m5Hr9R9hdp2tlF6p4WJ3jow/LiltZ+XHOUxOHG/
    gs6uFx6g6Lk0q/oOg5bcpC1sIS3m2bLkAsCtFaVTj935czNQwF0Df1POCzjZgCtSDr7NeF
    FKx6g38tyjLkmVI/VfpJF4IO2K3ul4LiJK0arJMVEcJaMJdJuMWmmbp/8TZFZNjswjOh4H
    /444YzEkUbSyqm3LK8g1CYstGq6WX0TsLWYG2yowmlNtrX044rtZc8C5hnCTmSUIdKyQYq
    dasckukuSHSjXxcqL5d/aMI4RJmHu/+Vkdt4bG2tGost+4kMeTldeLNK01z1Zb1uVvuvL2
    /SrlirgFDtVBZDUl80noLx/g2xr01tsFk+pqaa3YYKaqqEPsbeStBPAlMG2a6TZ6AR6yBI
    OJ0NVaZiTfmkpn6GscAcnGKrsfp14TAA2E0vRC2JE+GcKd/rjpwm915TV7Xg
X-ME-Proxy: <xmx:sXkdamSVqn7K8sHhlT71XeFtYfno6KZcBVY_7hagC3eEnIMgITWn-w>
    <xmx:sXkdalOpSk5oQ4vCN89QwhIskxsChu75PlJsqSBJ20uj6vxE8q9q6w>
    <xmx:sXkdajb4BMtHsMKNJhUT6KjVfaDwa1xwN6AFq8yqW0bCWS5CpYCd_g>
    <xmx:sXkdanxG0RXOOrIqKLspJL92hK3GRJLqfBAjUvEzm-zpViU6QrH7Vg>
    <xmx:sXkdanMjbIoh-kpQcbEHqX4EibnA5dGUzeUVX6CTrh0VmJQ9LL5I_pGk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:23:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge-ort: abort merge when trees have duplicate
 entries
In-Reply-To: <0d81c027aafcb386398836ffc73b058b7ea4c702.1776731171.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Tue, 21 Apr 2026
	00:26:10 +0000")
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<0d81c027aafcb386398836ffc73b058b7ea4c702.1776731171.git.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 21:23:12 +0900
Message-ID: <xmqqtsrm4fgv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Trees with duplicate entries are malformed; fsck reports "contains
> duplicate file entries" for them.  merge-ort has from the beginning
> assumed that we would never hit such trees.  It was written with the
> assumption that traverse_trees() calls collect_merge_info_callback() at
> most once per path.  The "sanity checks" in that callback (added in
> d2bc1994f363 (merge-ort: implement a very basic collect_merge_info(),
> 2020-12-13)) verify properties of each individual call but not that
> invariant.  The strmap_put() in setup_path_info() silently overwrites
> the entry from any prior call for the same path, because it assumed
> there would be no other path.  Unfortunately, supplemental data
> structures for various optimizations could still be tweaked before the
> extra paths were overwritten, and those data structures not matching
> expected state could trip various assertions.
>
> Change the return type of setup_path_info() from void to int to allow us
> to detect this case, and abort the merge with a clear error message when
> it occurs.

OK.

> @@ -1081,9 +1081,11 @@ static void setup_path_info(struct merge_options *opt,
>  			 */
>  			mi->is_null = 1;
>  	}
> -	strmap_put(&opt->priv->paths, fullpath, mi);
> +	if (strmap_put(&opt->priv->paths, fullpath, mi))
> +		return error(_("tree has duplicate entries for '%s'"), fullpath);

OK.  I was wondering what _other_ kind of malformed trees would the
updated code by this change is prepared to handle (most notably,
tree entries must be sorted, and one way to detect duplicate is to
remember one single path that we saw earlier, which would work as
long as the entries are sorted).  This "ah, we saw that path already"
approach is much more robust in that it does not have to depend on a
sorted tree.

Makes sense.
