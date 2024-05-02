Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1FD527
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622540; cv=none; b=roWCzw38svusxT6v7nLCv2gZ1cp6pYatKOtGwHNft5GvGSsFJm0irJbSYVqFiWyaF/aHaVIEIV/ErFFoXknIlgl1Ors3p598RVpCXYwjDSzTjn2UbNGFt4xS0Izi0vBc3+DVun7LiHphlTs2hVgUjLI9w1wfm4xP7ZqW+kCHtl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622540; c=relaxed/simple;
	bh=O+dpOAJEgNEBZV6rc3/uZn0UX7FCpTfw+Eeeui5DVZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTWwG8t+nDYTCM1pg+v7RbeHybI5iLPlxqR8fYKkaBLQiz5rBM17MVCrZER0iivv1qULklHpsokA5CszXRcmPcY6JYr6Wiu65+kBbtiF488aX0S3O/DP312rQSCsy5fwEZMlL9DAURRsbccynj1mHuF3N9w5e2lR2yJvTe9wOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=lQvEodFx; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="lQvEodFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714622528; x=1715227328; i=tboegi@web.de;
	bh=mrBdtcm3SvPpzR2Xmu2YKrb/3fYy2dcydBDBpZF275k=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lQvEodFxpWOVYyqekafdAaz2414UstcEyk6bEdF/xNWoSmftP1t5C13yL+ySaL9D
	 GlVEDj+/CWidKhvjbt+LQP16Hq3iJTd8THW4maLh22nQh513+83uNqcANVaBr312S
	 XxB+C4cZFX1osKx9m5uj6vnNGR3YkEhIS6Up6SgdVeRXciEaub6uSiWl4U453ip4X
	 Qg+35QUimTirXj+0c0as8InbhuoJxnHVw+G7F1coLMkDU1r1Qg94h9S8R3Hf2crht
	 41IvbDolyyga+GPSYx9X2IV5m0md9hX6X1sRA1GEiG39TaMUrm/U2wEj0U4Us66gq
	 ENVQyWYCUM+24Fakgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1sac0a1IQG-00hJUA; Thu, 02
 May 2024 06:02:08 +0200
Date: Thu, 2 May 2024 06:02:07 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Matheus Afonso Martins Moreira via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Matheus Moreira <matheus.a.m.moreira@gmail.com>,
	Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
Subject: Re: [PATCH 02/13] urlmatch: define url_parse function
Message-ID: <20240502040207.GA26134@tb-raspi4>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
 <13b81b8aa06cfd63a5fd9d1acbaf21a8b388ff47.1714343461.git.gitgitgadget@gmail.com>
 <rt77kwzaia3w52o3hoeodjilk5gkh6dz5dip6wmn5hia55gp2r@5fznbu2ljdqy>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <rt77kwzaia3w52o3hoeodjilk5gkh6dz5dip6wmn5hia55gp2r@5fznbu2ljdqy>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:jWke4o4FFCZc9n9H6PU1eTdp+EjN5iaDJsO5Qg19F5ZBSh6smUo
 DJe70BZy+Uf3Dx+JrVJB3nhCNu7QzZs4By/BnHgGuk0iFhWrFA5qm66xh06/IC3F72kb0KE
 QX1u8BnNho6TOjViDOkjo2fHZiTmo4vofRcooZTAyue1mB45Q/2c/FW4MzH4vId4/2F3uiG
 eAzLsZu0wv2ujuvadptug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s6h/l5fPrp0=;vyBa3tMbtLfT2R3J3XExyM+jBvw
 l1WOF52p0QYBXz8IfYuacY986mrtT86r4PylPvSkymFoaa/4Om/JRJf/oypucKlGAtfD+qOSv
 svbNMBFGL+yp4yVFeBsiZHlRzBrpatlQoMkNQiXQdRG3CbtHFaSIGksxGV84w7xBlZC0Fc8ub
 m6v4pJtno1pKAvjxb4v19urX0QLrGEtHl+c7uXOBMM3hWe0/YbYU75aigC8aH+1pMDog3kt7L
 T/Ez/9G8nAjhnaFDAL25yIW8Mm9iCXUCi6sBi0cH0LjnkKFWjuE4lTNMtq1UuqW1v/yudTKjL
 U8hVj0sL9XUGcCtrngdvZXEhG1C7wHKm1WYUDqo9xE7s9PTfISqq4wHAoJ8cJTdCc11mKGSMV
 8X/pQxcO02J7z2PaJYBxrbgud8LUkmLYWuBD3oO6PmGk+UnXK9woB70ftEfzfuoRlVPpabmU8
 aOnhiIPu+XocbaAvStjj0f8VVvwM6nuLg+3cVdWPkqVp5tXd2sX/BCSPZbar6V/UmAVlSVEjF
 EazQQLGDs/QehiAdSHp9+dEHuGzPSkN46CjMnKpS/R9QfUJqV28aJeb2c34vX2FwvZzHrQQnT
 DikMxJssyyPa5QXxmfbEzE0/dEzICTBqQXnflfoMAiDgkozsEZTltac6U27LV4O8UNBKIusR6
 VKfZL2/+1wNIq4DmbBmr02bN6TB4d8IM0x65M42oX50CfaiKF6vVi92sLcFJ38tg234m+ENa0
 2CHs2PVPBsgsx7OrrDjTQke8qckTMC+WOuV72npdgmpSZDKPXGhO3kzeou6j5NQ74DQfvC4MS
 ft56qrHNqYQpAvT2hUKk4/le+jFC5iebgxLrgXQJPwD0I=

[]
> Interesting.
>
>     `
>     $ ./git url-parse -c protocol file:/test/test
>     ssh
>     `
>
> seems like only having a single slash after the 'protocol:' prints
> 'ssh' always (I think this may not even be a valid url). After this 'els=
e'
> block, the url turns into 'ssh://file/test/test'. Will examine the detai=
ls
> later. Not that it's your code's doing, and rather the result of
> url_is_local_not_ssh(). But just wanted to point this out and ask if thi=
s
> should error out or is this an intended behavior that I can't figure out=
.

ssh is the correct answer, try something like

`git clone localhost:/home/myself/project/git.git`

It is the scp syntax, supported by Git as well.
=46rom `man scp`

    scp copies files between hosts on a network.
    []
    The source and target may be specified as a local pathname,
    a remote host with optional path in the form
    [user@]host:[path],
    or a URI in the form scp://[user@]host[:port][/path].
    Local file names can be made explicit using absolute or relative pathn=
ames
    to avoid scp treating file names containing =E2=80=98:=E2=80=99 as hos=
t specifiers.

So yes, they share similar problems
with the ':' that could mean different things when using the short form.


