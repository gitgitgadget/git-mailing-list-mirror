Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA02576
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202322; cv=none; b=FbxoGEsC1vm+PG0biBaaO7f2aqHTRQIl5cL2IvQEnjqgeR/H+zMdoOcraXBfppnVmbCLSRT/f7ZgR6cpB5JjYdzRkcCLpuhkIQtUsa607y2EZ3clh9S9FSh1T23V74vyY7+7xu2qfE1Aa5OvqIAgAI5S74dWYRxMndwZcg9BMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202322; c=relaxed/simple;
	bh=DcGEbyrpPlH3Q+B5o5EgTLC/jaMIHiLuis6dMdVxoys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM0U7tDpfZ+2i7YuJgJqVx8EbdA1caWCnRF40oX4oOqjD7DTcSn1R8xcJbavQhnKGjRehmpvYLIyQnyRcE+hxJGih2AfNdguFSDyj6hlz2MRh9LdqG3djQVslOSiHhUPDXyzoaYym5bsUkpAAZAf0DDu0T2oK+fXW5Bz+9t4qA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2rYovtg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2rYovtg"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae9be1697easo10833966b.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753202319; x=1753807119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KwptIIKaI/vp+sKmPtRFlojmfwFzF4FuxEoNiAQTTw=;
        b=A2rYovtgjeXa5sMGvdsRE4gi1Fju2bHDa+8KaPMhtK9579KUxfP4fGEMDVmTP9jiPF
         udtpPgESn1K8x96OWaWvwSHPMDQYp41tYyAd8TjVaUdVKuYMASetI4E/TCnILqagBsMd
         0WwZ/3NANJjvGwZCeRHnSdLK7JdU6kD6NMfFoV+sJAvI3G7tyv0DPnnc0hFUXz/y0cfh
         yrN13KHk5gghN0v7qdAHqzl4NqxzhvzeDBlRHdrLbEMkTD3QHAL2BQVkSAEjkaNm7I3F
         s4zrjKltb1XwCWFQjsIxNExPa3WUYoLzsd1zY9mrDZq+LwIvbS68DHbQAaQAl6VDf+vn
         qX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753202319; x=1753807119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KwptIIKaI/vp+sKmPtRFlojmfwFzF4FuxEoNiAQTTw=;
        b=E8KjyDEpBJuqYq8NFl1yqvx4Fd1y/F+oiOTCDf/UCn5X8fjW21jE+uMaTv9K7XtmVJ
         BAEXIzFEtc4aVtJrIrgXtjISR2iCCldbOKSOmNNGaxxq7IqIYNCgkezc9Szf1lknTAnO
         oXXFQc4Hji8fZdzLe6n9UKlan8i8LG0bO6bcXTiOiZj5xEkfXxaF74RH2d5KnweScXHM
         mVvN9XGt28N8j9arFPWMUyeLvkf19H9rBKskIgmSn7e6p7LKUPPD8cl84dYsbvnaVAgi
         XfW6BwrGmlqhCr8PkZ8sWPwHPN/V1EAiLlEqlYnP62xtJXddiKAxa103jkPCoY2vPw8I
         FWQw==
X-Gm-Message-State: AOJu0YwTfZ/Gxm80ZGrtRYcVP+KOmc+rRUnlPqFaghJc1yfNtrv0UmBn
	j9sRfNQwyJMWp+DQagJ4pgfpZSO4AqfKtXhfa5Rc0L902CONyrCngeFUNlRPI8d9Tr60siM/hJM
	aQquTdEMZIGKOVx1gDS6yLkvvl2G1R6w1aHhcFsw=
X-Gm-Gg: ASbGncvwmXmMqgaRA53px2wftZ/t/Ks994uYItl/g2Me6hvpVTfb7TpluYzjiGG5KWG
	z3z2w3aSVWN94rrUmtdubFhFVzCMzQn3QeAUTuccSCYtjf7Zz1Ayx1JJUOVb7qd07w0zd8Uxep4
	L32wlTCoN/nDgbAjoB4M4vrNubuc961pm0+7LEHNAv+7hjNTpTjiQRbITp+03bQTEdcAG03ycqc
	0NSQI4=
X-Google-Smtp-Source: AGHT+IH666amZyR8sz+uJk7QmZNWUooj0gtlTcMcCDEcBOeuaKBEf6pvwe6949ORnt8Zl7wtOibYBmCfwm7oxrxvG5k=
X-Received: by 2002:a17:906:fe44:b0:ae0:c1c4:645 with SMTP id
 a640c23a62f3a-af154e33d9amr369419066b.21.1753202318838; Tue, 22 Jul 2025
 09:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=FFpNPLEYsajBZqhxhnD3-642t=qQribO+oNDF5-3hhuxDnA@mail.gmail.com>
 <865894a2-ed71-5a03-a708-585cbb591ce7@gmx.de>
In-Reply-To: <865894a2-ed71-5a03-a708-585cbb591ce7@gmx.de>
From: James Gao <thehighmountain25@gmail.com>
Date: Tue, 22 Jul 2025 12:38:29 -0400
X-Gm-Features: Ac12FXwPNI6nw-xoztx-LdzGJEh3j66kJr96V-C0DW4dMJiKMdp6Lq01lxeWpxo
Message-ID: <CA+=FFpP-_TkD0O4iOjL3EEHBKnxxqGOfChR6pestqt6kjkMQoQ@mail.gmail.com>
Subject: Re: Bug report: latest (2.50.1) x64 version of Git for Windows
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes

Yes,  https://github.com/git-for-windows/git/issues/5737 is mine.
The clone is already-existing on my drive - background story is, I
reinstalled OS, and tried to set up my development env again.

Repo is in a normal hard drive (not cloud, not onedrive, just in my
local computer).

That is the all error message I got.

lts is actually LTS (Long Term Support). Term might be misleading, I
sometimes use LTS to be latest lol.

I am sorry I was not able to use git-snapshots, I downloaded
Git-2.24.1.2-64-bit and it worked OK.
I might be able to reinstall the newest one, and reproduce, but I am
quite afraid to do so, as my 20+ local git environment is at stake
haha.

Except that, I am happy to help you handle the issue.

Thanks!
James

On Tue, Jul 22, 2025 at 5:47=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi James,
>
> On Mon, 21 Jul 2025, James Gao wrote:
>
> > I just installed my system, and downloaded latest (2.50.1) x64 version
> > of Git for Windows and installed it.
> >
> > I am on Windows 11 Pro, 10.0.22631.
> > Git CLI is not getting permission to the folders.
> > For example, I cannot run git init - error: couldn't set 'HEAD'
>
> Is this the full error message?
>
> > I cannot git pull or clone or git add
> >
> > It returns me similar errors:
> > error: unable to write file
> > .git/objects/36/dd1796da4dcbb2f53005b64afeef698cfaf510: Permission
> > denied
> > error: src/helpers/schedule.ts: failed to insert into database
> > error: unable to index file 'src/helpers/schedule.ts'
>
> This suggests that you somehow have successfully created a clone... how?
>
> > I tried running git bash as Administrator, still not working.
>
> That is interesting, suggesting that the "Permission denied" error messag=
e
> is misleading and that the error is not actually due to missing write
> permissions.
>
> Can you say more about your setup? Are you trying to clone onto a network
> drive, for example?
>
> > I am planning to download older versions, but it would be great to get
> > it fixed for lts.
>
> I don't know what you mean with "for lts", but yes, it would be great to
> get it fixed.
>
> By the way, before you download any older version, do make sure to try th=
e
> latest snapshot from https://gitforwindows.org/git-snapshots/.
>
> Ciao,
> Johannes
>
> P.S.: I assume that https://github.com/git-for-windows/git/issues/5737 is
> also you?



--=20
James Gao - Big Dreamer, Fervent Developer, Forever Voyager

LinkedIn | GitHub | Gmail | Phone
