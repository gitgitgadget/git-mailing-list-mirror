Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE43428859
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915327; cv=none; b=NQ4akrcx/HYpvJo7GngGpSzyTbxC2HaYBYZbNScOkCQTiqHTOSVpJSagHZEnK7713Oq9LaiP4z+hwnb2VCiGrGFlbEojUfJt1s/dQ4npOlhNukYzJW+aV4RVtyxncW/Bp+zcAz8ZfrgeU43syI0/gYgMapq02IVQoFXZAYpvbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915327; c=relaxed/simple;
	bh=VA/1K5kHCnSKQGNKSwXvif7VpWxn3cYgPvXMC+KlXzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIYch6HfMJLUI+hqISPO8wUfKU2x/LFregO+n7pFhIERybuelW4+sL73GnNe3v31KVf4zmKnWzwUpW6I9dTQxG6rCB7fCcnCj7lVbuHWXygS/mvO19199s+sqod9mOX4VHFUob7RkQ0vACxOT0F678LPzAO7qlTXtm9im8sWENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL6TYQ5y; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL6TYQ5y"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b30275e69so6738035e87.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768915324; x=1769520124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA/1K5kHCnSKQGNKSwXvif7VpWxn3cYgPvXMC+KlXzs=;
        b=CL6TYQ5yFU3OzonCYq1kSMwxsy2uUeFzYaYy+lzhvWoBPhjWZojRo9PtT4Am1NtPCI
         r/U6pdgZ7jRV1mYQwBzfvnGaRdDABOgcXuk+12ne2CSVNOtZUm3aI/fWUgwP/qIYv+ua
         AXK5CqQp2EbxlsIO1ogaWatKt0ueMUu1I60fU+2jW8+UXIofEsIAS720q2gpZ/6VmKkg
         WtkwTe9VZP5jYq8R9VRP2xEMLX8SnN33MKJlxsOMnoywQXJg2OOS23zFuHfHQZrFgdpo
         08Fb9rYxrtm7uITxDsSJczMfC5UpYn5Ab3jtCPnYYRnpAFfGDPX0MVcTrxu2DaYfOLgD
         WwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768915324; x=1769520124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VA/1K5kHCnSKQGNKSwXvif7VpWxn3cYgPvXMC+KlXzs=;
        b=XW1MuHXfaxaiN3pi2KGjC3/OFa4RUQ3bNurGQ3Dgvd8NwVlCUO0m0TJg9rP3Tduv1b
         cG0MEwBw1WV/g1G7HCceagII2BYrBMlLy6uQKGhBEOzjZi3DTVMdYnAJjYJRaXDeIzgj
         b8KQ7wEcf3AHn3f2xvmk4QJmJRQQC2widIyx9uTPxG1vhqMwaCi/CEaqx5NdMu5om41G
         QPBuwVuvAFIz32cS2p3BQHxBmiTrQrCks0Yhn6nSME1edDTKnknI+IcIagOotx5jnf/8
         wMRMSFu/tynjC3gImDCnzJ910h7CfBhFwxuccS/hfEFiN3XYgDEJ4DFx/hw3loRe17nN
         udYQ==
X-Gm-Message-State: AOJu0Yz6gdeAqSVrsuV7QTtYwIhXj18fpleLvNMGCz+HgK0r2JxPqtcT
	PBBYz8/mJJsxDmLZQEE66hBkc0rgovbyP9tNlXzLYXxhz3EZE4Vf/6p52+9YoA==
X-Gm-Gg: AZuq6aLDHye6F3QD5R3flm27dkL375TeBoNUNU71f/tM1JNYj12Ov07qmDqqpLdVBPO
	b9tBooz8snt1kzVdZ/nGxtPt0nq3wwFeAA7g6s21LBtQ5zamNiufQZW+A71orguAarXyfQKv9KQ
	YGjwWIl40R45ZyNIW40lP7q2j2UIlIE3sFaLL9Byk3Ff0sX9EByUhmr6iEqEyWVupOopvZ0vrnd
	mQDmSo/ZCUSUh4llXQjK4E8KzeWsyb3DO2x1x0MGkz0LXAb3PrKkXBBLtYfjhOUmK2JLGHt8ZdA
	d8EZ+qrxyvf6J/4LIyAGfPGM67k/G66tBpXpYXM8HBW8CZv2qO/IEcI6+EglJCbCsAhJcN8j+uN
	KTPU4Y8iP7ChqSN1DIqcalEQ86LF8wEajfebTeopz9YOys47PNJLzHqMnGbRDi4S0BTZcHwpqvP
	XLTMemeqVAcPdU59iJSX5SJt5Tk+hxsNqZ3hy1E6tnp/sbf0Rzcoai0XX9Bx0enuqrhH/YmLIgk
	sy1qy87qMcAJog=
X-Received: by 2002:a05:6512:3501:b0:59b:b30f:301b with SMTP id 2adb3069b0e04-59bb30f301dmr4890175e87.22.1768915323919;
        Tue, 20 Jan 2026 05:22:03 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf39c150sm4122300e87.78.2026.01.20.05.22.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jan 2026 05:22:03 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	peff@peff.net
Subject: Memory leak
Date: Tue, 20 Jan 2026 14:22:02 +0100
Message-ID: <20260120132202.1655-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120094957.28855-1-haraldnordgren@gmail.com>
References: <20260120094957.28855-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My bad, it does fix it! I think I applied your patch incorrectly the first
time around.


Harald
