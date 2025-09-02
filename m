Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7E220F5E
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822132; cv=none; b=tDTfdpsOO1+AtL0AwooIJXovKqNcjYgRBP3WYA2mkd5MJSmJmov5dQBBbEOWdwoMCTjjrYf/hjKyNCqdJrCvzrp3/dFXQuSjz8oYdFJHCutp340hRcM4bwNXysO+BNlqSREtaMGjBtK/zx8uELr5uYo/qCKT6IfxDxGVZCuufoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822132; c=relaxed/simple;
	bh=kmbp3gLC2oTedVBF8FzvEVbXDN577LYvU7IfIyx6awk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ka0udc5hKcxK0ZWx7IoxjhLJ5Q8WBlelAc3bV0hYAG+F7xu88Yp7cBAjEA09nIMbXlrE+mRmLVvsX4qaHYYmVfkRNs8s2syReaCHuZPUK2NT/4zFoxwTV4+C4oq4TfJCFJLI6Qn2v2jspcbl3Cp3NnGWCfiTDdCaN4GJN/jH+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaLSNTjA; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaLSNTjA"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e9bbbc6a65cso175020276.2
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756822129; x=1757426929; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmbp3gLC2oTedVBF8FzvEVbXDN577LYvU7IfIyx6awk=;
        b=QaLSNTjA1TNsy/GQ+eJdqs1XvU1mH12TQHVZKvAMYzCSa1bbN9ScaG6uFSNaL36aaH
         x5TMWRTe1kyZaFiCBe3u6B5uprXyZ1s5CHYTa/sQRHyNkM5nAKwya4CYOGwrMkjvqdAb
         CYkJYJtkGFLv8QU0UUy/EOLLzjg+ErNpJo/2WUVaF1FM5ZrDCairH1bxWtmsGKxKqbUH
         /TQCHq/AlJ3V7X8/aCU15MErsTxjkEApAnVUAnEZ3CLN6FzgrBLoZpaNy48dXptPvYNU
         2Xz9DOfwQc882ZnyY5uNHvsRa06aFgOM9yrbG/XlhCQn09f082dZ44KaLBmEkaLX38OL
         jefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822129; x=1757426929;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmbp3gLC2oTedVBF8FzvEVbXDN577LYvU7IfIyx6awk=;
        b=bMOwxD+s21cPVYzpjQTwBntToaxaQmH/ef7f+LgRPXWIpkZLTHCVAYw0yHcr+rYDtm
         lSt0gRj2FHXSbuLb1MHUo6FZTUulHycfOUDpItGhoxEerWp5CeXLb8DpR+JJaakSjIa3
         j2Vi2BGMwzEZRm7W94gNuh21sKpVVWwshuvO1HiG0QV/jDutQJ0y04oxMzatHY+Cv7DO
         t3BC+HrTbnKw9pAi5Ola/PucR087sBeD/bosnyanYxF5XjchEX+vkU/C+fdxej/bE4D6
         FSwFDrNE5Rq8DF0UbniZ7OP1UcviR/P282dVhpI+c+ZeFQ8ylXhbD3wdKboujvQwnUaD
         c9BA==
X-Gm-Message-State: AOJu0Yxk612Z6nNNgw3mEQ9XIbMQwGGyauTyvqByPRoSXOJxBBX8Yq/R
	bWiCB21c0m69Lugllyn3qJGEe8tJVQcJsv42yH6NfQTwmwgdERJS5qluJydT3BiewJvZk8Z90Na
	5o+ulQx588ZOUsXn+Uf7MmL/HNu2gBl7bRdZauok=
X-Gm-Gg: ASbGncu3JcS7EUM/R8fYq+miKfZDQlzPXTwiT3NHt437/o4s3DZYuc3O9/EbteaiBq4
	XmhNanI/hFT2iVSBC3odgJYUUliZv+SExSpFj9fMsfZB/qxaptMrtVlsEMAvMzI/CBAAY+m1/E/
	cPUjG6wKrW9K+KFm2BAhf7P91AcS72bOR5xQD8IaKVEt26Qbsv4cxTXoUz+5AIwiCcO86iCzfX5
	27svNusBYi/ZSljag==
X-Google-Smtp-Source: AGHT+IGd+yS3lmJF6IohoNsMaR7aaDOcy8Oc9YA7p04+qgzzq/y/n51qxXxjF3pAxwrK9oRHpBIZRAT+QcTPxcFMy3g=
X-Received: by 2002:a05:6902:2b04:b0:e97:276:4002 with SMTP id
 3f1490d57ef6-e989bed2a0fmr9176970276.3.1756822129367; Tue, 02 Sep 2025
 07:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?VGFydW7jgJDjg4TjgJE=?= <tarunramsinghani@gmail.com>
Date: Tue, 2 Sep 2025 19:38:38 +0530
X-Gm-Features: Ac12FXwL6Ie9GQ-f-ZeMjdyGOh0G5d8Ajixx7CAbpA73LIcD1XECOWxWKLY1kdo
Message-ID: <CAGAx-2Ac2Tt4-jTH=AApK3m=U7d2RJBaTW=uX6jBHzmpWU9NYw@mail.gmail.com>
Subject: Git fetch Failure
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!

Please answer the following questions to help us understand your issue.


What did you do before the bug happened? (Steps to reproduce your issue)

I am trying to clone the repo from cmdline. the same steps succeeds
with git v2.50.1 but fails with git v 2.51.0


repro steps


mkdir TasksTest

cd TasksTest

git init

git remote add origin https://github.com/microsoft/azure-pipelines-tasks.git

git fetch


What did you expect to happen? (Expected behavior)

Git fetch to succeed


What happened instead? (Actual behavior)

Git fetch failed with error

error: cannot lock ref
'refs/remotes/origin/users/ajya/sqlservermoduleimportM146': Unable to
create '/Users/admin/Repos/tasks1/.git/refs/remotes/origin/users/ajya/sqlservermoduleimportM146.lock':
File exists.


Another git process seems to be running in this repository, e.g.

an editor opened by 'git commit'. Please make sure all processes

are terminated then try again. If it still fails, a git process

may have crashed in this repository earlier:

remove the file manually to continue.




What's different between what you expected and what actually happened?


Anything else you want to add:


Please review the rest of the bug report below.

You can delete any lines you don't wish to share.



[System Info]

git version:

git version 2.51.0

cpu: arm64

no commit associated with this build

sizeof-long: 8

sizeof-size_t: 8

shell-path: /bin/sh

feature: fsmonitor--daemon

libcurl: 8.7.1

zlib: 1.2.12

SHA-1: SHA1_DC

SHA-256: SHA256_BLK

default-ref-format: files

default-hash: sha1

uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Mon Jul 14 11:30:29
PDT 2025; root:xnu-11417.140.69~1/RELEASE_ARM64_T6000 arm64

compiler info: clang: 17.0.0 (clang-1700.0.13.3)

libc info: no libc information available

$SHELL (typically, interactive shell): /bin/zsh



[Enabled iHooks]
