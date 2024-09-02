Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575D69959
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304953; cv=none; b=CtKouyfxdA7b/KXS8aVLNK/xJQhIJhte2txi7k5BqVU7rrICDJHmxwyn26B5v/t9begTyyZvK6UzESlnQ/7bmswfXEdg39spiDy3Oqx73JwELh4CZAUD3s8oxKiSGPL3UOElCnLLMh2oy1Fqx84Bm9fOeUPvvriYB2XO7MtqL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304953; c=relaxed/simple;
	bh=AO6MFfULFbWlUiaoOCmmDXjl1nT0ga4FsrR/8zztZNI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ov8ERaxEa55KSpG0yeJ9HNwxCtW/Ph2ArUwRuiFIE2FIl4BubWHQKa16q2YT68aplbW1gMJwPJiq+P05ds1OiPP/pjG93gQ5BBVuVpw0wUzHo/411ma+eS4JX+mN1kOnSU76reSHHrGgV7eN6T9rdzMYHndPPdvNCnpbrcDzdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl0Ucuui; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl0Ucuui"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6d3f017f80eso28364207b3.1
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725304950; x=1725909750; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V4b0+8uppsGH4WS1tTWCCSfwAEsHoht1CxBhH1D4zMY=;
        b=jl0Ucuuiki55smUJiuA+Bcld/5pNk1NhWD2DmFHb1qKvTchZPuBsBvFT+JzAtPL8Go
         vZsiQBF2rfyHp1nUJ0qcPht8RHBouHlwkotAZ4IyGpN5G6wkqxqgQMM9d+RzscKRK3NX
         HHUj1PTBy3YPfPcqoDVWLvI9u1NNbr6FRW9cLzf/einl5adTJZoO09o9uemIfG4sN2WN
         cgRo4lyGKoARPv73LIkkuKfxDE0gMmOPv75mX2MK4u/fKgPts8aQoA1GMrLRaKmSammU
         A0OIPGgjAHq+wXFhDs/KPkQ74oqKPkSiW0mbR27ZFW+R5azgVnCf2cpBbF1AoPyuiC2n
         Lh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725304950; x=1725909750;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4b0+8uppsGH4WS1tTWCCSfwAEsHoht1CxBhH1D4zMY=;
        b=d7k13CkWBsvuCriL4c+eg8N5vHWPFKfNYxIKcO5WP/8b5dYqxGg2Iq94JCsYa3wkqZ
         L7M3SbkV7byHuO4Ny8pMqemuFa64drowDjvkjjf0SUv3Jgy6NsoNdLiPTo7xAmx1EgEE
         abo+gba1xnEqqtLsSF1N6YRTe/vK3/7sZMDqwAuUyfjorJwYTWYJxp2WA+tb8CVfSVyh
         P1rVoyIZdJWIcFWwT6h6H/FlkDocoel69qPgmsXW2kHnIY4n0cxvdwb5V52ykJ3qXlyk
         306g9qMgtjECudf254irpCULvGps9+/2vI0jQbudvfefpJh3Porc+3Aw60sYSz/YE1YN
         6Glg==
X-Gm-Message-State: AOJu0YxPeJy3WgkOs3NMl6+EbPT0pIzIC0+ZWrO/MYnBndgcqCRvkJcC
	xQG8UhivBAfGTLsFX9jqo0aqQLg9zFBcQhSnen35i82TZY47ytSSzhDDUaQmQGcN9TezYD9zR9o
	QRba5VadTAjy0CxDKFvh1KOTwIk9aQw==
X-Google-Smtp-Source: AGHT+IFZ9w2c1vQaOvyqgcLs9lyE9xrAY2zOZHh6CJifIQnC6/kgMXvYJPG/sDlp0vJBp1JHc/ng9Oz10wpXlsI+mdw=
X-Received: by 2002:a05:690c:b:b0:6c3:7d68:b400 with SMTP id
 00721157ae682-6d40f3411f1mr117788557b3.10.1725304950339; Mon, 02 Sep 2024
 12:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aaron Gray <aaronngray.lists@gmail.com>
Date: Mon, 2 Sep 2024 20:22:13 +0100
Message-ID: <CANkmNDdgr3MkdYcBgg7rLKPyGrFL8wzdsnBjeNCfOjXMGmmEMg@mail.gmail.com>
Subject: git svn
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am running a git svn import, going git svn init followed by git fetch.

It seems to be a very long running process with over 2 million revisions.

The revisions are skipping large chunks more than the number of files
modified or added at each stage. Is this because of collapse branch
revisions from branches and merges ?

Many thanks in ada=vance,

Aaron
-- 
Aaron Gray

Independent Open Source Software Engineer, Computer Language
Researcher, Information Theorist, and amateur computer scientist.
