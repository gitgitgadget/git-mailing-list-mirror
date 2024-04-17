Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13881ACC
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395298; cv=none; b=Y5Src4/YQEHNG5OVg1ItGLl0Mx53IM4SI3E6M7waoGviwcPCF6LTbL9vuSYPGyIWAA27f2HsTx9qG/r1JJr5Su2QQlQGnUNsgvAK7vM6eef1t+XGmmGEhEJdHnSeZ8KJYCDjcF4T7Ap697vxWdEUC+fq9vDgO3c/2H8UszJTixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395298; c=relaxed/simple;
	bh=4aauvfeedGTCVobxYZ6ZfWYGXCWj0bvDoLZvgky97Ds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oNEK8ajLuf2n9bR1Quk4r0BYEA7DRvsqpu9xBrTxqJdXpjSXsnJyrjHWtsvW3HWqRQ35qL1rQklx4RPPMwt8Qm0m8iehzCh1BzQMpyxWHRHXRVtP3+0MxJM1tVzsnTFZOoOdKnfjfBklO1ibhha5v9+hGT5CVPk22sTaXPSYUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJGDfA0Y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJGDfA0Y"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f041e39bc7so472848b3a.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 16:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713395296; x=1714000096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmP4Y4yi7N00mS4qNAIHkBIG3h4iAd/CDyV+F5lcBAw=;
        b=kJGDfA0Y8QEKgXyBZPfpJuYLtwfM2IB2n7vbv9WPJZeaPWSCWzQls7uCfrhYoJrOvF
         B7bLAbx+SDcs6RBTDu14T2WLI2PspZClRVRwXCKxmqBJ+rBjLFwVzXXdD3DBB6wTEfRx
         jMjYNWZTjFhUiXP/BgHUBocRLWN88ZDKqeWeI1WfFEKNoPNtyP9bvMWCeNgg+xP6RXO9
         XWNY/Sv/YHJIqaqXRu12SSrgOzQuAAg+KU9lmnSPJppTI0JN53ubL+U9NKUCSkfv3k7i
         2QhCAjH4+wvAeGKQMD6yEZNxoLP3B2pPrVGAqbkm5b4HOkOA5EBptmM9dpkxys280EI7
         Q/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713395296; x=1714000096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmP4Y4yi7N00mS4qNAIHkBIG3h4iAd/CDyV+F5lcBAw=;
        b=rZedIsxKgkmlG4qUF0/ULjeDPFBjb8Y222Uye9TA7w+XY+BHCWuiGIVzy7jgMbQ06s
         fvcBAOwU4cJxLVXE6JWfZdQnoUkQ2GK7W4g0AHFdcsm/AxDqqczfNMG3ekqUORHYUiPs
         AnQUi/2jmPO7DSxJLSH+u9jortaloDuYAIFlZDnfFo4c2AJKsCmTMJ+AfVOg/QFcrGZj
         QlbqCc/Y/wBz4BB6pWwmVWnAEqNGFBstDEPnb32ySN+aF0dVVfIPcMgMuPWhMDKJUIzS
         sPLG2TXAaU3nIbU0VyS7gdlt3l6D2w0PTvdzSMgCLhfR54p6/QJT/Luqb+8di3YCE68v
         g0mA==
X-Forwarded-Encrypted: i=1; AJvYcCV+3Zy/HMYXrEbqOhcTNjCmXC5o3JpSJsTWxET9XxXYyPbWcjkDmu+ptRxYjg2r+L7/Z2JGU0c8aatOt30cdxpo6lEk
X-Gm-Message-State: AOJu0YyRvb2e2De+wZ1AozmGBimsUlf3Xb+0bymd1sbEGdKZJymOmd2F
	24sDBagIOuXwIzo8NEDDawKZDkEtvOwiFnxPnlNuPKV8CoV/lmgNtsHM4jZdS9+0j3QTDCKBtZP
	+vg==
X-Google-Smtp-Source: AGHT+IERGgjxSJ5MPx7bkBKLZPwncnTH/np0v+2k9zkjCM5+2UQFGEYltc765Kne5PQ21Cj4YenTA4JRkUc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:98f:b0:6ed:344:9faa with SMTP id
 u15-20020a056a00098f00b006ed03449faamr100103pfg.1.1713395295939; Wed, 17 Apr
 2024 16:08:15 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:08:14 -0700
In-Reply-To: <xmqq8r1cczw8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
 <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com> <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
 <xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com>
 <xmqqjzkwdigv.fsf@gitster.g> <owlyzfts52ln.fsf@fine.c.googlers.com>
 <xmqqfrvkd843.fsf@gitster.g> <xmqq8r1cczw8.fsf@gitster.g>
Message-ID: <owlywmov4mg1.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Kipras Melnikovas <kipras@kipras.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> We are not installing this thing (yet), so how about giving an
>> instruction to run "perl contrib/contacts/git-contacts", only
>> assuming that the user is intelligent enough to be able to react to
>> "perl: not found" by installing it on their path?
>
> That is, something like this, perhaps.
>
> As the string given to --cc-cmd is stored in $cc_cmd, and is used in
> this call:
>
> 	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t, $quiet)
>
> where recipients_cmd takes ($prefix, $what, $cmd, $file, $quiet) and
> runs execute_cmd($prefix, $cmd, $file).  execute_cmd in turn takes
> ($prefix, $cmd, $file) and does this:
>
> 	open my $fh, "-|", "$cmd \Q$file\E"
> 		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
>
> IOW, $cmd is just an early part of a shell command line that takes a
> filename as its last argument, so I think it would be fine for $cmd
> to be "perl contrib/contacts/git-contacts".  I did not test it, and
> it would be appreciated if people can test it.

I should be able to test this later this week.
