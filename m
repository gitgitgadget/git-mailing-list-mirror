Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907B4207A
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765907386; cv=pass; b=f2uHJMW4w1Zpas3As4ypbw54EBQ7Icn9tIkShjjafsaLFiF3VXmE0Z9CU6kI164MhxIKO7rDBM/AjLF7LejebsMEsl9NjpvCFxF6PwHU1fwbMfUmVDDJaZWaCewkBE/fOQcje/UYuy9Qisj9v7nli6T5mocxNw37aoNHafSSoR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765907386; c=relaxed/simple;
	bh=papnDmew00KFzMjLtGDxT8alg1BFsBnEjdkmgwh8uYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCUUP2/vO+vM48ojycrz7kyx6Lhj8ozPTx791R9tbqwZDcGb/NFThj3bowjJL6RCbH0N3W7bK7Yv1u/xQV4hhRoJaI239mfIN3irUdAd0jWZIlp7SAShHgpR+W9Frjb+pCvKVLus218yttEFP38PAiIzQPT81BIA4J55K4AJNaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fs6oDsgs; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs6oDsgs"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee147baf7bso6511cf.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:49:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765907381; cv=none;
        d=google.com; s=arc-20240605;
        b=eF6pFTK4IqL66C1++r41UwXeiuGVDsl2XU3/4UYxAksXz0vlLtt+4ik6QK8DYHC3r0
         2/sxfoKNCF+c4wQINwV1BSlIR85dB+jjoaH+E5jknub8cry7E9q5Jhs/ExEm+Edk0LMO
         6dD6WmktMYFrB4Vgv6PBJNZQJa0uBpykySqwKPQE8i096cRUAI+w+U2ytXNItYqVZx9M
         jp/keWZkkbCQ6Sdq7O/1Bh5CQaDT6khJXtYQ3bOI7qdr4IuwDkz30cTKcLKZUekUCu56
         jYL1rPx5NF43FjGb91evHAW3uKNC5Y9E2Lt2LMa4Gs0gzI3vOE4+abgweqsAd+GUQwJj
         6OmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e76kVK7+1D3bs4SbV74KTC/4Fcsh2P/DTfdy52MpELQ=;
        fh=LK33xML8TFK5Po6sqlqcLURA65d2yKFoPMUEiKs1Fvs=;
        b=dh7/qHp4NOsOQMb+MNuTPvmc4ZibnNsgG0PcGvqcWq4cTX6fxEK6eQFWGjWEsC9wbN
         3Rdht/lha9oo1EPan5CX/3OVGe/AKOnoMmKE6Yhg1iJaRzqOJLaXLAXEco5aHveLYgJ3
         Qe9YRdDFE3IjNP7mSd8mRfIUcMc5npF1VaUTJMFNWTyeMCtlbTCvlVr2MUraNSsdo6OX
         4p5fXti+hrtNwYJZPkh2uWvFfpkrbuFTuXW6G2g/rWr+VU4jPr6J5dKa6CH3XBqOfKRk
         joWbTHtc+vjG/PMt7o4/kXBJbHKIH/q5Jkmub4HzpY0cfyb9dwN/8gqwInm559sBZdAy
         M5JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765907381; x=1766512181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e76kVK7+1D3bs4SbV74KTC/4Fcsh2P/DTfdy52MpELQ=;
        b=fs6oDsgseHJV7R/AFxE8XC4r5STMDM8zXRjWVL+VrLL9mCyw9FABLwFYtzZoiMOj4m
         XvIBikG3R+NmsxKBFy++36fouhuZWBxhscmJK+3iiwu8qKLRM4dUXCdRNyB2vUsRo0rM
         Y2wszeGdis/NiETNmTu+sNp/x4clbC0L2jPOeaC6mjA7V8dgg0Tc+IsmRPnuYs/gWgkG
         JtAOYMWqBqfQ4mBdK9z7284z9mJi0xBwM34wQGwaOknLz28em5J67F9Pp36dRWLzkwZq
         UqYAM6+OF1Db63dNXEBv1OJ3Jh++FPJy/1qbf9ByF5POqi+Ew4Bl0ES2sTdta4HJtlFJ
         tHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765907381; x=1766512181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e76kVK7+1D3bs4SbV74KTC/4Fcsh2P/DTfdy52MpELQ=;
        b=hMlhJ7QxWRnhodjxlxKiFUxWHkUUKrUzbqZJWQVf+gN4yW6DbM5jPG1T8Kprr6bPsd
         dTh/bJiwm6iWHjitlum9M1baCwlUF5PxRv9FE9joox33JAVD63e7++2GWxhaTxUtVqS+
         5D0yGhc2zZ+RFwoueuW7VP3iuOPHoPYYsCXtnFAHbb52YcYcx+1SBUOPzedJD0iwgc6X
         M8U7/zkQ5kLFsKkgENnu1F4dlb7U2CLcotdduzhuhihr/pwEYzVYziBRtcbIO1G5mEt3
         FRz1kXQNN4Qs2mYpDZkv1yyCM/C7V8s1cKeE7i2W0YJniRq1+b7v2FbOZI3QY6LSBy0w
         mLDw==
X-Forwarded-Encrypted: i=1; AJvYcCUM/TvO6Wf6EGV0DSkVeipRvQ9LdEY0xM6TfkHjxLxdZjhKxdQOPBl1sQLUU1lQN/HEd0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2q95Hvk1od2dmbHIVo6UhyQbRKEDI1s5yYdqyPCAUqtgcHR4
	XTY2tZTF1leSNnUC5qSAuaIScjpuvmGbS+arQ9qf87uYuMo909CEp3Qtp9jnHXGIUIfZOCsmQ8E
	sF3AJ/8C1rzi5jrHzu+U1uHaif8iADC/g3yJRlJMu
X-Gm-Gg: AY/fxX4EddPikbQhPVIgt2/JN1nX+BJ0TAID/eF75xcV+uazXOhgLoMdiOt/hong08y
	F/xxULwM4akygZJT6qlRqjur3IhRl6m0D7JiNrJLEkkdVI3HEpuGnJQ9UKkiPZnnMayex4ludJW
	b87+pX0XF6bkgmBxnC1rOIPkiucpoHcgmPslEPq67oylJSl13wB0wXmxB5fIDRc7QJvl/bJwadJ
	ve11DTmSPS7PKuX7T1M4gzF0b13KBTDXaaQ9i9iRy8n9A/zlvGJU8l4ez/3RkzwRrPYTbjuXIHN
	Dt9Ts4bSRGQ4udnfDePssDgiaw==
X-Google-Smtp-Source: AGHT+IF8p5dW+JqfXTzZMadH+nj52BF91m/C5k3kYCURCHwkUagq+w+puLMwPaqxpcFS6kqsb0fI9DWLix6fYwAqBKw=
X-Received: by 2002:a05:622a:164c:b0:4e6:eaee:a944 with SMTP id
 d75a77b69052e-4f34b67076cmr8047961cf.4.1765907380410; Tue, 16 Dec 2025
 09:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq4ipwc7y2.fsf@gitster.g> <87ldj6x1ys.fsf@gentoo.mail-host-address-is-not-set>
 <xmqq1pkv5gpv.fsf@gitster.g> <aUEUrXFaAfgzSs12@pks.im> <87v7i6g13j.fsf@collabora.com>
In-Reply-To: <87v7i6g13j.fsf@collabora.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Tue, 16 Dec 2025 09:49:29 -0800
X-Gm-Features: AQt7F2ptbBIjMgtoPnhXJLiHP1yl_23tIHw26ohyqJQGi0oigh1JoTY7wvDhhBI
Message-ID: <CAJoAoZk8AYmJHkFc58LGqn9yengsAd+5iTN-WuFtzBnews7EyA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2025, #03)
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Josh Steadmon <steadmon@google.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 2:42=E2=80=AFAM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> On Tue, 16 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Dec 16, 2025 at 10:59:56AM +0900, Junio C Hamano wrote:
> >> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> >>
> >> > On Fri, 12 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> >> >> * ar/run-command-hook (2025-12-04) 11 commits
> >> >> ...
> >> >>  Use hook API to replace ad-hoc invocation of hook scripts with the
> >> >>  run_command() API.
> >> >>
> >> >>  Will merge to 'next'?
> >> >>  source: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
> >> >
> >> > I think this can be merged to next, since the latest iteration has b=
een
> >> > sitting for a few weeks with no more feedback and all tests are gree=
n.
> >>
> >> "tests being green" tells us that with the current coverage we
> >> didn't see any regression but not more than that.  Especially, it
> >> does not say anything about the quality of new code (and test) and
> >> if it is in good shape to build on top.
> >>
> >> It also is very hard to tell from "no more feedback" if there is no
> >> room for further improvements, or people are simply disinterested in
> >> the topic and are not tempted to spend their brain cycles to help
> >> improve the topic.
> >>
> >> If there is no more comments, I'll try to see if I can block some
> >> time to read the topic over myself with a pair of fresh eyes before
> >> deciding.
> >
> > Thanks for the ping, I've now did another pass through v4 of this patch
> > series. It looked mostly good except for one question I had. Depending
> > on the answer I think this should be ready to go.
>
> I'll give Junio some more days in case he wants to take a look again at
> the series, then send one last re-roll fixing your nits/question and
> also addressing Junio's feedback, if there is any.

FWIW, I also expect Josh Steadmon to find time to take a look at this
series soon, but he has been busy with personal side of things for the
last few days. It's not that there's disinterest from our side, more
that there is a lot going on :)

 - Emily

>
> Thanks!
