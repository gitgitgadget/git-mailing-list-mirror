Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B662D3EC7
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322966; cv=none; b=SSdErUfk38qtkbagc8Bq6iRCHL9Q4soLUzeCcsoHjXd6/nnWLjQRy/8l2U3j6o4zaIaP/E98oBt1wIgOyKDF1WoUsXyjbueN9ng/BOj7u+9OZfC084wqFJLhdn0k4j+20Q3D9vtQvYHQhQCWTnlj490oBczguwsukWpa5khHn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322966; c=relaxed/simple;
	bh=qczevuJyAD67B7MxwSqPNLNZJueiylXzEoKoPf8r54o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJIevbrQgl5zMPpZHzbxMpkxu972KXfUneoTp3LUwoaCmcRjdfwuwje2Rsc/PIGZ2uFu1wx3rjcC85hcFtSXkVUiv7jxij9rQ7teVyabgcmENPpy8v7oG0MZAnTdHVrcJdtgO9CvUP0j9+A2b3kj7qfLpNVHIX92wCohvWtaIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Epjwx3gX; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epjwx3gX"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3652d7800a8so8516481fa.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758322962; x=1758927762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5NYA1cOMHPgo0Vfb2AU2xngM8/7ivmTLIxuSwp4Psk=;
        b=Epjwx3gXNdeVD6uZz34AlNLt7R9UxI7x5rN9VQBD7Xhev4JM1Ar8PsLeqeNS/Zd4WD
         oKePzBvgcn1UA7oMjhj8OkOcZatVzmjnZ/Sw6nNPYtUA4wQP4KwMx76jtsso/SjvDGsp
         ZsoXnZXWDsFtBsBGc50W/AdlSyPKFUEoY9nQju6BewswdMbByEsjB3Dk/xVHuYCl1IRn
         O1M0YcJdoR2SMcp3+zKGPmY0/37QdIZcxk3AkYpB9Z69kGzfT0U/BsrJObCH+k5TjRH2
         hpkSrBRRM/Z0n8UT9Qo/WrZB6pgqtw82kFEMSOosPijWzHwHNqD3K5/WLEaC+6UsVbSG
         uwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758322962; x=1758927762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5NYA1cOMHPgo0Vfb2AU2xngM8/7ivmTLIxuSwp4Psk=;
        b=NedFAJtVYTSYZ8nxcS1KKFcVrZtPOK5PVRVyT4q1ztNkHC6skiAlm9OUaCqudDZtrA
         WDPcqXFZqKhSDewsbYqWHg/R4KkPYuKS0NlE/pzi3Ui+qly4IycdLyMegoHWp3kHLAwf
         Ux+9L4PFXNBzv40rBo8EU0MaIC7AqI1Evu4LtnKB1GtkY/w52anUpl52DlB7ZdPZlekY
         Yx+bvZXhqg2yLkg4oQdcSgtoQEPX4g3RAUx7+XzOEj9Ot5aN4QpZezQvnnZoe4iYW2tw
         qpEl+2zq/WVg07B38mw+FXhuLNg7kNfuRdRM9msp8ebgEiS8fdhfasTa1oiF5/Ud5a/1
         hpZA==
X-Forwarded-Encrypted: i=1; AJvYcCVWPUxODGmy5yTsZAxKQ25XifvuAKNczYXGKOeVy4BRA+e6M5szNXVSid37OFK5xqDPR3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKagc2jn+9IFJD+0PakPzJ08Wcf7XFf6BSY6S6TqMA1SYr7KBt
	pLPKry29FyE+L0e1jq2ccBw3jT95omXyG1Luk92OfiyAEYVC+WXvJMgZ1tjskMu0DaXMQX889qs
	5z3JKdcm6ofhzyHY6MsCp+5XNOigaI38=
X-Gm-Gg: ASbGncs0M1sWt2gvJTkdQ5tToxAM4byIpiGUCNO/ZIh47aIFRUAfsiaRpS1nI2t3ADu
	hoi2r0nvg7Bh/HacKzP14Ea7nRkUSDFbrgRG+rl4+f9D4x8R3LCZQcMtiXMLKXFdGUljWpZCIQo
	qqY42X712RozAVymiBVk6wTylE1vyUhczTJruGpoOJbfxS5XxkIa2+vCqwCYGFGTo4mDhnXxQjF
	yGCbtP6
X-Google-Smtp-Source: AGHT+IE7D2cLzNVWZmywdm9oBHeGNAkT5aZriINBKjf6AJE9GR+Mt5An78yEw+lREQKWwWTmvyIlUEgzh2wsqqshnlY=
X-Received: by 2002:a05:651c:3257:10b0:360:5e8d:c85f with SMTP id
 38308e7fff4ca-3640eae2646mr12543071fa.0.1758322962241; Fri, 19 Sep 2025
 16:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <3061cc46c1910bdc4f66855db7a07d313b37fb27.1758071798.git.gitgitgadget@gmail.com>
 <xmqq348i5kqx.fsf@gitster.g> <CAH=ZcbCRzGGR1RFTWV1Zo7bm+DScx=zOJ=Ov-WkaQNrDN9w1Nw@mail.gmail.com>
 <xmqq1po242uo.fsf@gitster.g>
In-Reply-To: <xmqq1po242uo.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 17:02:30 -0600
X-Gm-Features: AS18NWDj5CJgIH6ACg8jGIBkPWAM8MBc70OEaHWZVBFu4XcnoygJ87x_3bELfg8
Message-ID: <CAH=ZcbD8zyw882D3HNSVNhovVCMO18fsJy6k5UfXncXv0u05dg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] make: merge reftable lib into libgit.a
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Instead of rolling everything into LIB_OBJS directly, wouldn't it
> have been much easier to work with if reftable-related ones are left
> in REFTABLE_OBJS and then RERFTABLE_OBJS gets added to LIB_OBJS?
> Wouldn't it have been less prone to mismerges to do it that way?

I didn't do it that way because I didn't think of that. I prefer your
way because it's much cleaner.

> As we can always extend things more, getting something close to the
> minimally viable set with some tests for sanity checking would be a
> good first goal.  If you pare down way too much, however, we may end
> up to be pretty close to what Patrick sent out originally with the
> varint conversion, so let's make sure we do not drop below the
> minimum that still demonstrates that we have Rust integration that
> is viable going forward.

I'm torn between A and B from [1]:
I'm thinking of choosing A because my approach and Patrick's approach
are incompatible. In order to use multiple crates and ensure that Rust
is built and tested the same way with Make and Meson I'd have to rip
out lots of things from Patrick's patch series.

But maybe I should go with B because there's a lot of prep work that
should be done with Git before I can start doing what I'd like to do
in Rust. So let Patrick's stuff merge while I work on cleaning up
xdiff and updating Makefile's libgit.a build process and then deal
with ugly merging later.

I can't decide between the two.

[1] https://lore.kernel.org/git/CABPp-BHJUkSERQon6xx=3DsHrhN7i=3D6ekv+Hz1+P=
+2mh0=3DXw15Mg@mail.gmail.com/
