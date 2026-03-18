Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461D369211
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817391; cv=none; b=A99MirV+lX3QvuoiSreS7A4exuIXcW2v+8Vj2u9ximr1yGq2zS5/wATTmWsf38mG7nMuM/CQIzWY2FNeHk4YYRh2S081UUsBzW7jKSqXYCAgzWeIlMvfWEu3yUTPUk/WPHLxvPtscrcLaNbHdFocKsansrAbJSaJCXTfXAdeLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817391; c=relaxed/simple;
	bh=DMh4wd6Pah8R4JP91y7j6GBojCZObyTja8YlTbWDU2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5fSdH7PtdE3zqCjjgnKRKz2+MVPfYPtCUonO40QWg4R3PmfryD4zfxsXkmrRuvvhBY9TCnsAgBD1AFLwYm1c/vtGGZcbefF2DtFoadGySgydtKoY7S8p6fY0pvPMijghq+Ci4IXYKkj9HOUpssuaDQlYVAPHAO+2rizQuVIGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIB7FoaM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIB7FoaM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82a655cfab5so1062826b3a.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773817389; x=1774422189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNlvRiIB1CFOsMPDGvma1QHkkwu/0oyPEKTZGmwGxK4=;
        b=SIB7FoaMI9tyOLWkC08sErNdH8oEkcSG6q6DQ3j/10Nh3zwUYW2CUNgWJXVF3EXOTG
         7g2d4PHbMhcw4Yt/fUuBEoQtospHMLTqRE6XkmoGjWSOsiPIHqa59Q/LEMVwAvbqjnmk
         CFYvPHL/19N7t2ye7jQZ6ryrCm9ucHvKSl3xb9TZXEhJqbvRit9ExQbvzjxm/WphDFXw
         4SCZ2LLjwKY/TmmY6y3RpWrwnW41YQnZaufRlRBwmRj0ObTwP2qm8z9osSkP3l7pYEDU
         Y/YhwRZJkMj6dJGajgRWrWp5lzyNa5q/jK2YHGF3WgRHjuHk2h9bF5WxhUeSU88Mcc36
         /C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773817389; x=1774422189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NNlvRiIB1CFOsMPDGvma1QHkkwu/0oyPEKTZGmwGxK4=;
        b=YmrC8wV1UBlKl/Gc1f64YegX6TMO2ymif9QSDKXZxZ2NEXVvnClecLpRBlJII1aEQL
         2tc1ZsSTSZJ0U4MYqPj7cjFdKSszAUjbhv0QMcLsTmAtm/RQD8O8CDZEJuCRq9+k13ck
         6z9pT8s+hD7pnoK8TJpWvDtcPODeNp0GQIbfgeVi4Dmd/pV1WQ1kkWqa0x4H9ZMCPf7v
         aucDraJwXoXKiDSHTWL3+4CUYq61E26Rf3Iv/bHsakDDQ2y3nFwYs6322lAvTxgKSDAf
         jK7hld0mPJDtJ4jSF8aatJuZW10CbC6VQy499KJsNJbk39ZCfjVIo9LOlkc8jr1P38RS
         39uw==
X-Gm-Message-State: AOJu0Yyb89yrQNX2KnrNTNFIx49A8M//5WTB+J7ktxaFsJ6F3VYG7qf5
	O9Npl8gpzDb4d3GhwIzXEGee29OuBpDbm7atJWRzD1tUNCGEtmKKirLRFFbDGA==
X-Gm-Gg: ATEYQzytodQmcs5jOUVXBOga3L26Bf9/V7uGwmYrVZ8P24Vt9fVPFWm1bsN2iBoDrYE
	n+Plv3Jjolcv8FiIPeBK/b2QoLjnCY4PK0NoFZZl0lfy5/uPTGjAmbcyiNfVmaAA5IjsToVwqVx
	N/UibVh6H6uBFG5x2gXwDsYwkXfoLWsIxw3tx2TogWtHnQwgljhmjKnhA3Qxagdt8B+mcQvAubE
	GehJCH0AAq2SfbeG98xIW9vyZwT/QaFZphH/b9AhglxAibZUBcLHkRmc3kakQLFQIwYTr0wqyEp
	MSeEqfd19j8r0NfBBr26WSXRFIxyE5zAb8kIrq7jMJRgPzrUULgq8lg538CQID7ddK6Rd/g5PMV
	E+yitOhChSroxSwwQBntsYlZkj+NZJza5AxybaKr/fWQhmeV6nDdqCbULMj3ADStI/nQuZmM8Qs
	2Saey+7GkHMq918T42h4j2dIoawbEZ4SAU0P37m8jHPWoxmm9TW5jpAg==
X-Received: by 2002:a05:6a00:a229:b0:81a:7be3:9e6a with SMTP id d2e1a72fcca58-82a6acafd48mr2218383b3a.7.1773817389377;
        Wed, 18 Mar 2026 00:03:09 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:4c9f:17e6:42d9:c5c6:178b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb2802sm1506222b3a.31.2026.03.18.00.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:03:09 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: Re: [PATCH] add-patch: use repository instance from add_i_state instead of the_repository
Date: Wed, 18 Mar 2026 12:31:20 +0530
Message-ID: <20260318070237.659845-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqo6kmjj9d.fsf@gitster.g>
References: <xmqqo6kmjj9d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Having said that, please make sure your patch works well with
> > patches others are working on.  In this case, s->s.r would no longer
> > exist after this one:
> >
> > commit d51b61f5dab9c8e715fa792f31d572bc96fb5687
> > Author: Patrick Steinhardt <ps@pks.im>
> > Date:   Mon Mar 2 13:13:07 2026 +0100
> >
> >     add-patch: remove dependency on "add-interactive" subsystem
> >
> >     With the preceding commit we have split out interactive configuration
> >     that is used by both "git add -p" and "git add -i". But we still
> >     initialize that configuration in the "add -p" subsystem by calling
> >     `init_add_i_state()`, even though we only do so to initialize the
> >     interactive configuration as well as a repository pointer.
> >
> >     Stop doing so and instead store and initialize the interactive
> >     configuration in `struct add_p_state` directly.
> >
> >     Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> > A good way to ensure that you do not send a patch that does not work
> > well with others is to make a trial merge to 'next' and 'seen' and
> > ensure that they produce working Git, after making sure your patch
> > applied directly on top of 'master' works well.
>
> The above "good way" is to notice and stop yourself from sending a
> patch that wants s->s.r to still exist.
>
> After that happens, it is tempting to rebuild your change on top of
> 'next'.  But please do *NOT* do so.
>
> Instead, identify such dependencies (i.e. other topics with changes
> relative to what 'master' has, that break what you developed
> directly on top of 'master'), and then merge them to 'master'
> yourself.  And then bulid your topic on top of the merge.  Work hard
> to limit your dependencies to absolute minimum, as these topics will
> take your work hostage---until they get merged down to 'master',
> your topic will not be able to be merged to 'master'.
>
> In this case, you'll be likely to do something like
>
>     $ git checkout -b sp/add-patch-with-fewer-the-repository origin/master
>     $ git merge --no-ff origin/ps-history-split
>     $ edit ... && git add ... && make test
>     $ git commit -m 'add-patch: use repository instance...'
>
> to build your single patch series on top of 'master' taken from my
> tree, with Patrick's history-split topic merged into it.
> After the commit is made, send out only your work (i.e., above the
> merge of Patrick's topic) to the list and you're done.
>

Thanks a lot for this useful tip.
Going forward, I will first try to ensure that there are no on-going
conflicting patches by a trial merge to seen/next branch. Then after
if there are any I would merge those dependent patches locally on a
copy of master, thereafter build my changes on that and send them.

Best,
Shreyansh
