Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7B2F1FDE
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085205; cv=none; b=BN03yHOwtk1koEIF7pL4fRDwR5ZrJ9huaP8bfpB3KAdEPcKqAxH/36VT7KKiQRbLwF+HVFjDrXmvFZq2viceKRp2SZysidq0Scc9AmBrrI7A30BucIQO6LFQqvhx0slMyBxt5hIUivKDGmz4X+/rpvM24HT5nO+mDl2JXD/A9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085205; c=relaxed/simple;
	bh=qCLoPoA8PW/HFxzxp7UBBrTlVxv6wgP99J7WPtpvbyQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uoax//5e+V/siEFXlG8onu26uUY2bZwJG3APdb2ElRTnK92UYuxtAGl3VD0sgaXLenYtvhpfXM+eMENigtdHtO94pQK25XwMjP7H2Xm1LFfpBRV+KTkJOVZYghiAO1EJpRAlHGRu1B2hzwC5spFKKMBLsSRAPEiCZ3eP3LsCb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkgAJa4+; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkgAJa4+"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-539360cc274so4421916e0c.3
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755085202; x=1755690002; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XbLYFNph4TDO0MhVFRXFXTCm9wHArShkLWfCpqO4Ul8=;
        b=NkgAJa4+xz59rxojgoxLcJcJt+N/q6EiGtBhJ1rDev77dfZfwaQf8BjitvQwS+3ZDn
         hOv9EQl3ni6teBv76Qjpw7QrP6IpARLCI7n5KkwW3HVpds9IpHWno7JVHluQKB9jCuGm
         6DLWzLYerUEIIlgWTnIiiCmBFod3OgO/LiB6ARrYwEtg+851Te7j64k8kg9yjjGWHOIz
         e2tFAsuF98Bw/di0T8KsbMzFetlGkM/JFEOx0jF2EDF3Jai0nbnfkoGaf35CGvFgVaJr
         lRlvfyB5TGS65W8DHf6SXzL0OfCtpUEfAL6L7l9xMPqYSWmmdVP0EsjMnoghS0cVvFPG
         rHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755085202; x=1755690002;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbLYFNph4TDO0MhVFRXFXTCm9wHArShkLWfCpqO4Ul8=;
        b=CTB5hr/wygr299SIRefh33l5ELPSzmogx+UXPbhfy+lDMWLBCoZ8lP3GbpBaKh01rD
         UYdHcyHXKc3tqDM7wkxXrdwEWGoZ/OeJaq7NZj7GMgo2Rqr7As5fP6Ce4VBgFgFQQLDP
         MrXW2SNVnYw1Et8+niYX/sX8104BWLpWNmY59FH9pUqLtoJon44+pWFFwifEFegz2Cc7
         L8pujc45Hf5cl9BLBX293FQKOHcpHDs/AGeMFMADh8FypFeB+asFJ5K4PzOMB8WigWUl
         CMTuzJ0F2hx0QqBSoo8XglY745yzbGLLliw/k4/rGtF0xfiizl7OsSVXwd+OSbFPjp43
         V7AQ==
X-Gm-Message-State: AOJu0YyftCc3+2GuATv/VDxHJ442agWYyLSCwmw18n37U9RtWrbUSfQ7
	Im73EZ5nIcWFSFZgzucG7iOGwCWfvdFit+SIfKhLVzORC9qouZRFNfU9ukED532gdtjKKD5LZyf
	fAvgDKbipNVC6M6VMFYTMCp/+wRSIYPtPYwnaiew=
X-Gm-Gg: ASbGnctgkgLza40L8yfov/5JDxMJiiJOAYYNv5Qhxqya9WINIEXE0pIRbhTpvd8NbzQ
	JSJYqmKVMO39ktc+fIoB2hosNiMXWg1GEmBNoFxzf2CjrJiHOdiSkFl4Jqvy36b6wXgZyFLewCy
	WpsTsTbbL/BCGIPPCbDJUlTiurh0NaMmosF+41G5jpkMgteXEVAo2+ib4ou2FoFd2+zBLrLT9NS
	VELKcZ7
X-Google-Smtp-Source: AGHT+IGByqOGeuZ8FXshr2/VFpkNSGkEm5LqK+URD1mw1UxL7b/7n8ts2eqiGfkgM1VHKbe+x6Hlofarfzo1J1oisg8=
X-Received: by 2002:a05:6122:3117:b0:539:8b51:fbe8 with SMTP id
 71dfb90a1353d-53b0b272ca5mr832554e0c.0.1755085202213; Wed, 13 Aug 2025
 04:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Cheng <cyqsimon@gmail.com>
Date: Wed, 13 Aug 2025 19:39:51 +0800
X-Gm-Features: Ac12FXwElcC83tKFylauzR-rMOvZ80xCg21ZzxAPlbxrHBuBOmgK_YIHfv3XaE4
Message-ID: <CA+itcS3DxbgpFy2aPRvHQvTAYE=dU0kfeDdidVwWLU=rBAWR4w@mail.gmail.com>
Subject: [Bug] commit cleanup does not happen during autosquash rebase
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Initialize a git repo with `git init`
2. Install a custom `prepare-commit-msg` hook that injects some comments
  - Intention: inject the output of `git log --oneline -n10` during
interactive commit, so I can see past commits
3. Run `git config commit.cleanup strip`
  - Intention: strip the injected comments too in non-interactive mode
(e.g. `git cherry-pick` & `git rebase`)
4. Run `touch foo && git add -A && git commit -m "Initial commit"`
5. Run `touch bar && git add -A && git commit --fixup=@`
6. Run `git rebase --root --autosquash`

What did you expect to happen? (Expected behavior)

Git would perform the autosquash, while keeping the commit message of
the squash target unchanged.

What happened instead? (Actual behavior)

Git performed the autosquash, but the commit message of the squash
target is now clobbered with my injected comments.

What's different between what you expected and what actually happened?

I expected commit cleanup to happen during the autosquash. It seems
like that didn't happen.

Anything else you want to add:

Here is my `prepare-commit-msg` script. But I expect this issue to be
replicable with anything that injects comments.

```
#!/usr/bin/env bash
{
  echo '# Last 10 commits:'
  git log --oneline -n 10 --decorate=short | sed 's/^/#   /'
  echo '#'
} >> "$1"
```

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.50.1
cpu: x86_64
built from commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.14.1
OpenSSL: OpenSSL 3.5.1 1 Jul 2025
zlib-ng: 2.2.4
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Linux 6.12.41-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 01 Aug 2025
20:42:03 +0000 x86_64
compiler info: gnuc: 15.1
libc info: glibc: 2.42
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
prepare-commit-msg
