Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98320ED
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412363; cv=none; b=f1X7tOVwR8pxKM5iKjBkasvQAOSRzgZfAaktacrdKsO8JMWb5oe9qSw75fj9/g5HuUyYBlxcHebCADIintxX8riLxpyjyUH9nOURwZRXU8zhjqsLF8ADMQE+1qsLE7mvLO8CFhCYhitPLJyTPFeelbtMpFJBJeaC7TaXvZuTaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412363; c=relaxed/simple;
	bh=iVuGx1Br1JZp4C3hX0f+LRl4m2vOo//EZp4+HQsd3ro=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LK40fiJl3L8vxXC/iYq3MumbjfiVApiXven68CgyaKrdaw17lfRMmwATNoqE45h2FuItUQvTSYb8DTxpcrkUOhHY6OrZ2GXhoCadibdQPfAcXj0jaT6dxcfrrab8YkiMfPv6K26GCA/j92mEsiyDMzZpKH53fZ6KFwFkQZgH/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHYpq/4a; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHYpq/4a"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa3fe04dd2so612405a91.0
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 18:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739412360; x=1740017160; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iVuGx1Br1JZp4C3hX0f+LRl4m2vOo//EZp4+HQsd3ro=;
        b=hHYpq/4arUZNValX/O3tILGXnvSjNfjr9rg9wZ0jSvMLiZKtNg8gOVC3ighP/nzDRy
         mRyiT1x6Za9mLih0D470XXnXiJD9IAhh09j96u8gIQ4XHnoN/eaq42RukskXxaCR2CHJ
         zI4GDBDRb5ndf70oCj8QrDYTwGJiKfAWC5+CixCkyUgtYXzquPNPmKPnFD5KfMsQFGi1
         amiJnLiDGovSs2EUKWq6oxdcqVN1visDpu8YdFmGg5BKj324teYe9PkSQUSEXth7lW3o
         Az2uFQyuFoiJP+jg+iwT6+D9GtNY7BoKfeLaCokAbCNw5crD1oOvdKwWovYTtmzTc4GY
         H85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412360; x=1740017160;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVuGx1Br1JZp4C3hX0f+LRl4m2vOo//EZp4+HQsd3ro=;
        b=g8LVxF11l7qa2GUFYEkiPtJtkeyAVa2964DdI/kSap5PGDYWKc6ZWCS7Moe43HvRMO
         rh4NMkXdqu28I8kkwVi5SGk9/75tCBE4ETrdxuNW+C+3sD5s8Y20eL3jUbTWsMpex4uS
         a4GtAbhBuHwDMqZKBFEQOFWqq6c8EVD2JXFLMNTiZH+4oQy6rJ0vQJZAHkKs46HcMYH3
         VIEa3CLiMsFqcg8OPX9UwY4x2bhUTxtUu1MGvH9MeryES5j9Kkabv4XNVhEQENk9d1xI
         CEuNyCbXZ0rTlBA2CnjLnQDDPw1tQzSRSDVCOsRXmXA8kPGGBs+6y7Bkdt6ouYXsly4V
         esbg==
X-Gm-Message-State: AOJu0Yy9QqF47QH+XHohkiPkZ09kSpsforBJ1MF50ZPiWiawO7nbu5DY
	BoIuBUVm/uZk4yxVddrkmz0+VbMSlfOZRcwmsuCzx3A9t5KR4w82wOo92p4Bf99ZEJQB4rSLeam
	qkwrr0+JDEEqBoZf2fB1TdBO2DQVQZYtvQnRFaw==
X-Gm-Gg: ASbGncttKsncJpwGpN5aWSy2qC404rGwCv9qt/vbdgAbHMXZSI/YojIDjzm4yUH6aCM
	rvrnyKAZUXvcHDqx+yV6R+1AAWqQDna9/KJNRAEEzSLRPRkX2DV9k0gGpQOEXbsbqfimdplus
X-Google-Smtp-Source: AGHT+IF2Kfw3H+kejRarpUw538nykSjvXGpmfEEXAI4AGb7HJpwEFa8pLxhpoji5aDrPOSjM3hJFxVaPzKRa2DxPGv4=
X-Received: by 2002:a17:90b:1f82:b0:2ee:3cc1:793a with SMTP id
 98e67ed59e1d1-2fbf5c6d3eamr7796705a91.29.1739412359822; Wed, 12 Feb 2025
 18:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jayce Cao <jaycecao520@gmail.com>
Date: Thu, 13 Feb 2025 10:05:47 +0800
X-Gm-Features: AWEUYZlXxwMFm-xW2PlrqzgKRKDWjtZqrEhwXrXUq43Mkl2OnTlio1Q9WDSNoIw
Message-ID: <CAGwx5_8wNzE51Z7pYA_skimZZ29b8C_Bxk_58kPOqcWAmSQpHw@mail.gmail.com>
Subject: Get the commits to be pushed accurately in pre-push hook
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

My goal is to check the commits to be pushed in pre-push hook to see
if they contain sensitive data or not.
I have an assumption that those commits which already exist in remote
repos have no need to check.

So I read the Git doc and pre-push.sample file, I know that if we push
to a new branch that the remote does not have,
$remote_oid weil be zero, so we need to examine all commits in this
branch. We can run `git rev-list $local_oid` to
get all commits to be examined.

But consider this case, if I'm developing a huge project which has
millions of commits.
I create a new branch (we call it feat/awesome-feat) based on the
master branch on my local repo, and create three commits.
Then I run the `git push --set-upstream origin feat/awesome-feat`
command to push the three commits to the remote.
But when the pre-push hook is called, `git rev-list $local_oid` will
print millions of commits. The commits except the new three
already exist in the remote repo. And the `git push` command will send
data only in the new commits to the remote, instead of all
history commits.

So I mean we've no idea which commits will be sent to the remote
indeed in the pre-push hook when pushing to a new branch
that the remote doesn't have. I found a workaround:
* Run `git ls-remote -q -h` command to get the commits the remote has.
* Run `git rev-list $local_oid ^$haves` command to get the commits to
be pushed.($haves are the commits obtained from the previous step).

But this workaround seems to be stupid when the remote has many
branches. I wonder if there is any better way to get the commits
to be pushed accurately in the pre-push hook.
