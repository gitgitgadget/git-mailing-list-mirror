Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05702D6E78
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927008; cv=none; b=ancgfup2gIziLFZ/pDE9G/cy2Wem5VZ2bCcsqGnkPmfjtl5SUxJNoWIO4fJrbXwqAZytTTzYSz9q7QDvwzFPylEPVie0rPd883wYx4al6ar1tAC6OFqrq/tOTM+oNTSs4LhODiImU3ZT3+fFV4+rmIFTctXCknH6g9BvksD2hec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927008; c=relaxed/simple;
	bh=5I/kuvnim0zyeVs5JiwlNO+dinHerau8plN18COgOq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFwP3P2FHqAotu3YrqDonpDdbfA+bFdtG4R2f+4AsMX2hGTvVaNxXiJ8KQ/Hr9OypL25W4k4MSGhQhF4i3vtdT+2JVHbnx0SioZzmTpsw/9z9mLl6qgqE8Pel8xn5/3MxWFPg1jXyFlevD/G3rY3o0FeA8scq3wLqcAINs2Nqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/ZReA4I; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/ZReA4I"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-538fecc0e3cso631407137.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757927005; x=1758531805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vZKNEkELWXdRQECPSGJXuTPLweCkKkJFL4Z/c8wpmsk=;
        b=Q/ZReA4IW05hQgpsosAdlTMLemEBp10GSoFNJsDNmJAVTxF8kgXs+tJOr72I5ymPt7
         qSVa4cpG6I06kzzLxvUTEi2NbTbAOewPTFeX1cLn6hwijaI1/c1SlSJguG8osb6DSaws
         wBKuLwCnC8zE04xnuB8veIYDZoq9nkufJe79GvQEHpCfVJAjrKlnvVtU4ATW7sB7fTWP
         9II2wDj9xlzotd52iSzMSKLm3uf7XZ4+HArSeZIIKhm8YklcQvLTtCh0KZ6kE+xxztNy
         QtVE26cDKtDXR1ej+zyTEa05ZP8ZAejrRwNLemwj2e3SyPWraEdQceMeXJIwkJmYkAub
         j6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927005; x=1758531805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZKNEkELWXdRQECPSGJXuTPLweCkKkJFL4Z/c8wpmsk=;
        b=CHUOY5ywM2uIGCcVNgEchF+bJ0+MvixkIedyuqBfTm1IoYbGzuhpYyq+J2I26Tck+B
         JD8IjrExrFYAh80ZbMrI/rb+6i4HcC0msMyf4+3LnPCUnlLouAAgzM/lllbW2hjJMDcu
         NfLf8W+119/jamwTuK8g9Jc3rXRCTlTb7K2DHfy5r9pyjHpzzBCsCYsDLOs/A5G1bcZN
         danHjLOQCZCjQt7aX6b7WGIjMaDFLBzoQ+v9UMZwsntHHIJ6+0yTfg3ao1TAoYQszlOp
         XdDrOHLyo7yIYFcyv7rXiycK6wjWxHemyqiLqp+xNdfmkys2ebSYlUyTKxE65h4jWkCk
         qiqA==
X-Gm-Message-State: AOJu0YxIZKtxbMebRTOX3Yh1KWEzcb/Hp/WSLgT0m+OCRQErycVnFAqi
	dvYT4SGMVN8H/+NKCpOYEaJ6YWGVfPeiGU8vw30O1O8OfTLOGznX+ef2uMUxuVm7WMHe3mgYCnB
	xEfbBrVcqN5aTNjildSarN6KfiJOfYKg=
X-Gm-Gg: ASbGncuTuVQ/sBgZNH6qxTYgkNQOBeB6OyZcyYR/jmFsnE4iiiCLMrtDPf1D0nGfkzu
	EJOfnmPlTsT7ppS1zMNTJFWol5Or8zRFK4aDt/fzBYtnQ6XLgALF28y6DznXleXI4pTEEJ8pYC9
	dQ1vQr0FVcXVcF+CVbJtG9z5vHVP2TX9aIuObATaqSTuvbRDU75EI8DDlYSLCDXx2JX4JeehySv
	kmOjQ0a1hygvXvy0lM=
X-Google-Smtp-Source: AGHT+IF4tCpJgh9GI/U7vlrnx6zKWPAUBhw+0sYin+36MzlU7tnzJ7ClExwp3dAaUZeTcYEjz6rLww37oIXme9DM9Pg=
X-Received: by 2002:a05:6102:644a:b0:538:f3d5:fc14 with SMTP id
 ada2fe7eead31-5560fd33232mr3324006137.26.1757927005418; Mon, 15 Sep 2025
 02:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+itcS3DxbgpFy2aPRvHQvTAYE=dU0kfeDdidVwWLU=rBAWR4w@mail.gmail.com>
 <63e7901f-4210-438e-9389-8117d5fb83b6@gmail.com>
In-Reply-To: <63e7901f-4210-438e-9389-8117d5fb83b6@gmail.com>
From: Simon Cheng <cyqsimon@gmail.com>
Date: Mon, 15 Sep 2025 17:03:14 +0800
X-Gm-Features: AS18NWCcnDWLmKW-ry-u_WB91XDZkIof3YzHOcM0klf3UMTFZsWDnQBxAGjck1M
Message-ID: <CA+itcS2Knde3K_JuVru6_s=Eh0rPBPi1aa1=y0_wyA-=A7CXsQ@mail.gmail.com>
Subject: Re: [Bug] commit cleanup does not happen during autosquash rebase
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Resending because I accidentally used HTML mode.

Thanks Phillip,

Sorry for replying so late. I forgot to set up notifications for this
email address, so I had basically completely forgotten about this
matter.

Yes I fully agree with your proposed approach. Also it's probably a
good idea to update the `git-config(1)` man page to document all the
commands affected by `commit.cleanup`.

Cheers,

Simon


On Mon, 18 Aug 2025 at 23:14, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Simon
>
> On 13/08/2025 12:39, Simon Cheng wrote:
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > 1. Initialize a git repo with `git init`
> > 2. Install a custom `prepare-commit-msg` hook that injects some comments
> >    - Intention: inject the output of `git log --oneline -n10` during
> > interactive commit, so I can see past commits
> > 3. Run `git config commit.cleanup strip`
> >    - Intention: strip the injected comments too in non-interactive mode
> > (e.g. `git cherry-pick` & `git rebase`)
> > 4. Run `touch foo && git add -A && git commit -m "Initial commit"`
> > 5. Run `touch bar && git add -A && git commit --fixup=@`
> > 6. Run `git rebase --root --autosquash`
>
> Thanks for providing a simple way to reproduce this
>
> > What did you expect to happen? (Expected behavior)
> >
> > Git would perform the autosquash, while keeping the commit message of
> > the squash target unchanged.
> >
> > What happened instead? (Actual behavior)
> >
> > Git performed the autosquash, but the commit message of the squash
> > target is now clobbered with my injected comments.
>
> It looks like this stems from f7d42ceec52 (rebase -i: do leave commit
> message intact in fixup! chains, 2021-01-28) which was added in response
> to a bug report[1]. That commit switched from always cleaning up the
> fixup message to never cleaning it up. I wonder if instead we should be
> respecting the user's commit.cleanup setting. The commit message says
> that should not respect commit.cleanup because we want to use the
> message verbatim but that is not what we do with "pick" commands which
> respect commit.cleanup if it is set. Given that we call the
> prepare-commit-msg hook we cannot be sure that we're reusing the
> original commit message verbatim anyway so I think we should probably
> change "fixup" commands to use the same cleanup flags as "pick" commands.
>
> I'm going to be off the list for a week from tomorrow but I'll try and
> look at this again when I'm back if no one else has picked it up in the
> meantime.
>
> Thanks
>
> Phillip
>
> [1]
> https://lore.kernel.org/git/CANVGpwZGbzYLMeMze64e_OU9p3bjyEgzC5thmNBr6LttBt+YGw@mail.gmail.com/
>
> > What's different between what you expected and what actually happened?
> >
> > I expected commit cleanup to happen during the autosquash. It seems
> > like that didn't happen.
> >
> > Anything else you want to add:
> >
> > Here is my `prepare-commit-msg` script. But I expect this issue to be
> > replicable with anything that injects comments.
> >
> > ```
> > #!/usr/bin/env bash
> > {
> >    echo '# Last 10 commits:'
> >    git log --oneline -n 10 --decorate=short | sed 's/^/#   /'
> >    echo '#'
> > } >> "$1"
> > ```
> >
> > Please review the rest of the bug report below.
> > You can delete any lines you don't wish to share.
> >
> >
> > [System Info]
> > git version:
> > git version 2.50.1
> > cpu: x86_64
> > built from commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > libcurl: 8.14.1
> > OpenSSL: OpenSSL 3.5.1 1 Jul 2025
> > zlib-ng: 2.2.4
> > SHA-1: SHA1_DC
> > SHA-256: SHA256_BLK
> > uname: Linux 6.12.41-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 01 Aug 2025
> > 20:42:03 +0000 x86_64
> > compiler info: gnuc: 15.1
> > libc info: glibc: 2.42
> > $SHELL (typically, interactive shell): /bin/bash
> >
> >
> > [Enabled Hooks]
> > prepare-commit-msg
> >
>
