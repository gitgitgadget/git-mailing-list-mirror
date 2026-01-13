Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFED2116F6
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329362; cv=none; b=nALDDj5Lpf8xDYZK0XA9basFgyv+gR6HcDzBnyTrc5X7JW9DiVoLAv65IBhjurjO7fUDVTBhYSGehH4q8sGTEgSmEjZjCw0dH7amEuBsdGBTgedq3SBDhSdFBwHYaLRKaUaGxMHJiaaO+6UFRF9d1C8cc0caYcWuuzFNi79SG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329362; c=relaxed/simple;
	bh=hK46QiHWVQbVsow01tItPTNUbXQkYQFbVFQ5Y6gRQbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKGuAfw/7KEW3fjuM+PoM/FP9Jujvoa/2ydiRBgKOwwL4dj30kOPOuvBPd15TXb6/StZGowIH3dQHlFGRF/KZderm+Cidb1hhxwZmzcp4meHYsdQkNpcedTpA5UbI9eoqmr4fZ+kl8K5U794+OAkQqzFCigZoN19j4X41uD5dxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTA74B8O; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTA74B8O"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b79f700a1so117453e87.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768329359; x=1768934159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/XQNFJcluz071bVG8A8WjxRN900//G7T+yTKWWAl/g=;
        b=PTA74B8OSZka802anZ/bWi6ybVG+qThFzrKz+yl5FUkHOl7zlpo4rbO11USfUHdCpC
         PwonoBj7XVyyMy2s78pLbBCUMM0RySR19LBchNZbaodpxUudFUxl88TI1kSm1xvjgJxw
         2K/MjbExrEIuDPD8+llxlUTQTQDW9siOavgWso/OOuQsPy+5TtjWGQq9NwgsmHMWKABP
         xe8atgUIQ19gLivD7GUxuD1GanJ1/wl6mJPVjIDR0hZoFSDkP1zOCP/Ln7KiLeSV+UwN
         PTbW/Yh0brK64MgEds9wzGyb+jo14p/un8hSh5OOQcz5NQM39yRLP0i8reI8auYwhIqm
         YZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768329359; x=1768934159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/XQNFJcluz071bVG8A8WjxRN900//G7T+yTKWWAl/g=;
        b=JUT7x2XJFKIuzYkArAXkVaJhSYaNWKBjvcVmktiKjM96mjN3DPDaJsOz7JiOiEqmLu
         UqKy7QIpt7x/FnnVkRdxoApNKiA2FTzL/ABDHAmJJU5pPlnd8wEb54387tgSQwDa61Up
         lYtvwwk5+lBW7xUvcgIN2Xu092tAgTkx9VHMjB1LxOYDkDvC1ASwmxcMFBdpXxTFlHgE
         0SsN5N4d7zQiwbTD4QSv0cuMQBpAIcZf3UxLGEMgQjEUGO/PfzDlthzdAPcVPYjSl3xT
         6P+E8oIYOAyYPjTNhXqcGEwchsypVShErHyYArDnmOttEY9tkBGyTfFDXW02QcPn8wud
         B1rg==
X-Gm-Message-State: AOJu0Yw34laWsu7DbwojzgnxhBXt6+JjYkgI7KqhTG2Rf9VFsTeXJD5m
	Ga8s1EbGOeKPnalkJFDHgA5oQ81iPxfblH2l2LITYKq8ul6LpHgstu80
X-Gm-Gg: AY/fxX7tObmmmg1isPwD1Z5OLCkoLdBVNwkzri07gGB5uaIq8q84oCLojtfUYlIuOCP
	kD5mIw14QEC+gOv6XtHngjq4tKFy+FZO8cNXcQ3oi8RpYwqFfKQMiCcdmzGy+S17kedI6C7JA7V
	hQEQuYG/CdaIm91rkYspktS8AihGt9wcgkcAoIeF+u/Kbz8V1qQ0F9PI1OG08++FybAnuiCC/hT
	D8STGIey5wFr+U6h+b3PeRCIpqLKgeN6Y1hLc5/Onr2zrwZwdmbWgtp1SxVGhQumDExlbFaiNyl
	vZE/3U6o2RotB7ncBxWN5QtVaifezM2Ncjk66mOvDZafrl1TuzZZICGHoawLcdFc7XUz00EigRZ
	+f8MaJNAp5l9DB2e5IJCkFeN9g0idQMpjQOLLQjyDAIC+/bD/DfdSwfwIDT6UEwS1OcG7Bpsuai
	EJ68S1PCYrCGiY7QnOZ4g+6/viVyq5qA26zMmxTAd+rhgSIKHBUbQpscd6xHONebH/5xFvMoA=
X-Google-Smtp-Source: AGHT+IEiTq+KJ4r0cjmEbtGZLhGk6bpedP1yfna8iKbonpTDIuNfJBzZpdG+fUf5h1EQciHzMpxmsA==
X-Received: by 2002:a05:6512:3090:b0:597:d9e8:3052 with SMTP id 2adb3069b0e04-59b9920dffdmr1284995e87.8.1768329358677;
        Tue, 13 Jan 2026 10:35:58 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b728badebsm4873311e87.67.2026.01.13.10.35.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 10:35:58 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Triangular workflow
Date: Tue, 13 Jan 2026 19:35:57 +0100
Message-ID: <20260113183557.7991-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113170321.GA265671@coredump.intra.peff.net>
References: <20260113170321.GA265671@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> For my triangular workflow the ahead/behind for the push branch is just
> useless noise. I treat my push destination like a mirror, where I always
> just push up everything at the end of the day.

This seems like a sub-optimal workflow 🤗

May I ask where you normally push (unless you only ever push once at the
end) of the day? If it's another branch than your mirror, why not set that
as your push destination then, and push to your push destination with the
longer

    git push origin my-mirror

It makes more sense to me to reserve the shorter and more convenient
'git push' for something you do many times a day.


Harald
