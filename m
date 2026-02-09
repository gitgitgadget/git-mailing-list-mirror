Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276B20DE3
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644705; cv=none; b=YEEfuyy4jlv1gmQrlPZWP/Dspphj/VQPSaPHwEvH1XFCET+W4VMrs3ReSvM5bvSTalCwni3oClbgYtYUul3MVoxzXHEvsVFPsH29IdTz0yj3mSab1/5J5w1hWAUBHsYY62mTO6lGDmod+5/3V3kNgfOHwaGF6dxNSlzXWPRrAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644705; c=relaxed/simple;
	bh=a0JOnNao+ZMogTfuRRNwnzjlwm4HUaoQIfX39AcqaGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyhy7VY3mESRYZ6O1+SinnZ+kAPRB5gN3qZozJ7QPp0O5S70Wo8xcWwDTPUBKzoxroKy2mBN6eZmP1K4hvupv5i80W5WFlg/h+ixHLPyGplTooaugEPhbINWntyz1edx8dnqVz3mDStOBiG0pnQkr6B9t2TaN9Qd8ZaIPob/jVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6Ow1UiX; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6Ow1UiX"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c6c444e89bcso1600513a12.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770644705; x=1771249505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0JOnNao+ZMogTfuRRNwnzjlwm4HUaoQIfX39AcqaGk=;
        b=Q6Ow1UiXfcKEes9gCsvdNIUAXV0N+QFo0T/M/XEIzImqcOkspKSgI9xIiJuADfbolj
         PCGgaFiq+FKMvLfu4Q5SmpFAHzNva+ur/gazwFCWHzbjV/y/AmXV1Cfhtw3iA3838UlJ
         K8upuQvud5hLa1nsh5NySpF8F4T4kJnciP1bdrNGXYtPTK6wpQG/EI6yZy2R8YyEINn6
         TnG3b5rMqKixQF+HwmABNGCXF4N6wnPyD2Qq2ScE0uj73RCmqlymnw5wnSudxr8ovI44
         J8ASYYdWTW52UQCqqch5XNFHCN0mod7pHgdUMfrONHCIrt6nwXPwehiyTocHFwfuu0EU
         QlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770644705; x=1771249505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0JOnNao+ZMogTfuRRNwnzjlwm4HUaoQIfX39AcqaGk=;
        b=hmRhNCeN9FGYu/kOj56hgtnHW8wkjBUlXnf/Cazi6w575272fyjti7xFSnrwj2UwQT
         6ZJFRcS5H/raUm2e3059GhulcwRSf82uy4IPVDD7DDC8EsSP37sWIJYP8PF7KFYmGS0x
         hOjX+2vRp9oFIWx8igihf8KjeljxINhirYpq+lNZZEXjGMGowO/t8FfeFsowHZZp/RSv
         jc33vZlK2lDLOLCSH7JRyhT/Kr4ktbamffI6uvG/MPYEpgiD+KFyviMfENoHp3lq55Ua
         TBH+mgiWwhxpNZPsHM/k1thnAj2bsk3JZxKm03nnGpFjc/gqZvVgKLyjlsJpEacBpVjg
         xZ1w==
X-Gm-Message-State: AOJu0Yyb8YjYRoPI0tNTz3WkuFvdOerQBymm9kBaDqFUm1ZdwZ2gUeZl
	uE4hMBzEi6iiZqlM39L03yEQ9wqgqkj7E7Smc2wbAI66/Rq6J92UzR/yzcNpDjVR
X-Gm-Gg: AZuq6aJ8Cqm/UcWwWDFgSDYVp1kc4ImT0soONegxdCbjnafzjybnrInU8sqEqwk14Av
	ApJNcwa7m+NgpT48vgPGjdu8VxTUVC8JiRJMfJTxuoRU71Bxt/tJpcedlOpAsuZSy/8EolEfP39
	PuYOtp+Wo39hP3Ws89lIw4EaHYeeMdFKXnbO6TlwED5RXK8Xv45MyHoFKP2RJ7H5h1L7nGCgB4U
	hHWzxlE94058HU18dgUhGKdPVhS9L4RtpgsM2I6dSXVXxnkiN5rHgevTBQ6GmOoApOvY8qylXas
	2qqqtxPk54ozZYWsdyVVlWQ+OKTcQv1oInLljU5Ce4bWqQuwk0mjEhKMgesnVFwpZxotdTayQ6U
	kYykMeTUGCLnXZgshZeqJMGFRf9O3Osr1kiNhC/kvgCLigAlt6TgJcfob2m7/6y14MJ67YLA5Bs
	78zsjZUKSnSbj9IER8WybLv/TpRGU0l6SlnntsWS4AKa7i6mo=
X-Received: by 2002:a17:90b:3910:b0:352:b666:6ea with SMTP id 98e67ed59e1d1-354b3e2c345mr9736659a91.36.1770644704398;
        Mon, 09 Feb 2026 05:45:04 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:cda0:7c0f:852a:fcd6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356288e4820sm6874926a91.6.2026.02.09.05.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:45:03 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Mon,  9 Feb 2026 19:13:22 +0530
Message-ID: <20260209134439.14492-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOLa=ZRaWA14sootWSPo5g4Yi4GBXf6HjdkdBY1Tt_+V0szCjg@mail.gmail.com>
References: <CAOLa=ZRaWA14sootWSPo5g4Yi4GBXf6HjdkdBY1Tt_+V0szCjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[...]
> > Thank you very much for the detailed explanation and for pointing towards
> > the bigger picture.
> >
> > From what I have understood, the worktree being NULL refers to the
> > primary worktree (as it does not indicate which repository so it means in
> > respect to the_repository). So if we want to access the primary worktree
> > of a specific repository or even the local repository, NULL does not carry
> > enough information.
> > And obviously, using NULL as primary worktree introduces extra checks and
> > measures as we saw in the previous discussion.
> >
> > I would be very interested (and the more logical step) to fixing worktree api
> > first, and then revisiting the wt-status series on top of that, once the API
> > makes it possible to rely on wt->repo without the NULL risks.
> >
> > So a possible in the worktree api cleanup approach could be,
> >
> > * Make primary worktree as an instance of struct worktree but seperate
> > it by having a marker like id = NULL.
> >
>
> I would like to point out that we already have a function which provides
> a main worktree, see both `get_main_worktree()` & `is_main_worktree()`.
> In short, a worktree with id = NULL seems to be treated as the main
> worktree.
>
> The harder part would be correcting all code where `struct worktree *`
> is passed and has special meaning for NULL vs non-NULL. See
> `strbuf_worktree_gitdir()` which also distinguishes between `wt ==
> NULL`, `wt->id == NULL` and `wt->id != NULL`.
>
> So cleanup would require identifying all such spots and fixing them too.
>
> > * Add this primary worktree in the struct repository (e.g. repo->primary_wt).
> >
>
> This also is tricky. We currently already store all worktrees in the
> repository in `struct strmap worktree_ref_stores`. Here, for the main
> worktree we use '\' (see `get_worktree_ref_store()`). So perhaps we
> should formalize using `\` for the main worktree everywhere.

Thanks for these points, I definitely need a better understanding of the
whole worktree api usage and flow before anything further. So I am going to
spend some time on it. Once I have a clearer picture, I will send a
seperate rfc attempt on this cleanup and we can discuss it further there.

Best,
Shreyansh
