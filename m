Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D8158853
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736275; cv=none; b=RgDTelJsKwxQRfa0miNstoh5GL9dQfWC3cBAPD6S5Mo0AbDc+dH6SFVwcx9/vIzNID2uzVJLdJUr34nPGZiUVe/nPncUzECRCzPRCGfoydfdf0lzVLbRg3SkN8JQ9QYg++B9cTKU+QB+UIKEnqYEtcV/egZ4S3ToiNWkpaaOEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736275; c=relaxed/simple;
	bh=L0JXJP/hVMwY4VJB8blRl0B/t+pUedHowPZLZHgHj5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3blDtMv7Jnv0PdEpBycnEOUbAZnsgORGq8hNLo0zdKbALh/vZVax4Ku/eTLpYR8/NwYFu9huoftWeOI7nPzWttxplOftqAydgFQAb6mhHl6f8Kleht08GlmmRSU9ptv8abFFm2dNBmRxBFsRw5sPVv4DTs7ETSiNyEEaA55PEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=CEG+E10j; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="CEG+E10j"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso16026925e9.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 08:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1737736270; x=1738341070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3nrbzwdHhhR9jUinJ9cZbdaY2f6R7N/VVxuK0MyBQw=;
        b=CEG+E10jW1C8DwasNekefHQ9wEnii7ssky234sl51vRn7l8k/8kZCWgWZLN4VboD1w
         5ijEFSgDZCWM93sSwwI3/JzZSDurlRDD3n47rXp3eWizhJAJ+p3EIOobNOdbu4DO8Xi4
         7Y9Nvi0iWd0DkX9FzxrVvpeFH9wWNfGe5x3Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737736270; x=1738341070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+3nrbzwdHhhR9jUinJ9cZbdaY2f6R7N/VVxuK0MyBQw=;
        b=rvVCDqjpUYdvYLuh9qGLpQX8fbRbuhJAtr76Z+ZJZ1wpKXE9gcXXnYk2h2Ak+8MomV
         wHmezpqbZpjnLBh7xgWaXAt3XJeXdb55/h76BkY8+Dd1GIMbHUAhKyFLGKQEJ7Oz4rpW
         9aJRWIKQ53yceo7fhp8Ug/jFJ6IiCcZc93aUTbsKM7SpkXRj6YykZwADb46wS7Cb/Sm2
         +VWY9yoQZHs8voeAEtlluvsu+blyQgjVHW2nx6TKkQz5WJJ3ghDjz3bZ9TsF5edsNwrm
         YiAur97viYfgzX6f9dl3OrXQiSyhV+TAkYBBon8chBC2bAiBaYiiZYdpFdyf+nMo9b8u
         G1Qw==
X-Gm-Message-State: AOJu0YzhE1qB+cRaswKSnUYRe4SYf4UvBlctSX53XqKbnHFmJCq7iESg
	Px0oevtKwmcIG8Wqqfi0DESm5DjgSp0gwQgvLbtkTts5fmHb3qKSfgDheHAVVkWzp1rPFgNfL+t
	GEQ==
X-Gm-Gg: ASbGnct5os2cH/bX9ij19ZiEWVI9Of3LG7MBxRYsCEubNStbxBBkHtkzKJ/uguF9FE4
	SfjVPPC+ZKmJA3YZbB5Bqc+qH4kSNoKKf7NarZ/yXGs6jSas2Hb2U3CxHpP8N1xf+5PbiJ/K8fN
	qI6J11HfQ44zSPXl+wwOaB+VjZnBJWmgpV1kUKe6tftSraLeNtW2aSOL/hUAvHQXMekOeOKaqi3
	w+l6iMMFUc5IvFBhz8+Nz3NfG4IjO1J9p93xGLcmIXuXDEfj4JGIyqM/AyH8/YZlFu8nplXCYed
	LHRalSMHu7eAdHr8ahFS9NfP/lMluRsow0Mx4on9JrQ0BmoYMFnb7ptaDjB2mmaRzj12OGgl9R0
	qbhlW/C0F
X-Google-Smtp-Source: AGHT+IF5hN8Gc1b1d65CPqq/75BViSb+5SOz7lBz7gLqFXO/MWUf76XpbmDU+4FXNlL5YPxcA9qjIg==
X-Received: by 2002:a05:600c:1c93:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-43891426ebcmr239193775e9.21.1737736270198;
        Fri, 24 Jan 2025 08:31:10 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd573245sm31649025e9.33.2025.01.24.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:31:09 -0800 (PST)
Sender: Peter Oliver <mavit@mavit.org.uk>
From: Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 50OGV6TZ024001
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:31:07 GMT
Received: (from mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) id 50OGV61Q024000;
	Fri, 24 Jan 2025 16:31:06 GMT
To: ps@pks.im
Cc: git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: [PATCH v2 0/2] Fix Meson Perl version check
Date: Fri, 24 Jan 2025 16:30:47 +0000
Message-ID: <20250124163049.23965-1-git@mavit.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120160301.121245-1-git@mavit.org.uk>
References: <20250120160301.121245-1-git@mavit.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As suggested, I have reworded the commit message of the first patch, and
improved the second patch to work correctly with future versions of
Meson.

Peter Oliver (2):
  meson: bump minimum required Perl version to 5.26.0
  meson: fix Perl version check for Meson versions before 1.7.0

 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.48.1

