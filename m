Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BC2DECB0
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992432; cv=none; b=NN61nNAm4hfWFi2crqZItG3jX6bcBPkoFJQHmprYwR7PWB85V02mjfMODO/EXFDB95f2gj7YNY1RD9+EmmAZp75gxOIf5t/uDJARG4Lfi917IuceEThmgya6Z3xaZa0yb7zTYxRi6nfV6DY4zYm0RBTNtO5/pPdqs+iAMKUEac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992432; c=relaxed/simple;
	bh=CnFUVhF7mmp0IqA8LtSMJVmRtY1jmxx4yrl5aL0phww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEWwR6HfIAkt5E2AhFy2xitVzPXRvpqAE6DVAIL2TeHucCpu2/wsNAd0GMEJm5PEroBrOp8vYndJKZxYfTNTAAMuaI10n5oYQo1f1guTuEOyuY0D0Rb70rTVSNgKsbdCGc6dm+ynIxJQbz3yN1oYuEPHHTVNTaldZtVZazaxOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3wjCdQb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3wjCdQb"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so930536366b.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760992428; x=1761597228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpfxIg2FBC7/Lk7TrPHvl3hDjVY9IwFyfRIBkLC/tX0=;
        b=M3wjCdQbDnstAWuKewAL7dSobR9p+OBvOzjCFn7mqqh22/wqMEXmPh3GJKG414FTZ+
         C2pmeaRpW14+IIJYejh8WYPla9zi3fes1nrzC/D69RqaJi36qHwf+79BSQOj1fR3cWil
         wp6l7VGkDVR1R8nbmy8iDozyWRJeLRMsutD/hU24nGSgMAfrYGSZGUGuaN2O69TZBwMd
         isVv824+h0FoigFJbF2wJJ5QbEZQcTKcRCOESHYIi4WXLuHj86XjXVpvE2Lo2b+hOXvJ
         OQP6kGfgy5npvMW380LlUwk9qXpz2xiuKhuzykJSXYtCjCBDEzaV4z1qhttzluF7+A5N
         +XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992428; x=1761597228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpfxIg2FBC7/Lk7TrPHvl3hDjVY9IwFyfRIBkLC/tX0=;
        b=nDpZOdfJDsfHh7j9wUdgbBi43frGGdLUhNIz8ZgKWb6CXwWRjvwZLv38LzRIQ2TUJ0
         Mo7SuIoKik22cn3+HR3TtcM/EN5e+tISgzSqzjbvQc5nMJp88qjHB/h4EpPdilynoVFY
         KaWkeNQumqqRI4IzXKQEXYVV7YMRAIHSw5A4Wg2mJGn8qtDfth05j3FmQdlFNkGpU3be
         wJLkhY/jkN10uQ8dyKZRYo1WCrIjWdoGXJfx/w4Y6yeRQG+LMSd9qyTFpSAJiPetmGHO
         ZkJkZH6WaT4I983pak/Ctm/QOD2wSV1BiVR8ObbeAe7e7JODHXDnxrS8EuxfwmWJfYDu
         a+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEy9DHrw0NRAlzoqmn7DwvohZk1Dvy4wCXK33EEEnXodmsVMZ5hYXujNUSlq2BU83XoAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6kvHuh8pofbPMu9XVGwOJXZlU3NZSOr5XRVdzarunaIWPve+
	CMtRWgkNTr9yDfFlcmAkZuy5kybNXHADzVDJBt2CzHeKQFdXEM3j70LtMQgyeEqI1sQL5/QJClf
	xHQWA5X2HNg4DP1fy/teqiAaWZ0eEU24=
X-Gm-Gg: ASbGncvOgKSOLbGBD2KL3Ag4dVzzCOQgE1Efs1TmgIOcaJA/pMn9w6RNzxFJKVUCBBS
	ul8chuEJLxDNmbCgHlxGeFVWnBBWrC5dtB/rJTfW+j1gzCh8yXhmZgKAsqpwVs1In98QVBw7PQL
	CUeUkw5hPLKz1JYJnvERpo23JJ4vrmMs70e2AYndc9wflykamI2JmER11SWhg2GkovV+WNrCJeX
	ckAG0BeBHiW/9ENHJvCrmeeEGtOmuqa4+VYHontXcR8Qzw2s9uAnMMlZOySVEIIqStZWnszG1ZU
	W64EhMlK4n0Oio2fNQY=
X-Google-Smtp-Source: AGHT+IEjggDWJO6on0t+F3XamC7hjy3gHGJgdFRwRqJk6Scx++Q6tEKY8is7mOGy71zW1Dk5v1iJVtV4N6ZLDcMM9aY=
X-Received: by 2002:a17:906:40d5:b0:b65:f5a6:68aa with SMTP id
 a640c23a62f3a-b65f5a66b4dmr981604766b.16.1760992427767; Mon, 20 Oct 2025
 13:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
 <597ea0f5ce24967974358e18603265b14322ba54.1760731558.git.gitgitgadget@gmail.com>
 <xmqqy0p8x12c.fsf@gitster.g> <a6d94c76-c9fe-4688-8eea-3bbab2b5dc07@app.fastmail.com>
In-Reply-To: <a6d94c76-c9fe-4688-8eea-3bbab2b5dc07@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 20 Oct 2025 16:33:36 -0400
X-Gm-Features: AS18NWAZEt5puWebkAGtWbKsDG8sewP3r8CFuOyM3iCoT7EMRexTWwn9Rh7QyQw
Message-ID: <CALnO6CA=_xQWVWkUONPA_p6fiCjeMkq8pw0SmgXzo0sUPMHNFA@mail.gmail.com>
Subject: Re: [PATCH 3/4] doc: git-reset: clarify `git reset [mode]`
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>, Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:28=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
> On Sat, Oct 18, 2025, at 12:53 AM, Junio C Hamano wrote:
> > "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> +`--soft`::
> >> +    Leaves your working directory unchanged. The index is left unchan=
ged,
> >
> > Why not "leave your working tree files and the index unchanged"?
>
> The reason I say "working directory" instead of "working tree" is that
> I've seen a few comments from users saying that they don't know
> what "working tree" means. I'm still not sure what the reason for
> calling it a "working tree" is.

At a guess: suppose I have a non-bare repository ~/code/git with
corresponding ~/code/git/.git directory, but PWD=3D~/code/git/t. Then my
working directory is "=E2=80=A6/t" but my working tree includes all the stu=
ff
Git is tracking above me, too! (It also helps draw parallelism with
git-worktree, but that's a bit circular.)
