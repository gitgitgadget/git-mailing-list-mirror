Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D66221FBD
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771277629; cv=pass; b=RzSlrq82ZLgGkiL1uKZwmrNqKK7MdYtIz3eIoSFjQWy+oL+OYX9UoTWRaLVB+j0NzpAil4ASJIMIqtwPKB5htaFuxOzvgiUtK3xT2U9iiAP4ymcfzCxFNH6c5BCob1psTvdcpNn05kh2LBSwMoxpmDhjJO0yy2gwmhJ3xLAillk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771277629; c=relaxed/simple;
	bh=tp+EictKhIut1VP+yZ2hF/un5dK//xgSrlGd+FxpksI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVUGx6JBkH9US4qh4BE0UTw72SWWOKgUQcgE9w+dSXqEy+kXoJBDHO8mnxA+6KU34hSSEGGjqVMgrMaqr8H7T09po38nxsjxVwXl4us+2itmDRP+iKN2Gs/t5/RYL9BETw8Qa88Mckh2fWya4R+QXoGmJWPZE8vlbWsrWjW33/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba/aMsMw; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba/aMsMw"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6c444e89bcso1130020a12.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:33:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771277627; cv=none;
        d=google.com; s=arc-20240605;
        b=XUxe4QYI12NnfVUTy/L/uCOci30SPyVjW3hpOx9wdcYlJ6ADU4pydGRD6r75bawOED
         Xk7w71XRTt2fLZ3fJodt9AKBKkI+e3+zxbGJwF+jikP5PrDkq0QrlCXqJnqjtzimScQ5
         u3veFKi5ovyJwEFsS2FLgcssZdKDfWII15nGE9APoiC0nDws6KflpFquU+6NQFpEKgO0
         9ipzPCV/6q+nsmT4AItKYdCD7uhMwqiaZagaRP/c+rNQSMzJ8hj/+++e3ikt1Al6qwCx
         ep/nrc/uI4VRoD7vGPapgKyu+u3wadPPh+Dsmn6oAKEJekfQ5PEBVVVraxkWPPGGmrm3
         WuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wm6b4TT4vDvS0EmlgFKqhoLDwkvRjKZOml3YCKZ/orA=;
        fh=4H3NLKFF0j/mFW633iXwrQOiln/XS5l0uCWVWR5x9Ps=;
        b=OMPHtuepXUicnzeR0Vs+0giLgeqlQDV1H0ZziOu/3hd4lZhOtsSxZE6cO64y8GSj7j
         RfyjsGKD3fAG0YIQfg10pcBA9Ld7nDsRFnXM4qRp/DRUfTBjq87QsxvZ+kbs3Nd1+8R6
         WZD1mmhw7Lgs02AVfPWNQYpVAT/d6/nWmHVBjfD0CfOMlsz8uQrDf9o+vdvInBqHEpef
         LxqxNv4dX/X5l7bQyiFu3M131K2/7USU4ojOrhzw95uGAHSTAhoWEFKd4QE7EuZD3XG3
         Vevlbeb6WgfAgsudTOiCWDbuy3NaMoOOkzdrk/KfHwU232viW00I2ocxFuM8hcKeN/3N
         EUuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771277627; x=1771882427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm6b4TT4vDvS0EmlgFKqhoLDwkvRjKZOml3YCKZ/orA=;
        b=ba/aMsMwuYIjR9kFgHmJoHGufKtRxk8J7XeiNt4CGxyon9TPe6nWIBdutRajlWJakI
         9tlZjtsq+nJ081FAnUpB/ZS+7Qu3CdbHd6IiECr4vAkHjq8mm1bSvF4jRobn4eXEZuxL
         cdxzY+Hz2WJpS+UCMwSKdURaHtpZhY0cWmNb0ZGDXuXSTiUT9rrJAiXEe5fI0MI1BB+k
         l3JF46EMDNS0L6jzo+jiLGt9yooQTsQkWbFCEdpS5fbeLsPDgx1btZR0Wa7/gEGEVtUg
         suE2wdSfyVyEGR+B7Mti/MXJ0H9vFBsK310TRTnEuj4vMwhwW5nEtkMHQMJQrsg7d+xL
         95FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771277627; x=1771882427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wm6b4TT4vDvS0EmlgFKqhoLDwkvRjKZOml3YCKZ/orA=;
        b=GeQbHBiTYNYSjeOO4uRwi+8eAEMxw/OOWL3jGd/KO7E48d8draSZthkJ5blDlt6jNB
         831ZNSnG+SbaWoUExcpfvbfAHxMNScwNemYjAs0mK2uPDRTBsOEwCTKPKfHHK11aOjq3
         uj1lsCAxyCOxWLieHTE9f4RxFbQWO8arOHJWNi8wcaZXkWkTCr7YES3O0eM9g2d6XkHF
         ZKmjg/isJw2AtVoxWMMx2AI56pNk6fFkipjrcUCOvoSqDixgJEyXmGXC4ClNR3Wy9Mtu
         9ZvJeJ1ffcGYxQ6Vhoc+fhDZ5/85swIX+RQmBSAPQbpq2RkvT1NKvowla9QWRjOxtmYi
         2b4w==
X-Gm-Message-State: AOJu0YzT/9JCQ6tiN2Qhjaym1GJPRpLnkGg2QDlMSUfSqRfBYfAw/9bR
	Y1qDKKiHUQHVyv45c/vqMXyQdsY16fIosvNflVD7DmuzKUwb2wvwZWtlhbSfRP2uzybPKX1GuGj
	UU6u6cvGyqamFZ8ksjh4+bR18QcHBhx8=
X-Gm-Gg: AZuq6aJLNrJdBSwN0eXzszoo7CgpIRY1sGYC1Z6D/h1+9ZevsCwF+3PJOGmvwru1yS7
	SzQ9wswDisKqPJDhUJ7ZEAKW5tZ5jr3G+WQ8Q9ClE7N8kT/Ss7up88NtYUTUXXO3ekhuLQQQLkH
	sSAHTdKRrwhKlVOog9D7trQyawF7dWmPRmm78A2s8+mt7nH6AG196x9mVmS306lXwr6q5fKp5k0
	+K7tncchywAKQNDZuVP6a/fEmh+IBvDujhn/4TzY3O78zxlbGKFswrlMCknhNi86UHXuqmQUPh5
	KGNOmoLnUT4BFQP0MkEOT/P8Iq717fNPDCuYRU6bzoYB9sc0WA7chXweGwfeJieSMqg7mP262Cx
	D1f3YOxuEMhVlrxiRhG8liNv0dw==
X-Received: by 2002:a17:90b:1c09:b0:354:be2e:c056 with SMTP id
 98e67ed59e1d1-356aad5e5ffmr11800518a91.18.1771277627333; Mon, 16 Feb 2026
 13:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215201906.889951-1-ask+git@howdoi.land> <20260215201906.889951-4-ask+git@howdoi.land>
In-Reply-To: <20260215201906.889951-4-ask+git@howdoi.land>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 16 Feb 2026 16:33:35 -0500
X-Gm-Features: AaiRm505ODWGIq52tzkXILxC-VJ1H9UJJB8fSRDJKNRjWr6Dv9TQu4JaZm5YfBY
Message-ID: <CALnO6CAK1-+MpvjjPFUCeOEbDQn+R8EG7E8bmHo1XYt_ZMQpCg@mail.gmail.com>
Subject: Re: [PATCH 3/3] contrib/subtree: process out-of-prefix subtrees
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org, Zach FettersMoore <zach.fetters@apollographql.com>, 
	Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub, 
	Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 4:16=E2=80=AFPM Colin Stagner <ask+git@howdoi.land>=
 wrote:
>
> `should_ignore_subtree_split_commit` detects subtrees which are
> outside of the current path --prefix and ignores them. This can
> speed up splits of repositories that have many subtrees.
>
> Since its inception [1], every iteration of this logic [2], [3]
> incorrectly excludes commits. This alters the split history. The
> split history and its commit hashes are API contract, so this is
> not permissible.
>
> While a commit from a different subtree may look like it doesn't
> contribute anything to a split, sometimes it does. Merge commits
> are a particular hot spot. For these, the pruning logic in
> `copy_or_skip` performs:
>
> 1. a check for "treesame" parents
> 2. two different common ancestry checks
>
> These checks operate on the **split history**, not the input
> history. The split history omits commits that do not affect the
> --prefix. This can significantly alter the ancestry of a merge.
> In order to determine if `copy_or_skip` will skip a merge, it
> is likely necessary to compute all the split history... which
> is what `should_ignore_subtree_split_commit` tries to avoid.
>
> To make this logic API-preserving, we could gate it behind a
> new CLI argument. The present implementation is actually a
> speed penalty in many cases, however, so this is not done here.
>
> Remove the `should_ignore_subtree_split_commit` logic. This
> fixes the regression reported in [4].
>
> [1]: 98ba49ccc2 (subtree: fix split processing with multiple subtrees pre=
sent, 2023-12-01)
>
> [2]: 83f9dad7d6 (contrib/subtree: fix split with squashed subtrees, 2025-=
09-09)
>
> [3]: 28a7e27cff (contrib/subtree: detect rewritten subtree commits, 2026-=
01-09)
>
> [4]: <20251230170719.845029-1-george@mail.dietrich.pub>
>
> Reported-by: George <george@mail.dietrich.pub>
>
> Reported-by: Christian Heusel <christian@heusel.eu>
>
> Signed-off-by: Colin Stagner <ask+git@howdoi.land>

nit: "git interpret-trailers --parse" doesn't understand
line-separated trailers, so only finds the SoB line. See
git-interpret-trailers(1).

(A useful test locally was something like

    b4 am https://lore.kernel.org/git/20260215201906.889951-4-ask+git@howdo=
i.land/
    git mailsplit -op
20260215_ask_git_contrib_subtree_process_out_of_prefix_subtrees.mbx
    git interpret-trailers --parse p/0003

which output only

    Signed-off-by: Colin Stagner <ask+git@howdoi.land>

which I don't think you intended.)

--=20
D. Ben Knoble
