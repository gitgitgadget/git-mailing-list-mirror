Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FF1E884
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882517; cv=none; b=BRS1GZpyGF8gpQ3lL8aEBT7hnom/nnbF0D5nXq7gtjXAlgVfz7Z/GTAbNkuRIQZH2Lbcuzu82YDtmBoUOzB5Oxl48Q4vSvti6YcvuvnQSMZZR4TTGjSfOADknCWQeuOVQNCkEVTcp6zAYZxJRFtU4UtS3pt9HbSmnB+T3qEFsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882517; c=relaxed/simple;
	bh=8njvtmEZx6TXh4qf73sESW5DrEMaa05/1N3R1ZJ7DTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9UrS4wEIptoZx+CLagmzSyZ1CMkmKu6Ydi9U113HOQGoeLbCMRRwTmd02UCUxOK/ghrm5e8ImW1yJNHGBj9DRCm6/wc/sbhQFulYOtvrC7OIQoM4wEOJcTmZgLjR5PQgwqViaHdm92wqJoibgV1dvAP4ej3eANHKTvfTWx3wBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwIRDPbe; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwIRDPbe"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso2919072276.0
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723882515; x=1724487315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGxi6erbOZBopKuA4vdPe4orvhg2nYd43pcVPUAsLXA=;
        b=mwIRDPbeEPXtjF6U6cMBm6ZhelV4ZebCUfIX97dO8i/7Iw2x8sfzDEL84cHgeC0Adr
         lDLVIJnFHTbLuDM8z8PLvt4n5m7BpB7iShBohJ7ZiESRR0nv7QnIM3vExyCdnJ14F99U
         XCncMP9ae7gP6OROfyHp40i75gq5/DyNd6VPKhnaniNJAt/Hs0NctizLjJ05Ni3QfV4n
         EfDefPhHSEfLv/GuuK2Nc0hEmMGqymyiHMDFvjTpHO3LGFMgYdL1WZg5+Rcq5iydf/7u
         0b/m9qsraJ7uObZv1zdrCT3tkQcl3jL1gleZ9VHuy/Y6MK0wqn1daWyAYLdDMGVP8tua
         T30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723882515; x=1724487315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGxi6erbOZBopKuA4vdPe4orvhg2nYd43pcVPUAsLXA=;
        b=Poz7YrYqmFMgf2OMZoxQDFkSxk60vBbuyNEhP3oj6IS4hU+3ZcMzqnHjaaPTERXWKW
         G5hEx80coZUjbE9jMmnil0EpepBBSyh7LkLPFX1+QUSY06CrOCpqNu925CGZZe14eVs6
         /ncMa12SsF6ui2GG0XBJk7mze1+qUPulnnIa8D6R5kxmND460wDT7VUtQXVOHfAHyi5z
         cm0FUL7XXr1wsP/5UepQ+6HQrOaFEyyhlh5SvdSMzIp0r6HgAowX+S2NH0ldeiEtiJVS
         wZZhPalMxgSA6j7mjgWBajcQ0/8S5aeEt5pmyr6Aff/D7A7ODj2ovJzxNLtdV2+cO8xT
         ALYg==
X-Gm-Message-State: AOJu0YwFEzPPl2oDU6xtpR8j4lHgJa41wxdXJmpWisB/GdO1V8f1uRj0
	DZUO+tsQZASpCm/AkgT28L8VW01ViMylcYAiNnnqm/c5S3ASsNSv7/KhXkQOLsYtCO/Mx9PYbxG
	ivV5geH1b+7soT6GW+EUtIk+URIEPw+Ys
X-Google-Smtp-Source: AGHT+IE81jo5Mg4QQDLGi1jlfuGr3GCaxwQadA+egciuqQ79yamOiZ0pO7Ctq7MTouosPR/KtWkQHlGoYB+6eVaM4lA=
X-Received: by 2002:a05:690c:7106:b0:64a:f40d:5fd2 with SMTP id
 00721157ae682-6b1b7b64003mr75376927b3.12.1723882514916; Sat, 17 Aug 2024
 01:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC1phya475QkpfLp84sb=2UQs+mFos3OhuHDjmBzboeDBbtjtg@mail.gmail.com>
 <011301daf04c$b6b30fe0$24192fa0$@nexbridge.com>
In-Reply-To: <011301daf04c$b6b30fe0$24192fa0$@nexbridge.com>
From: Zdenek Wagner <zdenek.wagner@gmail.com>
Date: Sat, 17 Aug 2024 10:14:48 +0200
Message-ID: <CAC1phyYpt+B42vLbJpi0RMBJUn8D5oknBDp9PQ+6kD2db1Np0g@mail.gmail.com>
Subject: Re: git push does not work over https WebDAV
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 17. 8. 2024 v 4:25 odes=C3=ADlatel <rsbecker@nexbridge.com> napsal:
>
> On Friday, August 16, 2024 9:11 PM, Zdenek Wagner wrote:
> >To: git@vger.kernel.org
> >What did you do before the bug happened? (Steps to reproduce your issue)=
 git
> >commit git push
> >
> >What did you expect to happen? (Expected behavior) The changes being pus=
hed to
> >the repo via https WebDAV
> >
> >What happened instead? (Actual behavior) $ git push
> >error: Cannot access URL
> >https://userfiles.math-gnostics.eu/git/mg-software.git/, return code
> >22
> >fatal: git-http-push failed
> >error: failed to push some refs to
> >'https://userfiles.math-gnostics.eu/git/mg-software.git'
> >
> >The credentials are in ~/.netrc, git clone and git pull works fine on al=
l my repos on
> >the same server, git push returns the same error
> >
> >Apache error log reports successfull access with the GET method (clone, =
pull) but
> >"user not found" for the PROPFIND method
> >
> >What's different between what you expected and what actually happened?
> >git push does not work at all
> >
> >Anything else you want to add:
> >It is apparently an issue of git which is not OS specific, I have the sa=
me behaviour in
> >Fedora 39 and Mac OSX, both having git 2.46.0. Everything works fine wit=
h git
> >2.44.0 and earlier. I have
> >temporarily solved my problem by downgrading git in Fedora 39. I have no=
t trid
> >2.45.0.
> >
> >Please review the rest of the bug report below.
> >You can delete any lines you don't wish to share.
> >
> >
> >[System Info]
> >git version:
> >git version 2.46.0
> >cpu: x86_64
> >no commit associated with this build
> >sizeof-long: 8
> >sizeof-size_t: 8
> >shell-path: /bin/sh
> >feature: fsmonitor--daemon
> >libcurl: 8.9.1
> >zlib: 1.3.1
> >uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Jun 24 00:56:10 P=
DT
> >2024; root:xnu-8020.240.18.709.2~1/RELEASE_X86_64 x86_64 compiler info:
> >clang: 14.0.0 (clang-1400.0.29.202) libc info: no libc information avail=
able $SHELL
> >(typically, interactive shell): /bin/bash
> >
> >Linux penguin.czw57 6.10.3-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon
> >Aug  5 14:46:47 UTC 2024 x86_64 GNU/Linux
> >
> >
> >[Enabled Hooks]
>
> Does your .curlrc specify --netrc or -n? Those appear to be required to s=
pecify the
> Use of .netrc in curl.
>
> --Randall
>
I do not have .curlrc on my computers, it was never needed. First I
thought that my working tree was damaged or that one repo was damaged
thus I tried a fresh clone of another repo, cimmitted a change and
tried to push. The result was the same. It found .netrc for git clone
but not for git push, see the lines from access_log. After 401 the
same object is requested with the user name and the password with
status 200. This works for GET (clone and pull) but fails with
PROPFIND. It tries the access without credentials. the server responds
with status 401, git requests PROPFIND again but with an empty user
name and server sends 401 again. At that moment git push reports error
22. Git 2.44.0 and earlier fills correctly the user name and password
thus after PROPFIND I see PUT  and MOVE with the correct name. The
lines from the failing git push after successful git clone (without
.curlrc) are below:

78.80.16.189 - zw [16/Aug/2024:16:08:58 +0200] "GET /cgit/ HTTP/1.1" 200 20=
890
78.80.16.189 - - [16/Aug/2024:16:09:35 +0200] "GET
/git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 401 381
78.80.16.189 - zw [16/Aug/2024:16:09:35 +0200] "GET
/git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 200 -
78.80.16.189 - zw [16/Aug/2024:16:09:35 +0200] "GET
/git/kraviny.git/HEAD HTTP/1.1" 200 23
78.80.16.189 - - [16/Aug/2024:16:10:42 +0200] "GET
/git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 381
78.80.16.189 - zw [16/Aug/2024:16:10:42 +0200] "GET
/git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 -
78.80.16.189 - zw [16/Aug/2024:16:10:42 +0200] "GET
/git/kraviny.git/HEAD HTTP/1.1" 200 23
78.80.16.189 - - [16/Aug/2024:16:10:42 +0200] "PROPFIND
/git/kraviny.git/ HTTP/1.1" 401 381
78.80.16.189 - "" [16/Aug/2024:16:10:42 +0200] "PROPFIND
/git/kraviny.git/ HTTP/1.1" 401 381

And this is successful git push after downgrade:

... (lines deleted, I have too many branches and tags)
37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
/git/mg-software.git/refs/tags/matrix-library-0.1.0 HTTP/1.1" 401 381
37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
/git/mg-software.git/refs/tags/matrix-library-0.1.0 HTTP/1.1" 200 41
37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "PROPFIND
/git/mg-software.git/refs/heads/ HTTP/1.1" 401 381
37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "PROPFIND
/git/mg-software.git/refs/heads/ HTTP/1.1" 207 3425
37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
/git/mg-software.git/refs/heads/master HTTP/1.1" 401 381
37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
/git/mg-software.git/refs/heads/master HTTP/1.1" 200 41
37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
/git/mg-software.git/refs/heads/input-flat-ext-branch HTTP/1.1" 401
381
37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
/git/mg-software.git/refs/heads/input-flat-ext-branch HTTP/1.1" 200 41
37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
/git/mg-software.git/refs/heads/smps-crossfilter HTTP/1.1" 401 381
37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
/git/mg-software.git/refs/heads/smps-crossfilter HTTP/1.1" 200 41
37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "PUT
/git/mg-software.git/info/refs HTTP/1.1" 401 381
37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "PUT
/git/mg-software.git/info/refs HTTP/1.1" 204 -
37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "UNLOCK
/git/mg-software.git/info/refs HTTP/1.1" 401 381
37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "UNLOCK
/git/mg-software.git/info/refs HTTP/1.1" 204 -

The majority of my repos are private, authorisation is needed even for
clone and pull.

Zden=C4=9Bk Wagner
https://www.zdenek-wagner.eu/
