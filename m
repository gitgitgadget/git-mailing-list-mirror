Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A254B2056
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490493; cv=none; b=I3K03tJ7RE2eTgoq9i902TwAQD2QRyVEfsDvFkbM0pw9vt6e7IkP81oi4udGzQsRV6Jge6SU5WRqteaHyUQWmgD4vJRfHyXESNpC+9Xz6RoaNWCCJ6n8cjHuU+6JH4wU6a3KuEjSthlBeNcB7z3nxi/OKAlAbqYFW392XycLOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490493; c=relaxed/simple;
	bh=UfFkf3LpwggFfMVRbW23la458ajIq3bUK62/P83TVYo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HTJdcaJqpap2NkHY4Y/aXfd25d6rYG7BWZ4IyC8ItOsmGjSpaKXCmln1v8trjqLVXl1RTQM5kNOyyzLhFUFPYxlFLxVfs1F4tmWvhMgdZvACVZooMFSCQoCxkE6SuBjG7RQGMawbV76y3D/BtVXbNsJpOBYFi0yl06Hr6MHV3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuDGA6pv; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuDGA6pv"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43f9b11aso6961007b3.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789490489; x=1790095289; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfFkf3LpwggFfMVRbW23la458ajIq3bUK62/P83TVYo=;
        b=WuDGA6pvvKXu8WD3UAawMjviAHLGdb4EtUOeckcfXUb6ptWhTA+LgCGjY560rGaKHx
         Vu7WRJI6K1X4esGnf/FNRtMTMiDVa0gUcCx5fjWjcoKjISy1W3YOekuhBdlj1g/xeYZY
         omjRgkHvYUm/5/PCVn4oJJYPnSYOe0yZeWa0B8vTrlxFp6h63AFmPOVUGsdfIldsxBC0
         kMiOZlh90RZ415l1vmY4Jt2S9dkF2habmkaHLp1gocXzDE/Vtpo9CjIKE2Gk+dzZDdV1
         bggLtaBgPy/Y58pC65PrnKqMKjNz8MZXtbClzLpV5gg3Q638KGARnyfsImGaCQ0aMOG7
         UDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789490489; x=1790095289;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfFkf3LpwggFfMVRbW23la458ajIq3bUK62/P83TVYo=;
        b=GZX97mvmMlmOWfG51vY8VpIrwhqLqXyaDk0PH6cvq/Hxe3YDXHIPTU3mznnWroNA+V
         ntzsERMwfvQKJPmd0Wdd+f1c1bq/wRFFNwK1VMcih/1pVQWMGaQd5VqywVhg7M6JIWzl
         mA5UVzEqrJfv9r+iy6YGQZkIH0haWoqfIQUCjxR3WwuVtSirLM2la9vmOteggJ50XKHI
         SNRJDaPurE6oig9qQFX7uVPuQbDi4b1dEZEs7/5wvm1lBCoS7X4nksSr6Rk1DbA+PQha
         QpCMpfCt87udQvhkHoT5dVG/CZ6WpXlMO+lOAV6YymGRzBUR2U6dXSMC4TlfTeKb2tFM
         /kRw==
X-Gm-Message-State: AFuF++mdp6IHqILbuRd2ZB8TGMDMyyGjEg+F4s2+asmjGExbI4TT6LMU
	+YXJl5vQtecyaPsnTqwXZETW4gOmSIuHUnbrlLZ1l981medMd/XYdPuKKEeqLg==
X-Gm-Gg: AYBFou0MIg+/X6udOiaGbLO1xdgUfJtZ3Az4zz3eEQ56kEeNN3SCfZCjLItoyxHP6ow
	QqpO6204MG+RnFfXfyyjjYBZE1jOWKuzRI1nKc1kP5clM/cH23xzAZoCIHe5kL82biGq0JBWZIL
	NdDT3gQwwgY6BA3y6YBi/tk6ood4ETwOiqyo1Bdltczluq4BmVTnMBlfbP5iTPN3CMG7kE+MAXi
	7s+V9vh82hpSdb1piFXFWJAOpPbgi7YwuYO4GDFE3IyeoB5+Bhtb0KpauUOMug5YI67t7yIXHk8
	QIjuogIu5qnSXdLEVMEaFebIVrik+1S3CnOGdFUULhNRb7RE+dA55sOUX0H78yg9kmZEqSDJLEx
	bC8tYpTF9mAYXmGLK5VAjLVy240z47sXw9h6Buiuk4mTOFldOa+1UPKFIsLYO8gZKAuMAtfuaGd
	19W0R237U0JvzMgr5YsNnrvC566eF0xVt0MIuNu7ea0nSQ7mWARVcCxD7j5jdogfxp4GiC6rDjc
	5ZL0PTJKmNqpJwaKw+NuXLzwHCYscnpOgsgfHXxC0ru1V5/hcPB7Npg2lV1YQuKi1I51ItdQ7hQ
	/i25smcQlmZdgm1kOIMbi4zqpritlUn4lALo+BkZbf1NDcUD
X-Received: by 2002:a05:690c:16:b0:873:5ddf:d874 with SMTP id 00721157ae682-890f5afa6afmr7817557b3.63.1789490488731;
        Tue, 15 Sep 2026 09:41:28 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:4c98:2196:42e8:e905])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88f90aebca5sm8478547b3.0.2026.09.15.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:41:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Bug!?: Refspec '+' should be same as '--force' but is not
Date: Tue, 15 Sep 2026 12:41:17 -0400
Message-Id: <DF50C11C-44E1-4BEC-A446-8C27F165478F@gmail.com>
References: <1bcb043e-e744-4e01-8569-4da5669d25fc@carneios.de>
Cc: git@vger.kernel.org
In-Reply-To: <1bcb043e-e744-4e01-8569-4da5669d25fc@carneios.de>
To: =?utf-8?Q?Andr=C3=A9_Kie=C3=9Fling?= <akiessling@carneios.de>
X-Mailer: iPhone Mail (23D8133)


> Le 15 sept. 2026 =C3=A0 11:33, Andr=C3=A9 Kie=C3=9Fling <akiessling@carnei=
os.de> a =C3=A9crit :
>=20
> =EF=BB=BFHi there, think I found a bug...
>=20
> In https://git-scm.com/docs/git-push I find:
> > The + is optional and does the same thing as --force.
>=20
> The fetch documentation refers to push for the details of <refspec> so I a=
ssume, the statement also holds for fetch refspecs.
> However, this is not true:
> When I run `git fetch origin --tags --force` it will force update tags tha=
t changed on remote (as expected) but will NOT delete local tags.
> When I run `git fetch origin` with config set to `remote.origin.fetch =3D +=
refs/tags/*:refs/tags/*` it will delete my local tags as if prune was set.
>=20
> I'm using Git 2.54.0.windows.1

I think this behavior is described in git-fetch(1) in the PRUNING
section. It=E2=80=99s a bit opaque to me :) Still, you might take a look
there and see what you find.=20=
