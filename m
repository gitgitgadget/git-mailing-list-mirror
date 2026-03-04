Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9C36C0AA
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644507; cv=none; b=p708412fkE009D+kGrEPq2wPffZiV+FOQLYEYGTk1me/9KDYXhGTsY99uhQR33pp7n4awZwVCzvfapy8zpwb84wTLf1zaykAOVAMsBpAuRcG3CquCeyAmVhwauXc9b3GUjZ3HSTHopDW4tHhbfK4uk5Zvqknv9LhOMjGttQQACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644507; c=relaxed/simple;
	bh=QupMWkRiU74A/Td7W3KQyvfvjYpwq58NyRkSC8b7EBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qJsJfN8S53LUKX8rN88VxusTsJV34/9QPknS6nuHzcIqiWLZou3PfonnBpZ5pRp1SqUX/DaKuCgjunVpUfEx1F2ttVVXvuSuOXES/XThr8G6emOA9Vee7fpf40vcvBjcvsPWNTuDRZvPX+R30YMjBUHSXnc2dSQxx39HIIfLFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PR7u8OJo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aMWdTfuN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PR7u8OJo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aMWdTfuN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3328B1D00231;
	Wed,  4 Mar 2026 12:15:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 04 Mar 2026 12:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772644505; x=1772730905; bh=nwotk2taxW
	7tA9414KWLrTbwbSIw/nHTyOLKbBXi6NU=; b=PR7u8OJoytpNuB78PuZ/UrhqlG
	9EzVCYgSp5W+zJ1oFP+IK6M2lLF/zRyezAypeGD76LBo74BwojKz7Z+Qddkpudst
	a0cl3H49EV5DyzzDNV1yIXf1H0M2ZSGUAFaEvdVqF6437JYM2sYMqSuxNFaSwBnY
	xhBfFP3daXypeieIeMzrhDwwXoHGjR1SKKFrO7Z7R7SAyRHxgMSJCdJ2ykEC13NZ
	kro3E/Y9EfcLc6/x3r0glWD/VvP3JWgk5IfuLWRlvXV1NO+hA96nQEUKl/aXD/eA
	ZPYnoy8fHhxIpBqqgRzJ0KJw1Pp3HgEuw9Vj1iLCPJyS6klNU6dtd4UugIsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772644505; x=1772730905; bh=nwotk2taxW7tA9414KWLrTbwbSIw/nHTyOL
	KbBXi6NU=; b=aMWdTfuNMOp1XHBkD85X30nwmMK7evhk1O8VyxfxGx1WmlLZKoy
	uPX7PNFycwyq+FCH9ddS64Uu0SHxkMm3wXweMRcpUGusBUtYWrzdcmOllk3jRpYl
	2IgdDz1oZcsH89LOrBvdEgDr9s6sH1z7ARXfE4V0uF/PyiyBc3ouDfNkOT2TCu+Z
	wX4DZPqhLIEOzIBTUTFe9itOv6uAdgyF5FbatpDYC+j8qClpJSIn+SXeMBdl93Ty
	//uftC3nYtaz/WDeKzz4NShvtRz/i23CBmQxHqRVf4Ey3hsnxFwrKO/8x5ZvC8Cg
	mFDAOsSwRkyXkEEGaMW6JjEeVKtYG1cVtDA==
X-ME-Sender: <xms:mGioafH3KTPjHi9KACbEAt72oz56oZDjwBLAhsVB_g0zBXfMLQq78Q>
    <xme:mGioaTwPn7-E0kChtSf-SCpSZ6A0QZZ7iQ1XklC4_G4uTIGiviIOAZXwIvRVoY3Ob
    YyP-diOMkvembdtw8OHaiIr0TBP2hLljEr71w9V2WxoKoFZkKorHps>
X-ME-Received: <xmr:mGioaehsN8ZNXzbUvGYT09LbkujAMbhtyBI5ZLKc_ODlaXzgeHn88-uqVciBMNkMHyOz6pCSrIIxJmYuwWHi4nhSwdbR5HgIfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtd
    dtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mGioaWxSHLCO0XWKhDsaOuLfZmhQB8GiJxO_sONiT6FrbmnEwkbVIA>
    <xmx:mGioaZKbDXwj3qgzgHuTVdJDpX9gOYYkjgdikpZ1KDeTO8mk9e0_Tg>
    <xmx:mGioaVTquRySXobeL87hj26jlaf029yEpBWO3MFPwTN2XghOFFvGwg>
    <xmx:mGioaZpH846j6WKZrV0LbQqEeAqR2I9Nda9GOZOwYdLBzzHJbGmPcA>
    <xmx:mWioaXycxRyA6vxke0yiNta896T5hURlFIgz_bTlfWYpgSwsO2O-_ymD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 12:15:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] path: use size_t for dir_prefix length
In-Reply-To: <20260304130502.8475-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Wed, 4 Mar 2026 18:35:01 +0530")
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
	<20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
	<20260304130502.8475-3-jayatheerthkulkarni2005@gmail.com>
Date: Wed, 04 Mar 2026 09:15:03 -0800
Message-ID: <xmqqwlzr8qjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The strlen() function returns a size_t. Storing this in a standard
> signed int is a bad practice that invites overflow vulnerabilities if
> paths get absurdly long.

"a standard signed int" -> "an int variable".  There is no
"nonstandard signed int" anyway ;-)

If we were doing malloc(len) using length truncated due to integer
wraparound and then strcpy() the whole string, it would make us
write beyond the end of the allocation, but in this case, the worst
thing that can happen is that we stop comparing prematurely, which
may make us declare that buf is a path inside the directory dir when
it isn't.  The two callers of this function do not use this
miscalculated len to carry out what they do, so there is no other
damage.  It indeed would be computing a wrong result, but "overflow
vulnerabilities" is a slight exaggeration in the context of this
patch, I think.

"overflow vulnerabilities" -> "bugs due to integer wraparound".

> Switch the variable to size_t. This is safe to do because 'len' is
> strictly used as an argument to strncmp() (which expects size_t) and
> as a positive array index, involving no signed arithmetic that could
> rely on negative values.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  path.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/path.c b/path.c
> index f613d8bbd1..56be5e1726 100644
> --- a/path.c
> +++ b/path.c
> @@ -58,7 +58,7 @@ static void strbuf_cleanup_path(struct strbuf *sb)
>  
>  static int dir_prefix(const char *buf, const char *dir)
>  {
> -	int len = strlen(dir);
> +	size_t len = strlen(dir);
>  	return !strncmp(buf, dir, len) &&
>  		(is_dir_sep(buf[len]) || buf[len] == '\0');
>  }
