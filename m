Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497783A7006
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808466; cv=none; b=cC7ey3DBslma+GBiv6eVr/5uC7gUPCs1uQhLqvL1WtMR1UX8Y1Sx5SN2/myRvnARs5R294pX9ofrUO7wpVjF5VxsggKLXs2yymTd2AE1TcGi1StLyB8YmgJzYunHzScuzaDeis7cle86F5pmfr8mdCdiu00bXc8JVpTgtDFY+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808466; c=relaxed/simple;
	bh=/0YB23JXc2fNMD6oqHw+jtZsjYmZNi8L5bVzxPrB1e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAmNZN5SSY9HIAi5pVdj1FWGbOYsLSUiUB5dX6ZQH1zNHaAmKYBg2RxGDHeS3en7B5xrDTjL6INHeiYiTQSagjeWQUuUaSF7D2u4AMJMXd824XNbyA+iJk+5aGaOJ0K/YgaqGbl773RSHMp/nh0JG1EGOkDYFhj07kMisvwBYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSl4b2XS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSl4b2XS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7e2762ad850so2015773b3a.3
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 09:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808451; x=1768413251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5Xgpjl3iSMQ8NxjkqoP0QFA/qbMprKbX2QnFY3+2wU=;
        b=GSl4b2XSskaB6P7nncn661Ms63KMNqLHzzfsELCDw5zLFLwc5RIp6yNjxCabEGkaFS
         h5xnqhbZlJ3ZzL+0m6uNk0cYovgGgpfXx9Um2Or8RGe3geCnf6GFHsHH8yYGfQ3SonOZ
         SvljUmblaU62WZ+XAvgs7vDH9RqJzjA0fFo8NCpg1YlpgiQnnjjlWD7ky7YWrTsctNIq
         AtO1GPCUjclSixLs4Xz/BptihXistzmA9qC1oLvGQ9ZUTCuWk/f+yK7hs1ZX1tWc0EZP
         k4DZqHlRiMd3ITC/fn4Q71RDeyMqBiQOhPwNbKxgtVhyhLcztF4Qls+cwXdz7x2cuH5l
         c8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808451; x=1768413251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5Xgpjl3iSMQ8NxjkqoP0QFA/qbMprKbX2QnFY3+2wU=;
        b=bk3Wx/GykWJHpfkGHWimOBFUL6EyLC1okQK89BWh1/miagWTZ7I3ra9ZEatgnvV9YY
         8t8ob/+aM+8Jj4uAK/6kRJ7QaryDrYaS54ki5yYZi4bhjX84VlulMeV+Sef9KlF31S8/
         fCQ1wmU6sOO1/8oRhp/cbRNiAySagkvqINPkQ6mkfBLL5vJIx25IaUXOcinwFlcKGmZZ
         noH2qhP5i7OeCxvyxNPTTpmMmOMBXPqPlGPFiigas2xjrLy83+e0bElyEcZDBNqUjle/
         9qQmEABVlUpMzn5fqjHAhWXXSPd1QnFr05vhned99F7md4mSBiML0TYhcpxZlL4Z8JI+
         zh4g==
X-Gm-Message-State: AOJu0YwcPaixz/vxnJIAiYDn4KdVjCcFxhdpPvL3pYLCmPFPH++3ENgS
	jeiZkqVmBMHvmiNM/bPDTR/ClvPNIBGVWK0T1Pisu3hONnPojfXXc183qkcHXzQU4z0jRfTALuF
	YHmimPPBuVlWHOQuDfwde+HNPUATdKZA=
X-Gm-Gg: AY/fxX6+bM57WzLmAmQBx6jnYLCnD8CGa5N9F63AUS2uiUHTjn3fCvQrGfpE/9njGji
	zFD4YLiBFaczqqQLl6cCmKsGdZbgCdlEYLyL16Xh1beJF9dba4IdYRUwF+sSDa3Q9mm0d33XvCT
	r44ZVY3Qvhm8zqopa2cKysu41Qs1oarzO81DPX9atoI9cp1sc3FpQvwMtORyn7gSGs+4a7tgOGT
	jLGwj0YtgVRTrdtBu9n8WmO6Qmn+FSYF8IFq0gw5X2h51x5dGTVujJsOXox2auauFRUPtJJSETn
	lKgTqSkQqYlhjguJEJ90h2iV26O1lQ==
X-Google-Smtp-Source: AGHT+IEu4FGwg6ObUDtXfFTw32HtBuMNmQ+Qj/nCZWJTamkmVIrfmkcDnbvima3hqo3hrKZxy/s07KxaLbs0+wu0DYQ=
X-Received: by 2002:a05:6a21:99a5:b0:366:19e9:f43 with SMTP id
 adf61e73a8af0-3898f8ccd5emr3111373637.6.1767808450879; Wed, 07 Jan 2026
 09:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im> <20260107-b4-pks-history-builtin-v8-1-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-1-18e9779e3a26@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Jan 2026 12:53:59 -0500
X-Gm-Features: AQt7F2qAmOWRMlOJoeaUdZzMhNkNTwt1Zc_dmJWDT6Kr_-CoZ36V7PL29EQNyQs
Message-ID: <CALnO6CAMX8K6oNzTmcg_stqkU2FCUepdvNfPTGaA-jSaTMzj0g@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] builtin/replay: extract core logic to replay revisions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 5:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:

> diff --git a/builtin/replay.c b/builtin/replay.c
> index 1960bbbee8..d7523fdbc2 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c

> @@ -517,24 +568,13 @@ int cmd_replay(int argc,
>                 }
>         }
>
> -       merge_finalize(&merge_opt, &result);
> -       kh_destroy_oid_map(replayed_commits);
> -       if (update_refs) {
> -               strset_clear(update_refs);
> -               free(update_refs);
> -       }
> -       ret =3D result.clean;
> -
>  cleanup:
>         if (transaction)
>                 ref_transaction_free(transaction);
> +       replay_ref_updates_release(&updates);
>         strbuf_release(&transaction_err);
>         strbuf_release(&reflog_msg);
>         release_revisions(&revs);
> -       free(advance_name);
>
> -       /* Return */
> -       if (ret < 0)
> -               exit(128);
> -       return ret ? 0 : 1;
> +       return ret ? 1 : 0;
>  }

I tried checking the tree after applying this patch, too, and it looks
to me like the return code flipped here? In particular, some callsites
that assign ret =3D error(=E2=80=A6) are untouched, so I don't think the me=
aning
of ret has changed. Now, error() returns -1, which is truthy, so
returning 1 instead of 0 makes sense here=E2=80=A6 was this a bug in the
original? I can't quite tell, but that seems unlikely.

The original blames to 81613be31e (replay: make it a minimal server
side command, 2023-11-24), but there it seems like ret is
"result.clean" (except for some error cases? which are handled by the
negative conditional), and "result.clean =3D=3D 0" is the success
indicator (in other words, _falsey_ means success here).

So overall this flip _seems_ correct, but it was hard for me to follow
at a glance. Hm.

--=20
D. Ben Knoble
