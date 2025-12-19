Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450626C3AE
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766170429; cv=none; b=B9K6Cy5q767UKSEzOEbrQnKCeB3KZi681hAqwZXSS/qD+UoBZNbLWAYl+bVfNG4XWadWyhNhLAVo6iTT7RTWRKRNXVgxQk8BwpwpMM+V62no6+pm9njtyUMNssLEyzrQrtyutiTfYCZR12HnYBDGaE62Wp/aMFxkwmeDey++kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766170429; c=relaxed/simple;
	bh=SOAHX9F2Wv8PlnW5beNEBsd6Gs+RE8zD3THYEP8BjDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZ0DqQvzc9texaerIsp+WFBb/feGj6xb5TAVExjaXIlmlKp8YrgfbivEzzsgK+PJIsRPOlsInMQPbqHEtakuQhLzNI7/L9InGZXXyO1nwzeOTHPnljiBNOy6J5H+44x6OP+etBCogQE5s+6GPmzbHkkUuuTFXcT95waDvD45+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIRb+sgc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIRb+sgc"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37b9728a353so26498521fa.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766170424; x=1766775224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOAHX9F2Wv8PlnW5beNEBsd6Gs+RE8zD3THYEP8BjDc=;
        b=HIRb+sgcKaaEnlAGINcS7n/rbEoh1A6+tzjCQGyUzGYWKtsGQv3Esy2yHyoL7bHCXQ
         TZ+7pbNTYZFsnzxjo5eWRVvhzAYsq1s6NrHOZEoxV8BiOko67X4p5vKoHjjSxnzt/hMP
         F6//sGOXLNXpFV5iJDQbLkQBp57grHn9KUw9bWyJbeZNrrLLjmBuPkXNqsgZLHHE8YF3
         2I0X+4sgtNz6Y3XtKr9wLaugwERpOpY/PQNd0BNOqSVFUWYHUj8/sxJAFltBemAnl2zu
         BJxRFeYN9DW5N+FJpBm/EnZ1tv6ki4u92r1UQeldZYnAgsYVGm2zTOMTn/IUBrglpRxj
         wpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766170424; x=1766775224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOAHX9F2Wv8PlnW5beNEBsd6Gs+RE8zD3THYEP8BjDc=;
        b=kQ7HjoiOYPD3Ari7YCE3pe3n5tWuklttP5EBIVsp9GzBzNvHt8eD9x/VUCqWPMW2Hn
         /1fozLOdI6jpmlWwNHJglqPSnMjKT+w7Dd0Lj29wIeHMeYXjtkFfu8Es4Jhifxt+7SGx
         iB43ziNjx3qDa7ZfUx7o/ZVPGsuiuBZnPqpQwDpUsN1XeMJNdPdGdy8ptMy2zWrS4c6O
         r9RlioEBTwqTs26DwPukKEa77qD4aSK5f7afQqsd/tbHJga8rLSiR6JyXHbIC4WhrSEz
         5/UA3d5d3FeRHGWv00uMeWwWqe1I0hyq8QLmM0r/ojLh6I/W4UT4yFFbQGVgbvDguGRT
         8TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrXhOaDjWBWwqr8KjFegVUN7kBhDaCVLil2iE21eBAGKXhe6eEDMGt6tqn8fbV9R9Nyso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIY8E+dkYAU4x0O2f1bkdu7k0G8LbVcSDjHvdspfZ07G1YlU7
	jjKOyonlPcDaXTNTVdFawWQmojWpsuWgChaRsn3oXnMp+QeK0lFbTe0x
X-Gm-Gg: AY/fxX6Pdbi5aahtpIYK0l+fyUrXWsFaF3pVl5ob0OpTKogD4D/Ggey5XL3ci/xNOOd
	FWKGfSLAxGo8QI21tT1z/Xg+jlyA+MSHxy//LWM1/fn7YvmAGTSTrNITI+oQ+4HFH6zwpEO3Sdx
	1bYtxyLTqP+IDUNZHYJ3FHRJSw2JBBBFA+MWkzc7i1vA3fsiL0eRCMquG7bfpmRfqCTVoTD0LXU
	INNLPl6vT+p74dniL7ronw1DjVTVc6UPMyHC1+GjUwAA5DW32qUJ/jbOma0axupTk81sfG4LhmE
	hx7KOkUdHbwzwQLJIAmvR9CJ443WlT8xLtvwW6QFijiiZAtimvjXnYe//JNh5FzAp8LgE+f89Rn
	+MZwrXI6XGdmeew2c17q3yZ3b2o0uPmtpXOX8yE+52LjaNt1IZRmqzK4lRIQo2qGVObbvcCshof
	ONjik6wj5prYy0uqBtVvg7mNxKhFGLnpZvSRWcKa2+q0g/6nGtOuXvWvhRReg5bF0kxSFr0vqjM
	yI36oWVBQ==
X-Google-Smtp-Source: AGHT+IHo1knwtIBYQGPeEnzPWgGySWNBIMXSk6kDVDzwqqlG0HH14E2bIELY03/dIFRH5JpmVmbdAQ==
X-Received: by 2002:a05:6512:39d0:b0:58b:8f:2cf3 with SMTP id 2adb3069b0e04-59a17d15b3dmr1523507e87.21.1766170423439;
        Fri, 19 Dec 2025 10:53:43 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5d29sm906908e87.19.2025.12.19.10.53.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 10:53:43 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: collin.funk1@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Fri, 19 Dec 2025 19:53:42 +0100
Message-Id: <20251219185342.35056-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <7B631B32-22B7-443C-8D1A-D05FF93F55C2@gmail.com>
References: <7B631B32-22B7-443C-8D1A-D05FF93F55C2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben!

Here is the use can when it would be useful: https://lore.kernel.org/git/20251219145037.17880-1-haraldnordgren@gmail.com/

You don't need to tell me about the benefits of version control 😬

Harald
