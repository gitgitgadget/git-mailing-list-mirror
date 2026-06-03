Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4023876B2
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510240; cv=none; b=cfA0Y/aKflCEzR8O5oJDzxCrDraZB8TWrlANSisoWu214XEOmPZBJ97gCfkKg3GIbgvMsYjsjEvsQ3Wxw+nG5jyNAMt3C3T8er2X/3gPu6OMBGunBKJRwN6zH645+B5urLUfu/ZaOebd87uOSaDbo11nEgHL8Uew+q1GmB56HdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510240; c=relaxed/simple;
	bh=ziA5cgcJci2Jwsn02QE6uoJx2CUXSQQFPb72exx3Q+Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H40KmtT+pmVqiBoLyxgQX1wLvYhKdDjsRyZVKwCxJoru0Qtaqk7B/p0wDyEUh9LQSmH0orYVzLwFfbN2RjxUhVhPPfamDct0lhhiqgpaugO20SqSKECi8eHeS5y//E2CgfED2CGPDPRcXzTkzDH7Sh6Nu41DCv4gVrCMczZ4clI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fipNnfg4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fipNnfg4"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ea16f090b4so21488507b3.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780510238; x=1781115038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCu5wrIqkFhOrypv61Jbj7tOENgKYW0OpB4ZKuN41OY=;
        b=fipNnfg4FDPPZ/9wLh+sUGsQVXDH0C6SoHhAFIM5JyQbPs+n2yHuMl7gaZrVY6PWYW
         GG0tnUQUTqSXD10a8D9OiZKm1DQpz0hn+zq1My4f3MSd+9P2GJSRnX43pdKGHiFb6XqE
         d2muZPhXNHSmP0Hb+3qlMs5YO9ZqYr8hPs6u38pYxuVJ6SIO5f/Oyzl2uP1ZxIEcq0/O
         01F6gKhsEDEKEgs+yGKmWfe2omCQf9Xr6Xqg5G6JXKWwphftOmxKhN6rLNzuY4s9osIs
         H3IiUXYpc/O6CwwhI/wcrX4T3jud8R9hWCda6mnDVvkZBzvmwH2mpD2AOG85ouUZgi3p
         FHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510238; x=1781115038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HCu5wrIqkFhOrypv61Jbj7tOENgKYW0OpB4ZKuN41OY=;
        b=hN3y7hJVtIbf17exXqOb9XYZfedS0uaak9FvmfFYgoNoG0J9hiZmqhNJCWnPeiSTMz
         PD7nwR8sCZ8K2oqKz8A3UMx3arniAXEtT+1VoNba2jbpiJGg3T8BO9M8jrKWH2aJxL8F
         m4kDW7EfWhYlCyrbJ6B7lwRTKRNiluqkPtKP/H911ks5QzuHVM/ZHzVzQV6Xq6mgLwQC
         Df9hwWxeUJo4s3XU/kMH+C1qi4ScRfFfOWAuqMsXXdvU0wEux1TOYod+4s9+/ibEI/KT
         0hIQuXoOz9j8z2kwezM9AjClBc+T0XdALqV1iX5EPDC8XrhJQ96ZUHZoiA1AOtpnHBhJ
         hB1A==
X-Gm-Message-State: AOJu0Yzs8MhIMgbBJxOw/H7oaRyGHaBb2S/IErt4MH6ucjFydbQ879nH
	/LTNhwyhDSN/jwmzk4s879QbJBdXZ4CwxRWPXJnNkAqh3CxRu1ZAwwWU8hFeB6PA
X-Gm-Gg: Acq92OFHyikgo/xFB0IO4IkcpeKisHC6fdteOVzPFgwGO88kwrbhftfdQ/nJRgjvkoO
	VRkWmRMliQFLIN4EYuP+nQWaputT/8wVkVPnCHeDP004WaKxemLm6b3VDGbuD0+tP5bqF0vgq0O
	jnT8RecNJxTVAPffBB0h73X7nWooegE8un3yddJDofrAPdhdA/nXOId40FAELDp/uNR2heD3vbL
	abFuhq0jkQg9MlRizggkoj+weQwgIuDZXOf2zalM+7kUM0gQaJnS9QVBKjWhsT/bscz4V2yJ1na
	M9Jz7N4l0cIQ1qG9rEo15oCaY64pFBThc5ECOy0kLWgOW26xhPbHi7G+UehF/GLtB9YSqKearD1
	qh9i+8GDwZN78CP7r4yNjbh04xsI52f1IUcoGjZZDHDQN23nc3KT6oZBvDH9HHPk4BqvRw8XFAT
	cRecMbsjRkq5LXdIaAB9d8Iqgmn6djNglIp6t42UQXu3/ql9/mydMfrPD99BdrE5yWaXtVs/PM0
	wHb+osQiCyjNYRaSm9AJ98cNI/D4aCBFi6tKh/T
X-Received: by 2002:a05:690c:64c6:b0:7e2:47b0:1d65 with SMTP id 00721157ae682-7ea481d36ccmr40076327b3.20.1780510237748;
        Wed, 03 Jun 2026 11:10:37 -0700 (PDT)
Received: from alibaba.. ([135.129.124.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2358b61bsm20610077b3.28.2026.06.03.11.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:10:37 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Follow-up and appreciation regarding Git contributions
Date: Wed,  3 Jun 2026 19:09:51 +0100
Message-ID: <20260603180951.86323-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Junio,

I hope you are doing well.

I wanted to briefly follow up on my recent patch submission (Message-ID: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>). Thank you for accepting the rationale for the new behavior! Since you mentioned it would be helpful for someone more familiar with the bash completion code to review the patch itself, I wanted to ask if there is anyone specific I should CC, or if I should simply wait for another reviewer to pick it up. I would be grateful if you would let me know if there is anything else needed from my side.

Also, thank you again for the detailed reviews and guidance on my recent Git contributions. Your feedback on patch structure, commit messaging, and contribution workflow has been extremely valuable, and I genuinely appreciate the time you invest in reviewing contributions from newer developers.

Separately, I also wanted to ask for your advice professionally. I am a software engineer with over four years of experience, currently looking for entry-level or internship opportunities where I can continue growing as a systems and open-source developer. If you happen to know of any relevant opportunities, or have suggestions on how I might better position myself through open-source work  or any other opportunities, I would sincerely appreciate any guidance.

Thank you again for your time and for maintaining such a high-quality development and review culture around Git.

Best regards,
Zakariyah Ali.
