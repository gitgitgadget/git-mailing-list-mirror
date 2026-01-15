Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE4258EC2
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493878; cv=none; b=t9c8YfT5RJhNhd+x5Qz3GeW0u18njYIa1V0g/3Pdq+newVrNd3NmYIEaZfHL/6Y5Yr81R+XRcOQerXboDw4rDdLSimdWQCtzWWuni7/M1tjDHIIQbEo4yT123rwwpXiVZ3ILiWS6kEJX4aPUMvxJF3DbcYSYRdOKjgKzx2AWLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493878; c=relaxed/simple;
	bh=iuqUa1tVy8edTuPBgVjSJLP20CwCqqMye+YF9FWIB4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCjD1ANibOx6cso6ENNi9CHUEiXrCDcABXlepNEX2EtepM0Ozce5MpUkToOqAx86YWJeqIv58/jm8Ze2JODyucu5BiJv4OuPutJjJnJn3LiRz6yOuW3Ngj/t4xUOcTSjd/7poIIPuqBS91ca2XOTxnbZ5ZAmnSqdnxvZ3ZueEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2h/Z6av; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2h/Z6av"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c0bccb8037eso449092a12.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 08:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768493876; x=1769098676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDarbCctHsl3cL0UaxXs1k/zsSuT5nCjDHGMA8Na3jU=;
        b=H2h/Z6avyrg0jC37VOdXDYEGco5s5BvrLGgIxMCNdhe2Ya8psa/pItaeip1YnRGhJK
         O8Le9LL4f/OXeMvtkaHPNKR+/qCNPSPU/32G2KmT9xxk4m4pcvDRImzIuy+rIu1J0nMK
         v8er1v4716Bif/Q/UcO/xome1jIBsujNe4yBagiYsHySe5W3KKZdFI1UE/8Xp68ySNji
         eNC7OCerzwUTGf7O9UNLndYy0B0Z7fjevRINqyiFPMq9F8Jvl7yUUmGIU4lKOUVSFFeG
         k36MpJLXMuqAaaKy8NwYJYA/yEAsqIjShY4YxFK6XQozHprPL/HF8Zdw9Ye3TPQdjNNl
         x50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768493876; x=1769098676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDarbCctHsl3cL0UaxXs1k/zsSuT5nCjDHGMA8Na3jU=;
        b=wHwaJGmMvREb3vKi7WL19D3+PYX6daHy0tsjRSjeDHJFuTlBzlg6dcaFN2AlvGTFQp
         +YED4ywcOFJgpM2SWv1/WooQNyrlJh9zZR/kZk6rRQMHt/0gKsxm8JNhY330ku/20j6p
         axmYNUm04j2ssP7JWj+556nZ/0R8bwZW4+L81n2KUmKzsqNCv8BkA7XZg0FKnEJ1epbm
         CD2XFe5xodJ5HQ3dcWQAXd7ST0ShsykWfhzVrh6mcKPHoQ0sAJIMMEHRkqe2wrO6bO5K
         YvePyfk8MmZGvhC08fNWUc/cn2EvbdY3KEC/RuQ+k8wh8DLxzWOwWsDeduT2pqj+CZZ4
         6V9g==
X-Forwarded-Encrypted: i=1; AJvYcCUMTJxXKf5GW5FvGJJIBH8cJkKqIHG/vOlKp0efrVMfsPIYH222jfAZ8J3aKBfpVkxnk8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXCYy/XBiOBElWBEoKJmSnTROpPo/ViArJJWVIlLHP3MDaX3P
	n4DEbpPH+S+WJvOwTQ4kdY2N1I1Sm773FkUssp4uYGRYr6jzbi8V0eH6RAjOR9HNrx7bh0rIrC0
	KCqI+z6K/9PHvmOvO5OTXRCu0R0EbSaU=
X-Gm-Gg: AY/fxX7irtpysDxZwCBNT78k8ELMemWC+urx0cSDI+1WdhDyLVsg6bw1ICseOV11gRp
	R2gxyFlxvgneRTm5v+lJ2rWQDLhJwIbZuCW4hzNNrwAwP1M+ViCIoMmGTkF9+lk9EF1pPqA/RhF
	DZmu5oBu6F1gBfbVCnuTIzvs4Qhu0+NGZk0/g0KsMuKgryVjmK2QC1BvugqXJuwSEpU+rE6jK/F
	YDAnFdkeGS/h6k68hgPJNqf9KrxK1n5qI8KUbplckxkHTS3g3DtgqOJfV19anTZ0VpwgEq7/gLp
	F+keY+D/YSsWOj1mwkDaX5aAIdH9pIgpaar5QUDu3Ymi7XpN26pcB+ef5Rq9oNpJNoT7
X-Received: by 2002:a17:90b:580d:b0:341:c964:126c with SMTP id
 98e67ed59e1d1-35109152e03mr6621460a91.34.1768493876190; Thu, 15 Jan 2026
 08:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114162427.GA885771@coredump.intra.peff.net>
 <4F632782-4B1C-452A-A64B-CA223D2C16B0@gmail.com> <20260114221716.GA1013308@coredump.intra.peff.net>
In-Reply-To: <20260114221716.GA1013308@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 15 Jan 2026 11:17:45 -0500
X-Gm-Features: AZwV_Qh3xY4CTqHc5Aky2PEIalUTxBc4R0MnKQCJV-SDOgRuTRYFRZ_3qzsDrtE
Message-ID: <CALnO6CD3Zg_69cPPn+Rh4EKDF-tDQSLJ42YSMJz308=1C8ZQHg@mail.gmail.com>
Subject: Re: Triangular workflow
To: Jeff King <peff@peff.net>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:17=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 14, 2026 at 04:38:33PM -0500, Ben Knoble wrote:
>
> > > Le 14 janv. 2026 =C3=A0 11:31, Jeff King <peff@peff.net> a =C3=A9crit=
 :
> > >
> > >>> Yeah, though @{push} is usually not explicitly configured in the sa=
me
> > >>> way @{upstream} is, but rather a consequence of how push.default an=
d
> > >>> remote.pushdefault interact. But it was added for exactly this kind=
 of
> > >>> triangular workflow. I sometimes will do stuff like:
> > >>> git range-diff origin @{push} HEAD
> > >> I imagine the same thing could be achieved with
> > >>  origin/$(git rev-parse --abbrev-ref HEAD)
> > >
> > > Sure, but:
> > >
> > > 1. It is a lot shorter to type @{push}. ;)
> > >
> > > 2. Using @{push} works everywhere, even on my non-triangular repos,
> >
> > Just so I=E2=80=99m clear, this is only with push.default=3Dcurrent, ri=
ght? I could never make @{push} work otherwise.
>
> I always use push.default=3Dcurrent, though I think @{push} should work
> with other modes. E.g., with this setup:
>
>   git checkout -b foo
>   git clone . tmp
>   cd tmp
>
>   # for the sake of simplicity, our triangle goes to the same place ;)
>   git remote add triangle ..
>   git fetch triangle
>   git config remote.pushdefault triangle
>
> then doing:
>
>   git -c push.default=3Dcurrent rev-parse --symbolic-full-name @{push}
>
> and:
>
>   git -c push.default=3Dmatching rev-parse --symbolic-full-name @{push}
>
> should both point to refs/remotes/triangle/foo. Using "simple" will not
> work, because it demands that the upstream and the push destination are
> the same (so it doesn't really make sense in a triangular flow at all).

Gotcha. Yeah, simple (the default) doesn't work. I suppose upstream
might, too. (I also have push.default=3Dcurrent globally, was just
wondering about what the minimum was to enabled triangular workflows;
see <https://lore.kernel.org/git/CALnO6CAUSU-Pq_r-WYm3o0to6H8MdqiYOuoKaRfL1=
PTt30VaoQ@mail.gmail.com/>.)

> But in a non-triangular flow, it will happily point @{push} to the same
> as @{upstream}. I use a triangular flow for git.git, but most of my
> other repos are just personal projects, and I push/fetch from a single
> central source.
>
> -Peff

Ditto, yeah (_sometimes_ I actually do the triangle origin/main, local
branch, origin/branch, so I almost always set upstream as origin/main
anyways). Cool and thanks!

--=20
D. Ben Knoble
