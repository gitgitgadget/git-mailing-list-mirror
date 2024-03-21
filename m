Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0137EC
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710983638; cv=none; b=aOI45L/YUtc/vJH83h8wq/sx3EnoP+IIuUJoTlinJcRk/Okcb0cJKMMA7O6UvQ1cXWAtEJETVynlmwqvAonaAfbqmdeRTsqfuCqMzkys3rgcCdELIKR+OpchsjIbjPtfNEHU775EzU7JajjQ+2CNxUnRr7UJIkPY2lEmne304/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710983638; c=relaxed/simple;
	bh=fkttRN9xElzs+oqygvoLr5xI5Yt6zH3TkOOT59ODiEQ=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=L3hVnEbnzxIh03g2Z2A6gNcs3tyEIrYWrcTjlldMtiZWzBb/P6o6872L0Wdr/l+N7KMZk0T/WYPU9Ze16hhdFbUANxwH3uXYo6Igr6LDA1lc9eDyJwFCjS3xkxZvlMIWOBgjZUkz7dELojpdxMzh0qnJiI+UVQyQktidAMylvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/JsFGUc; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/JsFGUc"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cf21c788aeso16204139f.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 18:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710983636; x=1711588436; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vo+kiKc7rMXNYHxml/QDyFFA731BUGhSYy4VdgeYzZA=;
        b=U/JsFGUcLVLZQIjLkWwMi1ekv2lMksiOpbR6EsTnbZFUdUZ5+Kv2pqaW/Ouj11dBO6
         zvl7IwJIoqgHPNX7JAXi8HYBDGIGCYMizxn9IFtzDaSmPBjAbQQIsNuMML4qAGQGimu2
         TUhP8M7bw0Qg3/Xly/W2hcVdlkviISgcN5Ro5O/0qCsaiiyNZ+CEpZGOcun99gAW3vXg
         Ch962zpY2DusFRjfcnz4WFOICZjoQ0tfc1+0SXBVBIUDwLcCFQUpz1qA51mUVsyvIdS4
         ivcZU/zRmmZvCcOffN8kFI+e/KvKw5a3242tLn4W0Zrc7RMbvPM0FQjHMzhAbPFAAQhU
         dsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710983636; x=1711588436;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo+kiKc7rMXNYHxml/QDyFFA731BUGhSYy4VdgeYzZA=;
        b=Ou6pflaB4DAsj5C3EQUkFJ3XubW8N3+F55NivHVfv/YRX/Xt7B/b2qpMO5P2cnOjNO
         vxns1nw49kDpMwDQ8wBFCuni/jOXPeOm2toYnN0OOv2je242Mv7xaTBGvVWfMCC2LK/L
         y6HfzDCjze1/Cy8bDYZZ+je5dC95rpX1cCOuYuQ4DE/v1jo9sAL90AkwuWzeEbJm3BRX
         eNClLaaS7MpOIXJtXKY7SU16HL2RlSHMPbg3pq3HsPStOtJJ8c/PVnXBvVkuMwbGprU4
         3NPm65x6HiYdB+IfjMIyfButCUNluiYf0VBMTU4xwNnbKssgOGHerKi4FwJPzBgNPwK4
         o0yw==
X-Gm-Message-State: AOJu0Yxm7LGG+whKpun2v8mygQ6fgjtjQmFfBGwm+1irgsvrMRXvLUaf
	Wy5exl9PZ3V+F0cq1RM8YKmPQDJ3v/c72IQlLl0fk9K3luE3uKWiYUoTTTr9qM0=
X-Google-Smtp-Source: AGHT+IGbgnEob80EziPErf0kvWM8kgIroQBWo9xgUUC2CdMvTzQDK4Z+jRe6jpF5tSgcmMd3i9vk6A==
X-Received: by 2002:a05:6e02:cc4:b0:366:980e:b7d8 with SMTP id c4-20020a056e020cc400b00366980eb7d8mr7893030ilj.17.1710983635562;
        Wed, 20 Mar 2024 18:13:55 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id el5-20020a0566384d8500b004798921479asm2483171jab.128.2024.03.20.18.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 18:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqqmsqshoiw.fsf@gitster.g>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>, 
	"=?utf-8?Q?Jean-No=C3=ABl_AVILA?=" <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
Message-ID: <17bea28cf691d3eb.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 01:13:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> Very much appreciated.  I wonder if we can have a better workflow to
> do this, like perhaps contributors write a paragraph in the cover
> letter with the expectation that it will be used in the What's
> cooking report (which will become an entry in the Release Notes when
> the topic gets included in a release)?

I think some more official process could be beneficial. As it is, I'm
wholly unaware of the current process for creating release notes for
git. Do the maintainers simply review merged changes and write release
notes as part of cutting a release?

A strategy that I have seen work well is for any commit making a notable
change (one that should appear in the release notes) to include an entry
in a CHANGELOG.NEXT.md file. When cutting a release, the maintainers
would move the contents of that CHANGELOG.NEXT.md file into a new
section in the standard CHANGELOG.md for the release. This way, the
contributor of a series is responsible for creating the changelog entry
(or entries) rather than the maintainer, which can help avoid
inaccuracies from a maintainer with less familiarity trying to
summarize.

This has the benefit of anyone being able to easily see notable upcoming
changes at any point in a release by simply looking to that
CHANGELOG.NEXT.md file, rather than needing to review all of the commits
added since the previous release.

Of course it does not need to be markdown, that's simply the template
[1] that I"m familiar with.

[1]: https://keepachangelog.com/en/1.1.0/

Using my own series as an example, that CHANGELOG.NEXT.md might look
like:

    # Unreleased changelog entries
   =20
    This file contains changelog entries for the next release. Maintainers w=
ill move
    these entries to CHANGELOG.md as part of cutting each release.
   =20
    ## Added
	- git-rebase now supports a `--empty=3Dstop` option for consistency with
	  git-am's similar `--empty` option.
	- git-cherry-pick now supports a `--empty` option to allow more robust
	  control over what happens to redundant commits.
   =20
    ## Changed
	- git-cherry-pick will now error out if `--keep-redundant-commits`
	  is specified alongside `--continue`, `--skip`, `--abort`, or
	  `--quit`.
   =20
    ## Deprecated
	- git-rebase's `--empty=3Dask` has been deprecated in favor of
	  `--empty=3Dstop`, which has the exact same behavior.
	- git-cherry-pick's `--keep-redundant-commits` has been deprecated in
	  favor of `--empty=3Dkeep`, which has the exact same behavior.
   =20
    ## Removed
   =20
    ## Fixed
	- Documentation for git-rebase's `--empty` now correctly indicates
	  the default behavior when `--exec` or `--interactive` are
	  specified.
	- git-cherry-pick will no longer error out if `--allow-empty` is used
	  while on an unborn branch.
   =20
    ## Security

We would of course have to decide how detailed these ought to be and
what changes do and do not warrant an entry, but presumably we already
have to do that as part of the current process for creating each
release' notes. So long as we document those expectations, it seems like
a reasonable thing to ask of contributors.

An additional benefit here is that the release notes themselves are
reviewed as part of the normal patch review process, allowing reviewers
to suggest edits to them alongside their code review.

The one minor headache with this process that I am aware of is that
applying multiple patches that all touch that one file does lead to some
conflicts. For example:

    # Added
	- Some cool new feature!
	<<<<<<< HEAD
	- A different cool new feature!
	=3D=3D=3D=3D=3D=3D=3D
	- A third new feature!
	>>>>>>> 9b423104cd (Introduce an awesome feature)

    # Changed

In practice, the rigid structure of adding entries to the end of the
list and the blank lines between sections seems to result in these
usually (always?) being trivially resolved by simply accepting both
sides of the conflict. That said, in the context in which I've seen
this, it's been in a forge where each contributor must address this
before their pull request is accepted. It may cause more annoyance for
your process of accepting changes into your tree -- I'm not sure.

This is simply one idea, of course. I realize that it may not be
feasible for this project, but if not then perhaps it may inspire
someone else to come up with a better approach.

What are your thoughts?

--=20
Thank you,
Brian Lyles
