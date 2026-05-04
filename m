Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDF3AA4F8
	for <git@vger.kernel.org>; Mon,  4 May 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903957; cv=none; b=eRRl9TlKzzpwPtHKv3VTcEDoATxGyFIlP/FIbvPmFRzRb5RQsEx7BMmcABjeKVXFHvTtqvf0OaELu1P7bOEG+wopplM2f3DP/ha7dJmtYOlsFk+rAgPrYDrThsgL1x40l+BL6Gl1m8wujr+GR3Gz/9FfV6u0FBo1/79qCB+jm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903957; c=relaxed/simple;
	bh=yVn55N3+WG9BRFEIIlPiaZuC5Kl+hMI4X45f/tvy82s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OREbk9jlldZfS73M0BdtL1WKae48iWd6gQjCPXnS6qnVeEBBabyUOLzrayiY1zK6u95lP8ILFpZrHrhz3r6MLLBRqpy/leeMrxd+Oj9ceuIY3OFStngjayBGu0JMxtd/Q8GdnYezIMZlGHiZptDOXzTBHr6K52H3+nM2efXqWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GCNFDZ5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QB4FKH+e; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GCNFDZ5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QB4FKH+e"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CD2E1D0007D;
	Mon,  4 May 2026 10:12:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 10:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1777903955; x=1777990355; bh=ZOLuYvOIvf
	EZw4qmXolIlOWcQTM1VVZ7k9xaMrbbEwg=; b=GCNFDZ5H1JBPc7RXcc4gJJiuRU
	yOxJXhd8vbjMj4cCiozJn/5o9sJjonNLU6+kMuOPVlWLDRHIYtICIwCIkd5fs9XX
	+W30qFQ+Qu12knj2OSP/grsveh0ihaKHHB47hL3tckaNmzyR1V4DlC//XzQP759M
	V6xyYJ4cP6XrkTi6WzK9iCIVyyG2vu4I1oXb8JyV4CYDe6u4Pp4dqAM6ZrXZHm7T
	ZRa7jW0UoStA6+rlQQdcmPLVCJiGlCuwN0FMq/apa2uHVxIWU/iqSL1aN7H/G5e+
	aqymhv5UxTKrdR+YeWxnlOFlfXyjLyGGGGjjGCDpDMQp22g8hJH1FzTu5zuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777903955; x=1777990355; bh=ZOLuYvOIvfEZw4qmXolIlOWcQTM1VVZ7k9x
	aMrbbEwg=; b=QB4FKH+etGkTGRKMOZBR3OC+k10e8LcxbK/QJHiRZwAvMVWdxDl
	flRuRmVmlO0sTfDLdzryPVf1+BXnXrs6isx8NI384IvxPOLbR63TcFmycsJFKhLP
	gb30T4vgFJAatgIaM4qinAU+Gew2SKM84sAD4FA1vi1pc9uTC302AUEm0lCq42uP
	a5bWKJoPjuCkyA7k24xgV2zg0G4HMV0Ro1JxlJQfL9HN2sRDH/KR9oQeZOqjlyOm
	oJcoWJsAlBYcCbq9quGhLSF+2sb0AYPunn3SvReGm7jhRsJeOuqt9hmwMu3PRAPR
	aUjoH3ko99DS2y/tsskj9VcOSNlrXqgUCvA==
X-ME-Sender: <xms:Uqn4aUW2mEIaTCVONdaF504u2t3GSHJn7I2AYMUPoHOaZ6kO2bAXBA>
    <xme:Uqn4aQCRNR43AUtr6ON5mZqJxcQq0QSBR90vwj5wMOp1z5lY8wYauHT6E-11K3So2
    eHNKkhGgGuThi-RJ5xHlERIEHFVRUy9S-zBFjsK6FrXZnWD9fIO>
X-ME-Received: <xmr:Uqn4aVzFkt2X0qKWvOJF3nZTSXkNz324_tJ2GaUKyBLRXwAxH87hL8aunkEuRO5yZvmUdkmXiwzTPlPFyAFZxxPBEZOcM0RleA02Vsr3-Ok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelledthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Uqn4adAzadbdXzEGvvU4Q4oTsL223lJ4YnfslaRnZdy6HTJQyLiu_A>
    <xmx:Uqn4aSZreV0YJEdb3v5Qx3NPy8DqosoCgLIneqxsUi9quRP8HmhrUA>
    <xmx:Uqn4aVhEkKgxvoz5eC8HakeCEZgC9J0uYsWBGIbStrA1n1mHlmA91Q>
    <xmx:Uqn4aU4zxyGL9J6t3GjE9cJHpvteB6akg_rcUGDBXUSl5HuQIpVLuQ>
    <xmx:U6n4aRidNp4Max-pM72-3krF9turmfP0V3KEuiVkvXTnmCeJvBhPunwR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 10:12:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d565375 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 May 2026 14:12:32 +0000 (UTC)
Date: Mon, 4 May 2026 16:12:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] mingw: optionally use legacy (non-POSIX) delete
 semantics
Message-ID: <afipTWyj2zVYYqMz@pks.im>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
 <97508e91b62c91b77447dbba39a84770682591a8.1777380768.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97508e91b62c91b77447dbba39a84770682591a8.1777380768.git.gitgitgadget@gmail.com>

On Tue, Apr 28, 2026 at 12:52:47PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 2023c16db6..04f9aa3922 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -449,20 +449,63 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
>  	return wbuf;
>  }
>  
> +/*
> + * Use SetFileInformationByHandle(FileDispositionInfo) to force legacy
> + * (non-POSIX) delete semantics. On Windows 11, DeleteFileW() uses POSIX
> + * delete semantics internally, allowing deletion even with active
> + * MapViewOfFile views. This helper simulates Windows 10 behavior where
> + * deletion fails if a file mapping exists.
> + *
> + * Returns nonzero on success (like DeleteFileW), 0 on failure.
> + */
> +static int legacy_delete_file(const wchar_t *wpathname)
> +{
> +	FILE_DISPOSITION_INFO fdi = { TRUE };
> +	DWORD gle;
> +	HANDLE h = CreateFileW(wpathname, DELETE,
> +			       FILE_SHARE_READ | FILE_SHARE_WRITE |
> +			       FILE_SHARE_DELETE,
> +			       NULL, OPEN_EXISTING,
> +			       FILE_FLAG_OPEN_REPARSE_POINT, NULL);
> +	if (h == INVALID_HANDLE_VALUE)
> +		return 0;
> +
> +	if (SetFileInformationByHandle(h, FileDispositionInfo,
> +				       &fdi, sizeof(fdi))) {
> +		CloseHandle(h);
> +		return 1;
> +	}
> +	gle = GetLastError();
> +	CloseHandle(h);
> +	SetLastError(gle);
> +	return 0;
> +}
> +
> +static int try_delete_file(const wchar_t *wpathname, int use_legacy)
> +{
> +	if (use_legacy)
> +		return legacy_delete_file(wpathname);
> +	return DeleteFileW(wpathname);
> +}
> +
>  int mingw_unlink(const char *pathname, int handle_in_use_error)
>  {
> +	static int use_legacy_delete = -1;
>  	int tries = 0;
>  	wchar_t wpathname[MAX_PATH];
>  	if (xutftowcs_path(wpathname, pathname) < 0)
>  		return -1;
>  
> -	if (DeleteFileW(wpathname))
> +	if (use_legacy_delete < 0)
> +		use_legacy_delete = !!getenv("GIT_TEST_LEGACY_DELETE");

Should this use `git_env_bool()`?

Patrick
