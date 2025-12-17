Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5257382587
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982652; cv=none; b=YDcj3OwOvVQGw7K7B8pvcWUclh/wcL/hCSIgGc8sXxUzLLHPJGLBKUdV/rHh5FKZRyGWES/Wezs90FLr4X+hJ8c40y1OER9rUM1TCb0WVcMnp/cp0kwPpk+YKANWsH176ayP0p153UTJzcVzaN8hy/zhIwQoKbBAYHvEQjglxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982652; c=relaxed/simple;
	bh=WDEdITnHafn5ljOdIRoagI74VvF6rB8eCqB9aDOZiR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5tq7x6Q0csBqu9zjByMqlyWDv6wCqrMjMjg51TLbUo0Dt6rOHneOOkWuFWlbJopKyacQvrdrLytwtYiplSM9SWaO01dphsoJ5nOfeVZQWX3k9JwY4bm4eKthLLiKAsi3iNwkGv/0LTqvukxc1kLBKWJlJnYsZVGvlwJKPgfSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vddQp4+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uePL+unA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vddQp4+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uePL+unA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 688AFEC0193;
	Wed, 17 Dec 2025 09:44:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 17 Dec 2025 09:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765982648; x=1766069048; bh=OEzi/0D0ly
	mlt9+/KHtXZzD6yUO5LIhqalZwbkd3VDU=; b=vddQp4+1r13v8xUFRMQNe4d7Ft
	0DMx87hEDOSK9COJxUw/9+ZAReE3K7bwwmbe2fbR0MRmDx+hJPIoZSD7KjHEe0vV
	p5I3UteqC9g1UQN7lJYs8X9dDd2WJkEu5NM71V6FdfmzmPueQa6G6QNw8GnmtnZ9
	YhyfHPdrbgph5Ik5jPOq0tw78urmE64TDH5ZHTYbhmBRPm91zP4VI2UA2fAvMh8D
	wQLI9Lh5TiwvwZSN8gDZGrzCP6UY0lN1ggJNsTjzMbAB3RCRE3n/qdFkSleUTAD7
	+mOieUohkSrOkRrv6L3M82plsMYF9DxxSMkUtCT4qO9uVC2/XoOW3/1mxcfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765982648; x=1766069048; bh=OEzi/0D0lymlt9+/KHtXZzD6yUO5LIhqalZ
	wbkd3VDU=; b=uePL+unAsA7TFwNkNxhG0rz6AQiTSPVJ2MgBj/c9jHu1KayN3g6
	TpGMMRgTYpsq+aJYjldaADF8aXZBuJYgyGuifSauxFY26eQmDpj9+Tzxkj3soDXH
	htbYwzmYG0mSF8a0tJZDnsIWblSzX/UXhUUDbt2PBzjPPT5eoRlChEfPKLgsh/I1
	On5n42DdL/OJTRlbz4uJBrU3HDerSYn839Ei4ZssqnE7jWQtm15Q3uFOajj7LAvG
	XBQPDGEcqfrXZDfbzpl+xIUGeMpemw+2PtcMG5aUZHgegeSgHAivQFCPiSsnPdLt
	FMjtTAJPkBFBjZDvqYszVywDlsR1yPep3GQ==
X-ME-Sender: <xms:uMFCaTp0YRLmE_xwlD5cR53OPwjShbPxG2RiSyKVhvvR_8AKuKsw_Q>
    <xme:uMFCaVGQNIWzZzOxEPbHJnoRw0aI80mONHDjFNF-e3FMBODSTAIVIZvEyyXdTC9uC
    Ia6M4-iRbUwXZmZCjiUcXapB29S5UMsUfzgSYMF2M9EHyp4vALJLQ>
X-ME-Received: <xmr:uMFCadlANG4FqtEcxGSIYaKolzPgdJex9E-61w1foes8TLXksL04VR3hRBGjD3fAJlLN-1YcQoweSiDinWFAe6T5-rFujOB8XgSfPGVP6Ks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegvdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghh
    ihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:uMFCaQkWWb19bIkDKHaaruExXmgdRNaOjNRspam2aBxaTOrA63ly-A>
    <xmx:uMFCaWvzZzGAO4dQxT9icGQR9wvb-Rh13u298oXiOjw0jxKePd9-GA>
    <xmx:uMFCablHKqmXZIA7scdurrz6zG9krKdqn7eHvuoMh-oxUV_AXjhnSA>
    <xmx:uMFCaZvJz_0er9xzppM-bFkQn68eMCPUl-EcCETpn_Ikxl9SLWLiPg>
    <xmx:uMFCablDMWDWG4mEF0miB7Xq3z-y_GDcjecWUVk4laRG-3x9Z5ZFJAgJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 09:44:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4ca7c37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Dec 2025 14:44:05 +0000 (UTC)
Date: Wed, 17 Dec 2025 15:44:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] mingw: do resolve symlinks in `getcwd()`
Message-ID: <aULBssdzMOw449HI@pks.im>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
 <1928738b464915e3fb796145688bbfcfcc0fee3c.1765899229.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1928738b464915e3fb796145688bbfcfcc0fee3c.1765899229.git.gitgitgadget@gmail.com>

On Tue, Dec 16, 2025 at 03:33:45PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/compat/mingw.c b/compat/mingw.c
> index ba1b7b6dd1..7215b127cc 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1251,18 +1251,16 @@ char *mingw_getcwd(char *pointer, int len)
>  {
>  	wchar_t cwd[MAX_PATH], wpointer[MAX_PATH];
>  	DWORD ret = GetCurrentDirectoryW(ARRAY_SIZE(cwd), cwd);
> +	HANDLE hnd;
>  
>  	if (!ret || ret >= ARRAY_SIZE(cwd)) {
>  		errno = ret ? ENAMETOOLONG : err_win_to_posix(GetLastError());
>  		return NULL;
>  	}
> -	ret = GetLongPathNameW(cwd, wpointer, ARRAY_SIZE(wpointer));
> -	if (!ret && GetLastError() == ERROR_ACCESS_DENIED) {
> -		HANDLE hnd = CreateFileW(cwd, 0,
> -			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
> -			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
> -		if (hnd == INVALID_HANDLE_VALUE)
> -			return NULL;
> +	hnd = CreateFileW(cwd, 0,
> +			  FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
> +			  OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
> +	if (hnd != INVALID_HANDLE_VALUE) {
>  		ret = GetFinalPathNameByHandleW(hnd, wpointer, ARRAY_SIZE(wpointer), 0);
>  		CloseHandle(hnd);
>  		if (!ret || ret >= ARRAY_SIZE(wpointer))

Okay. Due to the change we now also try calling `GetFileAttributesW()`
in case `CreateFileW()` fails, which wasn't the case before. But I'd
consider that to be a win -- if we cannot figure out the final path
name, then we can at least return the unresolved current working
directory.

Patrick

> @@ -1271,13 +1269,11 @@ char *mingw_getcwd(char *pointer, int len)
>  			return NULL;
>  		return pointer;
>  	}
> -	if (!ret || ret >= ARRAY_SIZE(wpointer))
> -		return NULL;
> -	if (GetFileAttributesW(wpointer) == INVALID_FILE_ATTRIBUTES) {
> +	if (GetFileAttributesW(cwd) == INVALID_FILE_ATTRIBUTES) {
>  		errno = ENOENT;
>  		return NULL;
>  	}
> -	if (xwcstoutf(pointer, wpointer, len) < 0)
> +	if (xwcstoutf(pointer, cwd, len) < 0)
>  		return NULL;
>  	convert_slashes(pointer);
>  	return pointer;
