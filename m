Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AD35B13C
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761537724; cv=none; b=iEQK/WXB0LFYTiOQuVPnuOwfCKXQKGl++xJVqkOInEUZX/hBxg1dqU7GnQfNi0m2WP1pJA2WmnppD9vzyj05mkpsE3EFt9F4ial2C7yopGwCYujxTbMSfAKLuB33hZDN0VDG3wl9kwMhMER6NF3aYF8CLSaSEYOZW6WYszf2hhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761537724; c=relaxed/simple;
	bh=ooQEVTMT8nBpX/KrYh+ECkXoR6aiUS/w6QbKbM9ydOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQlZ5YSxvKNYFbCiM3uhRKFSnk/trLTPQyvpwezeePlycYOHR/69TfnG5paN3BmUIEhwnF42X74h3fqDu8e+5z7pxpPux2BY/6Tlr0INGt13io+hsvtDzwg79LFXXPptiste0fdk9bMfwVGZ5NYK28f7t6FfpvRn1bEA86U/IyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj2kauM3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj2kauM3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4539dddd99so894897766b.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 21:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761537720; x=1762142520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooQEVTMT8nBpX/KrYh+ECkXoR6aiUS/w6QbKbM9ydOM=;
        b=Xj2kauM3nnm/9AQ7rrgjF69J7BklWEWDVSGRmC6izEBSXAZftB6qw/42yVdvsnJ+e4
         6S6Q+VXWAgMKJARA2EuubHFOvLfQu22bxxQZWyThwufpy598U+cttBbN2G2DFT0/9ayf
         Vb3ynqEKbs1W+uDF3xcDbnGXq2DU90i7uWRuStY+RjxfBz3vJ7XIOK24Rasz5VDN1DPE
         OV4JbCZUkFsgsHUgN3H3nTYd718hpG1XcYIypWcHUe462FVOfFVQFSHiIG9GynXZb0PJ
         F8V4Af495RNBi5442KpYf6aKT0Pf20kjWsRWHKzrw+dgK2Ma8qBIJoF4mPPzd5uCCxc4
         qtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761537720; x=1762142520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooQEVTMT8nBpX/KrYh+ECkXoR6aiUS/w6QbKbM9ydOM=;
        b=m+iaP+nM5bIt0lO4G6ML9gTgnozJZqCStt93ptPAgQkkJwBaJdSrM54d28c4XkC5Du
         doNzy5OjNL2ebnAOrxdaVAVTpvKWLyAGddt9thq10t9ChzopPCr1Fsx085EYW7fN6iY0
         Z2ID1QnpxWT55AIviv7CRqO4wYN8GHb1CsALOGS4JhJNxQmVRjxQUbbNLmRJjNJ9u4u9
         xlK719IeIkEUOpNXqrjZnJmgktjYjFc9hNS5v14ZvcK0R6hijzdE++2We3xcrib9PKkZ
         Tuy8CP+e55drzqukzAK8f0XpAcJ6AcLryHnz2gK6L//la5FyfkA89/LDb5tqUC8FB2tC
         NidA==
X-Forwarded-Encrypted: i=1; AJvYcCWCo8r627d2y+hid8sbTsfTsCtdl76u7BQFH2hg9Qo+eReKaQ0/YBsoAJ7oexGozhjp4dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1X3GP/ZmY8YMTrVUVd2+qh4gw8p55dri720fxFfPcu09biUS2
	j5o73Ffteq8LrKRRjIm0sZiD8uJwLjOw2MAAQmU8WMFU4QnmsWwjNQsnTCiYeIPzxHyt7IV0xK5
	kXnnzXYmN5c58akDf3K/196oiUZPOxrE=
X-Gm-Gg: ASbGncsBWEGfYvh7rTW8kJ3/bHNrBMySBl9oNs7ez8ZIS8ruSoluKAchgUh3Ec4NM+Q
	Q95uuu4wB5t0idTeYAiOkgVlUtzsgAkuV1RN1AsCwDQ0rUIMPjGJh0sHFbRivwew0oCjzLr+ryb
	w72JSas9SQOlsmWjbswOJaFAiiq3M1HpKURDwLLBlWDDFAXiArJtJdkkz8rrAXRhYeLHAILj8Sv
	367rOM/ANCK9XEhyrmIaF+pJG3n33QVhRakJ2XTcxZM/+9kjD7Q2NHazr5P24YEv1fQg7DU
X-Google-Smtp-Source: AGHT+IHXRnQ7p7daNcKMUvVcNyLnnrepfgyTgUAGmGke/0fpT2ZBX/oGTQ7N+H9IsBxpzIiQCzx2ZsO99wyYQdRPQ6g=
X-Received: by 2002:a17:907:bb49:b0:b45:eea7:e97c with SMTP id
 a640c23a62f3a-b6d51c30f7cmr1311731766b.47.1761537719610; Sun, 26 Oct 2025
 21:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2082.git.git.1761295094982.gitgitgadget@gmail.com>
 <aPtCvwvNUtFXqrpv@pks.im> <xmqqikg4qqn2.fsf@gitster.g>
In-Reply-To: <xmqqikg4qqn2.fsf@gitster.g>
From: =?UTF-8?B?6Ziu5paw5a6H?= <r200981113@gmail.com>
Date: Mon, 27 Oct 2025 12:01:44 +0800
X-Gm-Features: AWmQ_blUZXvbs1bMJuWX2ZGjGlpF1hmeUM3flTSD8fkyE03vduxiXfVyyish-3k
Message-ID: <CANWnLjtWWOMtSKyB4275ZPZM65xkyNMnaF8u+v62tqgrOb_ByA@mail.gmail.com>
Subject: Re: [PATCH] refs: add missing remove_on_disk implementation for debug backend
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, RuanXinyu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	RuanXinyu <1096421257@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> >> Signed-off-by: Xinyu Ruan <r200981113@gmail.com>
> >
> > Tiny nit: typically, the author and DCO should match. But the autor is
> > "RuanXinyu" whereas the DCO says "Xinyu Ruan". I don't really think tha=
t
> > this is something that warrants a new version, but I wanted to point
> > this out anyway so that you can fix this going forward.
>
> It may not warrant a new version in the sense that I could tweak
> while queuing, but I need to be told which between the two is the
> name to be used before doing so.
>
> I can make a guess and use the latter but it would cause me yet
> another piece of extra work if I guessed incorrectly, so...

Please use "Xinyu Ruan" for both author and Signed-off-by.
Sorry for the confusion, and thanks for fixing it while queuing.
