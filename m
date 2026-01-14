Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D46396D16
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394484; cv=none; b=hkN25Lfk3Gy90hg7FrmoFIOKdhas+jR1tvq7A7am7OJ8EgRKHESbVbyE7s0luc6M/7vYzx17FZaeW9sYpEG7iXTOW7+M71RyYBBjW6yTR6DVsHn2cEBbDtO7kFWqk+KjbIG2UERhpL0NPj7sGrZ3u3moDy9VuDufzYu4GgsIIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394484; c=relaxed/simple;
	bh=hiK6oaGROA9EVBnUKCYaI8xhp0hmz7OY4HXt8dP7s5w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j6PL3VCy1eUndDs39h45lnuOejiIfwUaWNIG+UjJHvoo/O+skMSOAO3uDnUny4cnLDsKt3asG+p4+1fBwcvZJ65qzRuNvCXi7iaP59elbjoy/KOZvEoxoQeXydqzabHQJZ0KpiUYWWVzaC2SXimNCXQHrHatN5vxG5nbOk4X/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQjzivPW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQjzivPW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb5810d39so4546269f8f.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768394481; x=1768999281; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zcFCRSUescLwA4QWHdluwaYWAZTnpGDrR1j9A8EBi6U=;
        b=UQjzivPWhs2fvTPCMt5VD/s1uyg3H9XAEDXRtYKpPesGDP3HtTYoHlf4+Jm7ZW5+ey
         nhZO7Fr5JXhSePJ5NBeS2ZfZhSm8251mQhUKeCoYdMwGEqwiO89X0A6hL+bLz2rDYDjO
         MWzLMub5c3Y1wKdI7d8K52YBn2dsJhxPpAHNb1Mw+wyhQqoRKJ3d/8mfNnRxlqnBkV3k
         djO8/QvF6QICRlHm9L4i7aZKCX0ftS8wOposxcjjHJ/H71TC4OHydexaa7lopMgKI9Wz
         O99HbVfSKROYpCaVodK2zKoS/7rHfmScar9PwwQdWLqj2RfVMrWIi5KtSu3WHocgfrCy
         yWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768394481; x=1768999281;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcFCRSUescLwA4QWHdluwaYWAZTnpGDrR1j9A8EBi6U=;
        b=tew6P0lHcUXaGQu3Nqqd4reBCaYAfdw6rN67l1FAMJ848pYliU08PYTWNzFEpSBpfZ
         JrNhEc+ljPk1vqzj3upxaFxETa6sYDheR68x8eKhbB1fM664G73vHIfp0ugwCFPNN+wi
         KtbhKA9qBP/ZBjLEQ25ZvvQRH44gYTRprNorExHfXRzZRIKywvzSNl53NuxaKzQectMO
         PLtwmqDQvGGBtyHZ5PmjJhfNZgjof6qREiv3OYW0QlvtNd82AQ+OClLZRdoKw651W4h3
         a54mSKIUmL1B/QZwNdJ4hBqFBwENwrlrmNa2syMixdZKn+NjICnibzRq02EFb+Voj3e+
         Ylqg==
X-Gm-Message-State: AOJu0YxY7HX2QBwr7pmyZvywKksmUvq19CEmXYaXAF7S3p5u2hrvjoZ/
	fhHn6MkwnCDIsPEQKmHDJqnexqS8ToDFfUqfdG9bqer8RLkIyHdW+nk6z6Txo+qqWdLLVdUTNfa
	kixaQPVl/ceRSajOW0/f3aafaRQnLYX4N13rPEtIClA==
X-Gm-Gg: AY/fxX4AxR1cpI1G7/UIbOfbpD9L2EtTgBGUiY7J94Oz/02oJkmaMeS2IUq3nTetDOl
	yfP9ZCCCTzSJ974ODxdOyyCmIUReZMKfQrrpLN1qSY64Bj+gGPPYkepHPOwzwtSTTv/3jllGdW4
	t6w+nidhk1P5ZOoqB8xBgWEsNmcQJ9t5hvVXbty99gRcKq61T0pmf025cBcM+1Wxywe6SWbrWOe
	eqEEkMxBSQtwOLbOwByi+ukEOCmFI7sLJKgjntjkCqJLyhkrXcrlTxh1PZe7nbs2y24elAQvXHG
	+JG9SeC5PYg=
X-Received: by 2002:a05:6000:4022:b0:431:7a0:dbbb with SMTP id
 ffacd0b85a97d-4342c547506mr2654461f8f.33.1768394481208; Wed, 14 Jan 2026
 04:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rajiv Sharma <rajiv.tilakraj.sharma@gmail.com>
Date: Wed, 14 Jan 2026 12:41:07 +0000
X-Gm-Features: AZwV_Qj6U8Pya4-4S6Nj07UdEIGTOcUvDN4yrBiOCRAYL0nRwhuqvn24x_wSKuM
Message-ID: <CAGe2LO0nxXuNNRYS0fk0JuPBDa3UCT8EDJ6G1u4GNW1d9rzRgA@mail.gmail.com>
Subject: [BUG] Git push sends too much data unnecessarily
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I tried to create a new branch pointing to the commit which was the
ancestor of the current branch (i.e. HEAD~1) and pushing it to the
remote. Since the commit was already known to the server, I expected
the push to be kind of no-op since it's simply creating a new pointer.
However the push ended up taking 10+ minutes. Since I was running with
the `--verbose` flag, I realised that the push ended up sending
multiple GBs worth of data just for creating a new branch on an
existing commit already known to the remote. After some
experimentation, I managed to find an easy repro for this issue:

Clone a non-empty repo from some remote (e.g. git clone
https://SERVER_HOSTNAME/repo_name.git) in two locations, `primary` and
`secondary` and ensure that both have the same branch checked out.
Navigate to the `primary` location and create a local commit for repo
`repo_name`. Push this commit C1 to the remote server
Navigate to the `secondary` location and try to create a new branch by
running `git push origin HEAD:refs/heads/shiny_new_branch --verbose`
(or by checking out that branch and pushing it). Note that `HEAD` here
refers to the `HEAD` commit as seen by `secondary` which in reality is
`HEAD~1` compared to the remote
If the repo had some commits on the checked out branch, you will
notice the verbose output highlighting objects being sent to the
server where there was no need to do so


To understand more about exactly how much data is sent, I ran a few
more experiments and came to the conclusion that the git client sends
HEAD commit + all ancestors of HEAD commit except the commits which
are also ancestors of some other branch / ref known to Git.
Pictorially, it can be represented as:

B1  B2       <-- HEAD
*      *         (sent)
|       |
*       *         (sent)
|        |
*        *        (sent)
|      /
|    /
*                  (NOT sent)
|
*                  (NOT sent)

This explains the multi GB push in my case because I was working on a
long standing branch with lots of commits. Initially I assumed this
was a server problem but then realised that in the push path the
server just advertises refs and where they point and it's the client
that does the negotiation. I think the bug exists somewhere in the
negotiation logic but I am not sure.

What did you expect to happen? (Expected behavior)

I would have expected the push to be extremely lightweight without
sending any objects to the server.


What happened instead? (Actual behavior)

Already detailed in the first section above.


What's different between what you expected and what actually happened?

The git client sends loads of data to the server when it shouldn't
have had to send anything at all.


Anything else you want to add:

Note that there are workarounds for this problem. If I do a `git pull`
and get the latest state of the repo before performing any push, this
problem doesn't occur. Nevertheless, I think it might be worthwhile to
fix this. I managed to repro this across OS (Linux, MacOS) and across
versions.



[System Info]
git version:
git version 2.47.3
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.76.1
OpenSSL: OpenSSL 3.5.1 1 Jul 2025
zlib: 1.2.11
uname: Linux 6.9.0-0_fbk12_0_g28f2d09ad102 #1 SMP Thu Nov  6 08:05:52
PST 2025 x86_64
compiler info: gnuc: 11.5
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
