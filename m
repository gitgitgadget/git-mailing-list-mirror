Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB33AB289
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343986; cv=none; b=lGXbynwQhMUAUeiaAgH6FIA0akYVM8p8/Dc9cvSX8Rx2gS90Eahr+F6Ur68hadGGS6XyLuW7CrAf3Rx2BesWUsVPFxpYy+1aDoG9XY2V4YtZgsGwoKk6HTtthA46Fh9KUu7nyC9oofZ363ud3xQ9PbU+ks2MbsKif1tif+m/Flw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343986; c=relaxed/simple;
	bh=MDGcPvz74Vbin0nwfD/Xzb+3lFU2ssZ7xMomExFGbEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiwcOO4gZ+Vbof8Vor38FCU8xrjKsEMaISUz/WTA4FSoNpXMw4khpG4MLDp8Or7Q2uku+X2+l0iIieOf6hJt1yKbREMNE8GNh4GyI4eVpiRDS05EWcacSQue2NLcCCGlGOZt4N18aS1ZdGM/4ZcYyft9wYV3JSQ7r9YbNN6mLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe2Bzj5e; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe2Bzj5e"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a12c19affeso416761e87.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773343983; x=1773948783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDGcPvz74Vbin0nwfD/Xzb+3lFU2ssZ7xMomExFGbEQ=;
        b=fe2Bzj5eLDKHSoLTkl62KnDbcu0JLNxi9B8v7qdb0kkUrEBJEJpSRaPtb1nKLtTclg
         FJZbMKKFwP+umhLaDhMgnsWnMIoCjlkCaM2wyNecolo4dj5uA+objS3cR4mZHrG3CU6X
         FSOdL/T6RgfcWoQ3HNtgMGhdqTR3bqUzaHgF45j3YPHYwWchY8BE+FgBC7ORn2KZLvtY
         WKbM41V0mtY8seV8d8g8abz74zgMuBlDcnEKfqQ9zegPm54J1tJ9qX2bEYVpxehsG6UB
         1DN8Ts7oOFwsYcUne53j7hL8SeRa4ut870um7FERiBfdrrcfxEv3/Bp593QeFe+/3F4f
         OeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773343983; x=1773948783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDGcPvz74Vbin0nwfD/Xzb+3lFU2ssZ7xMomExFGbEQ=;
        b=jhlbDyzvKRhMStAnGBTIh4xG4jG/pdyktTDi/ASgkwpkInTtaQTBQ3rW7vF4R4l4ir
         mkxgbrHNEibLKdUm6p2RFt3napgU0bqsLpWxFF68HItbLMcM5zWDLBNkusLNJfq3QsU7
         M13qZ+zP5xF01xA38DdVpfQp5d1f8koXAGuhWHDmEU2nx1zwW/lr2in3I+9yUO9pjv8k
         AauRN3470XZmVIYdbzbzvp7qZvM1m/TxGxkvqT1TK+/UTl2Hiu67pUQPPX2XC3XsMltG
         yfxrMAwLT8TugROEFhaI0wSjyXJELFQfIJXfIhcpWTsl6eIabBhmwJTHkSdlzUtXPEQC
         VP+A==
X-Gm-Message-State: AOJu0YxaJFZfVbbr9rei1dqfWAP5RXRmCY0kWE9GzoxYFVE+jVbtLRxF
	rNZwYAym8R8AYGLvELEyGpiIEvR03ISUYP3nLHABN9t73JexxfFN1qA3
X-Gm-Gg: ATEYQzz6wd8PkRu9ZfKKGVNsB8C69pEP+EiB6CJNHDsDjp/gBLKUBUilfrxUR3337DN
	CVLBf8x/RRYZgd3Qd5JkfflP/97XkBPsoQ7BluYUClgyi2txroo+22wFrCrXvH41aNb7j48pxyf
	543Oe/UYQyj3OjPoZ7mVr3Matv3LbzyzfNGbwcT9S0TuPNVkg8WzJwlaLSmQVMYgmDAU+AvAwa+
	Bh+VKijn9wOM32pSRVgYGc1lv6mBwbFFDElLXsgO0kXLWLrjFtz2TNJnaB4NK79kAZWhO5C610o
	GwUxheJvdAXy0Y2DydlC3K6/hRUyy6Mpj8aHbz1okcD0XVR8EPpcSmq9FWHQFA8FDcZ+673Er2j
	5eQlhuJpgBSLxMMhnaaJk7Nl1wcvvuMXUoEVZL6O846DRw1IdmNR06B0VL4IVtO3YAPPqmDc2tg
	VxqywMrG5dgNWfmWexuyOlX97/8whYPDdWL7kPf5/Z/8fXpzFU4i7VRcjJX43j2n54Qo8IM/JGL
	o5KkvE6WDWIYnG2vwD5jXe2XzQ=
X-Received: by 2002:a05:6512:1111:b0:5a1:3e18:88d with SMTP id 2adb3069b0e04-5a162546944mr301096e87.3.1773343982484;
        Thu, 12 Mar 2026 12:33:02 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33cbesm1118974e87.9.2026.03.12.12.33.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Mar 2026 12:33:02 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v31 0/2] status: add status.compareBranches config for multiple branch comparisons
Date: Thu, 12 Mar 2026 20:33:00 +0100
Message-ID: <20260312193300.41693-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqeclpi00y.fsf@gitster.g>
References: <xmqqeclpi00y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Good point! I have been running this today, and it gets a bit annoying when
it's stashing and unstashing needlessly.

I updated the code!


Harald
