Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5F78B61
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043598; cv=none; b=t5dJGtzmVaP9Y2b461b8O05iDw2LLDF8uL5LJsQpydmXdgBLHQ0YEqE9za2VBXexyeszdnc87FhBCuGrZNQQ3XRt5HN+OtdVhSPGKU3465tiqNJlo/TEhaB+3PqQflMoTP/tH0uP5sdTpriWkiO71AzL3DEOgZk37w5reolqBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043598; c=relaxed/simple;
	bh=ps8vlwXFHsU7qCXXZzqsCV53qUaRhrLWQI4Ttarbb8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2nzKOn6+04O5IxirrypGz6V4c6QbF3BpSiUqFWwpGc67W0xgKjZJykLx3LPuFSG1N34m2gcSWp5RUfSoIjd18HI6LYkZA93PYq81to+BMuUSKQpd7BJzUAToU9yXx5jOIJHqS+nKpWR163JgvF05oO3Gcsho7nXkqbw+KujuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ+9GY6S; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ+9GY6S"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so5944179e87.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043595; x=1709648395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdooa3LzjwUrnvNzdigz7bMVs3sVljNeXHivJXGkO14=;
        b=FJ+9GY6SJ1oODvX1kqcF2uOnaqEsg3HASINnux3l/hBfpjiJeUuuuljd00Pp5DsjTW
         0tK58Aow4oN8qGC6Bk5tub+vTnnZjF4jlLSSwbfG20Swz9BbCkshkEqcNP8Efy8OO3QF
         NNQgfFm+1c6oh9et1BthQUqQjskYeUOvYyJry9zp5JkTjewgECSoNi0dMdf/sojRSkod
         H/1TWY8w3hHcAfa4D4yDA8t1Dm8Bh6mNbkP3LXqaKbknPZNPZZOsp16Fa1bAgaIWL1k3
         ZSEvoeBjbZEv6ci7LwvaThbvetkrl9scxqak0zxhnpXQpnqeUvrWPWkV/Fre3SsatXpJ
         jLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043595; x=1709648395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdooa3LzjwUrnvNzdigz7bMVs3sVljNeXHivJXGkO14=;
        b=o2x8S4xoAMkVEZYB/1oZVpHAfSJf5mx77vDxLyseScIx/bDnj0yKugbzuS9YuPiMzo
         CdR2rW0AA28bQweud/RnCuX1uhlCe9KGqTSFa4p/1z6glqg7WdorJApRar9/CRgmj+13
         QVQFvuB2LrBgvhl3tRdntCC1pKT2I4sOq5FoG9I+5O14usr4TvHyOys5ho3lRVpGSPYA
         vxl/qXR35Qy9mXdJTp4aw6q+WIXxJN73t/Uvgj7YtzRhkt4bjx+UklCNDXERuGvcV2r/
         gDi1GyZW6bfwSkVt5/soXUCLkn/s9rtQZomAgONcmM9MQjvsHdY2V4Mim4WlHp5OHxJL
         h1bw==
X-Gm-Message-State: AOJu0Yz1HouRW1UCI8OmTPh1tuMBtv8zelC+s54H4O8rATOP5Wq5zsnX
	32O4yp7ysM9pGNCLNtI/4HS9lklOg16xLHLJlM9Fr09D+nhZNBnn
X-Google-Smtp-Source: AGHT+IHhh7nPhnjP/I/ZPBPUPLynwnUZbJv6JiZohbu/OtFl3gr3UN572P5A0z20n9jbMtY0YThseA==
X-Received: by 2002:a05:6512:2314:b0:512:e394:bfb1 with SMTP id o20-20020a056512231400b00512e394bfb1mr8001953lfu.43.1709043594758;
        Tue, 27 Feb 2024 06:19:54 -0800 (PST)
Received: from host-sergy.. ([154.72.153.222])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906bc5800b00a3efa4e033asm805915ejv.151.2024.02.27.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:19:54 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
Subject: [GSOC][PATCH 0/2] Add builtin patterns for userdiff in JavaScript, as Microproject.
Date: Tue, 27 Feb 2024 15:19:45 +0100
Message-ID: <20240227141947.71447-1-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firstly, I'm so sorry for the delay between selecting the Microproject and sending the patch series.
Learning about regular expressions took me a bit longer than I expected, but it was all worth it.
I'm very grateful for the opportunity to work on this project and I'm looking forward to contributing more to Git.

This patch series adds builtin patterns for JavaScript function detection in userdiff, as 
my Microproject for GSOC. The first patch adds a regular expression for detecting JavaScript
functions in Git diffs while the second adds a test for JavaScript function detection in Git diffs.
This new pattern looks for lines that start with optional whitespace, followed by 'function' and any 
characters (for function declarations), or valid JavaScript identifiers, equals sign '=', 'function'
keyword and any characters (for function expressions). It also considers functions defined inside blocks with '{...}'.


 t/t4018-diff-funcname.sh | 25 +++++++++++++++++++++++--
 userdiff.c               | 17 +++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)
 

base-commit: c5b454771e6b086f60c7f1f139025f174bcedac9
-- 
2.43.2

I would greatly appreciate any feedback on the patch series.
Best, 
Sergius.

