Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929451DDF8
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167776; cv=none; b=WZbzfXhb380PDVuxnkqnRGmdcuWcxhwWBKbw2DKcREwcZ41N0Id0lBuy2wWkpRWynczQap5/bGF3UQBdH73tv8i/i0YM0vwQYD6xcKe+uD8QI44G8F0FOfIrXnEEj3DLr8p2lCJVY4BRahnOouZMgrP0KiezHuEHxPz1hjWSkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167776; c=relaxed/simple;
	bh=YqBSxaY6FOfTyfv5YizWw91Lc1r6XnpSeMa3tRmiTak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0kDuLyQ9V0d/K3ybaliyU0euZ7EalXaU6E2Ra02ryfobTpE0BpU+94J5QTQbhKTXaJKaxvnXEplNAssPJLIXTo65W8jDOJK8Fdl1D1wMK+hzkMdX4ihdxVA+OWU4za/b9paoFxqSJW9VRZ0dS7RTZpFpTEqUPoBaQT5mpNcSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OONU2Ie6; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OONU2Ie6"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d33431c8so108875966b.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790167773; x=1790772573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqBSxaY6FOfTyfv5YizWw91Lc1r6XnpSeMa3tRmiTak=;
        b=OONU2Ie6CUnusRfcwdJ360pUtiNLvMPzt2D/WhJn9i1JddXuE0ZqZnO02eJhfslF8F
         nkownaaktbtjP81wo8WdBSFfAJJfLLVa0N64E+FA9Jo+ufM22ht+JklK5i9D6JJG6KcH
         fGbQDu3fJhEYCElOVVHxoVzyLoaUJRKvGce08Eb3DXtDwl4cluAb3AHD5q0T+31tm92p
         N6ZALKQb58i62e/feVeaIhTVRLSI2P6LQ2WiCIhCF4Pflsfr5hcYkSxwO74eQpxXR6iO
         nLKDkNeLVUHDbny619bDj3PnAEDjh4sL//OQXPcvFG+hQRk95x7sJppkLSmpdjyoiGH7
         k+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167773; x=1790772573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YqBSxaY6FOfTyfv5YizWw91Lc1r6XnpSeMa3tRmiTak=;
        b=0HoCeKfaAN+5HUvS1Oh16geoUrOgVTOAlge0CtWhzFhBErhjk/WIoD3AVxclJQNkMg
         7IeEOCRZ5qiwoZJgp5Gk99TY/u/FMie/2L1sNwth7Q81cScliD2h65rQxi/yf1f2hSSQ
         PIdI4nPPIiNBiUxwIF0GN/vqHCsg+QMLugY1RBmqpsSzyPF20CukRL76U3Hj7g92N30N
         z5qYvnkhbe2typMoMjT5DUnsFYcFNA0SGAvHo2TtxE9rzpT0wjpmOfByCM8qMA4A/l0Y
         xAAot3nVdayrp42Yck4lVt1mCnLOQgoWKnyCsHDnhIJWDScomu3S1r+IfmYBS/xSHV/C
         yOTw==
X-Gm-Message-State: AFuF++mGelDqKZ8SardHykn+dw74THEPNM7MVwGM20aYEYvHNpl8wxrX
	TUN39VR9FLDQF2U+KhsVQx1i7wX9U8yQJlXUXtGEjqLNJGl8jmLeMlRiMHwW54Tf
X-Gm-Gg: AYBFou1Y48ss/Sc78v5QsyeCT//qCbV+UhN8+kGaHP5u7m6wjeWbWpWodpGVk6c+w/8
	Ct80tPnaqtFkQrWr7lCg3qSYTI96zAxGfkMM2HQcGJq7w9OnsNrp1PjUlB672drNCCSMx6jGHAM
	Oai0PnMU42DMLRPP6lXvTQyFpiAmbtIDQGyHA7nuqvm3Q5j4BVaKVUDO//rD/pc8g6lUggp3Tvu
	ZCrxiIjBMam7u1VsX1b3/b7savAlnVOk3XYZzN4hr+0hSRdHq0Bd9dQkcC18jQf7NfodyH6WQIq
	EfZRqcl2CCFdMAjet/EoKnlAngTzABpRT5+4NG9cWNHd6uVI0gz/bPjTZMkgIVKi4T/j1VLjc53
	AzurlY6LkhnnLrZPpVkv4B10p7hYCrgvs9I4a3VayO0MGMmytvTMBkpfnqPgyguvZINg3JY5Pt5
	TF1GYUcb7lIdv7JECDe3yHrSOT3i2WwnO/E+3/aMreRLCHb42HAHgOHy4HtqP0eZTcEppNXG9wA
	jQrfJKchx3fLcev8vlh40LtYYUTKznGg56cuHA2lzdti0NeMcHgx8fo2g3bPNpc+FFGe8Bo7T4e
	Ku76XLZJGWNmOOpg24o+cMeHOdjCm5G7GMzwwlmHD5DUkeSvfkj9MQ6LYEU=
X-Received: by 2002:a17:907:1b20:b0:c29:5021:f6f8 with SMTP id a640c23a62f3a-c2aae329a1fmr182452466b.36.1790167772674;
        Wed, 23 Sep 2026 05:49:32 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33e046sm111885066b.8.2026.09.23.05.49.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 05:49:32 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: Re: [PATCH v4 0/3] refs: report old OIDs for batched deletions
Date: Wed, 23 Sep 2026 14:49:31 +0200
Message-Id: <20260923124931.39424-1-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAOLa=ZTN1TU2A1sgEhiw=ymMYr6Ge11cMEubSaeKqr4WNU=2EQ@mail.gmail.com>
References: <CAOLa=ZTN1TU2A1sgEhiw=ymMYr6Ge11cMEubSaeKqr4WNU=2EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

> Can we avoid REF_TRANSACTION_FLAG_SKIP_HOOK by changing the call chain
> instead of exposing a general mechanism for skipping hooks?

I looked into that, but I do not think it removes the distinction
cleanly. The packed-refs transaction is an internal, physical part of
one logical files-backend update: it needs the normal transaction
machinery, while the reference-transaction hook must observe only the
outer logical update.

Restructuring the call chain would either duplicate the
prepare/finish/abort lifecycle or hide the same hook-suppression
decision in a less explicit helper. I do agree that this should not be
a public escape hatch, though. I will keep it internal to the refs
implementation and limit its use to these internal transactions.

> Should the int copy parameter simply be bool copy, given that the
> function has only two modes?

Yes, agreed. It is a two-state mode, so bool copy expresses the
contract more clearly. I will change it in the next reroll.

Thanks,
Maciej
