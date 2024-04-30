Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3141A0AED
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496331; cv=none; b=sVri6c35CpSCHALUp0G/TY4IeJ3a3ZMC1Lg80iqOTKvg9zMWpEGE4GDy1CQ7qrVh/b8t8fGfFcLPisr06NoKVTiL2Z/JCoqdD1jbC6E+KdRniwse0x4s4JmI69f5m3VFw2tC9tzmJMNO8a3iJtlCa4e0XyiYD0vkJQG055SxWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496331; c=relaxed/simple;
	bh=QF4wIvKYBa0EAIQudoFdyauA4Q1evMOOoPo5zeT5ZRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF8dsF8DuZmDIgZ7NW9ZbB1VRSIacB6hQBvuUvH0u/TKho6ogvI7l3kMSyxxWB4Q8vcg25qSPigYsj+1t/VbWyoI0XCUlt0rHfmFNY0+1YvL0snBxatu6vo2GRju+CnbyfmG6rqqT8LROY08mpsGkQ8SFQOALIPInqp1OqZX1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=TxYwa84r; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="TxYwa84r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714496314; x=1715101114; i=tboegi@web.de;
	bh=PnZ5MyFQclud73SBTmQK8lDuudz9q+vFQ3KZ06qNWms=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TxYwa84r9bCD+1XfeqvxBqmiG320Ehdh/hXkF0Cxuq2KNpL1oB4O4Snl3dIze15a
	 BepmJnV9zBKLgvrTGUNCF/R93pWL28ziIubXb1IKq9qEE4GQmkWPEXcCaLNvoOa29
	 b9VmKno5bcQT5BkT1VdCI3+berFVZNrO6ks6rZCG7XyEY1z5Im/KHJSm0ecLgmFtx
	 G7/caLT9TryXrL8yz1qFWueiWrqxWTqOjPJ7pyp6aqMbF2wZAsDTlL70dGv6VHy3P
	 VYmtlzaXrE/G49NpiTEqm/mupzUDg31EAw0Q4qoAvLZiOAPg2J2AyUgFiiilny69b
	 s7CyQuPivf1D5GZKKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1rzg0o1X2W-006oyu; Tue, 30
 Apr 2024 18:58:34 +0200
Date: Tue, 30 Apr 2024 18:58:31 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: "Jun. T" <takimoto-j@kba.biglobe.ne.jp>
Cc: git@vger.kernel.org
Subject: Re: [BUG] 'ls-files path' fails if absolute path of workdir contains
 NFD (macOS)
Message-ID: <20240430165831.GA3546@tb-raspi4>
References: <55D75808-70E0-46FA-906D-C00CD612A262@kba.biglobe.ne.jp>
 <20240430071247.GB1504@tb-raspi4>
 <44EB4C2D-5C86-4448-B8D8-3E90F75DB5CB@kba.biglobe.ne.jp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <44EB4C2D-5C86-4448-B8D8-3E90F75DB5CB@kba.biglobe.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:0p2r5mwsFjM2rchuxU+HC+U6nMjFLr7jC6EC08/mxtIyeLJQv29
 WB+2vCGKye+0PCKP+HiTfmthpzVdDZI4XLFRNXQvT5Rbu/+s5noMkM+RWJOJ351J/TsvBfb
 2RMxbVXQg7CyuN2anqFAh26410KOGdA8qIQTF4lpChYY/3p6Tce11Pk1uB6NdGFOpyrTMwA
 1zfPexTOEjtzhdpBq3+zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:19DnCGEx8fE=;zPF3GeS8KUt49CUD0q9MZj5SE6X
 Aoh8QCNjwZchaliyeHgUGyKUhuKPEFZQxWjCjrJuV1vdV5uK5A4HAJ8K7zLX2Z9YejYowhPDF
 mkQxi902u/xeHrmlp4VNTDLctuEvdioYpX+Nd7g8Gsb8SuvRMaNHAQobAWfJfAG6UnT08ECt4
 KADcaygdjM9Y+etSEvoQJxngmvq81spAhpb6DhBqGku8g/dNvIkrMxJkBGlkyZAlPNoPxXdCY
 jMuQTt9gi5OVYRxaURRFZqtepYqF2HfwH7b+VmURsk/3p5FZtycPlPyuQrHWwZExGSu1jSBFZ
 xP8FS+jpc224KgDDs2NT0/i6S25Q2GVR+HWTrHT7rqbkvqYfem2KjQzTj1GP940udnu5lx0aI
 BCOTTJl72my1i+wn672sYlIZlxKRQE/FMBnaIYdO2UNlLS/wQCc7hfgYVFs5kylW8cq+ZXx6h
 NdBywEWihVmYXWZBGbloMW8/4DDD6ja4yzySBm918fC+wgO1X4ocmBbKgnNaqf/nrlewGeSY6
 CVnYfz7BHhL+c0fMy9AcFMraaOQUXnZV2q8Yk029erHuNMf2X5kiOuCJ5G/vfJyKS8zVFwcLr
 rSrLa1jnkBuDOE7EYMCY4XmLzVccsZhfOAZ8JUyMEUhGD0haNY1HuV85Jm1ZPo9Ja7rSaDBBl
 zd3taJow6dkz5/w38tLak2vuOUOTrh8ggt+vt2Li7x7n6naRVP1xP/hRS4NwgPB5BloS5o9CG
 fP18ZkgbAbP0SyQCql8H/N+F0PiMbA9tlLnEpYlO00mfI1SDpj6Vq69eiEyWH9HSLGcxFd1dM
 L26gGztWHsEi5CUCFp7wOW5gI21Oj0UcenRMeUtTnbNtU=

On Wed, May 01, 2024 at 12:52:38AM +0900, Jun. T wrote:
>
> > 2024/04/30 16:12, Torsten B=F6gershausen <tboegi@web.de> wrote:
> >
> > I am familar with the NFC/NFD stuff, but not with get_git_work_tree(),
> > at least not yet.
> >
> > If you have a suggestion for a patch, would you like to share it ?
>
> Well, the only thing I can tell is the patch below _seems_ to fix
> the _current_ problem. There may be other problems, it may introduce
> new problem(s) (such as memory leak), etc.
>
> But I don't know anything about the git internals and have no time
> now to investigate further. Sorry.
>
> get_git_work_tree() just returns the value of the_repository->worktree
> but I have no idea where this variable is set.
>
> get_git_work_tree() and the_repository->worktree are used in
> many places, and I'm not sure changing the function/variable has
> no bad side effects or not.
>
> And how to convert into NFC? By precompose_string_if_needed()?
> Does this function allocate a new memory for NFC? If so, do we
> need to free it at some point?
>
>
> diff --git a/setup.c b/setup.c
> index f4b32f76e3..3f2f3ed016 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -47,7 +47,7 @@ static int abspath_part_inside_repo(char *path)
>  	size_t wtlen;
>  	char *path0;
>  	int off;
> -	const char *work_tree =3D get_git_work_tree();
> +	const char *work_tree =3D precompose_string_if_needed(get_git_work_tre=
e());
>  	struct strbuf realpath =3D STRBUF_INIT;
>
>  	if (!work_tree)
>

Thanks for digging - I have spend some time to find the cause,
but no success yet.
There is even a set_git_work_tree() in environment.c, and that may
need some treatment - or some other place.
To be continued - I will continue digging, where the NFD comes into Git.

