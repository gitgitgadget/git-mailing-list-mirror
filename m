Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3D19CD01
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760663; cv=none; b=hU5LW2MRHFXUuKm0NgXiuS1+ZSfIhpScOdD/i15H1vRphGEjRuH/iMtfiyRdXa7ziwD6k/NVvjxIyarn+R8BIjPHmQVVGiL4CWI7Rb5xW3p/pL8YZRUCqHSwnyf/MW0DlyRi/odwoFBqZiwsWsENpJRtH+kQv9M/l9QD7RLDbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760663; c=relaxed/simple;
	bh=BsA5ewbPnm+KJ27or00rNckJMebCwnnDB7MiHRjDpSM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cFpsfZ2jlKVuB8IGua+Rh6uTLrDMSDwoSs5a/t+E80jRto8GyJqaHHqVh8RtIzj//WZQ+tCjIqPciZwvbU/OWGTocGHlYHU/Ep+jvbfiTxOPA+BeIUcdN/zjm8mU3kxnjQ5NWsnyCHTBGPIFJVEPMVERwZ/PD24TQN6YcB7jd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=salesforce.com; spf=pass smtp.mailfrom=salesforce.com; dkim=pass (1024-bit key) header.d=salesforce.com header.i=@salesforce.com header.b=I9ZZZfD9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=salesforce.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salesforce.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=salesforce.com header.i=@salesforce.com header.b="I9ZZZfD9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53654dbde59so2148546e87.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=salesforce.com; s=google; t=1726760659; x=1727365459; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9iM1QBdoASXP1v6BxMO9EiBXe/Ds2i41g3wmsCyguDs=;
        b=I9ZZZfD9cJlHIUcrk2MGwa/lghiVnQ6lz54oQdVCxm7Wm+vzI+ei+F9pGxnDZ8JIoI
         FvIbgZ01Cq1OksxqzMDlUNfjxmKSqVB2/QrrfFvQ/c0mxkMngb/+6GaA3PrOkZOdnSjD
         m0nO36BtfhyfhM/T6cuKFOh0HJ9kfpPZe6muk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726760659; x=1727365459;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9iM1QBdoASXP1v6BxMO9EiBXe/Ds2i41g3wmsCyguDs=;
        b=iN6LekuIo4PQ48z4KLQQb18b59/f5v/IwY+7hiIZbBUMJyRJUJTn/WkeO2PBNVINwd
         n5UgTyTo9w6WGoPWl0S3zsAIVEdtplymi+mif+lJWv5+D3FasGvL1ud4JcCCG6FtnENL
         BaY6xAbOnzUbm+I0h2qP2/sbpqXQcP5GOBANcdzaF90ZhmTZAysy9Tvbvu51M0Wu6Wyz
         ZVjizEmuUudpYeWs/jhrbKuOvGYYduyTWBliRCS523twrt+pfZmgmgDEgFDotWMRueuR
         Bwud3TUdNyLqraAuDgpA9kV2/BqDyWpoj/u5cQsyWuLzrWo5QoDGme/x+TOvG9VW5v5i
         bN5w==
X-Gm-Message-State: AOJu0YwdMH6eQk7/1geZ8Zl1fhV+4bYt6AMIGKHdK6mpuZqgNIxzA4RK
	isRhzPNRASS9Wkab2ab4tswhIU2ij2A89Gdku0AlLjEHVaOWvLai4WCCr84ljfHsLxd8R2NjbRZ
	wudx+fxhyc8RkVRdtxP0z0V/Bt5NWhLMTkx+ebRVbgv2wMa9JSxo=
X-Google-Smtp-Source: AGHT+IFg5saqgA0d6PIa02n1rHkZDcoeJNXY7AMFhl2/Nf1Fg2CwDURlwSWZpGcMVmUxEEhMiv0aXRp3olGaL4dB/z8=
X-Received: by 2002:a05:6512:1386:b0:52c:dc06:d4ad with SMTP id
 2adb3069b0e04-536abb1cbdemr16209e87.6.1726760659331; Thu, 19 Sep 2024
 08:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ryan Brainard <rbrainard@salesforce.com>
Date: Thu, 19 Sep 2024 11:44:02 -0400
Message-ID: <CAPzz1g+jhP4oXLFn3XtG29fe5XuKwKJ_CQrSVejX+LOBp_-LUw@mail.gmail.com>
Subject: Bug report: null bytes in pre-receive hook output stream drops lines
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am reporting an issue where if a pre-receive hook sleeps and then
returns null bytes in the output stream, the git client that is
pushing will drop those lines intermittently.

## What did you do before the bug happened? (Steps to reproduce your issue)

1. Create a local "server" repo with a pre-receive hook that includes
null bytes in output: mkdir /tmp/server && cd $_ && git init --bare &&
echo -e '#!/usr/bin/env bash\nfor n in {1..3}; do echo -ne "\\x00" &&
echo "-----> Log line #${n}..." && sleep 1; done' > hooks/pre-receive
&& chmod +x hooks/pre-receive

2. Create a local "client" repo: mkdir /tmp/client && cd $_ && git init

3. Push a commit from client to server: git commit -m . --allow-empty
&& git push file:///tmp/server master

## What did you expect to happen? (Expected behavior)

I would expect to see all the lines output to the client. The null
bytes should not be printed.

## What happened instead? (Actual behavior)

One or more of the log lines are dropped.  Run Step 3 multiple times
and it will be a different line(s) each time.

For example:

root@5c7434417f1f:/tmp/client# git commit -m . --allow-empty && git
push file:///tmp/server master
[master b4f02d7] .
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 175 bytes | 175.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
remote: -----> Log line #1...
remote: -----> Log line #3...
To file:///tmp/server
   ae04465..b4f02d7  master -> master

## What's different between what you expected and what actually happened?

I would expect all the lines like this:

root@5c7434417f1f:/tmp/client# git commit -m . --allow-empty && git
push file:///tmp/server master
[master b4f02d7] .
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 175 bytes | 175.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
remote: -----> Log line #1...
remote: -----> Log line #2...
remote: -----> Log line #3...
To file:///tmp/server
   ae04465..b4f02d7  master -> master

## Anything else you want to add:

Tried this on multiple versions of git on both macOS and Ubuntu,
including the latest 2.46.1.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.46.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.5.0
zlib: 1.3
uname: Linux 6.6.12-linuxkit #1 SMP PREEMPT_DYNAMIC Fri Jan 19
12:50:23 UTC 2024 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
