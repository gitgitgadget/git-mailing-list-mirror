Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AAA271448
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353719; cv=none; b=RiXrWQhU2g9GY+OlJ8tzbJ0hArdOTH3yQcriPZQ+UglggDreGG6iLx5qB7lFn26vi+Qqlk825U5O0mPVDclP9BthSUP5pUqSFtnYY/fLak0DLKeuOxfchoE8qkqK2MvRFC1ini+TUGYDrZhyuduhl5R/wFn2GKk52PaFIIPseYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353719; c=relaxed/simple;
	bh=NgHxON/RydT5NWaUaEJ7OukemIpZpKQ72RbyRpMFIRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ndp3QOBi0D/rsxh4SU08xM58qlK19BXMhZ7nQ23F8WbbKoabYWy8h2EZAhxCzllsEDS/uAblLNkuQUfSRRsTBthpmiPd/YKcckneIuH5NQ3MIt4sEn1P1JdOZiiHewLVuvVXCl+6iF901FGEzanI3bZHRA4KM/RWI2RmlfI6oGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0jejeVp; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0jejeVp"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9379a062ca8so9503039f.2
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759353717; x=1759958517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGKpOoo6bVAb7I7zHZJo+L1DkGbR7QyBG0Fb2YtyM5c=;
        b=Z0jejeVpu2XmbyHGU3dKRdDasxb1m8e6GBXejMYAMr5Gp8xTa/B8eDWy5HQU2guBvm
         iCcixVJcpt0E3nYdXUJI05s2npMisN6+v+U8BJYGYAE5FnHotYB+ULoLpKpWVdbkcUIR
         P6Bsmn8RO7ABfJADSJx0YEqGCtXeAoPc8A7GadlVKs+Gpsf53F9MmKR14AEYeqoDeg/z
         +qMZoCMwFkDwIUKAF29Yk2Zhkd4xNh1i6XK3MMoRhn22ZUabA+bplILig6mHKo/0cdTf
         mf2RxJ8FJ8OWDlU/8LavYsE0GRna811MQwDofLZ8ybMrKGTws8cQ0WcyAIu8oeamm/h0
         +vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759353717; x=1759958517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGKpOoo6bVAb7I7zHZJo+L1DkGbR7QyBG0Fb2YtyM5c=;
        b=ZyHzwOipFO2XUCBeR8jmEjiHuw3wYRb+nN7ws8BMPlISsfdBkxDJN9OA+qoAYRBusW
         yYTFOd3PVOP5BRjVXaEiRN/O5gFcxizlsIyiTF7/xO+K35EL82kQe4JflnaHYtjQAXJI
         LuG/4ci0XhD+Gs0IIP3+JD2oPRrOBcd5wiXn2tWoE5PHSNnu5ITZpHAag1KvZ+O/MTFf
         IXHgRlGIyWo4KOC0Fgyxf6CBlJzD0DxuM0MnNjzQU48CPtCaeae0MMFSMyd05bYul9eG
         iDWA+ziUL79s8ndQBbUAISOs8uRfo/KnI/QbFsk2WhQWuogGuIkYkM9MPM+PNGBe+hve
         zL2w==
X-Gm-Message-State: AOJu0Yyxk9zkngbgf4WPk2GBUoGhReXbTprygCydZXwQvbBr1qm5uys7
	ZBdWnu9CHJ2A8y6JlolSIPExzFujIj+TGObjNuhooBQby1qhDHfZA0zUhNHDkVBjQ3ldLU6C+kc
	Tr26it8EI2HIn0YaM65HBawWtJE8di0QUNA==
X-Gm-Gg: ASbGnct1ForfV122xninNW/dklzzRYkylGL8X9vOpPsgBize8W/zPz/r4JWhzAFzxwg
	E1jCfQbxoJxo+6NvSKLklKUWtniQTu2f9x6dvGRVSb4cn8U0K9csuGC+GgqIPwbMB5sk3HcStOd
	kF2bJkIMUokekmigBdA375DO2wp0DtEux5Bk70l6X1+jq12LUzMnNuIQw25AomTlsEychW/L5E+
	s2ZFBK5VKNbI2SPsuVKwvIJC6WcaUi34I21rXjLffIuGjBcgNjvenpFPVkbBnSK
X-Google-Smtp-Source: AGHT+IHfArdc2qn7WxrxzqDePydcMWeOAo1edU7ogKGfslD6HDVbPWXrMh+vs0RwIeiwzI0GDIEn0KHOq07Y6NPdZcY=
X-Received: by 2002:a05:6e02:216c:b0:42d:7f38:a9b4 with SMTP id
 e9e14a558f8ab-42d816953dfmr67421855ab.31.1759353716704; Wed, 01 Oct 2025
 14:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001005814.846992-1-sandals@crustytoothpaste.net> <20251001005814.846992-2-sandals@crustytoothpaste.net>
In-Reply-To: <20251001005814.846992-2-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 1 Oct 2025 14:21:45 -0700
X-Gm-Features: AS18NWDj1MSV9qo4EEIZMY9EGDSBITtU1zFlocLs59aM-F-yCY8QvIalUV5zOws
Message-ID: <CABPp-BEAawZgDz+bBizUVz1=9XHE_g3vWGV17JooUes=JSmkwA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Define an extended tree format
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 5:58=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> +Following that is a modified BER-encoded integer representing the type o=
f
> +object and a modified BER-encoded integer consisting of flags.
> +
> +The object type is one of the following:
> +
> +0:: invalid
> +1:: conflict tree (only valid at top level)

I think there may have been some miscommunication.  There was
discussion around "at the toplevel" and "trees," but I believe "at the
toplevel" was meant to refer to the commit itself -- specifically, for
each commit, at the highest level of the objects it references (i.e.,
the commit object).  The idea is that conflict information would be
represented by multiple traditional toplevel trees (or possibly even
commits?) recorded in the commit object, with no conflicts recorded
within any individual tree.  Instead, the existence of multiple
distinct toplevel trees is what would signal a conflict.

Recording conflict information in trees rather than commits, as this
proposal suggests (even if only at the toplevel tree), introduces a
problem similar to what Martin mentioned yesterday regarding blobs.
In particular, doing so would require every `git log` operation --
which wants to determine if a commit is conflicted so it can highlight
it for users -- to walk not only the commits but also additional
objects.  Even if limited to just one extra level for toplevel trees,
it effectively doubles the objects traversed for non-diffing log
operations, impacting performance for everyone, not just those using
conflict headers.  I=E2=80=99d prefer to avoid imposing a performance penal=
ty
on users who don=E2=80=99t use any new features associated with first-class
conflicts.

Additionally, I believe this approach would diverge from how jj and
GitButler record conflicted commits.  I=E2=80=99d rather follow the path th=
ey
paved to benefit from their expertise and minimize (if not eliminate)
any possible rework they need for continued interoperability with Git
versions that gain features they first implemented.

We may find reason to revisit this as things progress, but for now, I
don=E2=80=99t conflicted trees needs to be included in your modified tree
proposal.
