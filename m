Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWrIhTIS"
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7FEE
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 06:54:22 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so36640441fa.0
        for <git@vger.kernel.org>; Sat, 25 Nov 2023 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700924061; x=1701528861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJRBar7Aag8lxX7ODi42XwSdN1MFRMOqoz7mU7/l13w=;
        b=CWrIhTISgYz1bNCJ2nhtURVysdn577Eu22RGTtXzxNpz7vk10QEz9JNZVbk6UQzsq9
         +ne5rAvymyLisBil8XeEHBuw2lsIpH+pHWuiewLMi8NhTs9LtrG28UWWKNRdcg7EsuEM
         TINyRosqxYjaiiE+8S2JaXGoq/rBBmNlFz6XqJnkuQe+DHK5IdE1EosvWdDlOQskalC4
         lVmG+qXW1jH/KdY8kzb2EF/88muP5Ey+/9kj4H7ktuVaIGtDwshXDCGWlQ0YwrH0dwDU
         Fds5pXyDPaqhO71b9dB+vTZDwAXnMxOxJv/bJIVCdeeLMRWSfXAA0OgLu2IiGKtknk4t
         UryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700924061; x=1701528861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJRBar7Aag8lxX7ODi42XwSdN1MFRMOqoz7mU7/l13w=;
        b=na/LLJQqMph2pqGfhaqi+DXJaWJh5g4hO7zs6TIqgJF/XCPr4Fg2WpOwxHw0X74GiR
         HUXchY9mlLYQ5NpbKU0CMNQ3PuC+kxDeLug/kV1WvZng4eucKVKJrb9fKVyur5Ha6ZM1
         Kt2VUtv45L2a9mrJlqTYb7Za7dcjrbOeBaB4v8ZTZfzNNhxT/nnWsqEhi1E2hIAnBNTh
         ZMwNxJxtaPTG+8QriCXeX7yTIPf1m49TZxWaVjAM7tDMcwOobzi4EzRyyLkGzFjBUi09
         SiTV5WO1Xa13HJiO5V0K+TuJzs0qS9N0aylHVqNxu/C2TOGH+b1X1bCMetMLmniFauIz
         PPPw==
X-Gm-Message-State: AOJu0Yyy9mVv+m2VSFq3aQNvMgrPl40RzRooAlW9yNsQV6dEi5dlvaCE
	K8BbiHnt3O8J2+QMEJgBBHbS+XjVfuDWM/tEKH4=
X-Google-Smtp-Source: AGHT+IHg+X1ta/D4SGHYUZHiSYF49m8qpWfBq3hq8cXYJBEMpihcJ7WEucp5oJDim+rqYucd25zh6B4AZI2U4E4q4KU=
X-Received: by 2002:a05:651c:1548:b0:2c9:996b:3b54 with SMTP id
 y8-20020a05651c154800b002c9996b3b54mr557226ljp.53.1700924060822; Sat, 25 Nov
 2023 06:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH1-q0iV+E73RrUDA8jcoFgNEfQDNwRnX5P5Z7r3Qj3GESV_7g@mail.gmail.com>
 <ZQb9Thxa5X-Fo5mj@debian.me>
In-Reply-To: <ZQb9Thxa5X-Fo5mj@debian.me>
From: Javier Mora <cousteaulecommandant@gmail.com>
Date: Sat, 25 Nov 2023 14:54:09 +0000
Message-ID: <CAH1-q0jGQBPZVYja3Sg2Xv4YGAxcUsnb1rL4MALKxCoywi0B=A@mail.gmail.com>
Subject: Re: [BUG] `git push` sends unnecessary objects
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apparently if I do that in two commits (one to move the dir, and a
second one add the file), and then push all that after the second
commit, this doesn't happen -- the resulting push will only contain 6
objects (2 commits, 3 trees, and 1 file), and be a few bytes large.

El dom, 17 sept 2023 a las 14:21, Bagas Sanjaya
(<bagasdotme@gmail.com>) escribi=C3=B3:
>
> On Wed, Sep 13, 2023 at 11:59:35PM +0100, Javier Mora wrote:
> > I came across this issue accidentally when trying to move a directory
> > containing a very large file, and deleting another file in that
> > directory while I was at it.
> > It seems to be caused by `pack.useSparse=3Dtrue` being the default sinc=
e
> > v2.27 (which I found out after spending quite a while manually
> > bisecting and compiling git since I noticed that this didn't happen in
> > v2.25; commit de3a864 introduces this regression).
> >
> > * Expected:
> >     Pushing a commit that moves a file without modifying it shouldn't
> > require sending a blob object for that file, since the remote server
> > already has that blob object.
> > * Observed:
> >     Pushing a commit that moves a directory containing a file and also
> > adds/deletes other files in that directory will for some reason also
> > send blobs for all the files in that directory, even the ones that
> > were already in the remote.
> > * Consequences:
> >     This has a very big impact in push times for very small commits
> > that just move around files, if those files are very big (I had this
> > happen with a >100MB file over a problematic connection... yikes!)
> > * Note:
> >     The commit introducing the regression does warn about possible
> > scenarios involving a special arrangement of exact copies across
> > directories, but these are not "copies", I just moved a file, which
> > seems like a rather common operation.
> >
> > Code snippet for reproduction:
> > ```
> > mkdir TEST_git
> > cd TEST_git
> >
> > mkdir -p local remote/origin.git
> > cd remote/origin.git
> > git init --bare
> > cd ../../local
> > git init
> > git remote add origin file://"${PWD%/*}"/remote/origin.git
> >
> > mkdir zig
> > for i in a b c d e; do
> >     dd if=3D/dev/urandom of=3Dzig/"$i" bs=3D1M count=3D1
> > done
> > git add .
> > git commit -m 'Add big files'
> > git push -u origin master
> > #>> Writing objects: 100% (8/8), 5.00 MiB | 13.27 MiB/s, done.
> > #^ makes sense: 1 commit + 2 trees (/ and /zig) + 5 files =3D 8;
> > #  5 MiB in total for the 5x 1 MiB binary files
> >
> > git mv zig zag
> > git commit -m 'Move zig'
> > git push
> > #>> Writing objects: 100% (2/2), 233 bytes | 233.00 KiB/s, done.
> > #^ makes sense: 1 commit + 1 tree (/ renames /zig to /zag) =3D 2;
> > #  a,b,c,d,e objects already in remote
> >
> > git mv zag zog
> > touch zog/f
> > git add zog/f
> > git commit -m 'For great justice'
> > git push
> > #>> Writing objects: 100% (9/9), 5.00 MiB | 24.63 MiB/s, done.
> > #^ It re-uploaded the 5x 1 MiB blobs
> > #  even though remote already had them.
> > ```
> >
> > Note that the latter doesn't happen if I use `git -c pack.useSparse=3Df=
alse push`.
>
> I can reproduce this regression on v2.42.0 (self-compiled) on my Debian
> testing system.
>
> Cc'ing Derrick and Junio.
>
> Thanks for the report!
>
> --
> An old man doll... just what I always wanted! - Clara
