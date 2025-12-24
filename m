Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315D24DD09
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766538733; cv=none; b=KhHpd38zmfZwt4Ut+LN512lATttd7frTuunOdoxuPW5HG7Nld83STK8Ucym3F+/hyuJoEnrVGREBLWF1dTrlPmyN158MdSjQBEer77pTBCkPinpY+7hSGeIyFjaert4RIyZDRSt08dRslZhZwNbYytLTFVgsdpZinhKED3bTyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766538733; c=relaxed/simple;
	bh=mu/5fNWPp6db2ffhGaEfSi7Y3YTPVNLzdOIMlN2Jtfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9KX0p9dEh3PqiYihCzYSOZUUL0xOoaPtnMtzpuC5yEg84iE/9fibSiCrm4vZb9nctwHOCeO6LryeypbGLLFy/hg2a1/uu7rbctDauutcOHc1McYn2rK1iLTlFFbgZQMt8FPnAnIqB9wudXyo4H3Gzwt0RsVC6Ig3HmQeSM7q/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2AfvGyN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2AfvGyN"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59445ee9738so4274152e87.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 17:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766538729; x=1767143529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUS1Tn3+MLEduVMPSi9KDiCyRdIYE6e5zxufAXG/pV0=;
        b=B2AfvGyNCa8BCwGJRgt8pbLAg2qKIySLGFJjYxp8KOSiX4tm715Dyv/2tp83u/m0Ln
         PKqMXmGUMqBpKNqz2dqH6G5ndUc0UL2D+FhrssJfMg8DiqOU4nZCCPxR5DyQJYuh1QWL
         mx78alSHPRCKZvA9pIDHLHFKroA0EWeOHgF10hMSeVmyNABlp4H6C1gxV/v5EyyBbFB4
         R+eeGEZic5lHan7+ZVq6P4i/zQLWfm3JbUepRl4q2Dbn++FvB6QSw5Vdvhy3bl53UOZh
         tmJY0W3X6VmT8k9fyhsgujSD/sDeVkioVUnvICzXjhKQTZUZNIF4f4tUl5XqF1lnnrD+
         V9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766538730; x=1767143530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uUS1Tn3+MLEduVMPSi9KDiCyRdIYE6e5zxufAXG/pV0=;
        b=Rgr3lhO+6P5gzpjx+ZCs5lbPLl1pKZuGp1BcNTOy4/HEGzGVAjIk8/M4CzmLoL29+D
         L9FZZF+8dcUIhsonCx47LLgDnkJnXRLWdDVp/mjL+BkaDFo+oZLmoDKflyBKCajginTP
         YTkOnU0M2Z/xRhBJ0AY53EMIXNFANxMOfMUg5XbIijkyE6Q+siHbtBwCyyNp2sTYx75V
         sCz/aGtCbfWaYvgdWreB2CfMCZ/GjvkOP/7aeQJjbChszBX4SuID8VVheXWzLpI4KHak
         CnOJKLjvuJyZ/wgkdwXLNpnvKJ5ld+VM+4pEJEK0mLY8EqBxlHmEl23mi8TaTiXmwws0
         IsTQ==
X-Gm-Message-State: AOJu0YxFIWftaHx9H6nYtTYY34zlOQhz/cs6L0z8MywAqB9iE3cfO5Px
	xQYUejY6KL96OM9MOxbMhEZp8V/iw1ES97g3Pzm80potcZT2C/XwBCFjfcG04g==
X-Gm-Gg: AY/fxX7d388uQTRcvWV1OHoV9uufGAPjQVhC5nQnpsEJVOiNEaS4eR6DzTLJjb1LycZ
	yk4LrtW/hYWdFUm8HDhm6lh6slarbWNKB9Ph9RYbmVrrpSh5Ww7T+/lpTu+qTis+2DLAcabJiw7
	YD1CLCkY+SLIP7zRBiFQewi5l9PnEBpjZppjrRBIpW+NKscirtdDOs3haSJo/r5IZ1YXvO4Z0dX
	dvTbBZgc2hfuFfgqj97PTDXLFnyv1NaGIACHynzWk7BUsR3ipCjghe21nBWAqou1YuOcMSeutYq
	EWDPVk/RuhH3vywxQe3aNdN5zXui6BbiLll+TJY+i3+kEa45llas8vIiiM1JbIaO11IShJArbD0
	flKV+Q+bI+let8deSyphA5olD5BSiphYgdQtj+Yrtbptd1f3yG4h8G+9xpOQvGr6EzZX1rJErYq
	dHoSS2THwwt6i6zxPm1eLvJg/avon1KGpsjsVovS4+8XAmoDAVfLCHdHT3YCO0xiwH5ymIRB8=
X-Google-Smtp-Source: AGHT+IHzRr/CZXoulwy2PMOwPU1ryLwNcJ1+hFV2XGGRr8otQSEd97sObDo+J4wWAcANjHfw3nQXuw==
X-Received: by 2002:a05:6512:23a7:b0:598:ef18:accd with SMTP id 2adb3069b0e04-59a17d366afmr4995419e87.22.1766538729299;
        Tue, 23 Dec 2025 17:12:09 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f85dsm4525461e87.73.2025.12.23.17.12.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 17:12:09 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	ychin.macvim@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Wed, 24 Dec 2025 02:12:07 +0100
Message-Id: <20251224011207.45987-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqy0msogso.fsf@gitster.g>
References: <xmqqy0msogso.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I see push and pull remotes mentioned a lot here. And I want to find out how much of the problem that can solve. Let’s say you have two remotes ’upstream’ and ’fork’.

Can push and pull remotes be set up in a way so the user can run these bare commands without and additional args or flags:

    git push # push to fork
    git pull # pull from upstream

And if so, will ’git status’ also show the status against upstream?
