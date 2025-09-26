Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03325258CE7
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853771; cv=none; b=brX3arQdz+cESWZzhGJtCSuxtDqkto7KO3UjKrcpa6gq/iR0IJRrEMWHcftRwmlxPb0LK8KxTEBWn34GrZ5h0D1krfV+Zpj4Rj3VKaappgIwzPh1qwmmYd9NCVYgNxEbFlK/U7aHWcFktf+n/ZL32ueuKDUd5shjcVS2jY9LWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853771; c=relaxed/simple;
	bh=E4e2A4n1X52jeVMkPHK6n36OdlBg9iytN+PxD8x4zkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr1mzrkmWZKcJ9pWwaEfoPsPVB/yt3pAn9MsTCk+u/UOEv9rccPZ4OIqOeh60WMvOYY6H2ATdJ3R8oTMyfewA6FyJ+4EfU2Ne/SzbC/kt8sRFlhPW1y3gZs6sPOoMIUvVJw6vSp00iIzARNm2EAoZk3chfComyhOP83hW4hxRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZDwudOg; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZDwudOg"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3635bd94dadso14961191fa.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 19:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758853768; x=1759458568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4e2A4n1X52jeVMkPHK6n36OdlBg9iytN+PxD8x4zkk=;
        b=dZDwudOgpw7PYLQ//S20+D9BgXIm7bzyObpe6CtM0br+2sV/PCk4lILgXTCsZ3xxzy
         AKLioubLZXiqKwOsQalqiymHU7lbS07HQcEtJ3TfAf5Aj9XELv75KSLGCn2nRU69VgrR
         /imiY8N8lLtndkfT/xubR6cF73/Bsk2YukzA58HjvqDbzfSfn3m6bHfVCyqeutcVzX/s
         13B/rT8XTwAffmslfMO0Qw9fZJTgmzMuuRL/vK/AY96bJjZDuT7AfUY9WUidcmHQ3d3V
         VumtBNIIUVZOKavV5qI0U7x0o2Dv6EpZY/YbBeayNtKA6diYiJ446RCBr1HUUNctBTRq
         JADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758853768; x=1759458568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4e2A4n1X52jeVMkPHK6n36OdlBg9iytN+PxD8x4zkk=;
        b=weYOYgj6tjS+T4hOROvSTEmHbj/XtNjYDu29N4pOkR7KwjQUH08lIQBGZ2BneLhdAe
         MQJOC03DSUl5XGB+BogY1eXzUqE3c2aBhVG2vw7W9ysoOzg33ymO/5U2WJVScF6r3Tlc
         mfcgT4a0zu+9B3o4rZ1Hx2q7cEq8VORDcBmqmpM+lkme7NTClmDqFAvRJJQLTW7qn85B
         l6OncaRRWGJUjzSO1rlkgVAFU62fi6CZwwrl6QJKJUZX5x/n+S6fvvPrkpeDvQNulNeM
         i2yCmIxfWFg9DxFL8/8gIBpBDMqbZSVrTGizhgXXcHFLlEdFZEGknb9HwnIxLLU1hRIX
         kOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM0r4l6QM1QIQYLLvcGHfMCdbeDwQJJ6OPfznmYddcGLdm1/GIhQoMDT9Ntd3EZgNyfI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7KwXJexM6ZGKdz5aZw2vikfIEz/iEndfAULwTQ0PboVz6kHB
	frkCtSajEB5nMtDeB9YUrN/M/SOv8s/mJoyWTnGV3Fj4B1IHqQn4bJUvcaqiPH9/GW3EVLXltgH
	jDvV9/pAlVjPlNFAbl/h3VQUbqTHN0qBm6Z/wmbJcQWQN
X-Gm-Gg: ASbGnctaFg6GlGAvPmMkU+mSxGK2cFvtE8Egh2AYLuzPW/XGddSIDy1kvYLNvGfDg1z
	62E/F+k6d4pbWVOFVSSS+bkHhe/t2FDttQkHCDJGWF8Z3NctLTHtp1UH/MvJmXimLg10ezRRgBX
	2XLWmfSxxFiiWg46p8lUL3hOW1DCfmgRxy/I/YU/uzW+Z0prw/FMVewLRdSBch830s8FiBlXhHR
	+kjzJKv
X-Google-Smtp-Source: AGHT+IEaSeq8bbGBiHeMDgamf0FB2vhVXapeIsUnxi2emV9H1SXRWMD0o6fBChXoLqJYFKI8II+ojd3dz8II3BrrjV4=
X-Received: by 2002:a05:651c:210d:b0:36a:a8bb:9b9a with SMTP id
 38308e7fff4ca-3707c0ba684mr9744741fa.0.1758853767801; Thu, 25 Sep 2025
 19:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <08a0fceb72b2bd0a2803d24b9874b7f9bd03703a.1758662670.git.gitgitgadget@gmail.com>
 <311f7dbe-b970-4a5b-9d53-05f019cc54cd@gmail.com> <CAH=ZcbBcEbTqQ-FpYSdr_QjSM5sKerECKsSVdTyHoSQqG-V9iA@mail.gmail.com>
 <1c3461c3-09bb-404d-a4dc-a895baba68f2@gmail.com> <CAH=ZcbC-cB35AGmiKgEQdFa5ee+DftwOQ_dUe4=T+Vq-dxR+qQ@mail.gmail.com>
In-Reply-To: <CAH=ZcbC-cB35AGmiKgEQdFa5ee+DftwOQ_dUe4=T+Vq-dxR+qQ@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 25 Sep 2025 20:29:16 -0600
X-Gm-Features: AS18NWBlzSGMiGrlONsSuew3FipswRH4l978JNOcAclG2rtWtns2asBag9FQ8kc
Message-ID: <CAH=ZcbA0Y90eQV3fHFsROqQu40Mv==XOtctrdW0fQwzb0p05xA@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] xdiff: use enum macros NONE(0), SOME(1),
 TOO_MANY(2) in xprepare.c
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:40=E2=80=AFPM Ezekiel Newren <ezekielnewren@gmai=
l.com> wrote:
> I'm really struggling with how to write this commit message. I would
> very much appreciate suggestions. Here is what I have so far:
> --- commit message start ---
> xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c
> ...

I think I understand what is happening now. The macros I should be
using are: DISCARD(0), KEEP(1), INVESTIGATE(2). The comments in and
around xdl_cleanup_records() and xdl_clean_mmatch() uses the term
discard, and not discarded. I think what DISCARD means is discard this
line from consideration in the diff algorithm, and KEEP means the diff
algorithm is going to look at that line. INVESTIGATE means that the
current line has more matches in the other file than some threshold,
so we need to do some more work to decide if the line should be kept
or discarded.

xdl_cleanup_records() does not belong in xprepare.c because it is only
used by the classic diff (myers/minimal). It should be moved to
xdiffi.c, but it depends on the classifier which is only defined in
xprepare.c. So I can't move xdl_cleanup_records() until more of the
code has been cleaned up.

I'll work on the commit, and hopefully publish the next version soon.
