Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0093F1459F6
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999182; cv=none; b=Aff0UQriONItEbhQ792bJ0CCS935XQogsHR1kPeGolKyWZJgH1GWhbVIHEG3FsvOrcancEb4kRnxB8eb4ILHNfH4xPVatkIfeUlNmy9HOgF1L41YbatsaDOrh1W6TRVIrSa4e+7n+qJsdqvZqSfh+fyf5wBDm70l7RwcJWHfDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999182; c=relaxed/simple;
	bh=9nGtKVg86f0+WpiNNRWOZQ05aKNPLNxyO88N8B8QfIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaVBRfDGKP47C2mFMaPOJDuzn5LXlpPs2nwOz9qwLi6lEWtt7QZJu9mUP3V7BW+kW4TvUM+7PkHkwf7ZemyHT4UXac7jUpZhJbptk1RbtKu1DVo4Pk9J+Y8l6nGNpdS4iyrg9F0EMoZUa1stK//hD0fCeGXfibRgYYSODVpLqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzAN1/+C; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzAN1/+C"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343f52d15efso4066083a91.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763999180; x=1764603980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8YgZqhVZrPPS7Lmk0XMMEnJl6pu1wJdaOIO0jIIQxo=;
        b=YzAN1/+CFK/T6e5cfA0qSwD7t/im0T1fa/V0pM4GbnhKOfVSdzAd5djzBc/MsaS9/p
         cdL/9PYQPC07Xhnagsh3Xrak8SakoBfHckc3lJ03V3zlNYt0cf2DRNHamxquetJw3nrE
         ladz4a/dddnqabqXniXkp8te9TJJAPhw1JvfkB3qek/DGhq6V00wln9kYEa6ROHIp3k7
         3UGonEFulO5rNe/zL+0X+STuQtv2hztojnNOP9v2l6qPFrmAYf2f1XLdAgDWc1SPdyXR
         Mbe3rbF7LUgxuB4WVBEsYMM/QDxVJ8BEH8KCQwFfw6u6ZqYIGNYnXv4RK6CtIdsyucQ7
         uBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763999180; x=1764603980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8YgZqhVZrPPS7Lmk0XMMEnJl6pu1wJdaOIO0jIIQxo=;
        b=GhEA05xGMsXbE68hWtYCBGGAnDnPrXdfJ32XDrEGsfEyzpunawzocSe0RssC9jbmpD
         00kZWKcI2vkAncOVO++8HFHV7lMv52v0SCwPnwxU+3czmtzt4ttkqoKPbuW5+/8XzNab
         T7l2X4vMVj9QWcCFGaX9wRGKLhAIAoBLedprJ8rf5fEnxB5DV604PfdzWVykWSg4dbLV
         5CWm5mC4ylH30BV+nKuNt/cbpO+UgMfSrmewWlRiG8+QMpOAT2UzEdYdEHbGPo0I+0uE
         pOkhRmdMPzL+PLbO+2GNx5fSTS3ChuEzTCMg8HQU2aS8xggbxI9N4tjmGAprZUg1bS+C
         JN0g==
X-Gm-Message-State: AOJu0Yz/c+87cWggRFYHkxIyAvXGi9jToMzEELgUo/Vj93z1VnuM8RNL
	StCglYpONGZgcBHuHFonTEe1oAP7TKATVFghmwjhHArgqXW66xoxwyn0zRy0BhaZi+ELPzTgKz6
	WPJrqx8erLGqI88VRsja252nAKyUI/so=
X-Gm-Gg: ASbGncuYaOri/T/4uXHYpL2JaezfBYpdrWERPcTBoGFoYt76y3v7lrPdUCaGvOJ8S4H
	DLqUBjTkOkQWf7ux58PofZMpqlbHSuvzJktbyPNhXD54XKKdO6exkg0JPjFbkgtrYMVL+XiHDyO
	p2p/QhbjpQuwB6aDWFv+uvkBFmA+ON2fr3SgMOa9Ccxeo7a+YqIY6bgMcPRIa0fqmP7TcXBVLg0
	qbtcIb3eVCKM52323ghPgQJeH7NbJaGG79rPFgxtlzochTfmeeIFXhNGeio6gLgbrbvF8X9MuDk
	UhfVqb00MULcGxJ4qg==
X-Google-Smtp-Source: AGHT+IElZKGccX4vz2+Tx06cooE2fwxgNIb04JDMUq8xK0ikW1Xln9OGAhgyZP5qbAUg8ETalWDWxNNYqKzaDc4pdGw=
X-Received: by 2002:a17:90b:2f83:b0:343:7714:4caa with SMTP id
 98e67ed59e1d1-34733e43514mr10248849a91.3.1763999180161; Mon, 24 Nov 2025
 07:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xb0yqj9.fsf@gitster.g>
In-Reply-To: <xmqq5xb0yqj9.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 24 Nov 2025 10:46:07 -0500
X-Gm-Features: AWmQ_bld9xJpQdbMd17gH1FaTu_FndsRVPSgys20S3PhbCp1k47zxXS87N-cGKk
Message-ID: <CALnO6CDm2K0Bn43gjXTvYqJ8gbX+8eZK1YPn1gwuThizK6d5VQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2025, #07; Sun, 23)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 11:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> --------------------------------------------------
> [New Topics]
>
> * jc/optional-path (2025-11-20) 3 commits
>  - config: really treat missing optional path as not configured
>  - config: really pretend missing :(optional) value is not there
>  - config: mark otherwise unused function as file-scope static
>
>  "git config get --path" segfaulted on an ":(optional)path" that
>  does not exist, which has been corrected.
>
>  Will merge to 'next'?
>  source: <xmqqikf47ajk.fsf@gitster.g>

Any interest in also marking this for 2.52.1? It's unlikely to be used
much yet, but since the segfault affects several invocations (git
blame, etc.) it will be irritating to folks who try the recently
released version.

--=20
D. Ben Knoble
