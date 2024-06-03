Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738E433AE
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396161; cv=none; b=dkm7FYhwkAYyLAIwV7/CcK/FK5GI0ZKI94aqlHZYwUqBlmsrRz+hJlA81hLMU3jOloECdr8UUur661GIMDzu9q1v0tLtlESkTFJmwIoBM5jRa/swMEDN13oKRBjd20/OGrQwg6rlT+hDcStSUyKnGL44MGHb9/MGjw6tR+XfaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396161; c=relaxed/simple;
	bh=8EuQEMO1Tn8rmUTpL+IKQO+DZDo/s5p9QTmhcxb2r5o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XmwqmQVa0FjEWc1C0XhCtbnUaB0D8dAPAlrQm0GbTIZXXvhjoVwdfZBUFe7UNnhz0FOtVFiXVXSyWmd0YmLsTU8ms+OmC8Ncn3wgEaUB3fR4Z0bh2K9oVXhoNUqT1r5g8PEdJv4h9ugi9qOu8lk4lIbVsEYpxEAsCbtroFc+q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoSHZ55S; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoSHZ55S"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b912198f1so2319299e87.0
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717396158; x=1718000958; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TMObR42NhpkfraN1s5qiconR9qh0lUWBAEU4k4+P5XI=;
        b=IoSHZ55StcRdM/7fllEx98YK2jAU7W8SxuH/u2WwfAajpFolT8xUvpdv9rkQFrBxxd
         tZ3LA55uEcB4UUeuBBvE2iowA+47Pj91mFx+0WLLoLrL5oiX8aj6uMbuQzppBW0e6GZ2
         8O5KSZuSjJ+T/fKqv1xzjn1lwjNqlbFEoLu80+NFAzonhqWN4hzYR47JL2/oBVuxQ2nf
         GNxzfmhtIThIbb67eDAY8WzM9aB8xDs4lydxhh6Xa2EEBC/dKIvg7eh2WxuEHAndW0Pc
         bPnpf+HbmnRGsy5tui2oK3rX4AQZR86oKI3re+TwOSMMs3YwzdRR29zZMARA9BZPo0vx
         myTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717396158; x=1718000958;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMObR42NhpkfraN1s5qiconR9qh0lUWBAEU4k4+P5XI=;
        b=h3LYJkeZ3AOo8VehKxrsqj0255yYcJx0PomXGKP3rcrsHUAwriKIfbhfsDznsZVPe6
         Mw/FrqZ919TRHKC47SC0GLhdXqmq0QFyNxsTuNggNbGbz2dzkoSpPJ6/nxMpXDfX1vTW
         SE0wa7XgUVWhh/ehhSrQTr5vnjGxE9l3VXQSnnWqCOLJkcdSDYdd8GrZ+Maji2XW9Nt5
         uSHGQo+uR1DCRddRJYURWnnHor5n3d5fCdkBYrVdcJHIrGid18TvgIk7RT1z4tKMoBL1
         RXA95lu3xVkjXEikvt7hORSTMOnADct6/b32qy3CZiI5C0zYAiFuOA26so85d/Z2qMIx
         RR/Q==
X-Gm-Message-State: AOJu0YzWuuDVbhoBZYE8HctcVkMBvKPQJlzeSOw+ok26Z5s8+s6WvFL7
	MWCYVw3dMpRq144vY81Ck1keRWZCcWEx6lRCKlXpogOrWYhrzER2S5QB/c80xT7NEXWvQlG9/gL
	Iry46Wg+zfljAsDf7z3ZcvpdF4OWbqFWLJv0=
X-Google-Smtp-Source: AGHT+IHoVnqCsdPefof+3EDMBPXOEeH0MP8Ur5/fHm6EZVkakXOPMEBHS2soE4hB92IyAM7zEDIhAdOxtLxWRd21TIU=
X-Received: by 2002:a19:9107:0:b0:51e:2282:63cf with SMTP id
 2adb3069b0e04-52b896c494dmr4594396e87.45.1717396157735; Sun, 02 Jun 2024
 23:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arundas T C <arundas.tc@gmail.com>
Date: Mon, 3 Jun 2024 14:28:41 +0800
Message-ID: <CAKRNJbAnUBmR5MHY=uSF1A3docO-uxWG4agWuFZEyPUnduyWHw@mail.gmail.com>
Subject: git pull --ff-only errors when git merge --ff-only passes
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. In a remote repository, have a commit that's only in remote at the
tip of the current branch in local.
2. In the local clone of this repository, edit some files and have
unstaged changes.
3. In local, run `git pull --ff-only`.

What did you expect to happen? (Expected behavior)

Fast-forward the local branch to match the remote branch, similar to
`git merge --ff-only`. Handle any merge conflicts the same way that
`git merge --ff-only` does.

What happened instead? (Actual behavior)

error: cannot pull with rebase: You have unstaged changes.
error: Please commit or stash them.

What's different between what you expected and what actually happened?

It errored out because of unstaged changes, even though doing `git
merge --ff-only` will correctly do what's expected. See below.

Anything else you want to add:

After doing `git fetch`, I can do `git merge --ff-only` and this
fast-forwards the branch as expected. Isn't `git pull --ff-only`
basically the same as doing these two (fetch and merge)?

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.45.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:12:58
PDT 2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T6000 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
post-checkout
post-commit
post-merge
pre-push
