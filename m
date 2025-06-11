Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1F2C1780
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749684412; cv=none; b=Tyynh1guJX5pAxGp2onPnI96i2oM32Wx65Ry6u8d/t5LDQ/Ruj0Ya3/95eFHqeLRTnYMxxCe/m0U4sZHumFiQK7k1pyDATeb5tm9x9mhwyB9VawcjB1Y8VP5BM/N2BxqadFNK9QpxEZjh1vmjYKc13+v0i+3bf91I18Xh3ISoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749684412; c=relaxed/simple;
	bh=VnfgVV5SUzmv3u08HD0YmgFVP6cRe45isPHFHmETfSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCTfMvdiHxbE3g6mOzIXlBHBPrNz2PY8N1EhQVd1cLa9l0DkUDFPnyM2XIBQ9f6iuG3jzujkcYVLnI3iOrB6SaOg4a4AQUsSyx23KVtzp9xVpAMfAreK9Fj/saeO5jZxlj6Hpg2Wv1osgDjlZot5ZB6AUyfQxFV0CCB9ECKFwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+wTowzq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+wTowzq"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad88d77314bso77410866b.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 16:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749684406; x=1750289206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNLI7lYOX1REGpUkYIY+yR83U4JzMJToE71frcgaV68=;
        b=L+wTowzqREcsSkdlQ0eWtdy1VFnU03GMUkCGFqMPkUgXd4Vc9zBfjQkaXGe5jX8D8e
         M7cCWZB6PInRpFTVxD/26D4iybTTKk+35xYHyispNO/02ReLbN+cg/rqdBuYczPxjNOb
         c2uLRyf9+cW8245hNmZevZv2PRV/dFzpa7mJPaMnzFLSqxSogzg2jw79nX/86dKDiF8D
         jv7uF76+dEg8bFTBzgesmaLdxqHDmcHuI2WsD9t8zldtMEE2W+1Y2buVv5QXTFUNFr/B
         VwwdfRCc+mUMl6PnLXSN+JCZB+UVzGbu99hpA3b2iozZBtAQUlLUJFWpAPbzuOYiwrrz
         om0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749684406; x=1750289206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNLI7lYOX1REGpUkYIY+yR83U4JzMJToE71frcgaV68=;
        b=hN9U0ZvbUv5UXsQuXCjYVUdlIc8jNoY42h/wYjApN6jxlX3auKV1JCgOa1+faXRp6T
         xOGgyjKwnip5v+p7Xoe3MduhV72EpPXym7ScjcloSn+UMk91hwLGnNso1spv5zFADwJB
         k5lIGUbmTr6ApRBvF7WbZO7LuaPwhUeZ2hbbhn8IukYQCLbqnswzgOs4UHJS5Swgdwjc
         2oR7vNWBQMR20UnHY+tjbGVHKfrOCZlwXeOquRs++MjLPqZ0B7E/FgsueOJh/CamWblE
         8s6UPRk3Z8JQzRHMMohcAzUjxhHksdYFYQ+QR3sogkdB4p1ZBvr6WfnndURXXA16dJx0
         kp5g==
X-Gm-Message-State: AOJu0YwgpLjWGIIaie/5xHLHVxZJr6ivvtYAXYzjKcaPK+G5KrD4flyb
	z1KTSWzQxECpvpbzYD2Oeqnu+YBlWaD7uxeNy7cyFdhO1+WtR/XhMnYE6zrbr94MQGdr0MXVDDC
	hXI1FG3mE9e8n+050uhqesJrTKkk0EnE=
X-Gm-Gg: ASbGncsSvvKOTLniq4V74oGGYgzckHq0jbjsxswindYss2RFA4vddd4Pqew+K9rbR8j
	4+UZCuEJ0fSF6fZlqSmUxrVLK0ZJpYGCF1GNVQtjW+7S7q5FzBoHUe+TgKShjlsBTQrnxXyNQ4V
	IJJZ1z4hZ/YXwWfJtChxCaPXU3V+rmOQzW7S1TAmZ6s5kW11cS7OArAKTakqswfTOteT5iZaz/u
	kk0dA==
X-Google-Smtp-Source: AGHT+IH1QGXGV8a5Dev/bbfdSZhSfqyap9L6TypVOU8/dCU1/KNTuU+zPwZecVxMrjC8tW9ZP16W8zvWSVGmuUayWhc=
X-Received: by 2002:a17:907:f509:b0:ad8:99cc:7749 with SMTP id
 a640c23a62f3a-ade897ab220mr445157866b.47.1749684406108; Wed, 11 Jun 2025
 16:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xh6xlpm.fsf@gitster.g> <CALnO6CCnjP2XnCw1CwyXztkHHMv-U4zrvf8_m2X4-isvPL3ygg@mail.gmail.com>
 <xmqqzfefj7j3.fsf@gitster.g>
In-Reply-To: <xmqqzfefj7j3.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 11 Jun 2025 19:26:35 -0400
X-Gm-Features: AX0GCFvLPHSzxs0-L7YNpCqmM2Oydvw83B0haQeZCmTC9MaDUeIV2e2paWVV8vI
Message-ID: <CALnO6CCrCcEp1FWWWPQ2fts-n-jHZdfYWsyYsG9W5aUV42gs8Q@mail.gmail.com>
Subject: Re: [PATCH] merge/pull: --compact-summary
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 11:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > Does this suggest that we either want a "diff options" option (or
> > config), which would be more general?
>
> If I have bk/new-topic branch, here is how I would merge it.
>
>     $ git merge --compact-summary bk/new-topic
>
> but there is an existing merge.stat that (1) is a mere boolean and
> (2) is true by default to force use of "--stat" option.  We could
> extend it to "bool or the string 'compact-summary'" and when it is
>
>  - not set, do the "--stat" as before;
>  - set to true, do the "--stat" as before;
>  - set to 'compact-summary', do the "--compact-summary".
>
> With such a configuration variable, "git merge bk/new-topic" would
> be how I would run my merge.

Makes sense; I suppose my question was more along the lines of "should
we go ahead and support extending the options we give to diff more
broadly rather than add a one-off flag (and potentially add more
later)."

--=20
D. Ben Knoble
