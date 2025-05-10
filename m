Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98D11712
	for <git@vger.kernel.org>; Sat, 10 May 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746909107; cv=none; b=a4YB613dZAklohXdZmFsZHxNRUjAWSwSj5UP3AUbnULXKB9n3SrIup6N91ZAhnqCtUwN1+dY5iMEgi1wQA7s3xr1pdZv53ElHFNWerGRPZDYII0HtQfvu5jUsWHAchRbvZKKlUjXXX434PsPLfDzgkmEuljP3gEof9+65JV8j2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746909107; c=relaxed/simple;
	bh=V9uT8DFXdTZntcToBwpc1hmIIYuIMz3o9lErTq0WM5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUmIhrySQvr1cPaWqakjBO1+zjY5ansHUVSpm9MCNZS2FS0DsBnccm8OTnc9dbDCCLHDnVa2baMandflsHtTOzTKQJ6gVkoqE52HgAz1+C1f3cfxaNL7cp6SeBfb43oVL9lDj9/GKCxtSGl/zlGlYdiX3ZJzn4EjP9+G9x9Uhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYRFE6Mj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYRFE6Mj"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fc4fc27983so3341a12.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746909103; x=1747513903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9uT8DFXdTZntcToBwpc1hmIIYuIMz3o9lErTq0WM5M=;
        b=CYRFE6Mj4Wxq55t4qeBooPCJ4fjV9jjZfYmfdBju+svZCMNjJjYMov5uYs5UeRj/zR
         LY7807eVZVDXwdtZLyistJ3AJvIoTQqeD2s6nFpAJE7/DekXLuBGhUf4jkjh/wIU5b0z
         XMAgQ4UsYT4Pmh32lWngUXRGs3mXWFXPR0ZByF07SWGt+ThFOPIn4e+v0l54ylrxEzG7
         1fifJCBDNoxIJQinV8TnA7TVyZ9XTYHzHvLUJ6jk7sND2Wds1wiLQnz+n5ZCT2Q1YhDU
         1fTHGBsZbVQMfKr9jme6VbMIfCgh42EXLBYZn9k0v1/t1aUBAp4vx19z33bq+03i2Cda
         kGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746909103; x=1747513903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9uT8DFXdTZntcToBwpc1hmIIYuIMz3o9lErTq0WM5M=;
        b=DZqpFU8zZXblSleCv5FkXhkrzSaPg+UByHHPkigw49N5Sjcou3oZX53qwS1OoM+J4w
         4RwHPjItKauw7akC2XTvFGo8NyF9H1KURJS0LfVoNClWTev3WHpNsDyy9lVOfs0yZZWn
         DrLeVOgsnQA3Ao8h4KQ8VrmtWKv25iqapyLoM0ThZ6cXoMWX/OD9kW/XwQ95cbTYSlLg
         SA8VuyMmoQ1Yv1o2OKXxhaAgT14kbzoIQN6aspOkDLr2nkW4Rm3Dzl3dUezj1AUteDof
         dBgZg5IgQEPt0u5CEJCi8xz7BxEZq4UnT73HDblhwk8/V34TRDwLk13gWrC80Ik4SqOx
         WvPA==
X-Forwarded-Encrypted: i=1; AJvYcCUfvy3Ty4Kau8cmMZj4ffmgiYUtE7YUjirfWq8XWBFhcT6tG5lKBOAZzBqjBI+7dpmje68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3F/uubMvMccvgkAd/PbVjN8/BgzPSYLWPXiELgfvGQNQBr4lJ
	QohWe/Hr/R7Vbn+YgK65VHoOTAW0tv1tt/gMPVd1YVGajuK6wvnD+Th85wNu7ZF1GPNUR3m1SpY
	kvHuh87/0qdmgIG2rZv131YXrrmOnfIptC+LR
X-Gm-Gg: ASbGncsk0i1tVCKcz2mvHD0SGbd5M45w+tBtTqOgGoI18kfidpaLLAhGiSjenw7IxCt
	hi6TrZYxIn6r0RAwV6q+stRbzFaqnNFlJVju1sbvrhoVTEUdz6XsWi3WB1tJeH3Ygur8zHi/xci
	06+w0nWgvChEnfKDq7cjcwXMLAVVXGyaruRT4wIAKrlyI=
X-Google-Smtp-Source: AGHT+IEBWbEqiLGL7XEoL6VZzu+PM8wOQkuY8wT7C8vJkqNMADBILXlQHul6jQkOV4Kvv/TnaqT46DNbSnCBketyvtY=
X-Received: by 2002:a05:6402:5149:b0:5fb:5fbc:4937 with SMTP id
 4fb4d7f45d1cf-5fcca38faa5mr65121a12.6.1746909103424; Sat, 10 May 2025
 13:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby> <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
In-Reply-To: <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Sat, 10 May 2025 13:31:32 -0700
X-Gm-Features: AX0GCFusd1Dr9p9uW0qHkSquOLdvR3S6Ky1429jvDnNsyzWex06InXSuMDAUnU4
Message-ID: <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Nico Williams <nico@cryptonector.com>, Remo Senekowitsch <remo@buenzli.dev>, 
	"Theodore Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 10 May 2025 at 12:46, D. Ben Knoble <ben.knoble@gmail.com> wrote:
>
> On a re-read of
> https://lore.kernel.org/git/CANiSa6gwup5vXU235mG+Ybbc+P=3DSbwoNFEmuhg=3Di=
Yu0yGvSXVA@mail.gmail.com/,
> I see that change IDs were motivated partly by identifying (related?)
> commits after rewrites. I can certainly see how it would be nice to
> track down how a commit I'm working on evolved; I can even imagine
> most of the problems brought up in this thread wrt splitting or
> combining commits (not to mention, say, cherry-picks where the
> committer makes non-trivial changes to the patch).
>
> There was also a note about using a change ID to identify a code
> review in supporting tools. Neat!
>
> I'll leave it to someone else to summarize the open questions? (I now
> have a few of my own about how tools in Gits ecosystem respond to=E2=80=
=A6
> unexpected=E2=80=A6 headers.)
>
> In the meantime, I think I'll repost this, since I'm not sure I ever
> got clarity:
>
> Re-reading the original post [1] (which didn't mention this kind of
> ID?), I'm having a hard time seeing the problem statement. There's a
> lot said here about the specifics of the solution, and some other neat
> things it might unlock=E2=80=A6 meanwhile, I'm wondering if all the
> consternation about change IDs is because the problem being solved is
> underspecified for a core Git feature? (That might tie to Ted's
> initial concerns about semantic meaning, on which I think I concur:
> the parent and committer/author headers have unambiguous meaning to
> Git, independent of anything else.)
>
> It looks to me, an outsider, like the problem is some combination of
> "I want to track a commit's evolution" and "I want to see related
> commits in review, esp. when it's an identical and already-approved
> commit." But I might be misreading, and clarifying the problem
> statement might help bring us to a better core solution?

To me, the main benefit is being able to refer to an evolving change
by a stable ID. That enables things like `jj describe qx -m 'new
description'; jj new qx` (update commit message, then switch to it)
without having to look up the new commit ID after setting the
description. That's sufficient benefit for me, and I think most
Jujutsu users would agree. That's basically the only benefit we've
gotten from it so far since we have not started transferring it to
remotes. (There are other minor benefits like being able to highlight
to the user if they have two related commits so they may want to
delete one or somehow combine them.)

Given that we already have this stable ID, it would be nice to also
transfer it to remotes and have it be preserved by the remote,
including when the remote rewrites the commit. If we can use it for
things like identifying a code review so we don't need to link it
using a `Change-Id:` commit footer, then that's even better.

If we instead had something like Mercurial's Changeset Evolution
(explicitly recording how commits have evolved), then we could have a
similar identifier that was based on the original version of a commit.
To make lookup by this kind of change ID faster, we could have an
index from commit ID to change ID (i.e. original commit ID). This
seems to imply a commit can have 0 or 1 predecessors (0 for brand new
commits, 1 for rewrites), which is different from Mercurial's
Changeset Evolution, but not necessarily bad. For this kind of change
ID to be the same across repos, and assuming the predecessor pointer
is stored in the commit, we need to make sure to transfer all commits
back to the original commit when we push to a remote. As I think we've
talked about before here, that can be problematic because the user has
to be careful to check that the intermediate commits did not have
anything sensitive in them. It's also often wasteful to share all the
intermediate commits with other developers. Another option is to
transfer the predecessor pointer outside of the commit object. That
has its own problems, like being able to create cycles in the
predecessor graph.

>
> [1]: https://lore.kernel.org/git/xmqqh62tm5fo.fsf@gitster.g/T/#m038be849b=
9b4020c16c562d810cf77bad91a2c87
>
> --
> D. Ben Knoble
