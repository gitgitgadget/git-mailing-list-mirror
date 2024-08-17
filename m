Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80317F484
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883614; cv=none; b=FqTBHjhUEgXjV1OWUeyIEEyj/8eGNmKKnruM+n/yO5QnQ4d1CY4wpwBO8O43MfQ5LDeLsFj75DY2hmmCcBYAT9UbT+zie3cWDE/uCDJMIkqJhxLMHIFuNkwSwvW1nu30EvSjHWvzWMFBLERYkXpOyC/WC9KFaR5zvaF6FSLG2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883614; c=relaxed/simple;
	bh=DAW3fqWeGtyBXE63cA1CIjjEun9B5TqLpZBIdxcD3AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJtZIUi/LxYE/+/nvtMdz2KLqZbBv+qpMk/1gBVEmeQLJAMYzAPJCsiJ5ydXnRa4ATqSocwETUqjAGZRqVaKnhKn4FiYI8ngtdV0iWf9O75FC6toO8Az7qF8CRhjdc2x6SeENUBmjao/5E531Nt2JJ8laSMwN66gHggfkK42d64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0najk6O; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0najk6O"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-67682149265so25562057b3.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723883611; x=1724488411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roY1bzuIY8cXDmXtkVDd0+fgvAoUanbBGCwxKB3dI5I=;
        b=K0najk6ODx4971YRaQST4p3aqwlYYarrJj2EltHRMlkJz0zAeenBStJCIBLHkQMady
         vuvQUbHxYgo6JDCd31DBg3ZmWqulC4KLLVKa7maCcUWvKtp5ffNz09UPJOj8o3L+ulXV
         GxIpYChgvTKzbblhEEiHejqQR/VxrGCwuT0EAvYbsGTBVsqq5UeQK4GPwy7ewhaFNsHH
         GfghMD6lQ0BEwTz/+9kJQUfXaByiMtHJEv263JiJ7beuF6mJKaualQSIqiczEc/RI1iM
         tex8lNvmb9dyj7zVZaGIIQF8LlapN9MiY4j/6WMAznF7P/OmehDO9441sv1pQuepcKe/
         AzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723883611; x=1724488411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roY1bzuIY8cXDmXtkVDd0+fgvAoUanbBGCwxKB3dI5I=;
        b=wj7ImaIk3lWdcr5zDnsUTdj5sToAFqhdn3+CQUNXfiX+H1n3OSm5cFOtIQJKwVgEKt
         2KrjrS15AG+DgHoyIJRYD/IvH0B0yEnh0hnM9YU/QGEPftDSTqvdlqfHig9UWml81jtf
         06sALG29HrpdAl4sV/RkXDYOb/u9/WIF0KYH8G9JhNoqghmyv1KetFR4Jvotz/32IwOH
         CH20YHFr8PcjPjamRyoDXwoqqhbk2OLAJEZUWIQd6vq8C0wad60FY114tqWLj4L9uj6v
         EeEboaZ553GLdq9Qh6uEHGZJr7U996NrOg21MYtKs1U1ajQrERenlzU+bbJBpnbRkt2B
         wiCA==
X-Gm-Message-State: AOJu0YzAysJIOVPbOYf2Dk53mASdgURGiFFaBtaIYxaNjpE6TaUdr+6d
	pR0Y/70Hx+mq36mtmyJgE6HN7BPfwBIhXnkv97oMPLO7QMDagiZu7Iz8GZhJ8P8xJtrdOoTEfx0
	Krl40q4u6HOXM9MJwLIX4OYkfaaSnQODj
X-Google-Smtp-Source: AGHT+IEovSFCuXRY3mBCSITQ8ksYlj3RE0O2TPwyzdd0yYHVNnyBepgAHhYlY+ZUpTaRtcOX7GISJmgp5gzKnPJvRb8=
X-Received: by 2002:a05:690c:6904:b0:651:6e6f:32d2 with SMTP id
 00721157ae682-6b45468d12cmr24230137b3.43.1723883610943; Sat, 17 Aug 2024
 01:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC1phya475QkpfLp84sb=2UQs+mFos3OhuHDjmBzboeDBbtjtg@mail.gmail.com>
 <011301daf04c$b6b30fe0$24192fa0$@nexbridge.com> <CAC1phyYpt+B42vLbJpi0RMBJUn8D5oknBDp9PQ+6kD2db1Np0g@mail.gmail.com>
In-Reply-To: <CAC1phyYpt+B42vLbJpi0RMBJUn8D5oknBDp9PQ+6kD2db1Np0g@mail.gmail.com>
From: Zdenek Wagner <zdenek.wagner@gmail.com>
Date: Sat, 17 Aug 2024 10:33:05 +0200
Message-ID: <CAC1phyY-cZ-jfM2-W=SVN61K5x2c3bG=Xz8jdrnqSHoLc1Av6Q@mail.gmail.com>
Subject: Re: git push does not work over https WebDAV
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 17. 8. 2024 v 10:14 odes=C3=ADlatel Zdenek Wagner
<zdenek.wagner@gmail.com> napsal:
>
> so 17. 8. 2024 v 4:25 odes=C3=ADlatel <rsbecker@nexbridge.com> napsal:
> >
> > On Friday, August 16, 2024 9:11 PM, Zdenek Wagner wrote:
> > >To: git@vger.kernel.org
> > >What did you do before the bug happened? (Steps to reproduce your issu=
e) git
> > >commit git push
> > >
> > >What did you expect to happen? (Expected behavior) The changes being p=
ushed to
> > >the repo via https WebDAV
> > >
> > >What happened instead? (Actual behavior) $ git push
> > >error: Cannot access URL
> > >https://userfiles.math-gnostics.eu/git/mg-software.git/, return code
> > >22
> > >fatal: git-http-push failed
> > >error: failed to push some refs to
> > >'https://userfiles.math-gnostics.eu/git/mg-software.git'
> > >
> > >The credentials are in ~/.netrc, git clone and git pull works fine on =
all my repos on
> > >the same server, git push returns the same error
> > >
> > >Apache error log reports successfull access with the GET method (clone=
, pull) but
> > >"user not found" for the PROPFIND method
> > >
> > >What's different between what you expected and what actually happened?
> > >git push does not work at all
> > >
> > >Anything else you want to add:
> > >It is apparently an issue of git which is not OS specific, I have the =
same behaviour in
> > >Fedora 39 and Mac OSX, both having git 2.46.0. Everything works fine w=
ith git
> > >2.44.0 and earlier. I have
> > >temporarily solved my problem by downgrading git in Fedora 39. I have =
not trid
> > >2.45.0.
> > >
> > >Please review the rest of the bug report below.
> > >You can delete any lines you don't wish to share.
> > >
> > >
> > >[System Info]
> > >git version:
> > >git version 2.46.0
> > >cpu: x86_64
> > >no commit associated with this build
> > >sizeof-long: 8
> > >sizeof-size_t: 8
> > >shell-path: /bin/sh
> > >feature: fsmonitor--daemon
> > >libcurl: 8.9.1
> > >zlib: 1.3.1
> > >uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Jun 24 00:56:10=
 PDT
> > >2024; root:xnu-8020.240.18.709.2~1/RELEASE_X86_64 x86_64 compiler info=
:
> > >clang: 14.0.0 (clang-1400.0.29.202) libc info: no libc information ava=
ilable $SHELL
> > >(typically, interactive shell): /bin/bash
> > >
> > >Linux penguin.czw57 6.10.3-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon
> > >Aug  5 14:46:47 UTC 2024 x86_64 GNU/Linux
> > >
> > >
> > >[Enabled Hooks]
> >
> > Does your .curlrc specify --netrc or -n? Those appear to be required to=
 specify the
> > Use of .netrc in curl.
> >
> > --Randall
> >
> I do not have .curlrc on my computers, it was never needed. First I
> thought that my working tree was damaged or that one repo was damaged
> thus I tried a fresh clone of another repo, cimmitted a change and
> tried to push. The result was the same. It found .netrc for git clone
> but not for git push, see the lines from access_log. After 401 the
> same object is requested with the user name and the password with
> status 200. This works for GET (clone and pull) but fails with
> PROPFIND. It tries the access without credentials. the server responds
> with status 401, git requests PROPFIND again but with an empty user
> name and server sends 401 again. At that moment git push reports error
> 22. Git 2.44.0 and earlier fills correctly the user name and password
> thus after PROPFIND I see PUT  and MOVE with the correct name. The
> lines from the failing git push after successful git clone (without
> .curlrc) are below:
>
> 78.80.16.189 - zw [16/Aug/2024:16:08:58 +0200] "GET /cgit/ HTTP/1.1" 200 =
20890
> 78.80.16.189 - - [16/Aug/2024:16:09:35 +0200] "GET
> /git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 401 381
> 78.80.16.189 - zw [16/Aug/2024:16:09:35 +0200] "GET
> /git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 200 -
> 78.80.16.189 - zw [16/Aug/2024:16:09:35 +0200] "GET
> /git/kraviny.git/HEAD HTTP/1.1" 200 23
> 78.80.16.189 - - [16/Aug/2024:16:10:42 +0200] "GET
> /git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 381
> 78.80.16.189 - zw [16/Aug/2024:16:10:42 +0200] "GET
> /git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 -
> 78.80.16.189 - zw [16/Aug/2024:16:10:42 +0200] "GET
> /git/kraviny.git/HEAD HTTP/1.1" 200 23
> 78.80.16.189 - - [16/Aug/2024:16:10:42 +0200] "PROPFIND
> /git/kraviny.git/ HTTP/1.1" 401 381
> 78.80.16.189 - "" [16/Aug/2024:16:10:42 +0200] "PROPFIND
> /git/kraviny.git/ HTTP/1.1" 401 381
>
> And this is successful git push after downgrade:
>
> ... (lines deleted, I have too many branches and tags)
> 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> /git/mg-software.git/refs/tags/matrix-library-0.1.0 HTTP/1.1" 401 381
> 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> /git/mg-software.git/refs/tags/matrix-library-0.1.0 HTTP/1.1" 200 41
> 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "PROPFIND
> /git/mg-software.git/refs/heads/ HTTP/1.1" 401 381
> 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "PROPFIND
> /git/mg-software.git/refs/heads/ HTTP/1.1" 207 3425
> 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> /git/mg-software.git/refs/heads/master HTTP/1.1" 401 381
> 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> /git/mg-software.git/refs/heads/master HTTP/1.1" 200 41
> 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> /git/mg-software.git/refs/heads/input-flat-ext-branch HTTP/1.1" 401
> 381
> 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> /git/mg-software.git/refs/heads/input-flat-ext-branch HTTP/1.1" 200 41
> 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> /git/mg-software.git/refs/heads/smps-crossfilter HTTP/1.1" 401 381
> 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> /git/mg-software.git/refs/heads/smps-crossfilter HTTP/1.1" 200 41
> 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "PUT
> /git/mg-software.git/info/refs HTTP/1.1" 401 381
> 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "PUT
> /git/mg-software.git/info/refs HTTP/1.1" 204 -
> 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "UNLOCK
> /git/mg-software.git/info/refs HTTP/1.1" 401 381
> 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "UNLOCK
> /git/mg-software.git/info/refs HTTP/1.1" 204 -
>
> The majority of my repos are private, authorisation is needed even for
> clone and pull.
>
> Zden=C4=9Bk Wagner
> https://www.zdenek-wagner.eu/

Just a note, I found a computer with git 2.45.2 in Fedora 39 and git
push works, it finds .netrc without .curlrc.

Zden=C4=9Bk Wagner
https://www.zdenek-wagner.eu/
