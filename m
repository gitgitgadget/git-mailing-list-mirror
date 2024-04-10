Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608B38D
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712711621; cv=none; b=J0XMl9O3TvDOgJXe2nVPNhcCG0inplXIIWDddOCN6oB+dF+qGTqozSAx/wKSHMyk7hw1fLhlh/9X+Gy5gLGkU9ilvKqW1TJB5pW+K4tIUHoQmsK9u4pAnirnqvi//M4lS+3qoSB7fBcqIEmdAoY0kzMQNtQ23TxWNIC8XyfHOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712711621; c=relaxed/simple;
	bh=h/eh5Kf+J6J7HVWwayp1+OTxriSW7UB9GTcgyk3gFh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WUu7CTbHO11+Q9q5qY7TUoZUiscr5K2/udw+J43wY7QR/4/3u5vp7D+wXuujvJZSxDPIktsK6wuEZHcZqWBxkYBYsKQJBAyqJMijGKixX6uAMCo/OIYjFXhgYJnSJtQP1jDGErAIh2BRQNOtUGN47+e5hBQbKRbbXwO4BRD4iws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0mZsq+x; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0mZsq+x"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e3c14a60e3so37508025ad.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 18:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712711619; x=1713316419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsusbrCJK1Tzll14w3eQPYMTCqDp61VlVAvT3yj+NUw=;
        b=l0mZsq+xO/B8fdVq//WdREZ+fnpF52oAkgN/NHsBZbaRewUVMD+IJYAq35DW0hlEbJ
         n5ZjEGitsD9j8EXFRu1CQaAfbMKBhUH+gnYFeihiEX4fKR8ioUx7zOCTllxy2US8n8Dp
         c38qVXL/rzkbEwsWTMZdyMJkyIsEa0y+aNLwQ8x0TZhG66BGPwK2rWl95i7usM8b3aeL
         lJ/xReTJhZ6czPPMnl79cv4Gfj87qmk7YFkQNOtxuFLggzuq4OVqPOtKRoLfT4ZFuhGz
         queqyJ+rC4sPgiI9jSpgYz8vNUBDp4rrJRSV/NpErmZDmppRVZrkT7erTuYU1pNX8yrG
         DyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712711619; x=1713316419;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RsusbrCJK1Tzll14w3eQPYMTCqDp61VlVAvT3yj+NUw=;
        b=U3kgKCLiokqsWMsHn95lUnLjXl0wZZYigGROCxgtLdW0IDKvH4lBw6ElzMxBq+QlpS
         6oOhYBkcPqe1BFwYoFs4bOrMEcFCeybcCFGCfr9t8MHZH+RlczhARho5rJ72ttG7r5EW
         kshP+PNLNUBx0gxsi4QssT8ShHjSQ+xeWVruhdSd+lxHoa1nyUUCsX6rbQDcgWCpxojq
         Bl5mBOMQdJqqEvuaoljMGjOboO3Rwu0yYVUCHe1Tg4ZiZr7L3nvG8bqSOpJstn4oPBvj
         xMNOA4Jdu0B8OJ6wpDleWGWYTXvjIY9/s7yZR+g6qYNtXS1t1wUhOgcmHtKVERAJ1Q1r
         NSZQ==
X-Gm-Message-State: AOJu0YyhCdmWB3/PHOZprFbacBqhxOcl4DehXM1zxH/dJxjuL9vkku0M
	Skg8vdSF4aWQgf1PvpgZr+ozYcUxwPrM+HLXDixYGfwAoL+A2EteF9uzFZt+BEAUhal1ceb0rVO
	PxA==
X-Google-Smtp-Source: AGHT+IHMkg6dboNpnnSM1HaRUHcQT2Vi53K52tx4/GEz6u6BBhhYoSxOwWlrP1Ob0TyehlVM0R9quWbzERY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:f54e:b0:1e3:d11b:5368 with SMTP id
 h14-20020a170902f54e00b001e3d11b5368mr4358plf.12.1712711618835; Tue, 09 Apr
 2024 18:13:38 -0700 (PDT)
Date: Tue, 09 Apr 2024 18:13:37 -0700
In-Reply-To: <CAPig+cSw5wsYpm4Szk6HzgT3u+wMVz77NfqR1rLJrmCzejxvmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
 <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com> <6f71b1731f2aed9c2f4dc101bf4349344b575d73.1712699815.git.gitgitgadget@gmail.com>
 <CAPig+cSw5wsYpm4Szk6HzgT3u+wMVz77NfqR1rLJrmCzejxvmg@mail.gmail.com>
Message-ID: <owlycyqyrpdq.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 5/8] SubmittingPatches: discuss reviewers first
From: Linus Arver <linusa@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Apr 9, 2024 at 5:57=E2=80=AFPM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> No matter how well someone configures their email tooling, understanding
>> who to send the patches to is something that must always be considered.
>> So discuss it first instead of at the end.
>>
>> In the following commit we will clean up the (now redundant) discussion
>> about sending security patches to the Git Security mailing list.
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingP=
atches
>> @@ -397,6 +397,36 @@ letter.
>> +After the list reached a consensus that it is a good idea to apply the
>> +patch, re-send it with "To:" set to the maintainer{current-maintainer}
>> +and "cc:" the list{git-ml} for inclusion.  This is especially relevant
>> +when the maintainer did not heavily participate in the discussion and
>> +instead left the review to trusted others.
>
> This isn't a new problem since you're merely relocating this text
> (thus, very likely may be outside the scope of this series), but is
> this recommendation still accurate?

I don't have much history on this list to know one way or the other, but
it would certainly help to double-check all of the advice contained in
here for accuracy.=20

I also think that we need to add some more structure to the
SubmittingPatches doc. It is currently pretty long and could use some
help in being broken up a bit more.=20

One thing I noticed while drafting this series was that we don't really
separate minutiae from what is _really_ important. For example even the
advice around adding "Acked-by:" and other trailers --- is it really
critical? Other than the "Signed-off-by: " of the patch author (required
for legal reasons), it's not the end of the world if someone forgot to
add a "Reviewed-by: ". We should do a better job of separating
absolutely critical things that must be done correctly to ensure smooth
function of the review process, from the rest that are not so important.
