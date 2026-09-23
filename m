Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C03E49E9
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185086; cv=pass; b=VzCklUt1Dr9mtPHFYUYv+qFUFmzZjvIU8VKr7fsUS9k9HvzTOwvMeQPvOoumpbsIgvYnif2yQaHx6MHVA3DMD1+vXqSrDBqnHBq5pA7s5SrgCtHZO5Yj7RvGPK1ivBMC96W5ksZClHZ3cTkn7KBJYck2ktJlPTn6/5JMLsBLuJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185086; c=relaxed/simple;
	bh=xJ/jrBHKh5PCuKMrPk2mY7G2qdLfN9v9iDa62dSPl6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5LW2XaSlmNzb+ilcKi0BTWRh5SiivxnokZOjoBtrypL+/CrW6VcIdtWXHMK5yqOkzCoFDfqB83NcT9d6uaZXkKzqkfKZwtdfmq/GoFhTGCKu634kVgVODlH653Xdec9yFSgJEZkquzsqMqfKrM71OXaK7G13j0wJ7nD4M9RcBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7JVz9OH; arc=pass smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7JVz9OH"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b390bcab0cso651219eaf.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790185084; cv=none;
        d=google.com; s=arc-20260327;
        b=bXOZveFjLWY66+fPjh4uRUxnt2D0lnd/oraVeKmXrQ3GAWAjRYt6npBw4vUpivre5S
         nNZbIbfO0MQmuNnJnJoT1xUsOqI3glIDzG4H1yKSKJtmZgTYJjIs7QxZiCPgyDKwx/2a
         WMKSpOv4Zv6h3flsXgD0LzXSHI0SPtQw5rpIwvxM0yVo783oJb913BwHJf/dgIwEiLnA
         0xweYS/1lSQWVh/R4d5k1C4X64+WWXEg/aibHDHvFKBnQXDveqqcYx0Ixknc2WzUldfA
         PNTL9VmvPQ0M7U69tHNyzQgCHhLNoFqc1fme040eS/icMJN5uO7E35hLZXh6fFrswzO+
         o6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fLAVHU9fBdzNccM7WjRR/weWixQneeOFY0kWWL1fLHY=;
        fh=rfLjIwn2a57wX7vvUPf5sv7xoXYLkb1by0ZOpcDOxJM=;
        b=KIQF26DmAjwmbEyNgAO2dMgxb36REmU9U3AxNyZ+DKD+Fv9VMliwnVD6k+h1/YPLw9
         kMRitkA00NsXVSeyxG72aoe1tsI8iwOInGFPPVy6ADaUgUlhOEH5lfCzbNBIISlOjNtQ
         gqFFDPUBWSC9m5iIaIvyzzTzMRqlSthUAkKbVHQZU5+s4FIT3aF9gdd8Gtg7Hn61o1qB
         O678xKdJ0/yVT7BIFnbX+PWV6dVOrQfGRBI/1MBMblE+8kMTUSKDUMQgNCaYSN0/6U8X
         FsmJg+qvgFj+z0M9AMPCIVCSthHshp9pwPNtl2tQ4C8hVpmCFbZY4K48vhrO/y29t1kM
         mKSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185084; x=1790789884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fLAVHU9fBdzNccM7WjRR/weWixQneeOFY0kWWL1fLHY=;
        b=X7JVz9OHwke7GZtfpwOKt+/mTMiea5rkLOE6jnpJfhB83HaWwN94A/rNksJ9t9Uhn3
         GCOYHM8I9MjIhqLXhunaYj5LeKwciChTJio4uFhfz6PZlfSDqqER78CnouGZABjPb/O8
         HjI4NM1FUjccvof7EyzS2+ygr3RC6TutLAuJJVcJHNCK7rRHXtg2lrkyv1HKCsk6YTrN
         1HMN6Jl8XdpugxkeHeVMaaeJsdR0zd0Lddguh7pkIpqJWInIMqYTxMZNSTioWXUZY1xl
         oJVICFbwhlM0vB37NE/h8OG+YPmkdxifJH+npDtohM8FOQAuAQU21jXgdYsBYqcPoHpF
         epAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185084; x=1790789884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLAVHU9fBdzNccM7WjRR/weWixQneeOFY0kWWL1fLHY=;
        b=gEEM9dpEsUPP0RdXUnowdxYii+wFy9L/K1D0R1fd6pzLatPs89jGo48/QOV0VTZLif
         NS2Udwtm6H3mf/6B2rs1g4tGC52guF59WQN6GxTpvuasrRas8h3LdwLFru1WrQsP3LSo
         sdqZ/pIXpJDykkdu84NlQeRhlzRzpNX6zQzQHbgPotjDQWRbpCyi4HRKE7zvHKRGqpGl
         XbVsJRAFBBJKC4zE+h9SP3cHeSUjiEKcXRajlUiyJaG76aEoB5A4VFe9cI1G9156g6m5
         xzPBdbWAN9mNWhhQ6+Fr5SbwK9+ox/ZyX/t09dlHKTPxdw57A2Sp5v7mpisjHOI3oU8Z
         IOPw==
X-Gm-Message-State: AFuF++lXtehD6YC3HqMWTKXyoQQBWEXaaECab2jIFjfNHjmE+tWfC7Cf
	mIVUG7GQTjkVCBfp3X3eA7vGkUlizG5+49Am3xPB04vW+7DRZ7ChxJSxuwUBEXBT0bgoF23xtZI
	4jN7m6IihYw3fKfbLM6k5vf0B9C8KK78=
X-Gm-Gg: AYBFou1qnpvRCEdy1flmEO9HO4OaV/IWvBmiIYI79NS7Rdy5FthZd4AGePMJWBbYt52
	6daOYHkOEh2SGf7vRUwPuHrXMyUwivvceip2AB4uPY7AVx5+7tFaZHFw25MaP+aUG4wv2300mwg
	ukxdEpJUz6LsKk2XE/7IPIJK2KL5Hl6+hgkgqz2HPu8Qyu2rBo4Re/zVZryjrNt8Aro3vggtow3
	Bv520Iysuilp4WOyRfyAALiexO70KU5pO6h0n5iLuR9y0jrFkREHVbwRMLypfUAgYi//eKum+AY
	umL4beqrdLFsS2d9qr1q7HzEUVkkfxMUhDd9g4c8/fbjsqjCBPT4ddpSKdUG0yLpDt8/LUJsikK
	AhJWzoiLt4y4XIFXKIqLAVQqCAZqGEA8XRYhz7XT8J6MqlP6kTHgpsse6t9DReM81VnwJXk9opL
	hpWoEwP7Y5HA==
X-Received: by 2002:a05:6820:1524:b0:6b7:46fc:1c4 with SMTP id
 006d021491bc7-6d2d0d20c7dmr3986183eaf.35.1790185083835; Wed, 23 Sep 2026
 10:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-8-jayatheerthkulkarni2005@gmail.com> <xmqqcxujbser.fsf@gitster.g>
In-Reply-To: <xmqqcxujbser.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 23 Sep 2026 23:07:51 +0530
X-Gm-Features: AclHuK-KBcjRd5dAM3a7sc_-ZAhhAz29qWdMONxO38TCpjSLzs-JKtlIoX4hIqI
Message-ID: <CA+rGoLcLvm24XAeN9QOObEC2JbQaBhFmvivJ=-6OZ_t8F0Tw1A@mail.gmail.com>
Subject: Re: [GSoC Patch v6 7/7] repo: add path.cdup
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > Scripts sometimes need the relative path from the current working
> > directory to the repository's working tree root (cdup). While this
> > information can be retrieved through `git rev-parse --show-cdup`,
> > `git repo info` does not currently expose it as a scriptable key.
> >  [...]
> > +`path.cdup`::
> > +     The path to the root of the working tree relative to the current
> > +     working directory. Returns the empty string when the current
> > +     working directory is the root of the working tree.
>
> What happens when the current working directory is outside the
> working tree?  For example:
>
>     $ GIT_WORK_TREE=3D/tmp/x; export GIT_WORK_TREE
>     $ GIT_DIR=3D$(pwd)/.git; export GIT_DIR
>
> The current implementation yields an empty string:
>
>     $ git repo info path.cdup
>     path.cdup=3D
>
> However, 'git rev-parse --show-cdup' produces:
>
>     $ git rev-parse --show-cdup
>     /var/tmp/x
>
> Whether this discrepancy matters is unclear.  However, if the goal
> is to consolidate all repository path-related items under the
> 'git repo info' umbrella, this difference sticks out.

yeah
in rev-parse i could find this

if (!is_inside_work_tree(the_repository)) {
const char *work_tree =3D
repo_get_work_tree(the_repository);
if (work_tree)
printf("%s\n", work_tree);
continue;
}

adding this logic in repo.c should fix it!

Thanks
