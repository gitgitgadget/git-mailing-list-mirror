Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9283E559E
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919320; cv=none; b=fywqINDP2nEayVVbzdeRRxrNBb04KB+hMLyFPxZYqCaGJ5CbUCv1/AXKYpTt4QElOSdw6f7cfrwrJznFBOYXrdY8C14W6tEevRJfhF1imPRlGX5Se/PAYZtZYpptnao4JdFqXBU/3AU7pvH8b/0MR5OWjv//j4Y1Sns3OgFu0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919320; c=relaxed/simple;
	bh=vgzGS4B8LGrQX0RDB+eB9GOT6p6/33vQQ4fzNigUQiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFzXa2iNGd5AKLkEU3j29PovG2XH6R2veLUToQTD+rA0DrnZm4Q1sJBQreXEpn+bIClYwPuMKs73tZPfFeaXZt2aBs4NWLjgn6Lwnf2LNnJrCEa9r1Mbb53Y/M2ZnQYdqagZgfjjrUGhvQSBh353sqSWQ69BgSA/dCcvF/vnPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTHytXnM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTHytXnM"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393925cb1baso19959531fa.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919318; x=1778524118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVbYc6dC51AIsAloPQL+2XeQ51d2tbqsljOpBp4ia/U=;
        b=DTHytXnM3osoH51Q4Ws6IZqV54tbdIZ8rmA91nCobv+Zfc6sbNSEN+SZRpM4eqh8A8
         xWjkvzcRQZGSPeyoZ12Sd83hdQZIEOKg3d7teOEzJuDp+kWPAfgfuopuhKJaKpLTpYIm
         Pyzq6loTwNpums4LWK2RKQUlHoK26XkYebQ9AT0wgwbnPvIm/Q6Xg0hAhK/QoDiHGox7
         8JEG3Dpos1nH2aAW1ja4Ot/zsLCG4gSRG2ie7+T9d0CcXYXE6bemGrijtsIernUymZCA
         AaTQb4gxi2ZPBypKpxOHIw2i0Rwkf+qhkWhrSA3F/egfdHRTcycOvtNjvgo+9mx2OEfS
         i4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919318; x=1778524118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVbYc6dC51AIsAloPQL+2XeQ51d2tbqsljOpBp4ia/U=;
        b=FDhCzUa2T9/Vd1dDnD74toiw6T0LI/c3/0X03FsH86klDFUh9B/f0c4lL7TpH6QKi1
         Adx+RlRsM2qKNrT3gpJFmD5Dm/X0ndmmIuASzIWL37Yn4XqS0DOau5dUto/xo0ZNtu7Q
         extv0+tPll/5CBZSqWQ2CzZvSPtJJFoix06famaXbvxn/fKQeloEqKVU0+VG+31T9uHJ
         yTeOJ/bp2snAf1ZGHZSQi86dh6vOPy0jP1jLxlZbZSEgMJL4u+4mIngRhzFTjwefZuRH
         1yNW00ev6nrCtTpsnx1eWEf4tpGkDYNYFwvMLikHueOrZQe/ac0mU7cmLWWqZ8ScfT3X
         LMiQ==
X-Gm-Message-State: AOJu0YzkjbG5U2uJPOajBk/6QJOXjKFhukv3iaC2JDog9dBW8VDvDoDO
	UqYm1JQnYPxRFUbS2acX+aM+LXlqVu8lzt/UIUI8EssMELg3TXf7axRYX1XICRBFRY0Vkw==
X-Gm-Gg: AeBDieu1bWQwolF1qZsFDIa77RzfPaM8MOQ5i/VTKP+KhIic+DM9w7T0zXjxm/cm0/7
	41ejJwAlQ2vO303tdqVVt84eAGapHX+TLMxVUINGqa6ICrvWEBcEWHZk4pYXH8bb6koQVscgtIF
	h8hbhtci4AJdoYZXem50ai3T91hyXltum2i2LF3cNlCPt0rjHVzg94OLFQSl6N1BBqYEHf7wRuR
	de7alfYiLvLUfI5/vlljh51lUEJNLUSrHt/UtfxvqKsAq1B85IVxiwxMhyRQ/SYh7SDESEDRwJJ
	sPafaBwCGhKBvjSENsgA1V+4hI0R+0x0ojLmLbQUZquF2vs0B/0DqrJuzvKEg3k8NdLAfxwWEf7
	pmsWIHomSHHY3VH0wgyNWEhapAjbwNirNfUZ3UR0Gzfw4t3itL+wIDPH6BT5wQXAP/wd7abAORE
	hDiMTNlDe5CMJIlh62zk/4ScaLmpN0HtpnKfqbBU4UfI4THCq44YRNXEG4x+1ar9Rsk+WwkxNIn
	Y+8QOjgc2lg6DCEETBdEElMxTQ=
X-Received: by 2002:a2e:b8d0:0:b0:38e:9d2c:ef06 with SMTP id 38308e7fff4ca-393785a2e24mr45355261fa.30.1777919317555;
        Mon, 04 May 2026 11:28:37 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39361323f4csm33418171fa.32.2026.05.04.11.28.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 11:28:37 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: [PATCH] checkout: add --autostash option for branch switching
Date: Mon,  4 May 2026 20:28:36 +0200
Message-ID: <20260504182836.52258-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.6.g66dac97626
In-Reply-To: <xmqqfr48rubw.fsf@gitster.g>
References: <xmqqfr48rubw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I do like the feature that allows you to identify which local
> branches are already merged and prune them.  It will help users keep
> their local branch namespace clean.

Nice to hear!

> To break the feature down to make it easier to use by our users with
> various needs and workflows, we would benefit from having a
> collection of smaller features that can be composed, like these:

I gave it a shot to implement these, and then I ran it one some local repos
it works really nicely!


Harald
