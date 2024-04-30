Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422317B4EB
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496014; cv=none; b=ZSwzSnWAFKL/Ibj/sVqDspEdYhQmhSYbrx76BTSMJJ8TIGUKXYsvEJAo1eY23MhTzP7sfJX0eqL69AFbNDSFn1EUSEE3qWD8k8n2tyY6aRTsrbgkKeifvSczz8HXzGY0/vWKmzAWMALElCbnusdu7IG5VvFrZwIrWkx3rUza1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496014; c=relaxed/simple;
	bh=WZZqvqCTPkisQ9QfXpYPyyTKW0E7JMW8WAXpXbt2GfY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VUo0Ep/0irPX0lUoEbbM1z9WM3pgRTy0trhvpJ83xy3NAFCuF3WTKGSIXnfkR2RbulAmd+I0PeR7YWNbTJcraYmB9GoVNFEmZ+uIdc9mnLDd2PHFUPpCQABxFCW0zKn0rJGlqEcquqvyhw6Wq/LOP4f0026RdHIVrEOSXRuqE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudbees.com; spf=pass smtp.mailfrom=cloudbees.com; dkim=pass (1024-bit key) header.d=cloudbees.com header.i=@cloudbees.com header.b=kRL62yJ4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudbees.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudbees.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbees.com header.i=@cloudbees.com header.b="kRL62yJ4"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so11428e87.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudbees.com; s=google; t=1714496011; x=1715100811; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0cKcT/l/DoDg7Vhz/50bLRFFm70uCY3tNdcxyi2n5co=;
        b=kRL62yJ4LBrQARi7sYtAlE5TNVx7xIMd/KL7F5vnlcRmGSNzEEpKDHsj56IuufthNy
         ZFHvR9jvFPThqkE0j+a52GeR+dU01BracyjvF60QJB4mEpf4LPTD9Bbfly1wWnpnlZ5V
         UFVE5SGxuph8BC879o+zjl4WJUqQkyDicbA1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714496011; x=1715100811;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cKcT/l/DoDg7Vhz/50bLRFFm70uCY3tNdcxyi2n5co=;
        b=BjCfYazcg2KcSTR031ybUbqCZw0PI442WyfXvo0hgDhghmiGmaLApEKgHq1xbrMtbf
         nX2q1mdqT2WoyOxC5+zKvxv1u+Vo6P7vI+/3nct274jzUSY4cbxLK3o05Xj+PHWTtj2K
         +4/m5+cHdAgShPAJwgWS4sEA7B6iKuvHQIoE/0QIN8/P55jnHtrVDsWBv8LYeIXR/Jz7
         DT9gLO4SeHCoDlLFx9zRYPTz6cEC7cpeJJ9Yh3qHPRHVL6hvhlVTDNS/BcTRwS/lPzGj
         XYeQgl4i94B1L9+ovgs6vnTqNVrnze2unfNrj2AZnjQb3Fie85YPhBRCrZBWMQB3MU3I
         fwBQ==
X-Gm-Message-State: AOJu0Yy5BwsXmxUSaJ1ZzXqr7l5ptnG83wqUCmPgyOzFlYxu7xduBwgR
	PyVak7+NQK6CF4t39bUgOj4+RIOuKO3Fh6/wlmt199UOG+MvFPzDYpgipVk2NYM2dhC9hhye2hg
	gxqfDn/1C+tX2HwQ/qzQQsDUmzSxkXJxZ634ll1w/B7wORt5AzOdQ1g==
X-Google-Smtp-Source: AGHT+IHSkNkotAl+272hAQn5Hhw5idMO+nahCMPEnMJMgHxcb0/OgKMJ4qfztzy9VWAhqj90Gak65vX+cChMHWETcZk=
X-Received: by 2002:a05:6512:1317:b0:51d:9196:b946 with SMTP id
 x23-20020a056512131700b0051d9196b946mr126272lfu.25.1714496010476; Tue, 30 Apr
 2024 09:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Nord <jnord@cloudbees.com>
Date: Tue, 30 Apr 2024 17:53:19 +0100
Message-ID: <CAPcEHyfXuTOjkBfhhEwyqYiZroXGyJSSY0tgJCuSsp5PC-cKLA@mail.gmail.com>
Subject: [bug report] commit signature validation
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

reporting bug per https://git-scm.com/community  (also this is not
specific to windows and has been reporoduced on OSX)

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)


Setup git commit signing with SSH (but omit setting gpg.ssh.allowedsignersfile)
create a signed comment
run git show --show-signature

What did you expect to happen? (Expected behavior)

the commit should show an unverified signature

What happened instead? (Actual behavior)

the commit shows no signature what so ever

What's different between what you expected and what actually happened?

I would expect show to say there is a signature that it could not
verify,  instead the output is seemingly telling me there is no
signature at all.

Anything else you want to add:

this also occurs if pulling from a repo where someone else has enabled
signing with ssh, but you have not configured
`gpg.ssh.allowedsignersfile`
Regardless of the presence of the signing file git should tell me
there is an unverified signature.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.44.0.windows.1
cpu: x86_64
built from commit: ad0bbfffa543db6979717be96df630d3e5741331
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22631
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show
