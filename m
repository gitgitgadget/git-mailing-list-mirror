Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9812C21D0
	for <git@vger.kernel.org>; Thu,  7 May 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168366; cv=none; b=TwkSxbSlyOcpZ4INO0ZYQd4qLImTNORNcFUxJtcJIpu2FQC79cyAbIPP6dcXPPkjZctyYoV0nvvFk2faNvT5vMvfRcwHrsan9Nwh0LDj4OUsqo+0Mp8oFro2GESfL8j+bamXCVS0y2aCfP0QuRz2I/5oLTbAXPuU9IBCzGOMuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168366; c=relaxed/simple;
	bh=bm7YYLA7lSvN+qbrEs9/+SLMoHRL46BhdeLnTQv//fM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=fPN7Ji50tGldqEEWZMuLq7ORdbP8jFcrKTDqOLAq3N7MHaKZmvFZcUzfX0+T+lmdfQkKatKxvyAWHy7rJ9Ovrl4Ox+ptAE8YwKgpecCn8JYq8qLTgv/rW5YkIzqwlfaBVxndx9KI1uILnIOeUKweSPGy/m8mCx3FIfKW6VtTcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfd0iJvH; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfd0iJvH"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c477a3278so1061514d50.3
        for <git@vger.kernel.org>; Thu, 07 May 2026 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168361; x=1778773161; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPLHr01+iPGuGgECt86AWoU7J8GV3eDq6YZo0y4IuCI=;
        b=Rfd0iJvHn40yRXqiKXbr129Sv0rCcxyevyG8et64QNjaA4VpPPZtl6RUhMDXl2/+Li
         ux62xjWLZOrW5APNBgo3QIirCUmMzvwfV918pAlUaaL/pOKHVCpwjeEmozpCDwscdfsx
         +q1CM47+ZbOCN8HId4VH2SBp/peQaBb0sDjRbIQ08NqoSbukwHZQqcky1IWVd4rQTnNS
         l24EV5wf11u40yj9E/jBsbgSXCBSmQrrA/94gvqDMAeOGZDgRZFmeTERBwGL566hfzW+
         HsTOA+KtNLc7wkn3jzUIroK6DCaR6W8VF3pRjMQVvbDvgF7ZwzuFxUal1jgMumkW7yWN
         pttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168361; x=1778773161;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZPLHr01+iPGuGgECt86AWoU7J8GV3eDq6YZo0y4IuCI=;
        b=Wg2iWznYqOgPdSIQE31YjbxTVpvsTGZ5Z7vn0ywuOIUQ8UHcDzd4wyRM5SQfoyaazm
         pes75+5zEvzgjXI/yrwbBgkLic+N6umSbpeVrkaQLNwPfzB+dNu6Bm/oLZrl3fNmCJL1
         ZLYBfevT6H2bFK+dhgZ8QbNqbk/NZWjcXflgFCavlDVHlUt2ubmdouBqECET+qgYkCAG
         ee5MfEatY2Pqq3nNuTfx4xEUtTb6k3ZFnoSSKNYBi19ifNswKk9z34JR3DH2iHzlLe/k
         unCetHChrSsxFdcsY//fzeRIW8zryJiYW8M1z5VbbNJGLtjKJJW/yyHpeCEO9XG99ULU
         zeVQ==
X-Forwarded-Encrypted: i=1; AFNElJ925xiKhHTQLH/2e4DJ9UHP7svK1CintEDcnAKNDUqVu7M3Cp81JRZ+wv/HQk7/HmtMCMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FlV5JMbVfpo+H1+WCuHvnQGcmJ2l6dT2dJDRPIKiIVnbmPKJ
	QrMcL3UEIeff92ruDgJh0ZB82FFy7eFForeHv/fMB6AwfCF1A7yv+YFj
X-Gm-Gg: Acq92OGkusK7zs3/4lkFaKW8kHMdhf4VjdrZJJJTL8feqG9Tbhnv3BS4m812nDk4IK2
	F7ugUxqgrP5bVJm2tPvAx47WTSYm/HOshD6G4ZTw8lQA/8lJOQfDD2JH4qmEowKV3wnC3f/ZI19
	gOPBLjx4ouxVchdMrp8qR//o3XnxlwS/3Cw1stNEfcxMfEEguzqc6E0qOPiuSb3cxwQ+2Bbd0Kh
	NG5tZG8hHMzpEQeU3DQAfZjcRjB5COHit5V/nL+CBMU8TZnX19w0d57tPafIMLwZeXGxZo+mYY8
	8fqHkK1QZcnZA80F4iNLYE+Gr41cx29IxfAfIrIdIIih8H73RudqdBvE/8VoZ5WcMIFYITO/7KO
	58nh+G5ftQ9PwsVcnmp6QOgipYMa1GRHRL4x3HVhE4d8Nl5XTCTChD8wca5igaDZtJ9s7ChO0VZ
	QEkh0JhpB2f74inHMTI6RPgYwMx0JB776t+eB7y8/Wwt1SPeVAkxyvU4sYIilRNW0e8aB9XDG3e
	X+cKcIvXMVyiRFz34BlJjXiWcF5Eh02gMXJa1T3xeE8TUeuN3J7A5cJISAoBinlPA==
X-Received: by 2002:a05:690e:15cf:b0:651:be50:af09 with SMTP id 956f58d0204a3-65c79ad6df1mr6498189d50.3.1778168361045;
        Thu, 07 May 2026 08:39:21 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:912:e72b:658e:a9fe])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d9027a275sm50035d50.20.2026.05.07.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:39:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH/RFC 0/5] replay: support replaying 2-parent merges
Date: Thu, 7 May 2026 11:39:09 -0400
Message-Id: <21A507D3-1B0D-4404-8AF5-9485B01E63A6@gmail.com>
References: <4a94c675-661c-1f2a-27d0-3f10f761cf6a@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <4a94c675-661c-1f2a-27d0-3f10f761cf6a@gmx.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: iPhone Mail (23D8133)


>=20
> Le 7 mai 2026 =C3=A0 11:06, Johannes Schindelin <johannes.schindelin@gmx.d=
e> a =C3=A9crit :
>=20
> =EF=BB=BFHi Ben,
>=20
>> On Thu, 7 May 2026, D. Ben Knoble wrote:
>>=20
>>> On Wed, May 6, 2026 at 6:44=E2=80=AFPM Johannes Schindelin via GitGitGad=
get
>>> <gitgitgadget@gmail.com> wrote:
>>>=20
>>> [...]
>>>=20
>>> While I was at it, git history reword had a pre-existing
>>> silent-success bug: a positive return from replay_revisions() (which
>>> means "conflict, no updates queued") was treated as success. Obviously
>>> this should never occur, as a reword simply does not change any of the
>>> file contents, but bugs do happen. The merge-replay work is complex
>>> enough to make that class of bugs more likely, therefore I introduce
>>> error messages for those instances.
>>=20
>> Fixing this bug sounded interesting; I had a hard time spotting it
>> while skimming the first 2 patches.
>=20
> It's this part:
>=20
> @@ -482,6 +482,9 @@ static int cmd_history_reword(int argc,
>    if (ret < 0) {
>        ret =3D error(_("failed replaying descendants"));
>        goto out;
> +    } else if (ret) {
> +        ret =3D error(_("conflict during replay; some descendants were no=
t rewritten"));
> +        goto out;
>    }
>=20
>    ret =3D 0;
> @@ -721,6 +724,9 @@ static int cmd_history_split(int argc,
>    if (ret < 0) {
>        ret =3D error(_("failed replaying descendants"));
>        goto out;
> +    } else if (ret) {
> +        ret =3D error(_("conflict during replay; some descendants were no=
t rewritten"));
> +        goto out;
>    }
>=20
>    ret =3D 0;

Thanks, super helpful.

(Perhaps later) if we can say _which_ descendants weren=E2=80=99t rewritten,=
 that might be good.

>> Did I just miss it? Is it worth splitting that fix out to a separate patc=
h?
>=20
> Well, you _could_ argue that they were not bugs at all: a `git history
> reword` isn't supposed to be able to result in merge conflicts, nor is
> `git history split` because they leave the respective commits tree-same
> (in the `split` case, the second commit).

I seem to recall Patrick making a similar argument, but don=E2=80=99t let me=
 put words in anyone=E2=80=99s mouth.=20

> I could see the point were anybody to suggest using `BUG()` instead of
> `error()` here, but erred on the "nicer to the user" side.
>=20
> The only way this _might_ be triggered before this patch series is most
> likely by playing games with replace objects. Or maybe you cannot trigger
> it at all.
>=20
> With the changes in this here patch series, I wasn't so certain that I had=

> covered all the edge cases (an early iteration of the quick short-cut in
> patch 2/5 keyed only on the parent commits' trees, and forgot to verify
> the merge _bases_' trees, for example). That's why I think it matters more=

> now than it did before.
>=20
> Ciao,
> Johannes

Makes sense, thanks.=
