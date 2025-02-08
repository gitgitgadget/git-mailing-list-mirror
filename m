Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796833DB
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739050999; cv=none; b=uASZHRWgHrKaLgB8FQ9CclyCIlGghH/u2lTzXu3HmsebTQJdHFCzdeaUj9oc2e+eaP3Qig2aVqRk7gboCEfcjwph7eFMdGsNIkAb+IFmsXHvpVMZ0CkFdjq3fMuxvsz54E1LXYqjFVGlYMdXPT9TDdFpnRo0C/D4ceGFyemODss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739050999; c=relaxed/simple;
	bh=zJqXxXBadHakHQ4MSY10rWDS0dro82ZRJ7qxvnPGGtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUPtiLK9yMpj1WILZs3pAYX8Afqjo7wl8DpSeXZkYlh6GpIvRqKqMD33paB9R7QE+oTTxydRZNqCx8SjjI/2P1woeezJycvECd8VR0IUKCNwaXt0GX1g7i2SfCmuux/Iwr2BQJ9zPXIcPskqm51zLkCTQ2kElJ5OI8PpLPtOAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+HBq8dz; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+HBq8dz"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844d555491eso86919139f.0
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 13:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739050996; x=1739655796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pub7wvpy7RbtArL2LeaZ1tQRJsCrzeK0GV/6h+R3yxg=;
        b=e+HBq8dzUBUTNb1OZwgYk6IGlzDNkr1z+NvRWS6vfv5umCUZf0/9gsgzWHYSOXjzxS
         MLdkLaleRDcTNGB9qfmnz3vp95A6a5TiLGUBdT3zzymTCJjiGCQSji2IwZrbF9BYFxqd
         hfup2sQvMCb7yJtvRTx+2G/YkNvWiSvaBRfk6Yg6cXQBLn+M8RQcaQftB6H3EkPLFU2T
         DWskbDK9wrg/CowUi/hD+oKbXccGI10Bil/k46ihh8ETyloT1r3XD9EDrr2+a8BBgWoc
         xa9stODHv3ZD9w+y5ZErTM4cq+ALEI4ZrX1Z/Sjgrx34hN8e7zGBENS6EbJkRxwVet64
         nfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739050996; x=1739655796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pub7wvpy7RbtArL2LeaZ1tQRJsCrzeK0GV/6h+R3yxg=;
        b=gCKiSdYzJL+beR6IRK6zy07M/kIOZq4sO6AWU6SKKVkF14g4nZCfpjPdqTjLSjWr7J
         4eccF8l2/GAE4WAuaHZe/bMrOdmeTKFJV2wV9Ts8prEoZE3Crr1A9zR0rtNGlUEhK7Qt
         dnellpLsMl7xEz8jRpcEZykUMDCbEWjvVOrFuPKko8eEnajl1SM34zqlrsYFeYiJzeIh
         HDsuMdIp920s2JYGvVd2L5n9tO9rmsLEn2GbaMMc9Wp0DT0u4wBTcy0A1GPuPhXxmyQI
         Hk6O08kkeb5+EyMiWR4MwLuZloMlPR7O2mOnUHSmWw5QPdC6+ya+7B2YwrfPxC4j+6op
         ZOYA==
X-Forwarded-Encrypted: i=1; AJvYcCVjKCd0X4Orl6syAyXYe7DavzRyz7PKoz7hzH9YotZBG5Pgjqk7RbbiNcwU6c05y2Sjrfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8etUYmMmeM9bccD/cyaXF6mR/TU6RlnWhmnzvAjtytIkHq54
	2FML9ekY3UbZ6YC9LeoUFCUqEw2xyTYEhian+gRdwdsFzm5MpFWeF/JMdNaJ7gm0+EofX/BNp8z
	bFFp+EuXaAVJshtCl3nbvo7mJY1Q=
X-Gm-Gg: ASbGncs0Zu2+iL7EthqdHl373DH1xm7LUyRYjICQ1OJKr+kClfeJ/2kwfOmqUe0qYb9
	U+8BIXnkdB9VkwVgfWpKlKF+sIALdUlNx747ckQIjOTvWgUCAXaJBlqmP44wmxjXRJIjzdCrODQ
	==
X-Google-Smtp-Source: AGHT+IHpxnBtN4c5kQjPggE+W4cPZAC9CGt5FENkmP0+xz/Bo2HIR2KeSKTm5oR3BiprOg+CEeNgN2gLAO7fPa8niM4=
X-Received: by 2002:a05:6602:2d8e:b0:855:1ac8:ad8a with SMTP id
 ca18e2360f4ac-8551ac8b6dcmr80862139f.14.1739050996433; Sat, 08 Feb 2025
 13:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de> <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de> <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de> <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com>
In-Reply-To: <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Feb 2025 13:43:05 -0800
X-Gm-Features: AWEUYZmky76omvOzCOZP4SATNiFiB-GsOPVnW2N46zgN3s_vjLb1eOAgPPcuMu4
Message-ID: <CABPp-BGwZ029Y8Kfr2kkGiUDZ613kxS81JXzk36V85=77KcYfA@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: phillip.wood@dunelm.org.uk
Cc: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Sat, Feb 8, 2025 at 3:15=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Elijah and Josef
>
> On 08/02/2025 00:23, Elijah Newren wrote:
> > On Fri, Feb 7, 2025 at 12:34=E2=80=AFPM Josef Wolf <jw@raven.inka.de> w=
rote:
> >> On Fri, Feb 07, 2025 at 06:01:43AM -0800, Elijah Newren wrote:
> >>> On Fri, Feb 7, 2025 at 3:13=E2=80=AFAM Chris Torek <chris.torek@gmail=
.com> wrote:
> >>
> > I also see I didn't look closely enough at Phillip's
> > suggestion, which was:
> >
> >     git rebase --root -x 'git add --renormalize . && { git diff --quiet
> > --cached || git commit --amend --no-edit; }'
> >
> > which will work if you do a lot of manual work to resolve line ending
> > difference conflicts.  Since the git add at each step will modify the
> > files on which the next commit is based, that causes the application
> > of the subsequent commit to conflict,
>
> Indeed, I'd missed that (like you I've not actually used any
> smudge/clean filters)
>
> > and you probably will have
> > difficulty seeing those conflicts since they tend to just be line
> > ending differences.  But, mixing that with Brian's suggestion, you
> > get:
> >
> >    git rebase --root -X renormalize -x 'git add --renormalize . && {
> > git diff --quiet --cached || git commit --amend --no-edit; }'
> >
> > which should probably work if you have a linear history
>
> I've tried that out with a small modification in the script below which
> seems to work. The modification is to add "--attr-source=3D$(git rev-pars=
e
> HEAD)" between "git" and "rebase" so that git always has a
> .gitattributes file to read when rebasing commits that were made before
> that file was added.

Ooh, nice catch.  If folks had an appropriate .gitattributes file in
place in older versions of history, they probably wouldn't have gotten
into the mess.

> I wonder if we should add something about
> renormalizing a repository to the FAQ based on your footnote.

and perhaps your helpful example?  (although it does assume linear history)=
  :-)

>  > [1] The renormalize option to the merge machinery ensures that new
>  > blobs produced by the merge have normalized content, and avoid
>  > conflicts when the only differences between files are normalization
>  > ones.  This option does not ensure that new trees only reference new
>  > content nor that they only reference normalized content; _any_
>  > pre-existing blobs in the repository are fair game for new trees to
>  > reference.  As per the manual: "renormalize...This runs a virtual
>  > check-out and check-in of all three stages of a file when resolving a
>  > three-way merge..."  So, the existing behavior of the renormalize
>  > option to rebase/cherry-pick/merge is correct.  It may not be what you
>  > want, but I don't think cherry-picking/rebasing/merging with the
>  > renormalize option is the right tool for this job.
>  >
>
> Best Wishes
>
> Phillip
>
> --- >8 ---
> #!/bin/sh
> set -e
> d=3D"$(mktemp -d)"
> cd "$d"
> git init
> echo "The   quick  brown" >file
> git add file
> git commit -m line-1
> echo "fox  jumps    over" >>file
> git commit -a -m line-2
> echo "the      lazy   dog" >>file
> git commit -a -m line-3
> echo "file filter=3Dspace" >.gitattributes
> git config filter.space.clean "sed -e 's/  */ /g'"
> git config filter.space.smudge cat
> git add .gitattributes
> git commit -a -m 'add .gitattributes'
> git reset --hard HEAD
> git --attr-source=3D$(git rev-parse HEAD) rebase --root -X renormalize \
>      -x 'git add --renormalize . && { git diff --cached --quiet || git
> commit --amend --no-edit; }'

So, I'm slightly surprised here.  Does the --attr-source specified to
the outer git become an environment variable or something for the
inner git-add invocation?  How does the git add subprocess know about
it?

...<does some searches ending with>...

$ git grep -5 GIT_ATTR_SOURCE -- git.c
git.c-          } else if (!strcmp(cmd, "--attr-source")) {
git.c-                  if (*argc < 2) {
git.c-                          fprintf(stderr, _("no attribute source
given for --attr-source\n" ));
git.c-                          usage(git_usage_string);
git.c-                  }
git.c:                  setenv(GIT_ATTR_SOURCE_ENVIRONMENT, (*argv)[1], 1);
git.c-                  if (envchanged)
git.c-                          *envchanged =3D 1;
git.c-                  (*argv)++;
git.c-                  (*argc)--;
git.c-          } else if (skip_prefix(cmd, "--attr-source=3D", &cmd)) {
git.c-                  set_git_attr_source(cmd);
git.c:                  setenv(GIT_ATTR_SOURCE_ENVIRONMENT, cmd, 1);
git.c-                  if (envchanged)
git.c-                          *envchanged =3D 1;
git.c-          } else if (!strcmp(cmd, "--no-advice")) {
git.c-                  setenv(GIT_ADVICE_ENVIRONMENT, "0", 1);
git.c-                  if (envchanged)

ahah, so it is passed via environment variable to the subprocess.

Anyway, nice catch.
