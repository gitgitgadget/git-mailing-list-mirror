Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9A2F50A6
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476003; cv=none; b=WhIFT4YbY76higN79/zewN6510OTeUoAYrf6/bBIqpgOlrI5mVtuh6tmLGgUEo2C8zXkCwwjchiSDuTVwh3KVw6hzCJum8FWX2Xjc1Ptlo79x6ee/+nxnC79tGvKc7mB7hd0Q6ZLkNp5yO1yw1c3um2tQ82m6g0nSqb4pRqe1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476003; c=relaxed/simple;
	bh=XgXLcVCSd3QCR+y+34DL09PFfDwMiRj0iwpK8QQevUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ORF17KQQorvW11Wz8gw/Z3EvR+ZzZ4yxWxXA0LU3y5e8I9mmgDXz0MP2SBQvDF9OTPqN7h3xDwgmWrTRv49RIg7H4w54TQil6PtggI8WZ4BtBwDQco9Kk2wK5lWq3JGL+nYJ/VymCHWRjKd1YXenb6hsf9ZW7C6DB22+0lbpAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6HK786c; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6HK786c"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748fe69a7baso6777172b3a.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476001; x=1752080801; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgXLcVCSd3QCR+y+34DL09PFfDwMiRj0iwpK8QQevUg=;
        b=P6HK786cMiPae3/h7gi3xCEVkEGD1M7uPzC8IjdBa1wNi+XEAQcHNAXP04+UxgqpS7
         DNOKGqzTy7CPre9kMnG5kH6d+/mSxleaV8/KOW9jkAS56RhhUvJjelZ2f/Huvg+y6hM2
         /hwEshKa7q0+T7ts6PMQxntxe8Jg3SfKchMKMeHZbvp7xHxkzMCPDhs+XvlPZX/yIX+/
         bC1Md8HYLUNf+9Ure+Ti+Wi+oUlBxkwJglX+YCEopR7Z5jbJn+lpzoMHUFp8Fga4sEwE
         xvCGGs9f8afLpetFPIwrPUBfgPJi2oITLj9NcPYA7a4dwvs5BwuDd4l/E2iuRYiLrjsl
         3D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476001; x=1752080801;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XgXLcVCSd3QCR+y+34DL09PFfDwMiRj0iwpK8QQevUg=;
        b=hW3lsas9+PMiAJ6DYhPte/clDLoRjYCjNJrlAgDMBdEZgZQkFPZOgb5EJ47RkoB4jf
         H4hGUM75LK3jLvFgGL0c3WWyvAMNZ6h+eGVB9QRhXcVdtXyf7LTmX7Why4FrkX4ga7J6
         SAEskVUhqV0DhazkLGkm3yhoCUEb8Ov2twT68Qp9wT/slUfN3L+6hBUAG9MCdAI07WHS
         cufNzfuQuuH4DJ4O/uHz1+L3a9io0ztgHZRk211W9rJayM18qeKtufA+qqX0iiDsGkK5
         gWqTWzf5/qc7lHYTq/le2o+sILmH/gve1bt8QlVOxeQzw0FNfm3vwJfIwRSF2SKP5TOd
         4JoA==
X-Forwarded-Encrypted: i=1; AJvYcCUQByPQvy18guo6UkKZqNzXExD+fNZ0kr34+bOYusAHFu4cJsgEzhGg9sBtelman1Xlm78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvc0nI3MJmz0AfJGfgDXc3CopOdrEV3GzoSU3w8B7Yfkp0Oftz
	cSDgznY/0G2ie1UA/E9mGovYbBNrFCvhjNYX5R4OiyPGE9vevWnYyaW9
X-Gm-Gg: ASbGncvE9+EWC4KmXbHCLpDCbmiloQKosX+2m+0pF2CUVYOWsTWkBL0rPbs9S7o26xy
	PihP5YtnanAfAhlDupqpOitfEUavwPvsVREGJks770JbMm02fixrYVtIns6PAsernIfVDSeB1o9
	IEbRNhIiYTlargfBrD7weuYZ7HvnJtEQnNFtaL/gOCtO9fkeaE8cxFjCaPe+/teaKsnDJmQ9MuR
	z3VNIZfA3Er4lntXE3M0/8RBjEoQin1SujcpjsNMLaULEhYLGQ4WMeBb4Oprg5D9itMy2fHlKgu
	UIKqu0RP4l6etdA7rf+Wfs4MAQgCd1nXUAtDL6/0gh1OLk+9kR2Jm3zuqArQz6dtAX38tYaqWzZ
	uzBAjtXJMXlPInUzdMWntJT8Z5QQ=
X-Google-Smtp-Source: AGHT+IHizVpk8LxPiJ95RA8HjNi+Ygl3/vFWm94pXPuKFNikNAPeuPmdwsi35EqIR45DgWFqpEFZqg==
X-Received: by 2002:a05:6a00:889:b0:748:ff39:a0ed with SMTP id d2e1a72fcca58-74b5126bd0emr5376891b3a.20.1751476001426;
        Wed, 02 Jul 2025 10:06:41 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af540ae4csm14499359b3a.34.2025.07.02.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:06:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,  shejialuo@gmail.com
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on
 'the_repository'
In-Reply-To: <CAPSxiM9ahAPEr5fj_A1RpgYjJQmv9kZ2jYfR2Knat5yHZNDkEA@mail.gmail.com>
	(Usman Akinyemi's message of "Wed, 2 Jul 2025 16:48:19 +0530")
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
	<f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
	<aGPcKgR0G72JRSlM@pks.im> <xmqqikkbkglx.fsf@gitster.g>
	<CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>
	<aGSYLJaqDziLqtXk@pks.im>
	<CAPSxiM9ahAPEr5fj_A1RpgYjJQmv9kZ2jYfR2Knat5yHZNDkEA@mail.gmail.com>
Date: Wed, 02 Jul 2025 10:06:40 -0700
Message-ID: <xmqq7c0qed3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> To add to the testing part, I noticed that there is no test for
> checking "git prune -h".
>
> You(Ayush) can add that in "t/t1517-outside-repo.sh" there is a
> similar test for that also in the file.
> "test_expect_success 'update-server-info does not crash with -h" You
> can check it out.

Thanks for finding and suggesting a good place to add new test.
