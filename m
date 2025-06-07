Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FA21ABD4
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301004; cv=none; b=pFmYzM1TeL1gZ2yU5KfCAN8wEh/LASDELuJ6MbiC5hMiaUgmApfnNKXOjS3N1Cq2DlYlN8ZgXcD4y8YNMQpJGho8mMnXoj4Dne1aesvFl/+Sa7MUSBMObq/Da3rI8VBnhFPzyERSky1xibEZuDYZxYgjmmU3mZUdAJVArs5T+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301004; c=relaxed/simple;
	bh=lPX9SjuHEFquYPCzADHcw67JDMDBaiG6YsjzudfpdG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS9yP6GafRpthXR59jYD7Nrr0meYUZHMigDMa38MXnB1ss9T9SCRSafP0LFaBKPxK7lRay+Yw7PlF2Pxt22gW7czbFU24FJWSBPBIyStK3XedcmhW5Yl3BN0czkt834x8zmdmRSKnFNm0sq9n/wRtXZGRQu6MNLfBEO8zRwBoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daxcO/Gt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daxcO/Gt"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so2282322f8f.2
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749301001; x=1749905801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9Au/QFOhbdkvseMfE5bJ6K06wvrbPG/gP1L29xVN+Y=;
        b=daxcO/GtatxPsBcK0LHDCDdkiKSbwOkxYYVzBM9hfJBVgwSH43DBH+bwX5JdxcVUQl
         30pWCL9iuP1QF7Q/TFyzByzQIOJz8e8yjSp3aKH2z6Ypi+MC/KST6/11Uzhx/6j3+JNZ
         1BT5qCebSpnFa4krdi1o2LrOMs2xe1t9V806xGGiEx4oQX9cQCXkz0HwniiGvZNBAPbv
         ngYk5kRHvF+cKH5YaN+f6YsPQsI/MdirHJT004dZx8JTpTS8+UAIEQ/n5UFOGuLdGr1E
         GpMcvfnbB//K8hKZupvzjgXAIrRFbD03Y3KUqr0b/mSjwFltontGywPHBkKvb7eo3GGh
         MjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749301001; x=1749905801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9Au/QFOhbdkvseMfE5bJ6K06wvrbPG/gP1L29xVN+Y=;
        b=j36Dq8qPEEaB+iPYLn/8Jux13JHOyeod8S9/vEPyhR/HTvLsNPrZ4GKcNVNMqePK0S
         e55w23l/74r7x+KO4HGk1e9RGcarb6hj5noOheEW6ZvykVoSxeVDMJWTImaPh6lCT+kQ
         mViODpMrw20PN2k8tqWJgM8BMpBhlTXaob7FGCoezbyCurOM9OKB3Dy6ztinQs+LRAkf
         BhaDx393Kc9Y5AGV/rEtga9dFhcg9OLCeiqBHvUC5A15enJFbM2y/DGvH2d1vP6Tl3FT
         lx/I7THeSdHhTJ8Qi1u6OJUbCGI0HcmZ+yxAavDbRIg74dVLYd3rRG/cRvuKCIGHC8w9
         FkFg==
X-Gm-Message-State: AOJu0YwtEyyx0X02SX/7nTha4u1lmRqCOi/sNvyDwIPpibXuVrozOI0J
	IMwpnaGnacmvb98y7D5ogSACqZj0+Zqn1bVlI1fUNRQOm6/YuqXKOvpTKjBG8p6AAtzy+rEZw00
	fDyQKSoBV3W6hmMYQz2GItaaObwDYtE8=
X-Gm-Gg: ASbGncvlghnGeThYrqLd8Wt7XkVEws29c7b/cNJk3mJbHFsJZO5/7nPtwYgtCd1OgqV
	HLfEmCleKUml9sRrGFWotfKvAqhM9AiJONH1RXwTp6ZQpvby6NqZCOtxxRYzWxpEp5BwbXA9eRk
	hu6lVtzQh2AihgdudbXYzsoTQodRf7rHk4CN9IrMtEDlM3
X-Google-Smtp-Source: AGHT+IGKg/brOR9zXcQx2X2F5QHlz/V2ei9tYv2YOIeKiBJqEqL6oQ3GwWPVSrggtzKEypt8gFVpgl7Fdvs3vgzkBLY=
X-Received: by 2002:a05:6000:1787:b0:3a4:e502:81b8 with SMTP id
 ffacd0b85a97d-3a531caf95fmr5603184f8f.43.1749301000640; Sat, 07 Jun 2025
 05:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
 <cover.1749289514.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cover.1749289514.git.phillip.wood@dunelm.org.uk>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Sat, 7 Jun 2025 14:56:28 +0200
X-Gm-Features: AX0GCFuWivT0VL9IHhqy6DP5BHUMGll9aUE_7TMYdIsM1usQsZz8Yju2E7c89ro
Message-ID: <CAN0heSotWpNmqd905aknVTfk6WEcYifAwbXBKYfAWkhzxua3ZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] stash: fix and improve "git stash -p <pathspec>"
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

On Sat, 7 Jun 2025 at 11:45, Phillip Wood <phillip.wood123@gmail.com> wrote:
> Range-diff against v2:

>      +test_expect_success 'stash -p <pathspec> stash and restores the file' '
>     -+  cat file >expect-file &&
>     -+  echo changed-file >file &&
>     ++  test_write_lines b c >file &&
>     ++  git commit -m "add a few lines" file &&
>     ++  test_write_lines a b c d >file &&
>     ++  test_write_lines b c d >expect-file &&
>      +  echo changed-other-file >other-file &&
>     -+  echo a | git stash -p file &&
>     ++  test_write_lines s y n | git stash -p file &&
>      +  test_cmp expect-file file &&
>      +  echo changed-other-file >expect &&
>      +  test_cmp expect other-file &&

This range-diff matches what I'd expect. Now this test makes sure we
really pick up the `-p`. On that note ... I just realized that all of
these would keep the test passing:

 test_write_lines s y n | git stash -p file # what you have
 test_write_lines s y n | git stash -p file otherfile
 test_write_lines s y n | git stash -p .
 test_write_lines s y n | git stash -p

So the implementation under test could bungle the pathspec, query the
user for both `file` and `otherfile` (in that order!), get EOF from
stdin while handling `otherfile`, leave it out of the stash, and end up
passing the test. We could try to protect against this by providing
another "y": if git wants to read something after our "s y n" sequence,
we'll give it a "y" in the hopes that it will trip things up. We do want
to test the handling of pathspecs here, so maybe tighten this?

>     ++  git checkout HEAD -- file &&

This is better than what I had in my "maybe something like this". This
explicitly restores the file.

Martin
