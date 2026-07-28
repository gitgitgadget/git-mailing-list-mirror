Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CD3E44FD
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246057; cv=none; b=ZfgUiQVi+bp5d+rzGJaiEd5OZ3vfBmZk3S8AIaryGAwAbIl15iuL/dRZ9IpFemrp+cr/TrKPJD7lOhF9bm00oXKZSSyW3jq3OjcS+ZBzOFPV+VOqeZf+m7igA1E4LFJYDLZpmIeZ0GlbaHVZ94UnopQ+XIZ0wFn13q4Qpks/XDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246057; c=relaxed/simple;
	bh=fL0Mu7BsGS7/K/drPAuEbTjO382qcQe/HQ9HUwOtB+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPmBVlADolcxZ6gIx7+LlLybELYrdbl96XTLCAMI0J/QWTisxu+ePeqjaX+y2JNnuc3BUYWiF5ufax630z/c/S44/7gZcpfTCXXofvzh/Z445n6TskKraHn6xKCKp/Hxo6vDWQQtLGkfge077XrjkmUZrpkKvw+Sc2BmYvrO130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNRg32Q8; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNRg32Q8"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-73791ee3612so1805484137.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785246054; x=1785850854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fL0Mu7BsGS7/K/drPAuEbTjO382qcQe/HQ9HUwOtB+U=;
        b=CNRg32Q8sGZEoyGI7p4Xd6uPGplAi5hHTfDVmtGi7MaVX7p1TRPUYGlFAcrygLBwkT
         bMThj3Q3sLv17jX6yDgsh2mcCegGUB3SjQbWwBhSy3VieXT23ANS4dg0S6bNUwkpDi4l
         oOamZdv2MNEmpyEwftsfWAyz0iwvFxLPtSV5lb57y9QDJ0i8fOuB3KleKDWLTqIU9Tsf
         vX8TRu7GAOwyi1wcSjIFDcjaUZcg8S8pKncAMsDUs/PGCAJboTiVm/I4s0St/6kyF2ga
         oSRwu4kcHALijHCltXK6osPl6dGcPsLQTeZx7NfeYLvj9ohXkxGaeuyBYs9mlPQl25PT
         gf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785246054; x=1785850854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fL0Mu7BsGS7/K/drPAuEbTjO382qcQe/HQ9HUwOtB+U=;
        b=QyZPy33XLXahl3/IwtgtALAuScNsSbUAJO3CuaqscoNpn6EcUSimmx20SWfGO7SNy3
         DxkgLnBUIhessgIWGMYSgg/TenCdgvY5WLgsmWXHmtQrgpEGA2oxYRHlo5XvOlBLyNpA
         LjfPuTAWbPebCSw/8nlxeiS6vA6GrrAaRIH/3NePAnYDt2EHHf+Dk4+SD7vugvjYxtIn
         yZVcg0VTiMCivL8nN7hyICr7kAZOA96AN8f4vbQ1+ynX2Gs21I5CmWyHbvvcbLLdXqjz
         2GTUJRkJBq0fV4wqaBNLoN0rjLZtDmeTb2qOGNbq0+V0eB+zlvUAPZGEuj7zVDqnKefZ
         SU8g==
X-Forwarded-Encrypted: i=1; AHgh+Roc5AQcLFyWes3xyEqt2KcULRUTs7o3mwZi+lPdOsJTyOFKb/Flywfl6KsdiXX8Nq4/Bio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3eopbFpHeXAkGz5f45ASqzxsh/E2gFQ7IhMidDC1zrDOOILo
	ecFBBKjL2LqZ4cd/A2qh/gRH56M/3BMZhvDHxvO/VLxpbTYjt0oBqrfF
X-Gm-Gg: AR+sD12BMxkdFzlU8Rr14smIPaW3lNMUzanNiQ+uCiXUwQmjwE1bqVCeTeTzy/pz0BE
	bu6kgwa9SKISb7cGwGzVGd1q2R58PoyGkxejDPxp7YyWhpGIuEUK5zb1koxSofTfyDnDHeIqgKP
	9kEoK35TbPTrGW8iDGn9COAXHGLUdZ1PjZwlUqTmOQEJSnTQTwkIJb5i638LfGpXFtHAndfOt15
	Mzxezsc/030YVPFKzc40Bq+n9JbQFUo9GLyOVPnUrJKseaLivkNPZQTkKA0m6AGbqNKvQ30+ooa
	/1UQ0MDJ9v5+y7w9TCT0zDhJoJE6jTzAM9TRYTe4yRmIyFPfVBXypChzH7CLwyttUaM1FX9/6Cp
	oLRm3kb6dYwtTArV9e1cOwODfjJPMVzLYG3TNBtEU5v+ZemxXB/NdUdYxoz1Nqh6+SHeCdh0uzH
	gkiUkNImd5XUgUW2gBsPYSOSdPXKJ65n1NuES/K756XfuMDcbcm8YE87pCMnSZG7XQgtlQFy/14
	XW0iPwhHE2W0TknNjP/Xi7lHOznk77pULA=
X-Received: by 2002:a05:6102:148b:b0:739:5cfb:50f4 with SMTP id ada2fe7eead31-7549fd622f4mr1250923137.11.1785246054225;
        Tue, 28 Jul 2026 06:40:54 -0700 (PDT)
Received: from st-davidlin1 ([142.188.83.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-750362e67cfsm8008989137.8.2026.07.28.06.40.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 06:40:53 -0700 (PDT)
From: David Lin <davidzylin@gmail.com>
X-Google-Original-From: David Lin <davidlin@stripe.com>
To: ttaylorr@openai.com
Cc: davidlin@stripe.com,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH] pack-bitmap: handle objects at bitmap position zero
Date: Tue, 28 Jul 2026 09:40:47 -0400
Message-ID: <20260728134047.33801-1-davidlin@stripe.com>
X-Mailer: git-send-email 2.54.0.1783223981.geb76c99f7f.stripe
In-Reply-To: <ame6B7pHSvXekdPZ@com-79390>
References: <ame6B7pHSvXekdPZ@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 03:05:27PM -0500, Taylor Blau wrote:
> Makes sense. The commit message here and below looks reasonable, but
> please wrap it at a maximum of 72 characters per line.

Done in v2, apologize for the formatting.

> At this point, "load" is a fairly cheap operation. We have already
> loaded the bits off of disk in a previous step. If the bitmap was
> stored as an XOR against a neighbor, we have already XOR'd it against
> that neighbor and stored the result.

Agree, I reworded the commit message/comment to consolidate the wording, so
that a duplicate disk read is not always implied.

> However, I think it's worth covering the non-pseudo-merge case as I
> described above, too.

Good call, and thank you for the expanded explanation above, added in v2 using
a duplicate `HEAD` traversal, as suggested.

Thanks again for the detailed review. I will send v2 shortly.

Best,
David

