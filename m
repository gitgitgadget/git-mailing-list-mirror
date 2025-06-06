Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3B2874E1
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210645; cv=none; b=Q8660P7+BVpGV5ATiF7Zhdp02+gW/veuFBHgjqHzNiLLMYSaVAlpBx6sXlljdigyzsVlRwYQ1AywVBNklg3WwqpQRPEupwVJjoMePllDSOQia7kpYtq9SZbwr+0Hn8+djNn/EJe1x4i7FoVF00yPm8RuzM+6f8BQO/jvrkR9Ooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210645; c=relaxed/simple;
	bh=EbBjXWPTU45LOOwBxYloumyX4Z0NanOsAyEPk2wTH2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmZqbolPhaLRqWQiTzp+Uo7Mgq1uVMSb2pnGmRcc+JzCN7J+ibIYJ88Vzs2VDS7k1MvBzxaeklPgwZ8Ud5DLPiQKW1ApBJwhR1LBeBNWEHjBF8ArJvbkL9qRp+ISn/aKhJ+MjGtl5NOAyku3wm5s2Xmq5iYjW1mbT9sPTldVSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPHMC5sj; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPHMC5sj"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86a464849faso158128239f.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749210641; x=1749815441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmSieCCi8Y4KzdArrMDvqDDb7rOYdhrGnnN+g+gy92o=;
        b=FPHMC5sjz7RhQr6zf8UPn5UhP0oPNlEOE0pvkH9Jv4PBZp1f+RVYXfpgXtGb8qaSLJ
         lceWN1ZPTk76PgTtobvnfblgnpl0owYDTvt8ZiY6TbowJrIQs7HsQT24m5Y82SjYcAO3
         OFWeHmuT6wUsM6e3G31Dyanc2zCgMxVa/J9JLi9fx6tvESwvNGGzbYqv33NZOEO/nN0s
         AJHqHYe8tURkO+jCvVo6x8tgoSf8OYUpchvar5lw32s9+cvX6wy1mz+qzd01xv4n/Q40
         dIalC1xBcR3n+sMdcb4XaCWl+w46cm59/i0elOVgQl5q0p+4ij+CWL5zSm3YM9y3jKgp
         Dm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749210641; x=1749815441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmSieCCi8Y4KzdArrMDvqDDb7rOYdhrGnnN+g+gy92o=;
        b=NijSZjEqFAJNN9GMZjx3jr6hG0eHSZdwWsoqKOmjouKODLcuNKwtf/DCQ7kXzrGK7H
         yM/yN4aRxnENXE5RLiMOWfzlEAmn54cqHh+F12LdReCNYKKQET+lQmhzULGWwpQ/s3Ej
         a/bodi3/neNY9ppzpo6A7rKDgPPQMAJQ8dTBMOF+P+SVnqy+uq3FgC7CTw/+mZ8amsZ1
         JLmSfgH4HpOAPXkMMJ8sXMRwjGtWqDaZukWiwU9VU5/0jB1UgK+7B/1GVjtqnodDMZ7D
         8RRbIXBMyc4b/82Q7giZ4XDlgg2TZMRVHrTReNkRnTCBojrCEUUEYeeYHtbxbj24vMhd
         cZyw==
X-Gm-Message-State: AOJu0YxATnhsSlCObGNvb1XJWc4XnQJ0hndk9kOpQdKSgpgwFH3cGMMR
	TIWEXJdglJ3huwhYZ3bzSqycYJ/E8QtzvzpCjt5t5IWCCC/v7qQXRx99bWBr1OGWaLb03Pte0/u
	9Rb4H6pnDoZ4XlJgXNVdRSAFkTuoWqlM=
X-Gm-Gg: ASbGncvF6kgEZl1Bmh9a97PGe0tCAnokX3KGlCKqL+QG/GrMgoF26tUWNYuAoLuyqXt
	NO52c+YmWdpOfu9ajpp744M/uZ9j6Ocr8gboZZ/qSMRg+CXkszvLeXY7nIphhl4SQNpZbDNQNfe
	5f0ggwD+uhzpgi8CI3W4A311jN6EteKFMvFIi5twkhdA==
X-Google-Smtp-Source: AGHT+IGDguZPCIxDbEtOiG8f1Pgf/cogq5K0TFe1vVjZSjIFzt0Ygm5DtEtmEStUI1BHualxNRmRfgkIuiJO2GrVpIo=
X-Received: by 2002:a05:6e02:1fcd:b0:3dd:cbe9:8c06 with SMTP id
 e9e14a558f8ab-3ddce490f44mr34038335ab.22.1749210641475; Fri, 06 Jun 2025
 04:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJsoDaFKRz8om1d4YPtaqdyuBuPAiC-xHDuvmYW=VQWEzzXAtg@mail.gmail.com>
 <ad141d46-3170-47d0-860d-46e7b92f878d@app.fastmail.com>
In-Reply-To: <ad141d46-3170-47d0-860d-46e7b92f878d@app.fastmail.com>
From: Ondra Medek <xmedeko@gmail.com>
Date: Fri, 6 Jun 2025 13:50:30 +0200
X-Gm-Features: AX0GCFt0lkqxJqibKNYN2iyT7rt1wfnRrHkX_c5k9ptG1AdK1Rql8_4HZToPScA
Message-ID: <CAJsoDaGjF=2ZGwGdnx+M-1MdtfDWS2uE8+EAZMuu73cXjhWb7Q@mail.gmail.com>
Subject: Re: Git push tries to delete branch twice and fails
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yes, I have witten it's just in one local working tree. When I do `git
clone` of the same repository then it's OK. So I do not know how to
simulate it.

Therefore, the workaround is simple - I may just delete the local dir
and clone the repo again. But I would like just to know what happened
and if it's possible to fix it without cloning if the same issue hit
some of our customers.
---
Andy

On Fri, 6 Jun 2025 at 13:43, Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Fri, Jun 6, 2025, at 13:20, Ondra Medek wrote:
> > I have a git 2.49.0 (Windows) and one local working tree is kind of
> > broken, when I try:
> >
> > $ git push origin branch1
> > Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
> > To file:///c:/...
> >  * [new branch]            branch1 -> branch1
> > Everything up-to-date
> >
> > $ git push origin :branch1
> > To file:///c:/...
> >  - [deleted]               branch1
> > error: unable to delete 'branch1': remote ref does not exist
> > error: failed to push some refs to 'file:///c:/...'
>
> I was note able to reproduce on Git 2.49.0 on Linux.  Both through a
> HTTPS remote as well as a local (filesystem) remote.
>
> ```
> $ ./git diagnose
> Collecting diagnostic info
>
> git version 2.49.0
> cpu: x86_64
> built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> libcurl: 7.81.0
> OpenSSL: OpenSSL 3.0.2 15 Mar 2022
> zlib: 1.2.11
> Repository root: <path>
> Available space on '<path>': 202.28 GiB (mount flags 0x1000)
> ```
>
> > So, the same `git push` command first deletes the branch and then
> > fails because it does not exist. It worked well until something
> > happened and since that time it's broken. I've tried `git gc
> > --aggressive --prune`, but it didn't help.
> >
> > When I do `git clone` of the same repository to another local working
> > tree, then it's OK - the branch is deleted without the error.
> >
> > Is this a Git bug? Is it possible to fix the local working tree except
> > for a new git clone?
> >
> > Note: I am developing an app which uses (creates and deletes) custom
> > refs often. So, I've hit this bug when trying to delete a custom ref.
> > I have cleared all custom refs and tried that with Git branches.
> >
> > Cheers
> > Andy
