Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E926154BF9
	for <git@vger.kernel.org>; Fri,  3 May 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751315; cv=none; b=r3Ndo5ubFRtQNWcPyEK2FgHWsaL4BVMzKTqZ2wSPpM8GcWU3LntU8Uhn7OLQKAgEDCXWTkOvWbALN6XPdGM7ONGB6XexkLihyFl1qCzBLyydT9QD5k/YLbAIUYpzUbxkqKS3i/NiEhEUeockAOgIqfOfNjrGJCERIk7oO2GlBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751315; c=relaxed/simple;
	bh=ClQC8VSlvKJBh2I6Ccj/0WRIQBZ2rOynUTgahFNzYpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNvXslWbzGWG49zw2SgCDdCa612PHZx3hZpRMvNrWx9o+oCz17rQiyasjc9aHmehNh6EEK5I2bnUxXiXcQH7BPGCrektipABmbj3V4ow6G8UVQtr+lOOjdCP/iaRznO+EcPqJnbI688u+Jdlsnt9iclZQK5hEj8149Y5fjwjSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zeN7QxLw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zeN7QxLw"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-349545c3eb8so5940311f8f.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714751312; x=1715356112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClQC8VSlvKJBh2I6Ccj/0WRIQBZ2rOynUTgahFNzYpA=;
        b=zeN7QxLwL/ZkYlzdBisse5QMzg5ENpXCiq0eusUXNBa08ok9ssMHuv+Ou4Vgp1W7EX
         96yBQy1zBj91dfde05I6+VNqzrvwGyH1UC+0N+SCrY8m5ohajP1rLUkrXtqJHGwD4jxQ
         czNopdhLcV/GesyfJ++T5kP8WCdpNaVWukBgrjsdiwlAmg3pc7/AnmEbbQbxXBPu8tDT
         nekYplViUMy2pOr6SgVyPntfn3vq5TlpiTpl68liyuhqyvRvyoDepwtnBf5edtXt5AiI
         1oMUW9FuY6przXqVJH/CIqKDALVCJP9s+EA4BkalYMuHn8CF0DUmKrxNt7qIGc8yU1HP
         O7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751312; x=1715356112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClQC8VSlvKJBh2I6Ccj/0WRIQBZ2rOynUTgahFNzYpA=;
        b=ERzySsWvAekp3fAmIaCUxSDWZ1/c6DBjhlK+P8hVwNWkJJ9ydVyJdtfGux2l55/FcZ
         GSOMR+39cB8gUyAXes4v/tG93l2993cjxwY8vTJ5m7I4kNWIwNksIW0gfVQ+uEETbFWN
         PzUc1n5yDHGcct3xaETC7ZE6zwLmSABYfAPyt1QWymVBWiBCJLGjqjVkIVrSyjZSF8Ij
         hfc467urciPoxQhh2RdJTvEdT9TI3DSvS4ikzTdx97CPzywgcow5fL5qlPASMgPH7yi0
         pQYDgtfEpHxc4j916n12H1XqyjXHiNMnQCP+tsbaVkv0Wbo1PtphZoiL6kXTZE2w2dkg
         5XsQ==
X-Gm-Message-State: AOJu0YxAs27ZVKiGg8ado+Ln/iVDItU60B4AfHXrb6qNvii+rWN9+5vM
	rGKL+o1l3rnhyFZJqQX0gmWFn+r4IiIplxNMb0FkkWiVs966WRBgQHFGSFWLsQxt5ERf0zX7iw7
	1ymMJy9sAJQiXce0nNmKgMI8FqvKel9GW6fo8
X-Google-Smtp-Source: AGHT+IFD8Ttl+zgntGJFjj4Qnf2HjfADyQpQ8y8lBxftXz0P0ZIo4+WjRpcWEkYgLEo9C53McJEpE5G1zJq8w0uJXPM=
X-Received: by 2002:adf:ef49:0:b0:34b:fc9a:6ece with SMTP id
 c9-20020adfef49000000b0034bfc9a6ecemr2211413wrp.33.1714751312429; Fri, 03 May
 2024 08:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <20240417163244.651791-1-emrass@google.com> <xmqqr0f47wp9.fsf@gitster.g> <xmqqseyzar96.fsf@gitster.g>
In-Reply-To: <xmqqseyzar96.fsf@gitster.g>
From: Josh Steadmon <steadmon@google.com>
Date: Fri, 3 May 2024 08:48:19 -0700
Message-ID: <CANq=j3u5ZHYbJQjhwtnq05GocOE_AVrHodjPOqVCNN7OZHwVsQ@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, avarab@gmail.com, christian.couder@gmail.com, 
	me@ttaylorr.com, Enrico Mrass <emrass@google.com>, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, sorry for silence on this thread. I am working on a V2 but
probably won't have it ready today.

On Fri, May 3, 2024 at 7:45=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Enrico Mrass <emrass@google.com> writes:
> >
> >> I'd be curious to learn about norms or practices applied when no conse=
nsus
> >> could be reached. It seems worth elaborating on that as part of docume=
nting the
> >> decision-making process.
> >
> > I may be forgetting things, but I do not know if there is a concrete
> > "here is a norm that we have been using to reach a consensus, not
> > just written down but it has been there" in the first place, let
> > alone "here is what we do to resolve an irreconcilable differences".
> >
> > "We discuss and try to reach a consensus in an amicable way,
> > sticking to CoC, etc." has mostly been good enough for our happy
> > family, perhaps?
> >
> >> ... However, nothing
> >> in the current description strikes me as specific to these larger-scal=
e
> >> decisions.
> >
> > I agree with that.
>
> We didn't hear any more comments on this topic, but writing down how
> the world works around here, with the goal to eventually have a set
> of project governance rules, is valuable. Otherwise loud people may
> act according to their own (unwritten) rules that annoy others and
> harm the community.
>
> Thanks.
