Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B5212550
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764485367; cv=none; b=GjPEmVHEfU7kXbP0/nEz86LZdD0mgCfCvZ6/qI9cTWN81C/anEa75/BBo+xu1/QBoIT2VyCaM7Z2dhX5XfiGkGxtfnuX1H1s7+U9OjR0678QzypjNmhgMOdU4dF62ZbX1jz62RDXygRfBzKrALIvx3AIC3y80Z8bwUj5stumHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764485367; c=relaxed/simple;
	bh=5oLPIge6nD7KWfzzJs3WdAC2mP7BXkcWIKOG2BQIrPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QnMn9jZFrYIeOIQtgf1yJ0IUtePXEOQxcizZ49hsAGkJGdIO49DJuy3ZyDQ7Fb/x+X04VlRYC/D3E7X7j4X7eV5cy9p7Clln92TX+0VF1qLj/ZyD7XSwxLu8oj9BHgqOy2/vlCDpXAsXikoBARu4IsLaoCQAvIPv72Jivq6hvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b1KRgJV0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSNFhDDE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b1KRgJV0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSNFhDDE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AEFA4EC05A0;
	Sun, 30 Nov 2025 01:49:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 30 Nov 2025 01:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764485364; x=1764571764; bh=0wHshfICfL
	dWpPi0i7tEdu6AsFG0T2+D/AKlFRQjjC0=; b=b1KRgJV0WZRD4xcSjJXlHtwJEg
	Em24C04qRNO70RXFZRm0zmIfFrut6nYProQyX4JN2k1NyFPqqbd20F/zzY95crIc
	w+MdGfo5W6jJEbQcVFabFIi9j/QuaJX3p2y+SIDptDzzGR7fNeO1vBnuvFeHLOuC
	a4CsGeO+60H1rc0lM1n+QGJ8ZYAZvB4cqeiDqVEXsrpuujPl5uTvh3MXjkvsN2Zi
	OqMgi+9Q5xPeeXmWtjZZ6AZ/DpRML/7todyx8WnaOe0p2WvvuOa5Gum+dUZZz4Sb
	0TTdH/aXKut+yRMYS1Zuiw4Yo47MjivmRBVxESCBrBlphP/EZu23MGGV/ReA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764485364; x=1764571764; bh=0wHshfICfLdWpPi0i7tEdu6AsFG0T2+D/AK
	lFRQjjC0=; b=YSNFhDDEwyVbhVrbw821ahfzuW5zZNzTYL3fhMgqIDCpFY4M/Q2
	w2E3Nc3MYxXcNXVc1xIcfgov1CxPUXcCbjx2es75ZARAZ8o7jX97P10IFt+ye1fA
	z6EM4udkkKTdIKKcqSjdtqLJ+NmBxHgbC9rG9lomU+Owp6KkAV/6XiTkW5zX9+HZ
	BGx+AIqQnCMJAnv1KIfzVF+VDdafHBYB92XIJ+EtjQS7R5Id1YInKsiw3MGC02qI
	ByqMVVq890BsmoksxCrcizlUg4bZxveTVcWZR49uInuyiKy4p/6SyMmPwYvHUMLM
	gjlH0tl4tPONZ2JGAJ3hrL2o6j+zep0bkDA==
X-ME-Sender: <xms:9OgraZd2BMw3tu4oG8FMH8xp9AE4KZ8CbD8qidJ5fBu8gw4LRdtN4Q>
    <xme:9OgraePo1IiuwXHMmEeToLeZTF_72QLWexIJRRrtockJV0Id9Hem4PyF9prG2xyJA
    jnPRTxiKH0o0jAEndSohIMz5mkzNA7KBlfVYtqHPDqdRrXOtwxO7w>
X-ME-Received: <xmr:9OgraXgoEYXO3yFfM9vAlTpvwTkG45emz1c3uE-B82SEvOJSF6VKe14Sceyzq2YbHnUyk8oODAVcOzd_se7fbnhhhTIttw3pXIZ9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptefggfevvdehheeutdfhleejveetfeelleekteeufefgkeejvdegfeehhedv
    gedunecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:9OgraR0ZakoqNlbdmy0HyjELGBerTfjiVQpZ_9CjS8SQccfzGRUYhQ>
    <xmx:9OgraRj1uft-Plo0Qd-ZuIdYtWK3__HG0i-5mOTummmA1QlTAApkGg>
    <xmx:9OgraRc5F1EcfKlM7zQSmBd_J8piO4pbSB1NsG8AGJSMRsdRSxZB-g>
    <xmx:9OgraUkMTX-YqeaV9ove23vc0qHaBhtK_6DnmQIw2tLuzMCP8aeBFg>
    <xmx:9OgraU67bSyVg3UGsUe9zmyazgAQJSgKE-MImHB-Ohkq824MxZylA3ZS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 01:49:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 03/10] mingw: special-case `open(symlink, O_CREAT |
 O_EXCL)`
In-Reply-To: <96e279f50ebc26084095e781cf58db233fa05b74.1764440906.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sat, 29 Nov 2025
	18:28:19 +0000")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<96e279f50ebc26084095e781cf58db233fa05b74.1764440906.git.gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 22:49:22 -0800
Message-ID: <xmqqecpgc8wd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `_wopen()` function would gladly follow a symbolic link to a
> non-existent file and create it when given above-mentioned flags.
>
> Git expects the `open()` call to fail, though. So let's add yet another
> work-around to pretend that Windows behaves like Linux.

"like Linux" -> "as POSIX expects"?

cf. https://pubs.opengroup.org/onlinepubs/007904875/functions/open.html#:~:text=If%20O_CREAT%20and%20O_EXCL%20are,set%2C%20the%20result%20is%20undefined.

> This is required to let t4115.8(--reject removes .rej symlink if it
> exists) pass on Windows when enabling the MSYS2 runtime's symbolic link
> support.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 736a07a028..9fbf12a3d3 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -627,6 +627,7 @@ int mingw_open (const char *filename, int oflags, ...)
>  	int fd, create = (oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL);
>  	wchar_t wfilename[MAX_PATH];
>  	open_fn_t open_fn;
> +	WIN32_FILE_ATTRIBUTE_DATA fdata;
>  
>  	DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, RtlGetLastNtStatus, void);
>  
> @@ -651,6 +652,19 @@ int mingw_open (const char *filename, int oflags, ...)
>  	else if (xutftowcs_path(wfilename, filename) < 0)
>  		return -1;
>  
> +	/*
> +	 * When `symlink` exists and is a symbolic link pointing to a
> +	 * non-existing file, `_wopen(symlink, O_CREAT | O_EXCL)` would
> +	 * create that file. Not what we want: Linux would say `EEXIST`
> +	 * in that instance, which is therefore what Git expects.
> +	 */

"Linux" -> "open() on POSIX-compliant systems".

IOW, _wopen() does not have to behave like POSIX open() and the compat/
layer is how the emulation goes.

FWIW, this is not limited to symbolic links but anything that exists
at the path specified should cause the same EEXIST failure.  The
O_CREAT|O_EXCL combination asks the system to atomically create the
thing anew (or fail).

    O_EXCL
        If O_CREAT and O_EXCL are set, open() shall fail if the file
        exists. The check for the existence of the file and the creation of
        the file if it does not exist shall be atomic with respect to other
        threads executing open() naming the same filename in the same
        directory with O_EXCL and O_CREAT set. If O_EXCL and O_CREAT are
        set, and path names a symbolic link, open() shall fail and set errno
        to [EEXIST], regardless of the contents of the symbolic link. If
        O_EXCL is set and O_CREAT is not set, the result is undefined.

> +	if (create &&
> +	    GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata) &&
> +	    (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT)) {
> +		errno = EEXIST;
> +		return -1;
> +	}
> +
>  	fd = open_fn(wfilename, oflags, mode);
>  
>  	/*
