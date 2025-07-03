Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6EE1E9B3D
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566371; cv=none; b=lM6/4ax91/h4npUoKOFMqhC8pbqbb1aLIJlEar+eAwrvfH7W88HjC22xuCXTcqb1KOX3Pkij12jURQIjMGOmC5M4OMNIt0K7Bt/HZT2/+NiQgLrCJOevOxNe8Ob1iTDBIUW9UaGPd1aYXlSBKKyXUGUZUMcp/ondUrgxSAML6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566371; c=relaxed/simple;
	bh=mn4wbIvOrNwnobLEEwvEvGzoFI6fqPEyS728QLzBN+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+BVJAs0vMf27mdIe24VkPgLRxKmzNBwoLEf+CJNj5H9JhY54x+Zz1SVa8KnBDYi8p2BUJiOmjxF2g20fUJXqReaKasuracxdEBwyojL/FKN9vzYrJF3Pjv924A1/mW1VdUTGVdewWOjB0uMHyWiEo6UuV/HHuYGEdfYOtmrxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgCll+4V; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgCll+4V"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40b1f402deaso162192b6e.3
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751566369; x=1752171169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shNgzx8KbpdpLOZRwBChDP9/aooWtVGNg0AmlIpHur4=;
        b=LgCll+4VPBAr85pYBe+eEGEcpRDMclf94SMW5oU6FCUJ9nA+MMh/7zRGBczSpd5IQX
         hORKepLL5HQEygeR0MsInUgTMbZ7cqntzABDyKFo+50E0ACjqspnXkp9GQB6ax97w0iQ
         JLeaZLfze4wXajfh0mYtD69rfmS8CUmBP7W6dSI11Fsokdb+0STQsfgylPvu5eCoe0ej
         NdZfx+nVaOCWLLi1+HkZiMHt3vJ16vowGBOaOE847ucEeLwh8QMP3gYtKqDz3nDMljYd
         Pba+l7b0NAbjxR658I9nv24pcjP0fCqebRUawO4WHoU9HDVhv47wSoXRK4YbhDdQzPa9
         gl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751566369; x=1752171169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shNgzx8KbpdpLOZRwBChDP9/aooWtVGNg0AmlIpHur4=;
        b=j4CSEZHvxtjxvWz0eoLi7YoZkGlkA7uVUhEo3SAGN1jvvJwjm/mg+Kfg7pp234Qzj5
         gsMVuAl1A4DX87AmMOnYdL8SP5T/W46lh7SzEp8+EulUxUPl53I3vm8A15P+t79pSQHF
         2hfbdJ7SdZ0QBv8/pFlG/puoWj2slM7j5j+AbiM0MFTtyo1sIDVHA34mDh/oTG1+1op2
         oYmv0EHR+fAuPMgB4f/FVQ0VJ0wxdb7a6TKU/awVts78CmOpTZGnv63Ui/ZoQ92IbcZl
         NLb2zAXp+s7XxeuONNyVu56Gcy084sFl0eEVA7MDa1aciobuOcjUQlLCP4WZ5JDus/35
         ykqg==
X-Forwarded-Encrypted: i=1; AJvYcCWUGtU35Ghqt9tVOCkuZwZXG5ZRXp5XLsaze/kEJhRneYQdqdIfawysXjddka1NiC1TwUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzPhKkhKHzSpAlUIH54/f8PO7x0WpOdD8C9AEHqrtu0dJEwfG
	dNNy7LcRi6QDcMYtDF/2ajCCO3GUs3q87yEVl5/5bCVYwhreRGfil4MZXDSsZVVdOgvOfVWJaxd
	QvK7WeEXPGpSc1EP2pRp3yk6NTX3FUxduj5WN
X-Gm-Gg: ASbGncsVPp4BqFrIsmR8eKqDxeHhb96eLLTo85ckODGHVxhas9qUtekkRa+1+a4i4cn
	FfaNdlAmYkx2Q/yxTrN55LTXSGTK48WvGfDGpAsf7T1mfTw2JtkmM46rvaqg4pCNfDY42Ez9VrA
	9xcUOzXQ9z7eaI3sPNBVAjJBJUHOjf5qviWfcd5UQysu8Z1w==
X-Google-Smtp-Source: AGHT+IFGntnKifsb7h7xOAcwVplCr0PPvkocfkOd4Fkp9BEsC+xN/ycmC/w+vFkQtTtfvATipKcf+QJKWISv9MwFyAI=
X-Received: by 2002:a05:6808:1704:b0:404:dad4:f971 with SMTP id
 5614622812f47-40c0fdae07emr2709493b6e.33.1751566369320; Thu, 03 Jul 2025
 11:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGWq7vBSYuuKW69o@fruit.crustytoothpaste.net> <88CDEF6D-A01C-46BB-A394-CE0E3C3F9B87@gmail.com>
In-Reply-To: <88CDEF6D-A01C-46BB-A394-CE0E3C3F9B87@gmail.com>
From: Suraj Bhadrike <surajbh2233@gmail.com>
Date: Thu, 3 Jul 2025 23:42:41 +0530
X-Gm-Features: Ac12FXyyrHhBR-ub-s7UDyWK6NIWd09HyV69DkRmFZVGvpihbYrS3lv_Fe9Y-ag
Message-ID: <CAPGv+4bPz4qbRowYtJo_BTmmkDaGQvDFCrjvAuBsso0rqOF3eQ@mail.gmail.com>
Subject: Re: Feature Request git snap, Lightweight Commit Workflow for
 Iterative Development
To: Ben Knoble <ben.knoble@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Git contributors,

Thanks all for taking the time to review my proposal.You're all right,
Git already has tools to get a similar result.

Experienced Git users can set up shortcuts and alises and use tools
like fixup commits, rebase, and reflog,
but these can be hard to learn for beginners.A purpose to build snap
commands with simple syntax would make this workflow accessible to
more developers.

> fixup /squash  commits
> noisy logs branch fixup until final rebase.
> git snap keeps temporary commits in its own log (git snap log), so git lo=
g stays clean throughout.

>  commit --amend
>  only =E2=80=9Cundo=E2=80=9D in a straight line.
> Reflog can recover old states, but isn't user-friendly or history maintai=
ned.
> git snap checkout <id> gives direct access to any checkpoint easy explora=
tion,

>>> Workflow (Modified using your feedback)

# Branch
git checkout -b feature/batch-processor

# Begin snapshot session
$ git snap start
> Snapshot session started at 2025-dd-mm

# these files will be tracked, and any further changes will be
automatically included in future snap commits. ( removed flag
approach)
$ git snap add batch_processor.py job_config.yml

$ git snap commit
> snap: 1 @ 2025-dd-mm hh-mm-ss (2 files)

# Git snap will also track this
$  git snap add batch_processor.py

$ git snap commit -m "Parallel processing implementation"
> snap: 2 @ 2025-dd-mm hh-mm-ss (3 files) - Parallel processing implementat=
ion

$ git snap commit
> snap: 3 @ 2025-dd-mm hh-mm-ss (1 files)

$ git snap commit
> snap: 4 @ 2025-dd-mm hh-mm-ss (1 files)


$ git snap log
ID      Timestamp                   Files    Message(Optional)
--      ---------                   -----    -------
4       snap: 4 @ 18:25:18          1
3       snap: 3 @ 18:10:35          2
2       snap: 2 @ 17:45:22          3        Parallel processing implementa=
tion
1       snap: 1 @ 17:35:15          2

  $ git snap checkout 3
> Working directory set to snap: 3

$ git snap squash -m "feat: Implement efficient batch processor with
error handling"

# Result: Clean history with one meaningful commit
$ git log --oneline -n 1
8d72e56 (HEAD -> feature/batch-processor) feat: Implement efficient
batch processor with error handling

I appreciate the discussion and feedback.

Thanks,
Suraj Bhadrike
