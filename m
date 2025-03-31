Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222340BF5
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452386; cv=none; b=Ewg1LlW84rdruMi+oYZRwCEYbm2jWpekpMxJVYhbYt0Do0oT0CMa/xxJpSmTNN/Ig7KhX7d/QAmApcPgrsnpyOnOMTVrHinPJeMIf06u2QuXRYhD3W/W/qL1VoasxaHGmYwc5SYnm3NCDtRp35tcB+WvX9UAgdk7gzg4UP7J1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452386; c=relaxed/simple;
	bh=ODSsnfGcPD51885D03YyzFSLDFd/DnIVGrJtGvZqAM8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=d84ryyXEO1nTF4McoxTVM6tg4t/kQUhu9YS5N342ILhfJ5079khHKRJx6xar743TFFJkzD6tc/O/2PF6e8HqYlmZYcmSr3mS5beSfU+YTkjQyDF6auhq3ZJ+FrfSD22GmpaM4UG+KoI1JcvC9rGXLlnERaaI9drZUxlNB8NwNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e39IFpoL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e39IFpoL"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso50172401fa.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743452383; x=1744057183; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIeff4HvsRdhfL8oGMg8ZfclWPBC33JMSu5pGllq4Ow=;
        b=e39IFpoLBOvANIuzPE7vtUMplsMwSFFqeHs5+TIx7qkt4ggYebpL7gYxdDcNfiCYTN
         o/Q9UE3XMqlbW6Xs/T5urzc3Sss+jlLFgjoGOh69gGnnkuCdM0h7q1NyXwL9F/Vpf6Yo
         7XwBu/yh/5pv2k5WI7kG1+g6h7nTPgvYk33CHpxJ1iY+t8vwuk/iu3xutYlKqKveBF/U
         nnJiA9aEXNqCFFxEhHPLEUnCtsAuxIRDkbhHPvyZl59zr6AK7XsrMlwknuaihWMd5/jI
         XTklthu5UOskcnoyuc0YAeZlY9FJKxUnKjNtY8XrrGge+2lSBsrU/IbjITapVBSy/7YC
         m9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743452383; x=1744057183;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIeff4HvsRdhfL8oGMg8ZfclWPBC33JMSu5pGllq4Ow=;
        b=vNKgyvOMDU/xLYn+fdcwQpqbhhpiK8BW11VglwC7hUOcyg2ZBDFBL/+dbVh44O/xub
         frsKIbHPky/wyZj7cFIr//2F6YLPzQaeWz+i/+m225e4k+gN8kRVTfuZIZULNyyTXwAG
         mOGq5YO7gF/UfB4nV32V3+QEq1SW4g7r336z/QyQgq2i8OW51LsTydgE9/5B0w2C3xvJ
         yNadNkjHdkuJZwQtT2yTO8VmepAoue2crQhnS7mVykHNyOKKSc7Wars3AVTI+KH9dtiE
         1nj1FM6flBirFqYzPZ/iH3RPNwNWHnROb81rllQPAcLwUoGAemY8h4BBtub1DWn7JlpM
         I3XA==
X-Gm-Message-State: AOJu0Yx7HnvbmCDChErttHTd01d8FIidjanlZZMYqmVYQLDwjFIWIf7S
	r0p7ehh8QWZKyGB3LB1aXe2EQh9vwO9rIrsNXpgVxXnY831c7OU/cqw2CmGk26MWuo1dznEpobJ
	kSdchiUnzTxLYZEuVDT6SEPa5CEmVRUVz0Da0GA==
X-Gm-Gg: ASbGncsdbDQiW7ovs9Hm6pMaU4ycOtwz6ytRq3xhR1Ba/+hxgZL8LTAD74/lYbQFbVn
	a2hAd1+OKxSjoYaCi6U/CPzBblwjensn6cMdCkGeF+xC9jtEe/QZNLKUm2pkYTTIeUbX2vhdIJD
	2NtcB94TOpH1kN7aMh+dIYjZM=
X-Google-Smtp-Source: AGHT+IEr5CIQgn44ceiKai2j35UQ7SkNMG0283aNLifCFY7lxyLdMOIYAWzBjBive8K04G/ImADQd69CxRa3EoEimX4=
X-Received: by 2002:a05:651c:199e:b0:308:f787:5c48 with SMTP id
 38308e7fff4ca-30de034a7c3mr38924871fa.33.1743452382739; Mon, 31 Mar 2025
 13:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Mon, 31 Mar 2025 22:19:30 +0200
X-Gm-Features: AQ5f1Jrz0GwUAOij1C0J2subDSF2eDBiMbX-ZpuYvUwcVU9RnzkSAoHa9Iea3_w
Message-ID: <CANM0SV2huiGtWMcP+eEkNBHoieeoXmy_fM7vAOwyoW4=FXw1pg@mail.gmail.com>
Subject: --reset-author does not reset author date when used in post-commit hook
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

device time zone is not UTC0

post-commit hook:
if [[ -n "${SKIP_POST_COMMIT+x}" ]] && [[ "$SKIP_POST_COMMIT" -eq 1 ]]
then
exit
fi

TZ=UTC0 SKIP_POST_COMMIT=1 git commit --amend --reset-author --no-edit
--no-verify --no-post-rewrite --allow-empty --quiet

---

Run:
git commit -m "foo"
git show -s --format="Commit: %h%nAuthor: %an%nAuthor Date:
%ad%nCommitter: %cn%nCommitter Date: %cd%nMessage: %s%n" HEAD

Expected that both Author Date: and Committer Date: show +0000 as
timezone. Only committer date shows +0000, while author date shows
time zone of device.

When manually running the post-commit code (TZ=UTC0 SKIP_POST_COMMIT=1
...) it correctly resets the author date to +0000 too

When manually setting the date using --date="$(date +%s) +0000"
instead of  --reset-author it also works correctly in post-commit
hook.
