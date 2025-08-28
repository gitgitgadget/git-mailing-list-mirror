Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFC18C034
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388871; cv=none; b=HHihKg4ilRrUO+CS3QUAeLlD2iU2x5TWRGDKjqH8xftVmSo1OfVZkFGKzrSRHUfC+cb4QcyXwHjPwrvh/H8oH9O6F372+lVruFUKUvrH+SiIh08vsQOV7SrydGNHL+Tu1Rcpw0ye5n2OmZXyaVOju+TPesESHUUhuKucv5Lzcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388871; c=relaxed/simple;
	bh=SmdZGAU0Q/fPv/rDMq52rQh2AtlzDSh0t06TPeQWJ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnC0FiNCpn+5XeKqX/yX8QEYmSbsKi48VyWaB9qvlISgwRMTm2UOzF/GtSUeIgyW5v51lFY0jkPdkEquqnPHGihrGljPUic/XFjNwFC34bf0nL/tR9j44gJQ0BN8B3If0QFk/iKdPhCZqLC/HFlc4zH0LISYBbBqx4QdPSjZAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsxP4IYu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsxP4IYu"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afe84202bc2so132285166b.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756388868; x=1756993668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMFOHHMvjf3DvDjQ06nLPcrUvtqPUwicW0sjMD1Q9wI=;
        b=EsxP4IYuz3qdeUJ2w/s2fG9Bll6MmoRJy+qioUmArzHlNN3+wQbacvRjivV6NP2tDR
         QwTUqMAziSVFrcHWFFZ/qX7Lbva7IU/6yW1MFbTn9riYf42COjAv7RkoS2ABjc+hLHhd
         Eaz1+CkYHNjO5CGBb+F4h4eLGZ8bzWzaHCdJZo7pI7bw9JI8Bww//YEa2ooRzJWYGqsM
         DYLP4Cs5wNRU0dau86O9TMW/KWJs0VSe4yJCAxziEC9R3haAn9H/7gWu91iaQX/3eAxd
         mLTyifb+PhYi3C5Cjcz6JtV0LYY2UliqHAEABmCI73NGXNuwg7HMs/K8Qb/A1Mc1YuaR
         rfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388868; x=1756993668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMFOHHMvjf3DvDjQ06nLPcrUvtqPUwicW0sjMD1Q9wI=;
        b=jEm/NCZt91JPO4E3MKvUMtiw5uOUgMgmbZ6piAwLH3RxJCPJxKGAlcsPq+vH6ZBXHo
         0vbS+7TUqV5PDuegH+Lx2GRmEqmbfszDz2Nms+FwQFvFTAO5kWwCAXM7ndsVn+Hcrv6M
         MJN1CZy/P9pVilK8PpocFAW+nMIiPYCRhX1P5c9Hm+idaDXCEy5Y069OzxNiAXTM2PaZ
         RKLR56Q9dameroeQ0ENTinZybdx1NH0kD1+M1AjQ2aQSpT3tQ21qm5I8qW3PpXNC72Xi
         t8HKq2ISj63VGgssJjTEfz3hHLuJyBR/iN/NHUMDjTcVIczD3m2iseQwz9BJn63IwP1Y
         4KGg==
X-Forwarded-Encrypted: i=1; AJvYcCUreBqlt37FCczwOF1UwkLlNlF8KbuQg42BUW5J0EIKesd27g6TtyTLEeI5RYUlqOMEgKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6KdZaEPQnJUIC0PRsq+1dbm4hJROaMiQPMct+BCc65NXvWfx
	pFaoYe3PThOI/irwqUl+0DnSxqQsrqkLRuNTI3NsO+WNQ7ig5dVLlXwjxbX++mO0uLY7nMyfZkf
	0rAO+Ffp5Z9gZ5nNThdkcsT2YQ30xHOI9Ug==
X-Gm-Gg: ASbGncvX6LL5XQYmT+XY31W/SorW0rmIjlF1zFolGAwXPQlrFgkJZLsKqcPmGmbGvB2
	kwAOisVa+5mJ4brkvwz8VkvW8RbVEC+OKC7nKxKA5DV1pEfMfBamriWkN7TOhvsouR2xVP4Itgi
	TtPg9h42QG7oCMIEU+G2+QyP7GC/o3UQIZP2O/pfd09PeoAlA2fH6MtyMRxXL8uhGmOhzjesgM6
	YVWnlPQ2isPoAWi7YYX+IQSbN7Q/GsFXgpD01IwcbRAmRUkpX/xF9MQiLDn5G4=
X-Google-Smtp-Source: AGHT+IGQZDBBBYASq79nZQjCWO37udDbnaR9Eorph2lfWK7No1XbwFCBkPKgKcOAxQ5GsZB91vhfHVb3zUxabwPkdyY=
X-Received: by 2002:a17:907:3daa:b0:afe:c9c4:ac9d with SMTP id
 a640c23a62f3a-afec9c5d5e6mr522475166b.51.1756388867518; Thu, 28 Aug 2025
 06:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <370f11e1-b335-4111-912c-94429c5018d6@gmail.com>
In-Reply-To: <370f11e1-b335-4111-912c-94429c5018d6@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 28 Aug 2025 09:47:35 -0400
X-Gm-Features: Ac12FXx4_vx6fWHEW1vzeiyzuqUDioUc5ci_jac6k8hbo4cjWkeZmOhnC1fSnWc
Message-ID: <CALnO6CBbEB=94YsZn8vtjcwYENuMhMdg_wb2RbQunVCxnf53jQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	chriscool@tuxfamily.org, christian.couder@gmail.com, me@ttaylorr.com, 
	ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:04=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Usman
>
> On 21/07/2025 12:55, Usman Akinyemi wrote:
> >
> > diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> > index 6824581317..9fcebb7d94 100755
> > --- a/t/t1517-outside-repo.sh
> > +++ b/t/t1517-outside-repo.sh
> > @@ -110,8 +110,29 @@ test_expect_success LIBCURL 'remote-http outside r=
epository' '
> >   test_expect_success 'update-server-info does not crash with -h' '
> >       test_expect_code 129 git update-server-info -h >usage &&
> >       test_grep "[Uu]sage: git update-server-info " usage &&
> > -     test_expect_code 129 nongit git update-server-info -h >usage &&
> > -     test_grep "[Uu]sage: git update-server-info " usage
> >   '
> >
> > +for cmd in $(git --list-cmds=3Dmain)
>
> This lists all the git commands in $PATH which is causing "make test" to
> fail when I run it locally as it is testing all my local "git-*" scripts
> most of which apparently fail this test. If there isn't already we
> should add a option that lists the commands only in $GIT_EXEC_PATH and
> use it here.

That should only happen if you set GIT_TEST_INSTALLED or something,
right? Or maybe some even more exotic setup: even with my
distro-installed Git, the command doesn't list my git-* scripts in
$PATH or installed extensions (like git-when-merged).

> Also when I run the test with '-i' it does not stop at the first
> failure. I'm not sure what's causing that as I thought
> test_expect_success should exit on failure even when it is called in a lo=
op.

That's odd: when I make some modifications that cause a failure and
run with "-i," it does stop early. Hm.

Thanks for looking carefully! I'm personally having a hard time
reproducing the issue though :/

--=20
D. Ben Knoble
