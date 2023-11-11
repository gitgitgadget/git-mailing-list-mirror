Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB705678
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jipkbgbc"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C02593
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 19:45:41 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c594196344so33440931fa.3
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 19:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699674339; x=1700279139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6RMZ0X3FUtkiiEbhijb6Qb3Jjsjw2ohbStAegXZrbI=;
        b=jipkbgbcUPj0WQT0XAU6qUfQC4AOLX4d5g+D0YTLCgjpzdciCWtNXwO8jDiDUNYvsU
         6z+tHM9ql0nQYa2F6QsXEeEz8g6PBBt5UOYRgwIoQtJO2WXJHJ+DWxerZpowm8mHtcD9
         q/QqtEHpcgujl9O6Q0tSsDRf9AwZQzb7/TWyHLq1AFwLkT7OUo9ZqLKBdSPQydnARrrp
         KVDtC1zInwrdEMLNBVuXQTuub29RFlKbH13oRH0RNvh3nS3H6+WW8fiXr5egG83obLMr
         oXO4WakkfYmILKVSYCcPCWzMGOD/HsF/FEijQWWHWhb/Kw8h1eCWRgnj6UKl9XD1yNUo
         gJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699674339; x=1700279139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6RMZ0X3FUtkiiEbhijb6Qb3Jjsjw2ohbStAegXZrbI=;
        b=uz39VqAwvhB0nOUxc4VcILJHO7alHSZh9uEAcznTShlfmEtJxc56ijyeP4C15U6bFH
         zul0TEkB5PMwsNWx4++MKDZLEefFQ9NK5C0y6A2huFeHQJt2iQP8hdxIixENuewu7S5x
         okQaHpbm098dePulpTE8yHMbSCtl+cIBaJhjVhw7szS+TiLv2hxFfaLd21I/575b9Ouk
         L7MAx4fq2C0Nrk5YNsSefiQJuDLP81aLeI0uXQrNUTbaEXA+b5GsBzHKp0qFKuuHBygz
         il8zIYn7hGdmZYXdSx+bS1hLcmDoGCdhOUPxYdL8Pmv8+0kuRV9AG9+LH2vZR+qgPWxp
         X4NA==
X-Gm-Message-State: AOJu0YwUXzaBbizf1xs7xQx8JwEmhF2Obb7KOLi0aRiPw/6iw13/ksJS
	mwT+zg4GSjf0YTC5ztE0AUXaOecgwtN3tIVUy3o=
X-Google-Smtp-Source: AGHT+IEWwgMeb3xPRaEH6tw83/iVygCugqitI0TaWhshg3XjYDfMgDrMgYG6oLe/bGo+6WBMMzCwgMoXRduHKU1jaAY=
X-Received: by 2002:a2e:8388:0:b0:2c6:ee51:87ab with SMTP id
 x8-20020a2e8388000000b002c6ee5187abmr620464ljg.35.1699674339435; Fri, 10 Nov
 2023 19:45:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUpepnSCSxL8i96b@nand.local> <cover.1699381371.git.me@ttaylorr.com>
 <c615a61d32644b64ef8f47feb47ec909286c56b3.1699381371.git.me@ttaylorr.com>
In-Reply-To: <c615a61d32644b64ef8f47feb47ec909286c56b3.1699381371.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 19:45:27 -0800
Message-ID: <CABPp-BGzWciTAyyFyBwfjti+EPoNB=KdO3bUcS-=FOgT-X_NiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] merge-ort.c: finalize ODB transactions after each step
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:22=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> In a previous commit, the ORT merge backend learned how to use the
> bulk-checkin mechanism to emit a single pack containing any new objects
> created during the merge. This functionality was implemented by setting
> up a new ODB transaction, and finalizing it at the end of the merge via
> `process_entries()`.
>
> In a future commit, we will extend this functionality to the new `git
> replay` command, which needs to see objects from previous steps in order
> to replay each commit.
>
> As a step towards implementing this, teach the ORT backend to flush the
> ODB transaction at the end of each step in `process_entries()`, and then
> finalize the result with `end_odb_transaction()` when calling
> `merge_finalize()`.

process_entries() contains a for loop inside it, so "end of each step
in `process_entries()`" sounds like you are flushing after entry, i.e.
several times per commit being replayed.

Perhaps "at the end of `process_entries()` (thus creating one pack per
commit)" ?


(Of course, the fact that we need this change earlier, in the other
series, kinda makes this point moot.  Just thought I'd mention it
anyway in case it comes back up in your restructuring.)
