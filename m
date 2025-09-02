Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4220311
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848187; cv=none; b=ZH1NsbWuv5RAe1WHUo6dG3ganjaavxltqoxJtmIqHe5SLnGsK/JMH3FxIp8AoLemYzfGTinGcEfqXSY80fKuos3rJT+FCG0b+1U3HGGGfZgna75MhtKW9sMIVF8cfXw0nlkpn6osJ3Qb3Pfjmuyq4wDy12wcJHcQAjHJUKDH2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848187; c=relaxed/simple;
	bh=Gjhr7eZhfwaujBtHoL11J/DIhpXe66HJq7CEte/j2cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXFqjCkfEz5cIXxq491JuBvPAJlasRwUYhdB2D+9OOVpkkao+/CsKe8CSO8W9R5ShXVfm3/EUMq9iKDApz3/NQDPYRsuZMP6toIlJGn6T+3GVhzmeyB89Rq0GWe2mz4DOdLoi8qERSFrJCJi0g6pTlU3el9b9PPCE7WCr9he284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMLLJRcE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMLLJRcE"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso4878886e87.0
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848184; x=1757452984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gjhr7eZhfwaujBtHoL11J/DIhpXe66HJq7CEte/j2cg=;
        b=WMLLJRcEpVJ5A2FmVASOdc9Lwp39dD45HIbYo3uiRQo3cGBzJAmJDDqgHCQGkCtGj9
         U5AcLmxUIBY4Y9XatBm5byK9eaKgs2OBeIHN15N8On9jRcydf6U/ibl4WaoC374eQX6E
         lej6HKrWrIXvY86Fqe9t0BKec+0x4FDKQ2f5bw+9saXonkVmN9gQhoiyI40PheYpoV+q
         GEySHkGO3QKB65fvIsvgg65aRtcUk7Hh8Dy2k9lXPKYx+yPVVupCZCcCB1XlU3yOXMP/
         nMRy5s0Vjy52W8IGGn0f5IAApEGODhv2FZrjzhDfsxJDNSJMEgbOt5tZGM7u9U2Uwg/L
         4d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848184; x=1757452984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gjhr7eZhfwaujBtHoL11J/DIhpXe66HJq7CEte/j2cg=;
        b=RSHqznrQv3dlQekH61Ro62rtcouNU9596UkjbkVD2sIBpBeiA7zN0GGd6TdcIy0yhf
         cfdASTnCY3TopWC9hmQpV+CpA2X3XnMUS9/+TPL7Rez5TtwD6ISZMZFYJOd/ldlgdyAZ
         sRMg9hpIUzuz9FJZfbRWps4HJl7jVpOr1q/Dg5109srJTsEDP2ggd+5XqBGN8Dz+7Isz
         y3HhF7iEpzkaGXvaa0KXJxiIqwbwNT9Y7eoavUZpvfz4hRUMEJKHYaPxLqSil4DAaBXw
         lGjYnIf5jRFc50/SLDM4pRANJneyDjWsyGxZWZDLJR6QE8jO9ZqgaTQ6o0+fKHsmq1h5
         Z5dg==
X-Gm-Message-State: AOJu0YxlcMg+khpiHsWVkK+t5MBWz4CXq0EXRpNIa65tYVS+JBYBGh4D
	WrNy6k6VZliDTbbZo9SGw3LvFkKIRr5d0pGDeIm7HGV0sF3EGzxGXZher0ljXTSuNiRThGyVO/W
	XNXAQ20OJecYOfmwLBciPjP+QYGymhUM=
X-Gm-Gg: ASbGncvc5WsVQWi2SLnu6RKbnNHuU3KWcmyT/0n+MMmXxbJ1a9h58u40euQG4B04Wld
	j6sS55OvcAqv0Ofa2kCLhnrySa8dF+7/g9rQqK2qF2MM3LFCEZUFE5oQIfB2R4xu2PM+nkKp52Z
	mhG+EZecRVjnKhObOI1G+30n3Vpaw8D7drLDXUsYez+rOQOOQhqh2dBMUBQYmhqa1vlwJLBIJCt
	+IGvNIh
X-Google-Smtp-Source: AGHT+IEEoGW1eJpa40Tijr4Bc2Xcdn1AO4Rv+0hkgvEp8z6zHegY6bjuZ4gg8BbuDJU8c38t7gfP9m/kABrhyhCMmKc=
X-Received: by 2002:a05:6512:1455:20b0:560:885b:2c5a with SMTP id
 2adb3069b0e04-560885b2e96mr470961e87.41.1756848183448; Tue, 02 Sep 2025
 14:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 2 Sep 2025 14:22:51 -0700
X-Gm-Features: Ac12FXzmm5X-FoSzKKVbt2XXuCs_dkbP9GKtX1wGVg_dmhQkvkZhCTnfKEY5e6I
Message-ID: <CAPx1GvdA3dhWN8b6wORdL1MktdVoJ3E2s9sgoAyUDwFK+7WdzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs/files: use correct error type when locking fails
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Minor:

On Tue, Sep 2, 2025 at 1:40=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> During the 'prepare' phase of reference transaction in the files
> backend, we create the lock files for references to be created. When
[mass snippage for space]
>
> This is buggy behavior since the user is never intimated about the
> overrides performed and missing references. Nevertheless, the user is

"Intimated" is the wrong word (also this is a rare form, "intimate"
as a verb that is, at least in US and British English). I'd suggest
"informed" here, or some alternate phrasing.

Chris
