Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436118027
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 03:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727063113; cv=none; b=o59ioLT5W5Swtvty4lq9YJAn+9yBvZ2g1hOiz4fFiOUorXUpqnnrh5yXLh3604UyxEpBzdripiwAF7frkJGdh58MjKPuu1aRaI8y4m/JpSXnYn/BxovPwWesTrUzEKr9u4SmvaDQkIPvohv00R193h9jrMRy8O28Qm9M+Yk+9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727063113; c=relaxed/simple;
	bh=egoegzM66PaZdM2x7nYLGDU72Kk3NI8rpOxcwES65Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSZ8w2WqZhjjcrsGneOH8CLhwUNVtP9LfhjVH4WipqnBTepEc2UvKpiT525kYHVhYzm9JHOmeXkrQUcF/Cgh/7qoimxHBHUj/hZZ3gH+Irsq2FGrQgVSHogc8DT4ZjFBeCIRcSL6Z7oEXdSfcZvZzHcJTSm5wYQGHk7GsoKyTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kM2rkIXF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kM2rkIXF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718816be6cbso2888611b3a.1
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 20:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727063109; x=1727667909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbEIFl9MvgVM5W5naWdUvV9rkdN4Zbiezv8MAZmyihE=;
        b=kM2rkIXFouj1uoOyASlNMin6g9AYuWwHsQeDrMJZIDt1Zvwi6VskECZ+fX3hcVmv19
         E/bNtivxaZHp7RWooBRq8V2tN4JvZd39jr4exaHAmAUSzEqP6om7K/rYLfgC9B25YNXs
         YIdW0ZqDNAwt9TP8+v1COZ5sAO1B6vBb1iJyC/6JQknOBJODX21Qke7jiDhYNQK8f0bF
         IbhdQpLbHTkOWFkpzx5U75sInB/l0utWs85fFjnDsFCeLnj8DMvN/zwiUi704MYvtceF
         quLJDC3qTwB2gDVnMdMK4AZSv5sOZa0d1iJeLbIQtkj0uTrb7XO9sEXiLY9kK1ZBT2ts
         adqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727063109; x=1727667909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbEIFl9MvgVM5W5naWdUvV9rkdN4Zbiezv8MAZmyihE=;
        b=XiMzhb6KtyA/YSjXQ6jCAtO2FV/yHjvpD/bYeX3F1E8dOHRdYwRgee42J9xHMckBGb
         3shLJpP7+E+hI3049/zt7JdY+ae4XrZdEaf+P6grvaYHOgjo+XnFXLF8fj7dS88VbSTg
         RKpvec/9dyK2dPt5A5hASwp93CO4CiluYDKbtEGuuHm3/aqMwIb5q+OBC6wyFVpOzAvE
         1T3J1pZttQ+WTONfcJ3d2+aMF4V+FMLvZqhoVDgXzltrmqW1/WCOLj2nmMlkuF+2Hx5t
         2RtzLvVcz51xLq3A0S2GTCMtI13soQiUy+DfpjjKivQGW9dDIa64E0QKUWTrzaB198Ai
         QPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxwqTzWNznfjHzCqP9JjeWr2cXIYn2lMTRlySdM/NS0juykjnFkVL7qez7aJUX5uaFG4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0EyzRp+Ew/yb346mCdNptSGhm0RGf0KZuRJkXFF6GHGP2isQ
	WbZ4v0CEpcTgYSkLkYkLs1YD874bVyk0lglyyasZakBc3S6VXPEMOZBbGVes5xfdV6/MB4ySdg2
	QasofMEbN/jjDgJuL4zmr+P47Yz6C9cT+J4Qsnw==
X-Google-Smtp-Source: AGHT+IGTwDNRGZi5vcFEji3DKZj05uYoG1nDVptdi+z/aifFRq2sJwqSZg2klFFUcr8jhMt1EnOC4s342hqohtKWDgk=
X-Received: by 2002:a05:6a00:1888:b0:717:90cd:7943 with SMTP id
 d2e1a72fcca58-7199ca839e1mr15765808b3a.28.1727063108812; Sun, 22 Sep 2024
 20:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240919234741.1317946-3-calvinwan@google.com> <xmqqr09c89id.fsf@gitster.g>
In-Reply-To: <xmqqr09c89id.fsf@gitster.g>
From: =?UTF-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>
Date: Mon, 23 Sep 2024 11:44:57 +0800
Message-ID: <CAG1j3zHJVrpK5JZtUXFwkZgWY1-CxqET+ygpaMqo5aM-KeWaxg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/2] fetch-pack.c: do not declare local
 commits as "have" in partial repos
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, jonathantanmy@google.com, 
	sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 2:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> I was hoping to see that the issue can be fixed on the "gc" side,
> regardless of how the objects enter our repository, but perhaps I am
> missing something.  Isn't it just the matter of collecting C1, C3
> but not C2?  Or to put it another way, if we first create a list of
> objects to be packed (regardless of whether they are in promisor
> packs), and then remove the objects that are in promisor packs from
> the list, and pack the objects still remaining in the list?

I tried to fix the issue on the "gc" side following JTan's suggestion,
by packing local objects referenced by promisor objects into promisor
packs. But it turns out the cost for "for each promisor object,
parse them and try to decide the objects they reference is in local repo"
is too great. In a test blob:none partial clone repo, the gc would take mor=
e
than one hour in the 2019 MacBook, despite the repo only
having 17071073 objects. Normally it would take about 30 minutes.

> if we first create a list of
> objects to be packed (regardless of whether they are in promisor
> packs), and then remove the objects that are in promisor packs from
> the list, and pack the objects still remaining in the list?

This would work, though the remaining objects in the list would be
suboptimally packed, due to the delta heuristic. Because we feed
object id directly into git-pack-objects, instead of using rev-list. But
that's how we pack promisor objects anyway.

In $JOB, we modified git-repack to pack everything into a giant promisor
pack if the repo is partially cloned. This basically does the same thing as
you suggested, but without the cost of constructing the object list and
removing the objects in the promisor packs.

Thanks.
