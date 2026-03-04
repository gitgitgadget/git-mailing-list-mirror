Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570E36F40A
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648264; cv=none; b=h25aF1F4zfE7Q80H0HRiTBhAmSOE7BBzKNXWPZ5HUBI7FwjGBzIFFKjzvATvDOcPTpa866n9lPLcLh1N5vAmE7cocDdbnSo8Va/npFBH4PoNuSlv2wKxzlf2wlwIt1V9EbVmxYV33pjT2Ka1ktURmyKDNryZFBiqE+Aw2cMZKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648264; c=relaxed/simple;
	bh=ApPfNNacY84pYdpgysWo4fKkgB21y6ncSC5DMZ7xVXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Koesrioc6LQTfTZUparpNgDaWSP/axQ0dkWuRcky0bU2wQTCapRbgLQYyWVbTglx0DXEcZXodl9p5X++rGz0FmrNtGhb7e3WTQ3NWhxKn+pp4TMOq2foaEIV/q2solLX2WRV1Ib2aeS2A/kkwbgUuFo3fNTvfbqmrwuqZe0xB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU5FAqbP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU5FAqbP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso253977a12.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648263; x=1773253063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApPfNNacY84pYdpgysWo4fKkgB21y6ncSC5DMZ7xVXE=;
        b=ZU5FAqbP2tbX8qc/PgZ5l5SPaQhMM5lSy9afHLdn0aWLTXWr/bl0fMJzwgNmPNJj68
         C+O7PmiH/KABWrL5C2o6bcC6YXDtZMCjtQm0gCXoK53RLzZVrwW9GkQxnD/gOKGjdiVr
         nSi1wk3dVB3C9RJewuyvxAt8atU2sPvsg/bRdC47DQtTSpKHQnb3RLmj/YL9EgmmRdE9
         I1CzfxeaU4YiFco7NSGTOkTX0Vkoj2cmGH21tA4oXDE2O5bCi4B44ZTpmcJ3J9EmkiPu
         uWdNl0g+SenyMZ4skT9Q2CqeupbylfH7eR5vVOB1xuk7XSJToPD+/+7RkEB/QH5fC79V
         WUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648263; x=1773253063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApPfNNacY84pYdpgysWo4fKkgB21y6ncSC5DMZ7xVXE=;
        b=TipC8Qk0BRbJe3MuSN4pTLsBg78lHTcdop4kSEcegq3ymgCFhxUIB74KTxK3tEokQo
         GtSUa9qHmAI53DrR/9bwdZgqgmkoBd2WR8r6cVv62EPmyDUiLdNEKelnDJTV/AYSkOjl
         wRMQwzkl5PCw8rhD2mUuN+6KBU5B7983aTrivzmYtjIsv8Xa6pZT6tqxV/WZyTptGa+M
         ztaGBImjgP996ddHevAiGQ1lWtfiQ/MBhYyjA1dSu9S7lEZEOH9hnLpWrXmjNuMmsPT5
         l43cggRN+cxe7EIeP+VHlmgFN0lGqGFLLw/ZON7QZfqGvFO/BYfsMpTARUI4PI8adgrH
         Mntg==
X-Gm-Message-State: AOJu0Yy0Gc9riHSJiC0s7XyklyewcTIE4QgFLczI/cayEJatbmfOikPY
	zXoT0k+L/yjXieKWZFWtHJv0ASw3xvrQGviDEztqWNQ95k7Ntm1XGmqaJkzg1w==
X-Gm-Gg: ATEYQzw5sgGLRJBolLystBiI7RSkqaWLvhNrTPfRbVolaF+KfiH2T9P6U8H1n4Es6Ut
	g2tgq0G1Klm9cg4ELLRaCCKh/Um3YdRAx8TE0GhG32fuj+jKJXuEm3Ktscg6414ltk0va6aIjpL
	HiOC6nbFIZTwdC9Jar4buP0KNpZpLwPUiJl1cbb2pLE1XOuU+udTTqkM+Oqe9Qej4eBgRzOW/A4
	oMa2Eb9ulTK6AzOY+xt1KIMfYSv8VrvH+HowR1LELICyO1yHPxTb5GB0jPYohEreR+T3TcTPPRs
	mTBsV8iYgjh9fxol4ZNO8o0WLzdswewOmWVvBr93R3PYftzCOBoUz/6JztpPVyCbYWyPmfi3HNS
	8tOmdEy+07OjXxCwwWMPxSvQ4P2EoV+SPzYgO2kmuos9KjLkO3Q+SKKRSsyIuuD3d3/aGC2WBrZ
	iUEttWn/B1ygGh073RVyBm0Is2d/dbCssMKDfVirH1th2bxOqbHaMTX2oWZhWnjaAj4qAaVThi3
	kA/ht0dpdErCeDbcQqn
X-Received: by 2002:a17:903:1b65:b0:2ae:4f90:3245 with SMTP id d9443c01a7336-2ae6a9e7fd5mr28645585ad.15.1772648262529;
        Wed, 04 Mar 2026 10:17:42 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae464ffff3sm114392665ad.42.2026.03.04.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:42 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 01/10] fsmonitor: fix khash memory leak in do_handle_client
Date: Wed,  4 Mar 2026 11:17:40 -0700
Message-ID: <20260304181740.25613-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aafiaS-DscdIkori@pks.im>
References: <aafiaS-DscdIkori@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> Makes sense. If I understood correctly I think we could improve this
> code to stop using khash directly and instead use a strmap, which
> has a nicer interface. But that's certainly outside of the scope of this
> patch series and rather a #leftoverbit.

Went ahead and did this in v8 as patch 12. Switched to strset
(since we only need a set, not a map). Ended up being a nice
simplification: strset_add() returns whether the entry is new, so
the lookup+insert becomes a single call.
