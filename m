Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0D5D8F0
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703037; cv=none; b=HEzx9WW/hbJFAohJrjrmDfZlRWwCs4WA+O2t1NKnrAo06BMW704p69wuIt5FOAQ/KGVS7vYuEGZ0eLn+jAUaGax7+NxolRZb0e5qWJC5bX2cyqvBStw11CLZjfcitz2UEnWGOPPWrBUiA1XZOwUJS9JWpgTi1pYhrg+J5suJvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703037; c=relaxed/simple;
	bh=aWjgWd7VL1jM8F3cyNSORYX241cA/4ivUikXKDcJ2nk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=X3dG+0FgUVE2QiPD7Yy7n3urPY2dC2cMLVaTtH8UOf3WcbMkoTcR/sobxmUkdnZ3rE26SUxwro0uPwlx5nu0YoenY9czKJYb+iZJ/e2GuFqYQwN++BtdcYjK8I9a+/YoCxv2i/yB5AzFYmb6pnJ1vKo06VEOkdN5mgV3GI44I6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPh4dgN7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPh4dgN7"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e292d801e59so52857276.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703035; x=1730307835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWjgWd7VL1jM8F3cyNSORYX241cA/4ivUikXKDcJ2nk=;
        b=PPh4dgN7rwtWV6UU0+hO0m1sRWX79GXIoyjpFhv/SguD2mm0FL/+WjpjD7cNpFxJiw
         6uw0uboLSFcvAQUnGLw1PRw4I4TxZZvUGA6vLwC7XY2kv015qAvYXSN7pdTmBMFDgkj+
         uFBQkd93xgcS4Te5ioTHHMUciLQ+DM7M30Lt282JF2ZZJ5oykBemjyS3SIWFGPJdXPBt
         Wzhz0ZhrFmWf5DQfhIZ4MbwwsYG2WjwctQcU4O3bgyNGn0Xivdctco2Oev+EIrCus3W7
         gfNioj+WFWi3yVyKYx5xAnamEXe2a304ent6yW6+86FUvSCf1Ofe2s3cq/MtvDBZ2ZJY
         FW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703035; x=1730307835;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aWjgWd7VL1jM8F3cyNSORYX241cA/4ivUikXKDcJ2nk=;
        b=MElHqx7vgh1J5uvcVw4NFGoNJ80hll9zFMSXjFD0aXm//FF7UcW/ykGd1PrxInfv2b
         mCNVAvzpEj0DyPNb4U6CJheZjzv3MmeGbY+PDJn9Qdqkacegnh06Q59+bm5Pm7GBK/xe
         t5JtDiCrm7jnHCVB09dF65cUzlC1hraYGDRBy4X54bZF4+3HLcQIIXZVpoKYzrMXQ5Om
         mnkCQL7m2meTefJ2OLL2Uf8YbmpjfZJmsHV4dKQzps6rSmA0rECVrOL1+fQrdMAC6jXh
         R0Cx22Peu9qN3Gf+Np3c0PFGP/OZzJLGjc39PK0IoMOq5+eiX2K08JBylyQR+vX/muE/
         Opjw==
X-Forwarded-Encrypted: i=1; AJvYcCWCxIN2VbzNDkEjwW6R7C+9CS+EtI9uee9QVP1jsmTW0F6ISYz7+J7R42Ycr3SuzlREeIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9L0CiOdn2EGxCHc7VEoeKpoS58lgvhCt1rehKCa9dTCGqV69S
	oCRaURH6bzE4Ln2elOySm62cYjbrTq9WQL+YbhcWEpNriQ5zMceQvL1P8nEEKstyQxtW7Rax2Wi
	8IpH+zpLlq641Du0TiTdIoB2ZuLQnDg==
X-Google-Smtp-Source: AGHT+IGBeoBRnNAgY3FX4Zh93TzNz4pFLYRl4ILk0kpo9x8sAgUbFqRGzMetg38LomzHLhgSFsoc4RMmjRJ8NDaNtiNj
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:7952:f32:af76:662a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:aa46:0:b0:e28:e97f:538d with
 SMTP id 3f1490d57ef6-e2e3a6ccd06mr1595276.6.1729703034760; Wed, 23 Oct 2024
 10:03:54 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:03:50 -0700
In-Reply-To: <CAG1j3zGiNMbri8rZNaF0w+yP+6OdMz0T8+8_Wgd1R_p1HzVasg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241023170351.2939502-1-jonathantanmy@google.com>
Subject: Re: [External] [WIP 0/3] Repack on fetch
From: Jonathan Tan <jonathantanmy@google.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Han Young <hanyang.tony@bytedance.com> writes:
> On Tue, Oct 22, 2024 at 6:29=E2=80=AFAM Jonathan Tan <jonathantanmy@googl=
e.com> wrote:
> > As you can see from the patches, some polishing still needs to be
> > done, but I'm sending them out now to check if other people have
> > opinions about the solution. In particular, Han Young reported that an
> > alternative solution (repack on GC) takes too long [1], so I would be
> > interested to see if the time taken by this solution is good enough for
> > Han Young's use case.
>=20
> Thanks, I've tested the patches on our internal repos, the fetching time
> increase isn't noticeable.

Ah, thanks. I'm looking into why the tests are failing now - I have a
solution for t0410, but am still looking into the other two. I'll send
out non-WIP patches once I have them.
