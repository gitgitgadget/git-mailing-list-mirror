Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF112E75
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127650; cv=none; b=Vwucu9xIcNV7wdsIIPOo0bYkKuPKMR5azMDdGcXZQRbodW7iYaonB4CGWhk8wK+vFDejzz8OqotM+uylO0TdDtCEyCKWLoWWqznnzLOdzpTeR7/9Bd6kbO9hXBdPUjIQpwJ+G6EYludcVbX+LZa9Rudck+ym6lUycolQ7Ukh52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127650; c=relaxed/simple;
	bh=YhEAG/su4+K9fjjFcGGSpx/RmN7m1C9WONYSCrb75IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GV8KOHG/RCHYtKyQgQ/gSe80oj0dKEN8PfULE1sHRU4jIOjB4GBfbNcCGHZOa3xX3MhDcJpYSrC0cfYukNtejQg0YiRcqlaNYi7IVGMKsh+jsxSg+15o9WBF1R3sLILHdcvhPuLJufcD1EVawvHR22mcmnOudSbk2aIV4RTgYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwGR1TNK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwGR1TNK"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e03ce17b78so365100b3a.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 02:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707127648; x=1707732448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gfN3CriG7csMZ4c5s55XXdcqQRowbLCaV/I18J7EOsY=;
        b=CwGR1TNKtCSCSAX3nJ+QM3PT53ORREksi+TfTuMK6lOPmUY7GDBtaulzIEGjV2wB1S
         LPrshca8BGB5xTKo7O2e58Cb4/9gXmpfQ1M1g1SjfoEzSTD+/1BplJWEWKTavjT6bVCA
         /J89PCgPLlEftgSXgfgYrRDRg8i16tAY8c8fzA/UpgdwPdHEKTzJbkxFIdP7hxqHihyw
         oe35C3wa6zyhve8l5r0HdaXt8QHTxnn0eoeC6ca/pU1n7PVA3nvlDI4mCEXbxGxY8Z3G
         ci11Xm1v9oDDetrODu/UyKgp5m1xJZydhdKFVHtXPHCK51fD2qfkoNE6KYmnRAeW/cgK
         9MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127648; x=1707732448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfN3CriG7csMZ4c5s55XXdcqQRowbLCaV/I18J7EOsY=;
        b=ZLKMeKPrAWjaYbp8fPmH0kk21Xc1xbs3u8s7D90+tjl8b2fN9lmNEkClo4qZd/CYu5
         GILcTQhiurZwMcWHeQ7Tfj0h/48ndyW5MIET1AAXfAluKnGCI5BcDj3uR7rwK9lzyUWV
         VGFlFbLQt0/wP+7I61gwIAWIU4aWftbj6++wpBj3eWVv7+czpPEx1AIgCyfFLzKw11Gk
         0UlvkVLOb7lBlhgT0y3kIGmLwSkdX5UFHmfKwoQQWJpYOMd0iGbThVD7kF/I/3IX+ceX
         OOkTMobpMSoRG5bEzCG7B30xZ0H+F44iJI+6wgJQkVdTU3v44RGog4x4bSjDHnrsz6e9
         zh3g==
X-Gm-Message-State: AOJu0YyWuJghn5W9nQrzVmHlS+N9HdTQOqWq36R5WtlQ/Ghz5yleo4Mg
	EF/n18/Pxs584FWygqhq8vRkhtf1VSLLyxW8gR+w1BMrqjGvbkyLTcGG/GNfgWrfmNT7aFbAe2u
	eMTtoLCN70gAmiZENzuhNEGdNED72lMczyZQ=
X-Google-Smtp-Source: AGHT+IH6wcbGDhcxyf0aWGAqYStakO8FV3uE8dyb+MerBRSLMlqQRtdBNYgoAwHspTWZMzNhqKO3HlEkGig2TerX1TI=
X-Received: by 2002:a05:6a00:750d:b0:6db:d2f5:9e28 with SMTP id
 lw13-20020a056a00750d00b006dbd2f59e28mr7170998pfb.10.1707127648164; Mon, 05
 Feb 2024 02:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv87aabk3.fsf@gitster.g>
In-Reply-To: <xmqqv87aabk3.fsf@gitster.g>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Mon, 5 Feb 2024 11:07:16 +0100
Message-ID: <CAN0heSrX8zQnfk_abtgBreoc=a8Z+7E-jEHHUFmu6740L8p2Lw@mail.gmail.com>
Subject: Re: [PATCH] t0091: allow test in a repository without tags
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 20:03, Junio C Hamano <gitster@pobox.com> wrote:
>
> The beginning of the [System Info] section, which should match the
> "git version --build-options" output, may not identify our version
> as "git version 2.whatever".  When build in a repository cloned
> without tags, for example, "git version unknown.g00000000" can be a
> legit version string.

I've tried reproducing this along the lines of

  git clone --no-tags <url>
  cd git
  make
  (cd t && ./t0091-*)

but this works for me on current master, 2a540e432f ("The thirteenth
batch", 2024-02-02), which doesn't have this patch.

GIT-VERSION-GEN seems to be careful to only use tags on the wanted form.
My build generates a git version of "2.43.GIT", no "unknown..." stuff.

I don't doubt that you've hit this, I just wonder which piece of the
puzzle I'm missing.

> -       # The beginning should match "git version --build-info" verbatim,
> +       # The beginning should match "git version --build-options" verbatim,

Correct, my thinko-typo, thanks for correcting.

>         # but rather than checking bit-for-bit equality, just test some basics.
> -       grep "git version [0-9]." system &&
> +       grep "git version " system &&

This matches the commit message, ok.

Martin
