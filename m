Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164292036F0
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056949; cv=none; b=N8Fq8Frsds18wsGAIk7ugCa6gBNDtCxIpMpUCWl2460AXceA6VcxccKa2uZmk+sZErPHF0ork/YlDOLjGn1WArHo6Yo1addBRxDWvbrOCboive+iwG1j6a9DQussofi9imSSji3kVuh32SJwZO5OJ3M0DiKreBgjeIp1cTaftMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056949; c=relaxed/simple;
	bh=ukpZm/Wy20IsIlThX5QcIf2wDLfcpLRamKpbH9opuRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4Y5mG/0LFEKqxBZOxWu5TnxYqUXbCuB0hjuLrGVVMK5AMfSNx59x7T9O6VCcGE3vQkhKv5tBbR6Zq0RQWVYqP4DpGQW2/j2usj/JMmsjJOibQ5U+vvsGzdaZESD6TKNN/j2tiNKZVmRXhd0ashYj8NZSI+h5Q1JNCXrbz/5lH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIDRvI/V; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIDRvI/V"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b515e4521so103410339f.1
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742056946; x=1742661746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0++HYSEeBfufBIdhAnu1hkmeZb9vqXhznyW1CkvDYs=;
        b=HIDRvI/VDo+jdUlI5ymb7PtlE/YksvL5wUQBDBOFw3WwhM4B/yV51zvl9OQQmUb6JN
         ALQLgev9AOYpPotfx7XR3x6iaAzqJO2N4m703MaeUq3fcuy4mih5SYli2FshgHXOi/dd
         aqCQbUKniS6ND1r+agHd0U3GvECBag3IEwMlFWhFyxUvDYp4uY5OOSZZI/6meHnGVVPV
         g1j5ugn4wynUsPo3P9CzhmHXDC2IlvFcpmrRGqvVGsMQ1YLikaIn+3Pga5DZkfZH0bqF
         VVOnZoFBKhvPsnQlOGc+B8xXcE7NTLdEqWb0T87yIydvDQvZfXTcA0miHRi3ZI4GC55/
         QtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056946; x=1742661746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0++HYSEeBfufBIdhAnu1hkmeZb9vqXhznyW1CkvDYs=;
        b=XBAMQCYE78hJLOxTylP+F7FFTl7C11QdI5sIyBusSFJYEq/cgp97yYZ12mW3ISDppe
         Fss0MwpuWeB4yVEnOMVgNq8/cgS3GeQb4EvFUedUjO0JWiHJpE/swHEezvbXPNyCiw+a
         AyuCvyzpr9mmuOqPbTrNWCDHD0stmLtBwbZz8zbzqzIKTT7jLmKrrd9JzTmcgY8yRRMM
         JgetuwedX6feRhAM7X/3MXQVLGYRjLQyaJ8wL3RlxLZewx6lb76sG7Dc76AqoWxKIcuP
         olDho/lVMTnkuOfF5E9DZJ2zlbl9vC6/5+q6YhVbbw5LjAEtByw2pT/1iA2ulxv9Ve3u
         buDg==
X-Gm-Message-State: AOJu0YyX38jsrwXo+OomRppgjuUB/kj+NQOEBPUISzKHDMXVBrsexKJ3
	VcZAoquXZLlIGtZmOFGfzLGxYq3/083kMQHBnva2I5ARTdBRabTWfIsgyBGvHnHcP9WRYErInmS
	KfpsEvbmlW7H9WraNQvDKJzl57CHwrbK+
X-Gm-Gg: ASbGnctSVuz0TB3XflkkZpql3VNcLbiEWNfrp/DHoxaIrvB5Cyuo1jSWQSylA39uhKc
	sHlwKGL/sj2mCXC+w1Rg2QARTF3fpRj515P4V4tegCrMYsD20niZMYho4jdyxLl9cEw0hdx7kQC
	gklVA5zzj2RCxxpF7IlXTrheeG5sP74FwTm/NM4beeuCPt0bZY88iHipEF0g==
X-Google-Smtp-Source: AGHT+IEDIac6AaYq9F7zCZ4+TaynCC6NBRjP1bdnlIvNL0QYXfi7MB1FNxUblB0tmbqyn7ERF+BkuDe32IkoJcnG7RM=
X-Received: by 2002:a05:6e02:3a0d:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d4839f442amr73441935ab.2.1742056945949; Sat, 15 Mar 2025
 09:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmRq=7Q=vCPgmcLcek=fRsw83BPqTX7gTpcLb=JpQpYZEw@mail.gmail.com>
 <CABPp-BHPAEcJibTaiMVE1K7AvYE+TYmOt7=6XUtcZbm7wsWhDQ@mail.gmail.com> <CANrWfmRpDFuqv+fkCf_p_ggHTrRjD3Vgviqrai_rA7Lu-YFEMA@mail.gmail.com>
In-Reply-To: <CANrWfmRpDFuqv+fkCf_p_ggHTrRjD3Vgviqrai_rA7Lu-YFEMA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 15 Mar 2025 09:42:14 -0700
X-Gm-Features: AQ5f1JqPLGmVPLbR97p8bsYwb2SJMS9k3GtzySf8NSUSiZHfw8g7RWZURlTfiUk
Message-ID: <CABPp-BHn6sPBh0CPctJ4-rM3rxGwXkbG4-o236dRV8FTwdP_nQ@mail.gmail.com>
Subject: Re: `--ancestry-path` documentation has wrong graph
To: Han Jiang <jhcarl0814@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 1:21=E2=80=AFAM Han Jiang <jhcarl0814@gmail.com> wr=
ote:
>
> On Sat, Mar 15, 2025 at 6:16=E2=80=AFAM Elijah Newren <newren@gmail.com> =
wrote:
> >
> > On Thu, Mar 13, 2025 at 2:04=E2=80=AFPM Han Jiang <jhcarl0814@gmail.com=
> wrote:
> > >
> > > Git - git-log Documentation --ancestry-path[=3D<commit>]
> > > https://git-scm.com/docs/git-log#Documentation/git-log.txt---ancestry=
-pathltcommitgt-1
> > >
> > > The graph for `--ancestry-path=3DH D..M` should contain commit C.
> >
> > Indeed; D..H contains C, and C is an ancestor of H.  I apparently
> > overlooked C in that example when writing that documentation.  Would
> > you like to submit a patch, or would you like me to do so and record
> > you as the reporter?  I'm fine with either, but if you want to give it
> > a try, the relevant file is Documentation/rev-list-options.adoc in the
> > repository.
>
> Thank you for the clarification! I'd like to try sending a patch.
> After doing some research on how to make contributions today, I
> decided to try GitGitGadget way first. But I got some questions that
> the doc doesn't clearly explain:
>
> [Git - CodingGuidelines
> Documentation](https://git-scm.com/docs/CodingGuidelines) says:
> For C programs: We use tabs to indent, and interpret tabs as taking up
> to 8 spaces.
> 1. It seems adoc files treats tabs as 8 spaces too, is that true?
> (The prepared commit in forked repository is at
> https://github.com/jhcarl0814/git/commit/ce568e4a87dff14df4e7104af89be3f1=
2616f5de
> . The source diff shows tabs as 4 spaces. The rich diff shows tabs as
> 8 spaces. When I was editting the number defaults to 8 and is
> adjustable in editor options.)

Yes, assume 8 spaces per tab.

Note that if you're worried, you can cd into the doc directory and run eith=
er
    make git-log.html
or
    make git-log.1

followed by then either
    <open your log git-log.html file in your web browser>
or
    man ./git-log.1

and look at how your changes modify the end result.

> [Git - MyFirstContribution
> Documentation](https://git-scm.com/docs/MyFirstContribution) says:
> For single-patch contributions, your commit message should already be
> meaningful and explain at a high level the purpose (what is happening
> and why) of your patch, so you usually do not need any additional
> context. In that case, remove the PR description that GitHub
> automatically generates from your commit message (your PR description
> should be empty).
> 2. For single-patch contributions, is the pull request title or the
> first line of commit message that will become Subject of the email?

Why would you make the pull request title and the first line of the
commit message different for a single-commit pull request?  That'd be
weird.

I have a guess at the answer, but only a guess.

> [Git - SubmittingPatches
> Documentation](https://git-scm.com/docs/SubmittingPatches) says:
> It is a common convention to prefix your subject line with [PATCH].
> 3. Which one of GitGitGadget or the pull request creator is the one
> who add "[PATCH]" at the beginning of the title?

GitGitGadget will add it for you.

> [Git - MyFirstContribution
> Documentation](https://git-scm.com/docs/MyFirstContribution) says:
> Now that your CI is passing and someone has granted you permission to
> use GitGitGadget with the `/allow` command, sending out for review is
> as simple as commenting on your PR with `/submit`.
> 4. Who is able to use `/submit` to trigger email sending action? Is it
> the pull request creator (when `/allow`ed) or anyone (`/allow`ed)?

Once you've been /allow'ed once, you can /submit that or any future
PRs of yours.

> 5. If `/submit` sends email, then how to cc all relevant people
> (including myself) at the moment of `/submit`? Is there a place to
> fill in this parameter?

In the PR description include a line of the form
   cc: User Name <user@email>

> 6. Where does `/submit` send the email to, as a brand new post or as a
> reply under this post? How to configure?

Brand new post, not configurable.  Just post a response to the
original thread with a link to the new submission.

Now, as kind of a summary of the answers to many of these questions
and perhaps others:

If you want to see an example, take a look at and compare
   https://github.com/gitgitgadget/git/pull/1864
with
   https://lore.kernel.org/git/pull.1864.git.1740139296483.gitgitgadget@gma=
il.com/

You'll be able to see the cc in action, see where the commit message
and pr description go, see how the subject has '[PATCH] '
auto-prepended, etc.
