Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE7AD21
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936465; cv=none; b=WtlAZkocJJO36HNvm44S16FxZ5OVBICVz1CJkci1dGV5I1+wCGPed5qq/kDsWNKFC0ePYGUGqwKWMQEL5ZTdRYDiKKxqYBMlo0dJf6cZOe0sb7Yr7Vu+LcvnCiSOh8t0nMAhFMVgvSm0/ceMk/P3wp2X+LW2aGt3nbyNw9RX58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936465; c=relaxed/simple;
	bh=94QxK73kvX2kjzgCTJfv1kAFvfJeJv8isIqG8Ozm/08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6wdOmSfCBPd5TE+LeErQLCV6o79Xmoe9mLQWWUxVrjBoQAJySneinz3Pfqfc7oNMLG5UMcYQ/P4C0sjrt4z2v587RhuSgmBK7w/sCqT87cNcUDJBD9G3JF4OGvnD5OO/0eObGhF97tX8N5AluVN7XgB1vG8I/ukydVjPdMUi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mkfo0p/O; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkfo0p/O"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-528ce9730cfso1424930e0c.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751936463; x=1752541263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwPAXYlyZXkWUnI04wVTEwbM61OJKAZ0wNPGGK/92g8=;
        b=Mkfo0p/ODeiRzfwh0ZMJT4amQuNNM/9J/ln4ntnf2g8eMcUjjmOzr6IZp4zZdz0KEd
         MNh2v4rTSBx2kr5jSsBMIKUUvd8+3ib2Fu3j73wzln35GwiLMSTeSkqTxgVqJ3TUNvku
         ejgH1n3te2WvKeZlJWajHNVDe8rATTVVZahcl5Qd9hYymkbPUYaq7ResufVmIiHkNAzR
         gkJRwxWdJR9YSZR001w52VpII+2xJ/hKDc6mT5E11IPQODCG7Jqw7eG1t+NI5ebfRMJG
         p7Ap+HYRKzQw+uhS5F6aL9VIri4nz8nHRb6kql8sOs5s+a0QlPYjl1+iLu913TwmVERH
         FUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751936463; x=1752541263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwPAXYlyZXkWUnI04wVTEwbM61OJKAZ0wNPGGK/92g8=;
        b=CuBI0yopkSU5UInGlGWp6M53mh+JLVDplnJGYu40yvjeA4OPC4Z/0fWciUd5hXJYFO
         oWop8DAOsVGPsXFQMuI2PtStBd/78NaYa6mOJ6DK7OqH7Sv0Pc3mowlFnSyLHLk5n7CN
         UkYdCJxSU+I6RHr4Yy6tHo7y6nZQV5UqPczxPLdahmsRcwHb2yTOqab1NI+YuTdd7N4l
         Z0/kT5Tk98YMSErXAbkp+Uz6ERfjZmkml72PdVWITYxKU9LD5JiU1PMNHiS8EeDrcfbb
         XcO/nfadq8exsAuquBWguJuFfC1oo4dtyA0LnhS7xhza3ffBrAzwcKuJYCAFP9V1NggP
         xbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfvX67R2aT/2G+X10MASLVA8ZJVLUtHxs1jgvfTw02WnPiwcMoD9s0+fiOpZcf15oV6f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1zH1N23sAiIUFMfSWvtYLtErC9mdwz5xe+HHapHlC77PrN52
	p7JrAcNqPyu9wQOb2XFO5CAIXrovQSTqIewCQmSC7ugP8C24CF6hMKjaK2QaURFlbV2NlgGruO8
	pkDmKpPccpi+DMy1SbEI+Q+xG79S6iPE=
X-Gm-Gg: ASbGncv7gyBPjHP/W8MIg9bBtNDKVw98g/k8TwZOoAM5GoDSYUxiSGBiuvJ5svC/jD3
	8uQi7pgbaQCjuXYw3vg6wwbGlO5VJhQObjM0BcWl8BroD7dN9Nl8qCOSLf79+rzXuJ1n6vWgeuV
	bmZIaGpOTz+ykn3qWunFEYrexDWFvmvBGCkByLgzJs05o8
X-Google-Smtp-Source: AGHT+IH7l9G9OaY9R+Z2g9yj6YCnlzUiKIXEXM3/QSZhcssWyn/UAsq4jxHg/5Ln7AEHLWjli1DxDwVat+7cnvCpXeM=
X-Received: by 2002:a05:6122:2a4b:b0:530:5996:63a2 with SMTP id
 71dfb90a1353d-5347bfe01dbmr9580085e0c.7.1751936462814; Mon, 07 Jul 2025
 18:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702011214.2835529-2-phil.hord@gmail.com> <xmqqtt3n1v27.fsf@gitster.g>
In-Reply-To: <xmqqtt3n1v27.fsf@gitster.g>
From: Phil Hord <phil.hord@gmail.com>
Date: Mon, 7 Jul 2025 18:00:50 -0700
X-Gm-Features: Ac12FXzUDPyCuvB8sKyOGHoqVwFTHO51AqScimlxnc7CUkutENyoKqbx6QKz1B4
Message-ID: <CABURp0ohikpNPjxP_SfzK+txfbyvmM1adHZJ1C_Oa3SmY-EJwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fetch --prune performance problem
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025, 3:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Phil Hord <phil.hord@gmail.com> writes:
>
> > From: Phil Hord <phil.hord@gmail.com>
> >
> > `git fetch --prune` runs in O(N^2) time normally. This happens because =
the code
> > iterates over each ref to be pruned to display its status. In a repo wi=
th
> > 174,000 refs, where I was pruning 15,000 refs, the current code made 2.=
6 billion
> > calls to strcmp and consumed 470 seconds of CPU. After this change, the=
 same
> > operation completes in under 1 second.
> > ...
> > V3 forgot to include the first commit in the series (I forgot it grew).
> > So here's V4.
> >
> > Phil Hord (3):
> >   fetch-prune: optimize dangling-ref reporting
> >   refs: remove old refs_warn_dangling_symref
> >   clean up interface for refs_warn_dangling_symrefs
>
> It seems that the thread has gone quiet.  What's the status of this
> topic?
>
> Thanks.

LGTM
