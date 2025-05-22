Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCEE29AB0F
	for <git@vger.kernel.org>; Thu, 22 May 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932852; cv=none; b=iv2ctecHnIFgwvMRVi1e0o2HCodc8tftZ8VhDTckY0DwX8vNlLe+U7EKn3gqwDJzOucOzkCr3kk5n6nlBaMeY4+YkMN9IJrUD9fFmzi1t7NHcapN5Qc4Lqqx8J7WwTLF+W/5yuT2GrV3pBfOJgoeew5je/6x68z/4VlbuZVmANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932852; c=relaxed/simple;
	bh=o6RikfO7Q71aLHFPwUIEKu6dnbEjYGHOSWCphsTwNPc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F+Nof6NH6YDxG4pqCz8YRd2V5APMSEMW3AWpb6XmR+fbolvbjCO6yogxHX364bw6eWxqXMFkiTh2tFdERI6QPLJU7vwGCEYBaMg6pfTFjuVVc27ZZtcDsRGCmzy3wM2GXWt4cBRVg0TqjMpK1lqGvkJVTf1Te5UlW/PM+HJAAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvDBtMNU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvDBtMNU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-310e1f4627aso389698a91.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747932850; x=1748537650; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o6RikfO7Q71aLHFPwUIEKu6dnbEjYGHOSWCphsTwNPc=;
        b=GvDBtMNUpqIEWcqQohSYuOOe5iEFv18Ch/yCZfDvWPcCDGlakHJLSKU+lcxL5oMBQ/
         z0n1gT2q/9MgThO3WLXwEtaEzemyW4KhE26omLuC2q4K8kbsL24wrARg72MTCaKbFEE5
         zr+nXbcTFnCW3FPUPV7G6y7dwaAUlXLukgXC5OBlmA+wj085017emD6navA5DBjWcOaA
         J7/IQwQ8tccd8rlZ0NSPQ1P89oM6Nl/gfWdHelsIle69YKsRCg0g9faApkdzvbBuIY18
         Qtvx+XtnCOcrjfAVYtcDrxkf5aVAi1obL/0qtI4BSbrAiLF+vjFWOutyCB0QucCL0PSl
         GHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932850; x=1748537650;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6RikfO7Q71aLHFPwUIEKu6dnbEjYGHOSWCphsTwNPc=;
        b=itpiy5f9Ia1bfEFJ41n4PW0R4UO525+o/5223zXNdvruPUzA/nogdmqaG1BhgZh1Bo
         g7d1fRMsAOdoFGRj5l8ggyGyuzRTR0zUevkQ9jqw5T+kIiz5jgMjOisyAZh8unSGPY9V
         zseAgsLDO27UgUd/mYWFU98CC4ehU2dSPbRugN46EXKZ6aZ5BiKzbHG4JjiQDcrqhupx
         QFD6dSrUwfABOfq0i1tKFViScsLPEneFjJuANZ34v8cySarANmqx7mca5SN5ebi1c/jP
         Xvu1ARBTAzpbpPyLJzAMqj6fefcnxAMnhNhmd01xci8XxaosDRVDILNxlYYt3sHJFEGP
         /nSg==
X-Gm-Message-State: AOJu0YyOBJCuIgDwSGzqaiha5WteS+9ReoDF1E4BR2lGdWkEreqkB9lp
	I8xvE1Fcz+I12cOW6DraVNcLzZcvKiU6aNgqxC4jm6+JU6/SdKebSDPvTEmn8SkYRm5VMiXqhKy
	m4cs9vsb/BBU1md20Ek8ZIFqwTDEseW+7yD2w
X-Gm-Gg: ASbGnctinFBb7rvrUAL5u7tm6WvInkP6+NteMMgTE15Ijrx1b4I1Ffgjq/cE5yFwdqq
	pewHi3ttK7UuLXbj7Q4qAm/4warqcM54jH/H0VA+/MDfjLP+svnPmww98DIVUJeUrxwAvPtSer1
	YUMLr0JNr5zGM0PLUImdeVjOsmsUH2MEzPQg==
X-Google-Smtp-Source: AGHT+IGQ7iRaADgc9HF/QwoIVkFx2wfYECEKKmteg2Ck2qOuIUuwClo217puqWr46dcwwWIt+dRg44eY23e1aMpb0p8=
X-Received: by 2002:a17:90b:5284:b0:310:8d54:9e7b with SMTP id
 98e67ed59e1d1-3108d549eeemr12569069a91.2.1747932849551; Thu, 22 May 2025
 09:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: david asraf <dasraf9@gmail.com>
Date: Thu, 22 May 2025 19:53:58 +0300
X-Gm-Features: AX0GCFshZSAZrMZ3WErkrA5Sh8GKOdxPx_6kx_CiYQJyK9CCptiwWfC743nPDv8
Message-ID: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>
Subject: HEAD.lock and git maintenance
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!

Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

We have a system that runs many git commands on a local repo connected
to a remote repo on GitHub via HTTPS. Our system creates many commits
and works with many un-staged files. Every once in a while, we run the
following sequence of commands:

git stash --all

git checkout b1

git remote -v

git fetch

git status --branch --porcelain=v1 -u

git checkout b2

git stash pop

We start this sequence from branch b1 and record the output for internal use.

What did you expect to happen? (Expected behavior)

We expected git checkout b2 to succeed consistently.

What happened instead? (Actual behavior)

git checkout b2 sometimes fails because the HEAD.lock file already exists.

What's different between what you expected and what actually happened?

The git checkout b2 command, which previously succeeded consistently,
now occasionally fails due to the presence of a HEAD.lock file. This
issue started occurring after upgrading Git from version 2.39.5 to
2.47.2.

Anything else you want to add:

Using GIT_TRACE_PERFORMANCE, we noticed that a Git maintenance process
(/usr/libexec/git-core/git maintenance run --auto --no-quiet --detach)
sometimes starts after the git fetch command, occasionally in detached
mode. We suspect this operation is causing the issue because we've
verified that the git maintenance command requires HEAD.lock before it
starts running. We are considering setting maintenance.autoDetach to
false. We are unsure if this is a bug or if it is working as intended,
and would appreciate your comments on this.

Thanks, David.

Please review the rest of the bug report below.

You can delete any lines you don't wish to share.

[System Info]

git version: 2.47.2
