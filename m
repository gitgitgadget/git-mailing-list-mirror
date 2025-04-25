Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A01FC0FE
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560261; cv=none; b=Sryk6z2FfLQB+Xdu2NjfBZ9JGf5GDyGjUUZtOUdJ1D8F5vCATR5TN1/+COc9ypI4ri6KX6rD4vlG834Of6B0fzeja+eQQDCDrMdKqfdxYXcIHy97WoIU8AjXFRwivcFypXSImHPZiKHGlydjb6jbVxrkWrloYTk/sRsKNpOZszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560261; c=relaxed/simple;
	bh=scpa8bX4xlFcJTNKQ/S+wzSszKDhg5PgJzHc1sXP0GA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q3ewl9uDSanOidOI5b2eO4eqlgArdqbG+yDq1rBs8ZztMqaVT3sASzbQRYj/ic08Yr7MdjjTFQ81OvT4PoPz74BSS9jwURU/yyWkKo6bYQzeVPP6hfVHDIkYKNwFKMLv9D5DlXIcmvJbmV5aPFZJCz+eYRFbDfXSI7gjEyK2S1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI1mAUEs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI1mAUEs"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7080dd5fe92so16757697b3.3
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 22:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745560258; x=1746165058; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK8cUkqC5knowKJrxqlif5bXvYb90nS6/V/ZrFe52D0=;
        b=DI1mAUEsRI1v/mncBaeIWPLu6tXmDXTBdFewMPED97q/YxMJ45f1WLXicr4+AjtJVr
         HRJ/6N2f0aj7bKNnCbCdmS0ay+2z0+AfkOPv+YR74kz11uB0fowlErtbDYmErZnt+o2J
         Wf2RQ4HpAgCmPGMCCf88AuDMXK9wa0kpeWtso5FyhI7llWfeyqRNDG3xXNIZ9BhEet2V
         TSKD4oHpi74smQuOkA36cAafswzQPa2fjerOpRqAC0c5zZfz0GEjDQbiIoXpUHLa4CH1
         6wTV6c/eZ3sVVRTmVsIVs6ofpIdZ3nLc8QsKNEEVPsCLMF9ZCv2ovy2DqTWOiqlwJj7u
         60pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745560258; x=1746165058;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK8cUkqC5knowKJrxqlif5bXvYb90nS6/V/ZrFe52D0=;
        b=FAG7SpyJI2U0ArwLwYKGE4mcsIlT9BRXRix2vQGh0dg8q14hJZmsGgR92Cr6MB2UCM
         YbqpabSDBxYut9OoTIhSCv7ny1VMEP+OZJ7YG0TprDi/eYaEQOEEyaSRBhior7gJnq1y
         OcaMMcx2rrvjs9ooHfJOtwVKnnQkkoq3Smx9mMFLfmsEkxUz/uBnzQRqrkfYuSy1nWAV
         wAzTgWRM2nAmGh4gYDoa6zvY1uhneAt7hFCiuiMTQ9TU+A4CUJwf5HGFJ6tWSOirJT6j
         ZBv3q+ww4HKnnkQXpO90XcuEO3cDmnZMF1gCdiZStq2IDuO8+mht+PTD1ODaJxx+ZiQf
         tI0Q==
X-Gm-Message-State: AOJu0Yyb5yd4+5HAOJalYUJkjJRA9rX5yE7UwFadc0Hb/FDQQulM2reG
	VDW0t914nxNYNrkwJVXvsB243WlZTWrVEWvS99OH2Lqu+0gqhAsn8bKKXHG30bRB8QfT2agl1GO
	SmAAXah8PWeW81DUljZrSg4subJkvfW9D
X-Gm-Gg: ASbGncsNFqI1gGuo019VdNo20iDaP9CogyDc6nteLptJBIh9Zdezix5YfjOl/HpI21n
	yBUNAV4QpX6z7G1T3Acmsq1AWXGHruLw1W02QrMuKPYnc/E/WyjAo16jl9TszVlWU8lyHI69NH/
	nV1hhHWSTGK+/lVe64rnGyHl2effzDYCwdDu+e7/UYWCfuMcnHMAxvSCV5
X-Google-Smtp-Source: AGHT+IG6z/7X1MUG3svn71YAx6+qQNs6mK/Su0MQi/ETzS1Z+HjFtQEh9lSRSngMAdnMPNjvdPulv99+7ylhU4jsQU4=
X-Received: by 2002:a05:690c:4b0a:b0:708:3a47:3d2c with SMTP id
 00721157ae682-70854107cf6mr12312597b3.13.1745560258091; Thu, 24 Apr 2025
 22:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: justingolden21@gmail.com
From: Justin Golden <justingolden21@gmail.com>
Date: Thu, 24 Apr 2025 22:50:47 -0700
X-Gm-Features: ATxdqUF2Y_t2bqfpwwVrJn_8zfekOFBStwgwn2dK9mArIlxBw_-ogRwW6fNRI-A
Message-ID: <CALDohY2O1fbSDR8kTdpQCnZp5Cbc6QYKmT+LhbbaExgAqxaWoQ@mail.gmail.com>
Subject: Git Bug Report - Weird file behavior and unable to change branches
 with no changes
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

I have two component files, Button and Tabs

There was a casing issue (button vs Button) before that I thought I
resolved, but it failed when I built in dev

So because git doesn't track casing changes, I did the correct thing
and deleted Button, committed my change that I deleted, then added it
back, and committed that.

I ran git config core.ignorecase and it said it was true, so I set it
to false and then checked and it said it's false.

Now for some reason, it shows that I'm CREATING TABS as a new file in
my working changes. AND, when I check the pull request, tabs is there
but button is missing

So I clear the git cache with git rm --cached -r . and then run git
add . to add every file.

And it shows 3 file changes: 1) deleting Tabs, 2) changing another
unrelated file which has no changes shown, 3) Also changing another
unrelated file which has no changes shown

So I push it and locally I have tabs and button and in the pull
request I have tabs and button locally. So now I have no working
changes, everything is good, and I try changing branches from design
to dev.

It won't let me because I have changes. I check and it says I have no changes.


C:\Users\User\Documents\GitHub\desktopclock>git status
On branch design-system
Your branch is up to date with 'origin/design-system'.

nothing to commit, working tree clean

C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
error: The following untracked working tree files would be overwritten
by checkout:
        src/lib/components/UI/Tabs.svelte
        Please move or remove them before you switch branches.
        Aborting


What did you expect to happen? (Expected behavior)

The file changes to be tracked. No working changes.

What happened instead? (Actual behavior)

What I mentioned above. Random files were changed, no changes shown.
At minimum, after status says tree clean, it shouldn't stop me from
changing branches because I have working files.

What's different between what you expected and what actually happened?

As I explained above, the entire thing is unintuitive and seems buggy
to me. I love (and trust) git, but this definitely seems like a bug. I
know that no changes shown can still have line endings and that git
doesn't track casing unless you tell it to. Still, all of the other
behaviors I experienced seem like bugs. I wish I had repro steps or
anything else for you.

Anything else you want to add:

Thank you for working on git!

[System Info]
git version:
git version 2.36.1.windows.1
cpu: x86_64
built from commit: e2ff68a2d1426758c78d023f863bfa1e03cbc768
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19045
compiler info: gnuc: 11.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>

---

git clean -fdx

This deleted almost every file in node_modules. It's gitignored.
Here's the gitignore:


# Mac
.DS_Store

# Packages
node_modules

# Build
/build
/.svelte-kit
/package
/.netlify
coverage
vite.config.js.timestamp-*.mjs


I know this is because of the -x flag now. But even after that, when I
ran git status, it was clean, then git checkout dev failed:


C:\Users\User\Documents\GitHub\desktopclock>git status
On branch design-system
Your branch is up to date with 'origin/design-system'.

nothing to commit, working tree clean

C:\Users\User\Documents\GitHub\desktopclock>git branch dev
fatal: a branch named 'dev' already exists

C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
error: The following untracked working tree files would be overwritten
by checkout:
        src/lib/components/UI/Tabs.svelte
Please move or remove them before you switch branches.
Aborting

---

Currently unable to switch branches:


C:\Users\User\Documents\GitHub\desktopclock>git status
On branch design-system
Your branch is up to date with 'origin/design-system'.

nothing to commit, working tree clean

C:\Users\User\Documents\GitHub\desktopclock>git branch dev
fatal: a branch named 'dev' already exists

C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
error: The following untracked working tree files would be overwritten
by checkout:
        src/lib/components/UI/Tabs.svelte
Please move or remove them before you switch branches.
Aborting

C:\Users\User\Documents\GitHub\desktopclock>git checkout -b temp
Switched to a new branch 'temp'

C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
error: The following untracked working tree files would be overwritten
by checkout:
        src/lib/components/UI/Tabs.svelte
Please move or remove them before you switch branches.
Aborting

C:\Users\User\Documents\GitHub\desktopclock>git status
On branch temp
nothing to commit, working tree clean

C:\Users\User\Documents\GitHub\desktopclock>git add .

C:\Users\User\Documents\GitHub\desktopclock>git status
On branch temp
nothing to commit, working tree clean

C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
error: The following untracked working tree files would be overwritten
by checkout:
        src/lib/components/UI/Tabs.svelte
Please move or remove them before you switch branches.
Aborting


Also:


C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
error: The following untracked working tree files would be overwritten
by checkout:
        src/lib/components/UI/Tabs.svelte
Please move or remove them before you switch branches.
Aborting

C:\Users\User\Documents\GitHub\desktopclock>del .git\index

C:\Users\User\Documents\GitHub\desktopclock>git reset --hard HEAD
HEAD is now at 98c4b5c4 Fix file casing issue and re add components

C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
error: The following untracked working tree files would be overwritten
by checkout:
        src/lib/components/UI/Tabs.svelte
Please move or remove them before you switch branches.
Aborting

C:\Users\User\Documents\GitHub\desktopclock>git status
On branch temp
nothing to commit, working tree clean

C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
error: The following untracked working tree files would be overwritten
by checkout:
        src/lib/components/UI/Tabs.svelte
Please move or remove them before you switch branches.
Aborting

C:\Users\User\Documents\GitHub\desktopclock>

---

Fixed by manually deleting the file via windows explorer:


C:\Users\User\Documents\GitHub\desktopclock>git status
On branch temp
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    src/lib/components/ui/Tabs.svelte

no changes added to commit (use "git add" and/or "git commit -a")

C:\Users\User\Documents\GitHub\desktopclock>git checkout dev
Switched to branch 'dev'
Your branch is up to date with 'origin/dev'.

C:\Users\User\Documents\GitHub\desktopclock>git status
On branch dev
Your branch is up to date with 'origin/dev'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        src/lib/components/ui/Tabs.svelte

nothing added to commit but untracked files present (use "git add" to track)

C:\Users\User\Documents\GitHub\desktopclock>


It showed I deleted the file from temp branch, then when changing to
dev that I am adding the file.

Git certainly seems like it's in a broken state and I'm completely
unable to fix it.

Thank you in advance!
