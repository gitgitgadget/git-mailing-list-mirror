Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7251BDCE
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710612890; cv=none; b=j2tVREpIuqDWrTsZRCcAE4RDn4BDUB8L+mxTrn0rw95L5s9OLJawhr5CIW/D+DotR4/QftrDeuf2VCEGkYKWOzPh3oH2ag19jMIesMYqZRMaZhIn6kLwzVrKtOxL5dQDw28t2ePPm1kHIUwjY1/GgUenaw8hh3yOqCQ91HD7b6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710612890; c=relaxed/simple;
	bh=GntCOm2aKxTjfDHSovnK3IsRtNMx0bvkmfuRB22Mu+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TCusGBGcQK3Y2/7BBlqbNC2gWYylUbk7sQ4BlPh/A+EwIDtWlLouQpB6Y4eFFNiyWUQpH3Vkw3guXY73Ugqq4IQg5XCBE0PeChgqjd42RVEhVbhFY9oxGC3TSE2zGy8VShT/t62fjniGynsh130yFzVdKaDAW/3c8KKlVlfpOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGQ/S5P4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGQ/S5P4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-29bacf6d11eso2581175a91.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710612889; x=1711217689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pip1XRx4jrQkLhgKc7p34gp4TxOLPxEdpQuqY1H894=;
        b=FGQ/S5P4Gcl9BpPA/VerO+7RqNnrjBoJ37TiN1NgZt02DwOVEymTQ32T30pZxbpr/W
         N8DvCSZ83jEFUfoIZj+mO/J/oss94ddFFByMvZkj9FSqOHyiv7olPlfLNzikWxZNiNGT
         84gUVy+UYjxszvAgdSp57hD0f1VSILk4PNvh8Rn3paIE5i+4o5C3M+kuPyHDADHFqBSU
         2CispjWNR72TLJZUr8xZ0kPI36bClf9d4GXdF0oex3uzcviY4qbENhttoRrfeyUPz8NF
         9sMJ44bn1WP0wMBhsECm/0uvEUV7Bdg0V6bV16x879fDV9h5T20t8kcdaULyP2mJt7Ck
         Mk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710612889; x=1711217689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pip1XRx4jrQkLhgKc7p34gp4TxOLPxEdpQuqY1H894=;
        b=i2xEncYRckKtChedBimxiv4QUDf430K4VMBpMRMsI6Up3OwbXs7egR2iwkik80qtyW
         94D0wmvJibA9wx0dXMSZ/TmIArDRvfqqroK1PdzWaI8WfzGASyecBd4UCQZTitc3UDoz
         blaTriZomBLEL/gylpYfTAmVTUJ8c5qT0cRk7XY8UZj3Xpap7o5x7909WvUicosjSgOn
         HirMe7MmunjM9RTNcSSsI1KoIaykmwY9ehMM5F++W5umCt1Ac9XxZgyv7I5oAWKfNcJa
         wzURw5mULRl7K3BL6PVfzTbBfANwFvWoOmzsPeCm0c9tHTTZXgqZGQ7lw9fNnDM+pyiR
         Phmg==
X-Forwarded-Encrypted: i=1; AJvYcCX+PKLJ3Wf/GlXFHP6OCKGbeCfjNeyF02nqptEB5fk6Az6hGp8/DZRWZxvdFC9cPG2KFRjhk16xA37bQyxxzBp72G/K
X-Gm-Message-State: AOJu0YwbA6RwT0tVS6HyqwPmg2tb+jeHihcRxzeLtyJsvIkx3C+lgLcy
	7vz9s0YYJM12jrFyDGeS8pxAvceEbX8tVsiB2OB/pcJxizwdy4johKqPmpx29Qalie9QZ0TlELy
	v8w==
X-Google-Smtp-Source: AGHT+IE5EkGTv0Ahi8wpjw6tA4PV/DIwINjB6YhvTc2gWjd8ISGvgLGdNJfA3Dqkn+JDaTXZUYepC4PDYao=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90a:d511:b0:29d:51ce:5a18 with SMTP id
 t17-20020a17090ad51100b0029d51ce5a18mr23494pju.5.1710612888521; Sat, 16 Mar
 2024 11:14:48 -0700 (PDT)
Date: Sat, 16 Mar 2024 11:14:47 -0700
In-Reply-To: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1682.git.git.1708882423691.gitgitgadget@gmail.com> <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
Message-ID: <owlyy1ai2gdk.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2] userdiff: better method/property matching for C#
From: Linus Arver <linusa@google.com>
To: Steven Jeuris via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>, Jeff King <peff@peff.net>, 
	Steven Jeuris <steven.jeuris@gmail.com>, Steven Jeuris <steven.jeuris@3shape.com>
Content-Type: text/plain; charset="UTF-8"

"Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Steven Jeuris <steven.jeuris@3shape.com>
>
> - Support multi-line methods by not requiring closing parenthesis.
> - Support multiple generics (comma was missing before).
> - Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
> - Remove `instanceof` keyword, which isn't C#.
> - Also detect non-method keywords not positioned at the start of a line.
> - Added tests; none existed before.
>
> The overall strategy is to focus more on what isn't expected for
> method/property definitions, instead of what is, but is fully optional.

It would make it easier to review if you broke this patch up into smaller
chunks. For example, you could do it like this:

  (1) add tests to capture existing behavior
  (2a) change method/property matching behavior, one thing at a time
  (2b) adjust or add tests along the way, to account for the change in (2a)
  (3) repeat step (2) as needed for each of the bullet points you've
      outlined already

Not being familiar with this area, I don't know if (2b) is easily
doable. But if it is, I think the overall effort of breaking this patch
down would be worthwhile.

Of course, nothing stops other reviewers (who are more familiar with
this area) from chiming in and LGTM'ing this patch as is.

Thanks.
