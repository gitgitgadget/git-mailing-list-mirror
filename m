Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37684248886
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363646; cv=none; b=Y3AizpR9Wok5qJxlra2MRbbQceIOVfvQ1WvusQRg1CHFlsCOTB2vIh4Mk0v7kWBzqGSOt8wV9NJvGp1ICwFIZpCrDT6Yxuk8cYOt0OAcTywsdHC72KczSyHQ3UgqkCRN++ElXtPpjLyXQh4hdN4yoThdhphNBcLOqnZsFvrZxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363646; c=relaxed/simple;
	bh=tsp8BzkIz3mbhHOm59EWBssAHHSntK2Xcd/rJLUzsJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSo4Fen7LLNF5py1Mq0lOJ5vPDJ/bTNbpYVwBoowUHzn+gSPz5hHdjh14CrAJDSp1+xOijMATuoPt5Slus/Oo1+OMP8XLVBOBZESoALW2eTWNt5vdMQZ2ZpR6K7VD2eAAMCSpbJ2cjpoXcUX5hEMXphMoDO7ntW0e4Lay9E8fBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8CCsz93; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8CCsz93"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231ba6da557so581415ad.1
        for <git@vger.kernel.org>; Tue, 27 May 2025 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748363644; x=1748968444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsp8BzkIz3mbhHOm59EWBssAHHSntK2Xcd/rJLUzsJI=;
        b=D8CCsz93s7mqqATwpPzu9d0p8undT2d5F3tzbywmRo+uo4QbRIYHi2oR5WoWN9rcgX
         oSrsJw0gthT+e8TGRJHf7LGQEMKglhQ55FY0GLprPrTdWtT8cxgR9khCtbmU3SviTR45
         04BxfaNdFVrVd3Q7rPkuCfiZRb1RaeZn7eeNpqj3j9+cYFeeiaT/Pinx7d3MRgkMomF/
         jxGMWH1tawRPBhhBO3bvyv9rqDcqSqEGwz4eCjUTuZe7e8GgHJyHB4am468V+OiGDL+B
         fUZnClEwD8Yitc1k5vJ5ObiaNdpNuakDDT1Ky5hU6IOSPnUY1EmgZvLAk8yihO3qkTgW
         o6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748363644; x=1748968444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsp8BzkIz3mbhHOm59EWBssAHHSntK2Xcd/rJLUzsJI=;
        b=P2Omaj1woAADJjDqgrpy3cJcl5iZWm14L5GPAUBZcN0O4r8hyYZetFrqhjdu5RqkzV
         I+jtoNtbdrLGWLxVEzJKT4xeZ5sY+bqgfqrSIfYFJqNEi2LSr6ydJkoX4sruaJEuksC4
         0QpXAwsq7hQPic2K4mayluv1VmC+ZWufqebDXML05MtFB9LJ7PYZ7/jMj6f8FZ5VwTcI
         tk6PAAdQwjqMwy9m5+o1Rm0+qNogOYAU6eLIe1SbCaQHdK6Gh37zwNljkhBbXWaZy0b3
         4Uk0hESWdfyIRwj/7LrILHd6+6szxovuaoTpMY2Py8ZVTQGELieDOqnsB++9PBN1V7qi
         2Ryg==
X-Forwarded-Encrypted: i=1; AJvYcCWhAw7Bpeupv/tI2Oxzo9dVP3wxjO0Rm8p9sn3sTXpBqLMCyX90pZn+7k3mxyxbaS/vUjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjK9u+9oWx7nTyL6AASxFHWiPq560lYLWc8s+UedFBNv2RgtO
	ZmuFh/HqXLe9NV8pcZANgPj341EtXYICrXo+ZlniiSgvdd/N0jc8L8tutAQz9LGD397K14YkXr0
	3/BH6x/lUu7YdR/6lbUcKmT8T3Nb9CYhoOPykqcqmhpv0wa6CjVftYdMx
X-Gm-Gg: ASbGnctpP2t+Ud3j457xgW1TaXXcY5uVGkRxbAYEkk8g+rTKTr8JZGYKYkZQi+n2LOi
	dMqrhXeJUmajdFHRlOcrCfHjYyzhIpRRm4TMu0nLlDlZiw1/4F/kKdMfZhw2rEZzYqw/8G3/zet
	NlRZvVxfx4UrP8Hcexo0yHH/SyQwKFCgr7n6fu4QB0oZHqUwyX+fQOTs4sI1OaYm1YnQDdAb7tx
	g==
X-Google-Smtp-Source: AGHT+IH86VzO4Jf0mzImeSLRrr2+Kd6Zs82w03s42RuvcGP2O48UMotzjEz0lSpaYaLXIE/yzSTcIhCcueLtrlON+1I=
X-Received: by 2002:a17:903:46ce:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-2341808243amr8388965ad.12.1748363644017; Tue, 27 May 2025
 09:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>
 <aDRq6oIgkSfAepcP@pks.im>
In-Reply-To: <aDRq6oIgkSfAepcP@pks.im>
From: Emily Shaffer <nasamuffin@google.com>
Date: Tue, 27 May 2025 09:33:50 -0700
X-Gm-Features: AX0GCFu6aRtW2ZexagY5AHPyTC5wrshA31wVHZMNmp5xou0AyW6QjBZ_9RVEVqg
Message-ID: <CAJoAoZ=OGOWVWQJNSk0YAVA0V_O68Y4ycXdw6d8bJ0=OhnNGeQ@mail.gmail.com>
Subject: Re: HEAD.lock and git maintenance
To: Patrick Steinhardt <ps@pks.im>
Cc: david asraf <dasraf9@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 6:22=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> On Thu, May 22, 2025 at 07:53:58PM +0300, david asraf wrote:
> > Thank you for filling out a Git bug report!
> >
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > We have a system that runs many git commands on a local repo connected
> > to a remote repo on GitHub via HTTPS. Our system creates many commits
> > and works with many un-staged files. Every once in a while, we run the
> > following sequence of commands:
> >
> > git stash --all
> >
> > git checkout b1
> >
> > git remote -v
> >
> > git fetch
> >
> > git status --branch --porcelain=3Dv1 -u
> >
> > git checkout b2
> >
> > git stash pop
> >
> > We start this sequence from branch b1 and record the output for interna=
l use.
> >
> > What did you expect to happen? (Expected behavior)
> >
> > We expected git checkout b2 to succeed consistently.
> >
> > What happened instead? (Actual behavior)
> >
> > git checkout b2 sometimes fails because the HEAD.lock file already exis=
ts.
> >
> > What's different between what you expected and what actually happened?
> >
> > The git checkout b2 command, which previously succeeded consistently,
> > now occasionally fails due to the presence of a HEAD.lock file. This
> > issue started occurring after upgrading Git from version 2.39.5 to
> > 2.47.2.
> >
> > Anything else you want to add:
> >
> > Using GIT_TRACE_PERFORMANCE, we noticed that a Git maintenance process
> > (/usr/libexec/git-core/git maintenance run --auto --no-quiet --detach)
> > sometimes starts after the git fetch command, occasionally in detached
> > mode. We suspect this operation is causing the issue because we've
> > verified that the git maintenance command requires HEAD.lock before it
> > starts running. We are considering setting maintenance.autoDetach to
> > false. We are unsure if this is a bug or if it is working as intended,
> > and would appreciate your comments on this.
>
> thanks for your report! A couple months ago there was a similar
> discussion with someone else, but I cannot find that thread anymore,
> unfortunately.

Google had a big problem with this behavior about a year ago, I'm not
sure if we got far with a thread about it though. That may be what
you're thinking of.

>
> The root cause here is repository maintenance with `--auto --detach`
> will detach before spawning git-gc(1). This command may decide to pack
> your references and thus cause them to be locked. This then triggers a
> race condition, where the next Git command that wants to modify refs may
> not be able to lock "packed-refs" because we are still busy repacking
> them.
>
> The actual timeout to lock the "packed-refs" file is configurable via
> "core.packedRefsTimeout", so bumping this value may make the problem
> less likely to happen. But it's only papering over the actual issue.
>
> I'll send a patch series soonish that fixes this issue. I think the
> solution would be to make git-maintenance(1) learn about tasks that
> should run previous and after daemonizing the process to avoid this race
> condition. The effect would be that the caller of auto-maintenance will
> not continue before refs have been packed, which is similar to what
> git-gc(1) used to do in the past.

We'll look forward to this series with interest, thanks.

 - Emily

>
> Patrick
>
