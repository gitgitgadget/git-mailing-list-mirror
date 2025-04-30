Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5FD1F1505
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047037; cv=none; b=kmcVSRvGMzuzbAvl83Egm0UTqZ8hF5gTXwdW+W7NSaans18ToLJNc70F59ohI2XJrf0U3swkqru7J6erWGiT6aFTBYzM3ygMjXAn6kQRR87NP+UniLi944rXS1nJak2TX2rDo0kx7NMg0ldfHKdg/BZUxk1rIR4foeWj9DgLI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047037; c=relaxed/simple;
	bh=j8TwOvaxjnyBkTo4NN7ggChyBjRFq1zfeiIvWlCi/IA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YV2OowwM9tIa1+y0XITYlp7mhKUmUL2Ti+WDqxmEWyzlyaNc8SbJlgxhQN74OCg+m+KMzO3fbv7WMRu0JvwEbYimGeeIFkNttgSxRxAbqi0hTP+td8cZff/CXgU2uBheQv2i6MJYS2t9BfQVE8+Ls+P0yy+jfuzeF3xhsHDGNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzpur2BV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzpur2BV"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so576313a12.0
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746047034; x=1746651834; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6bAFtEKhYs8n8bI1FhTaHzJg3wDbJOBxNC0nyVrrsNg=;
        b=Uzpur2BVyxrmzBZq2z3pgFAfhGXPeMLMFE+jgc31HT1LjdP07LkMhbEA0T1Y19YB+u
         aaRiIEOspvlZloK9SIu+Vp4pzb9BVrleW6KH50EKjZ+VxTlcGb8fixq/8H0rnng841uE
         hMptdFsJkUnO38ryUAe3ULSpEoR08l7prhQqaJvFNenl/QFDwwX93LpjNzwk5pBRt+R4
         SIXdl90R29i5IGYGGHQAFV3wN3mlKIkPQWLF2FvprOd3jghZ03fqyDaUcSmP5Z47dgIP
         2+P3mZvnk6V+u6yh95I90Tswyqcd2TM09vicIxLLy2pUSIUrTtP9bk9rmlvty0oFN8vJ
         cKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746047034; x=1746651834;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bAFtEKhYs8n8bI1FhTaHzJg3wDbJOBxNC0nyVrrsNg=;
        b=Kya3B0GnBtOhgYcqYmWUBmrBeqDPVuAFYxTWCdOUOjzdCsyGIVykV213UJL+b+KbIj
         w0/F2eeVZO7q5G6QFyJ1CNHlme5TvQvC2HH5mrq2703rKqDmIyeGooC3w0VFco4eKm8O
         l1OkGLpPLYYwRxL43oYM5Hfd98J9DCjgnoYZFOP2O57BAZagZ9oGHLTmPuzrsPtvn9Iq
         rlt5V54QhanBlkxKvKt6IaW0HA5AYDn2v9vVjfSPU3u5CaTR5TmoEpUJ62sy74/YfyiZ
         w1vOkIja8Kk7qhdxUBAii2+u12pqGYB6AK0LH2M7yRVh/syW43g0yVRr2mi5zOfP+su6
         PIAw==
X-Gm-Message-State: AOJu0YzlqaSOvcJCscCxttHx634m7TiL9vzYf+4fIloC4kBwbvKD9k+J
	7vvKIKAXEoVv7ZlTMQiwHEiMsU1jq8nnGzylQSjky84rFSGzgWk0aWKEjJMQiiEmwRn2HYA4D9c
	JPE2GOpLDXpOSl4jX1ApJ6ucN1L4iFli2
X-Gm-Gg: ASbGncv5z//GjXF7SLJ1g6Nw7cGo/TibJFip/rtU0jIoECpRhKdN6na3CX4fKG4wiDS
	GlrBEPbOUR67O+UnGfcFJZ9v1pFlFOnFCRkbVekGCbg9dYRH35ffyYAiIyMQrmOUH1/50o5X6EE
	INdHj8RlcscJYZjRgwZJ+wtdOA3DDCTB+x
X-Google-Smtp-Source: AGHT+IGxSj5+Wsu3yVJY3WrOtS7qLwl8abvnhsxj6QfNZ8AkGaCVB1HsEBBAM61jf4i6Xb1QzqQBdd2r8iRa0sjxwpI=
X-Received: by 2002:a05:6402:5106:b0:5ec:da2e:6e30 with SMTP id
 4fb4d7f45d1cf-5f919373e7fmr46844a12.4.1746047033790; Wed, 30 Apr 2025
 14:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Terry Bear <terrythebear746@gmail.com>
Date: Thu, 1 May 2025 01:03:12 +0400
X-Gm-Features: ATxdqUE6UBEftR14cl0sZFg1TFeY-_-hRKkH1gesiod-mpqtjTe387oXHpnjAgQ
Message-ID: <CAJt5hUyLoNfEbQe4wpES8AZP5yimos+xjqU9B4PszGxMrg50jg@mail.gmail.com>
Subject: Bug Report or Unexpected Feature when "git restore -m ." restores
 merge conflicted state of a file after a commit
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

Can be replicated on a new repository.

1. Initialize git repo.
    git init
2. Create a file
    touch test-file
3. Write to the file
    "update 1"
4. Stage the changes to the file, create a commit.
    git add .
    git commit -m "update 1"
5. Copy the branch
    git branch -c "main-copy"
6. Write to the file on the same first "main" branch by appending new
content on the second line of the "test-file"
    "update 2"
   The file looks like:
    "update 1"
    "update 2"
7. Stage and commit.
    git commit -a -m "update 2"
8. Introduce another change to the file but keep it on the work-space
by appending another line
    "update 3"
   The file looks like:
    "update 1"
    "update 2"
    "update 3"
9. Make a merge switch
    git switch --merge main-copy
   The file on the "main-copy" branch should look like:
     "update 1"
     "<<<<<<< main-copy"
     "======="
     "update 2"
     "update 3"
     ">>>>>>> local"
10. Stage and commit file
    git commit -a -m "merge conflict on main-copy"
11. Restore merge-conflicted state
    git restore -m .

What did you expect to happen? (Expected behavior)
The "git restore -m ." is not supposed to restore the merge-conflicted
state of the file after it was staged and committed

What happened instead? (Actual behavior)
The "git restore -m ." restored the merge-conflicted state of the file
after it was staged and committed

What's different between what you expected and what actually happened?
The restoration of the merge-conflicted state of the file after it was
staged and committed

Anything else you want to add:
I am not sure whether it is a bug or a feature but the behavior seemed
unexpected and I couldn't find any mentions of it.

[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-57-generic #59~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Wed Mar 19 17:07:41 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
