Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A81422AB
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237823; cv=none; b=iP+gf/HA1HSbxmhCUe7BPjyJG5fZvUF0zNJyfeFxoqj4aEQGhyfkOovnZFTo+nMCNzaLXuZgxaT6vQl+74zRClCZAyuz7WnExqU/2c0pis2rsaWsl1CR3Wd4VHc7IeMpv7Wcm2GFNUG4CLAebZVsqJOs6H+FIKU5Awa8+rFQg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237823; c=relaxed/simple;
	bh=IMhxAUceLyA5A2ri3R4SuVsm1kRiLqpCAZe0tEVBAJw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BOMKzY9Wf7DD5S7KH2mTVB8tT6exkaVc4jHHFpw+xpkdeRpQRc9dPs5V7eAjcV3oGsmMyfqHgHNcdr0YAN2rJeiJHvbzn1YfAucSGcZIHhnHj7GuslTjuQ3Fo6gjpIIVjwbzdIbXJgqo7IQAo5+OUxoQ8Rr2i3kjCSqaTlfkzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUcgsHN9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUcgsHN9"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so9890096276.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730237820; x=1730842620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d9GNUWcx1LS1tgNBsJKMySXQJpgtxn63a/7Y17p3/jU=;
        b=hUcgsHN9cd7wuDHVwJIqbJpgw90DhQ2YvjK96aKXt53np9Cog8CoXQI2sD6H4qQmOY
         3guK4ryVprc57me471pgugUd7glEBXxyjbxG66ZaAtmFT0TesTYTkHg/12hD+3ICW4EM
         AkSaLW7mc7F6TvP9KIoMYGTE8o9tzWAvQRrHE6KTeehpJ1oOTmNGqx7J3SQftz6DRYaV
         t9aetdQjDSgQwFQ3VFEkapuYSpT7IqgxVTtriJ+xBKLC3J0mP77blBLjmkmg5/fntT98
         a4/Xa0smfoF+4/IAqIz9IDitAcsoCT0vBj4uM5sl62Vm6XQPC/L1T1uKtf3sAcZZrWfS
         3GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237820; x=1730842620;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9GNUWcx1LS1tgNBsJKMySXQJpgtxn63a/7Y17p3/jU=;
        b=bOsCtvMieRhpxBu5BCZHMMlZIDF7zu3aQQdZgKchrdRNF4kJ/bxSDrXGp+RQ9cshRY
         +Yzb4jLuozFjBnz9Bgu3jteHuFeKS//2P+PZHzoA1wVHCLSsgSqCD9j00JWre5hGTSF3
         1yMqxPkTJhWJk8tm3A2LE3cSoxzuAOgh2gfVavdxt+9JRE90opHKAlCtpHX4Q9RcNs26
         FdvOjKamF9XRg4FcpS6uUttrcEWL1N0ssmFnXI3gyRCBgE+p1mAfTXwy44xdo5xIM2ws
         gDxVOq9F7o/jPEhoeA1VZdSkccuE3ctCqXm8ivJd3pdSmt0kLByaOJhMLQcHtpeuPnIF
         Mwbg==
X-Forwarded-Encrypted: i=1; AJvYcCVkAJwMzbYlssD3kn1wpFbHTh0vmG7bg01qTAGJfsUMaluqKUcgNeH4wKAx7nQYvDZRyfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0YPRzbgDtTVMGuDoRkBg/kd3UzGWzU6W3ch0EecZ4H+PZY3j
	aKvm7tM07GWUAwayc1A+srsd0SeYYNr2HC/2yzNg3eOk8Y5Be0IbmtYtaWhtDKmP+llr2H7Flzc
	OjNgq65RxwdH2BbKWIENL/S3x/77b8g==
X-Google-Smtp-Source: AGHT+IHQWWij+aehZ3c9zMVqseP9LsOosUu4KMU8dtffE8HhL7xxA9I63mJJxeB6kLeQMzymFfQyeIQ97rn4CGYMmWcj
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:c9ca:c50e:3acc:7e6b])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:181e:b0:e28:fdfc:b788 with
 SMTP id 3f1490d57ef6-e30cf4d455bmr777276.9.1730237819852; Tue, 29 Oct 2024
 14:36:59 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:36:57 -0700
In-Reply-To: <ZyEkWyB/C/lGb36b@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029213657.1303762-1-jonathantanmy@google.com>
Subject: Re: [PATCH 08/17] pack-objects: add --path-walk option
From: Jonathan Tan <jonathantanmy@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, 
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, johncai86@gmail.com, 
	newren@gmail.com, christian.couder@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:
> Is the thinking there that we care mostly about 'git push' and 'git
> repack' on the client-side?

I would go further - for the initial patch set, we should only care
about "git push" on the client side. Stolee said [1] that the "primary
motivation for this feature is its use to shrink the packfile created
by 'git push' when there are many name-hash collisions", and in thinking
about how to reduce the patch set for easier review, I thought that to
be a good scope.

Subsequent patch set(s) can implement "git repack", useful for both
client and server.

[1] https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/

> I don't think it's unreasonable necessarily, but I would add that
> client-side users definitely do use bitmaps (though not delta islands),
> either when working in a bare repository (where bitmaps are the default)
> or when using 'git gc' (and/or through 'git maintenance') when
> 'repack.writeBitmaps' is enabled.

I was thinking that a typical use case would be to create the commits
(using the tool Stolee mentioned, "beachball") and then immediately push
them. In this case, I don't think there would be much opportunity for
a bitmap write to be triggered, meaning that the pushed commits are not
covered by bitmaps.

But in any case, this was motivated by a desire to reduce the patch set
- I don't have a fundamental objection to including support for bitmaps
in the first patch set.

> So I think the approach here would be to limit it to some cases of
> client side behavior, but we should keep in mind that it will not cover
> all cases.

Yeah, that was my approach too.

> My feeling is that it would be nice to pull on the incompatibility
> string a little more and see if we can't make the two work together
> without too much effort.
> 
> Thanks,
> Taylor

By incompatibility, do you mean the incompatibility between bitmaps
and the overall --path-walk feature as implemented collectively by the
patches in Stolee's patch set? If so, I suspect that we will need a
parallel code path that takes in the "want" and "uninteresting" commits
and emits the list of objects (possibly before sorting the objects by
path hash), much like in builtin/pack-objects.c, so I think there will
be some effort involved in making the two work together.
