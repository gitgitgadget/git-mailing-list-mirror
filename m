Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B28433B5
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455529; cv=none; b=amvuoQm0w8HbbcL2j/P/CUhXreeiR5j9j0qdE07Q8NroauInDqFyMvoUcDq9FaAgOMSiZtnRzuj2cEhTETFmJzOYt5p6sk6NNjL+RvVi5XxVQ6sGl7SDsnidcqHN2ZhxnQtvF5RPLVuVxyM+6O4hb53zOADpL6Bxmf3UUTWVva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455529; c=relaxed/simple;
	bh=V2SzI445eMudCwPXbYCWUwyaV0DgkKz+XdKM/TlMuCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pb221sBe9cEPUdAUE6uAd9frHBtRC5oDslDUR1Z81+aZASfLa8gX9Guthrcgd7xZOh+bkeltHaFx3OP8e5aQcAkfvH2OkwG6wfuNhYs/M17gIAEZWzYXvKRaddenHJUcxQelWn6yrqNp48+JOS4Lc7HFjUBShhEryfHKP/156Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O0LgVt0v; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O0LgVt0v"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c693b68f5so3353085ad.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728455527; x=1729060327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELbrGym9cVeoNcOE4WWrjd7QuiAJKdl7R9RGT1FHNi4=;
        b=O0LgVt0v7Gsw+rXbwi9T1H61E7GBTTTAx99i+BZsDkExFLtFHsQ3Qt2DMK0Jh4/D3s
         vKnsCSHAwC4y3VxJsU/mUpV5hIpU1469sFH7TTLNs8KFlGbPArYiGPTJhte/WVy6TVba
         1tpur2mAvFvnnMd0l+JhoG5opTB46jVTi8zf0pwZIJWazHkcLbH5lsBRHXIHFUAWB5iA
         T/1xNfyNXQl/YYQ3/MzM72pfafrDCMp+UoPG5HAJvXLFM1KNALo69YDF9afjsrn2mBIj
         PDf3e+E4M9H1xJNUbwki6Biq8oFhe1VoCCpeuDcIVss2mzaPpkFj8agdj2puPXrmNWNy
         7S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728455527; x=1729060327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELbrGym9cVeoNcOE4WWrjd7QuiAJKdl7R9RGT1FHNi4=;
        b=RssGw69aWe1Q1j9ThKUeDsaXxJgNUaGoBUyVf7Rx1oDsE80fPtAe0XXo7lxgEE82yp
         wJaph3z4JfYSGu5jCoy3IB9W0WZpuNNRQKyPuHs4D2jUZA5Wv7aZB/rOwmlsfcnLodYh
         zJsvfTQXSU9T+3ZbxR0JjLr7Cel6Vmv/Gx3pcxV5xbgSUPJKAjDypbYW4uN7VRa+gYiS
         h9Zky2Leugd1bN0MZCJcZgSle4bNtuLAYD00Bb0vJHBd+70GR57KZVKrIw8J7PGMF1WO
         YL8nBs1EuJ1RG6ES8svE5mYot9RL1Dn5b7NEkDebjiV/msVQes3NPtNOpMgYcQvEruUq
         5rhA==
X-Gm-Message-State: AOJu0YxdStMKu9aIJ5uEPlNtE3Jz6snVsjmL7d4qkDMIhqqdVYQ2ZnmI
	/ZV6bOKVLe/KLMEoBaC2PexFyZ5eJmr5iT20G+hJUt966anMuiguEJ08WuSki/THwM/da968Coz
	4pLwZHSFNfnoXjynaouzDxSJuO+16aC6aVOG5yA==
X-Google-Smtp-Source: AGHT+IGlgobS1HhNdDPrR70uaMzrNVNE7rw2hkLhrOmL9qEuD9Iv7WKXGadwRFoTs45oq2m0kNAvkeKfBJ2mNjlb1gc=
X-Received: by 2002:a17:902:fc44:b0:20b:8ef3:67a with SMTP id
 d9443c01a7336-20c636d7ccemr22611915ad.7.1728455526940; Tue, 08 Oct 2024
 23:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241008081350.8950-1-hanyang.tony@bytedance.com> <xmqq4j5mz295.fsf@gitster.g>
In-Reply-To: <xmqq4j5mz295.fsf@gitster.g>
From: Han Young <hanyang.tony@bytedance.com>
Date: Wed, 9 Oct 2024 14:31:55 +0800
Message-ID: <CAG1j3zFOMz-C=6xq_+mN2PrfyVcDrrTpMEHpLrrP_crS9J+rUg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/3] repack: pack everything into
 promisor packfile in partial repos
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	sokcevic@google.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

> > Packing local objects into promisor packfiles means that it is no longe=
r
> > possible to detect if an object is missing due to repository corruption
> > or because we need to fetch it from a promisor remote.
>
> Is it true that without doing this, we can tell between these two
> cases, though?  More importantly, even if it is true, would there be
> a practical difference?
>
> In the sample scenario used in [1/3] where you created C2/T2/B2 on
> top of C1/T1/B1 (which came from a promisor remote), somebody else
> built C3/T3/B3 on top, and it came back from the promisor remote,
> you could lose 3's objects and 1's objects and they can be refetched
> but even if you lose 2's objects, since 3's objects are building on
> top of them, you should be able to fetch them from the promisor
> remote just like objects from 1 and 3, no?  So strictly speaking,
> missing 2's objects may be "repository corruption" while missing 1's
> and 3's objects may not be, would there be a practical use for that
> information?

 Some code path does check if the missing object is promisor object before
 lazy fetching, `--missing=3D` does this check.
But in that case, C2 is also a promisor object, the check would pass.
There are no partial clone filter that omits commits, missing commit will
always result in error. And even if we do report "repository corruption",
the best course of action is still try to fetching them.
So, no. I don't think there are practical uses for that information


> These patches are based on the tip of master before 365529e1 (Merge
> branch 'ps/leakfixes-part-7', 2024-10-02), which will give mildly
> annoying conflicts when merged to 'seen'.
>
> I've managed to apply and then merge, so unless review discussions
> find needs for updates, there is no need for immediate reroll, but
> if you end up having to update these patches, it is a good idea to
> rebase the topic on top of v2.47.0 that was released early this
> week, as we are now entering a new development cycle.

Thanks, I will rebase to master and see if any other tests break.
