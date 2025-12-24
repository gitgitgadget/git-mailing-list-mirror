Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B91A9FAB
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766545401; cv=none; b=oDTvfFNwjndcrtOM/LetnduvlltRmHYCCZdaGjpwP0jbbgfW6pM7vGYpIHzfOOYObdszq6cMCcvEwA6FoHzI8uO0gVCv62JStEZ97/kayG1FMc2qGdsQXy+RL66rOGWFTUVjm865HZZAxFiuLSA3GPow/go3IZ/ge69rH5Am2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766545401; c=relaxed/simple;
	bh=C7WsgjMhKp8xcjhZglXv/RMM+el82F2e+5KbD/Nc+1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSWeHXiSoDUqv1OyAqG5J7CnyrLITI5XzmQ4juDLIpaorLIkdQrX7jjAjoQId7bFWYhfrv3RtGl+bXNz/SpUqoZB+sZS+4DsvR6shfhJhpMoxAqoNDY0xBhhLyKzKVGMYziPSx1PIs7bOwrdYuFhr9sfAvKULW3/OSPNvYyrW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9gwVOnc; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9gwVOnc"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4507605e19aso3720036b6e.2
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 19:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766545399; x=1767150199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWScMEiWT43VUpA6qeahy5HdaYa67ut5mzGF/j7jGvk=;
        b=Z9gwVOnchOWslK/k2fqyeTjP5Bx3JI2Oiu32/MGFwWEp7EDW7PUhP29UJuOrHJp4wy
         HkLbprx1zPWTF2pUt8svFKSDlVwnjXonOqg5q08xivhn8v+2k6ZmE9O8RiipWUI1FRgl
         uxE6FVUTYUBwKc9LPtiQZpRKP36KPV3KdjpbxnSh8KBeIT/4LTdnmAGV0WC2/Ms7SRtp
         8GJrTpkU/6LC2nK0lRl/y+XAo4kYQtxxO7xa6iIdy3l91atzeOXJnLMg3AwW9gjXYc2z
         SBuANPSgPy+0DVOGTRezpfgCDwedZOw4z0fjB8JDCzQ5NlrYkcaj3UoHWAWb/uNwhJd/
         nJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766545399; x=1767150199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWScMEiWT43VUpA6qeahy5HdaYa67ut5mzGF/j7jGvk=;
        b=hYfPDzKHZ6C8kOgPo4r6Bakn4bz8QtV8VjF+ATN66YfTd2yexBRGtfkI5oqgrJ1sIe
         10A0KcFoJuBcQRoM/52gm+T69QBnjoljFcrXlk9BVysG8PCEogpLbLrunSYQiOqxYGZQ
         SFlF5Ku+wTm6VlXncsvMB39RzHOqVI3eAepMqwQCUUfclcyXh1ONdjuNiPHtfOpeFxei
         hTquKawt+DuVe9qVmtG7TsgQL54idam30DfsD2+g556tX72bI1JKa2qXp2M5zC8CUgCY
         477LE0tERit3T4xe9oYbw4Z47xJGMh4N8+dezWBfLw2oSkRFFCsuKaG52bDrFCxzhZgN
         sBYQ==
X-Gm-Message-State: AOJu0YypzxE1QyvuUPrtD45tN47XFFEIrwCXT2PN2dDwm1ZTg1iEzqgn
	VDhjd59o+zHT/ZKjhLXXHB0fgAZ9vxdRzCOVNlFpVbgCAt3Uzi094mwU6CULk4iFkaXPqqtoTyj
	fQwZh5S9dHSpZswDaHp/S6yQd6z6gvLc=
X-Gm-Gg: AY/fxX7AtWXSUR8lWrbPVwyregxUKx5GHS8xtNUKRF+zIuFtO8moDaSJO21qiRQbTKj
	wo7+BiygJbIOAQ6jEMflMV+Y2dfTjn5L56tY+MLYKDNy1xcv1XGdLb8uwTSYKH/pnKcxh326hfi
	91hqV4wdrG7ppl3jzTw5yF09HASH4sIP/sy0w+U4huGoTeWP6TY0+id7Jt4E5q/Dd8Gd+cYILnw
	+P3R8n10qFtenD7gCavMfTjf04dV1AlxRFZXO5ObzxCOZUwLG7bViEskspklMLK3qmhRK2t1rGE
	nD2Vk3aesyRf7JHwJHuEYIimWAUr
X-Google-Smtp-Source: AGHT+IHVBqjZ+2rRz+rXPVFmk2MySwyJZuyJ7nvKMm0DMn/H39m8Bx6JqRgDEK+yTcJwNUxu4zqe02+43ha49wn4ajM=
X-Received: by 2002:a05:6820:1519:b0:65d:c79:8b87 with SMTP id
 006d021491bc7-65ea034552dmr3412413eaf.5.1766545398904; Tue, 23 Dec 2025
 19:03:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_replay_die_descr.13f@msgid.xyz>
In-Reply-To: <CV_replay_die_descr.13f@msgid.xyz>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Dec 2025 19:03:07 -0800
X-Gm-Features: AQt7F2pI_7vd-mlRgYpn41MC5ZC62C8R6K3TRAdWnuqoPDR2rb4lNz7YhYQvPHs
Message-ID: <CABPp-BEcJqjD4ztsZo2FTZgWT5ZOADKYEyiZtda+d0mSd1quPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] replay: die descriptively when invalid commit-ish
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 2:04=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> You get this error when you for example mistype the argument to
> `--onto`:
>
>     fatal: Replaying down to root commit is not supported yet!
>
> Consider that you might not know yourself that you have mistyped
> something; then this looks even more puzzling. You might have given a
> range like `main..topic` but the command says that it would need to
> replay down to the root commit.
>
> The only thing that=E2=80=99s happened though is that `NULL` has been
> interpreted in the wrong way.
>
> Let=E2=80=99s instead die immediately when the real error happens, in oth=
er
> words when we can=E2=80=99t find the commit for the given commit-ish.
>
> Also add more regression tests.

Thanks for working on this.  I have nothing to add beyond what others
have already commented on the series, except that I can maybe answer
one question...

> Somewhat unrelated to this change=E2=80=94and caveat not a C programmer=
=E2=80=94I was
> confused by `determine_replay_mode`.  Most of the function deals with
> three cases:
>
>     if (onto_name) {
>     ...
>     } else if (*advance_name) {
>     ...
>     } else {
>     ...
>     }
>
> But I don=E2=80=99t get the `else` since you now need to provide either `=
--onto`
> or `--advance`.  And both require an argument.  So when can the
> fallthrough `else` happen?
>
> I thought that maybe the `else` was old code that predated `--onto` and
> `--advance` being mandatory. But that whole method and this check was
> added in the same commit, in 22d99f01 (replay: add --advance or
> 'cherry-pick' mode, 2023-11-24):
>
>     if (!onto_name && !advance_name) {
>             error(_("option --onto or --advance is mandatory"));
>
> But just ignore this section if I=E2=80=99m simply confused.

Your assumption was right -- that the final `else` was old code that
predated `--onto` and `--advance` being mandatory.  git-replay was
originally developed in my private branch, but I let other folks know
I was experimenting with it.  When life pulled me away from git,
Christian and Johannes expressed interest in the command, and
Christian cleaned up my rough patches, stripping out the clearly
half-baked stuff, and also removing some additional things that didn't
need to be in the initial version, and sent it upstream.  None of us
noticed this `else` had turned into dead code in the review.

The original had the idea that it would be able to sometimes guess the
mode and allow for shorter command lines, but I was still playing
around with it and haven't particularly felt the need to push that
idea.

Even if we eventually decide we want that other handling, removing
this `else` clause for now and allowing it to be reintroduced later
would probably make for a more coherent patch anyway.
