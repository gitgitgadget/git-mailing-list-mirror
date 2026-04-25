Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF835F611
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139068; cv=none; b=WawjFP0jRjhJP4I+d8iN1qF9uctxP6chxSAejZAAcpzq8WX1oedD9Ttuchi9n18SDmlHIvfo2md3WVWMG8/HpHvFR7d8WedDxDmC9OZZCvB6LrkDIUOt+oulD8h7mcwbte73Qg/Y/JD1B98dAieLe1E4k7LrIgvvS2Bdy9POD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139068; c=relaxed/simple;
	bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRSJu7Dngnmrv236U/TO/qAZTamdZjigtJTyKAc9uvfF6ZAIazTAYvJArBGJi2eYFCRiRbrAelq9MBboNeHOW1VlWNYB3QrD+dM3iEiVS/QStuh7g5mKE7Ay8h7UXkR7wr7YbVr6k85np6BoI97vS+Imb0T4UuAxbcsVDmCX/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceVF1PSa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceVF1PSa"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38dd9f11a09so80508541fa.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777139064; x=1777743864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
        b=ceVF1PSa70Wv+X5/Szx6rKtfNCrnwNtZRztLV21SppywRsinHIb/1CKU8KQqCo3wB9
         VJAInYrnLdKc2rYd16Rc295RpT2iS48W7kiSjthgkwoiX053h+hCe1tSc0p3vbBarHVa
         tPlIvUDoEIpORAVw/c2YHeKUO/oujD6zt0jU+ocRNurb66N/2SZK1AavuK6A2SIdvDfO
         FKa1GsQquVk3cvYndHmr61YeEmHNValzSfApWVddI8Wrrcti3qM789DK2hAMR9iBLbU/
         r6pQtpv5Wk6nnopMMDGPDI6WuFocvFQ+IjSq6ecASntppt+8GrLO1e4FL7rbV6bLcRPC
         2LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139064; x=1777743864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KItqbkBAw6/pA2yhv7MPqq4FCcyChJiAw9HCOruLdwc=;
        b=bOPnX1WBDpYC4+gckZPyJqEw+biA8UUGJvY1xhkxzm5O/DX66wkK0KUUpOkmB+ZGJM
         aZzdKemZSZts2LidNz3ToSMXXARKKp/J7Ar1hcNkDOzfpMnnKHdoUZCjIq5sKixAysFl
         wyOqMA9pOCUjiduij2C+PbQG8WwogXj2dBz3LmSOnnkbK+TnY0kNEnwfFMl88iVWJqU+
         BovXyPmYHXNUtwhtzXbOwKaI+padXmXg37U2Cd5sT6ULN1lTWBdiCfYq554Q7x1M0sZi
         7O4fgWpd35VOy49rdN+IwS2NL6OtRuRYNqAD/W2JyI2I+qjyCccLQ5pvC1eC1xOS21Xn
         PSTA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZbjgxizjBCm0j7m4PZ9fzXOEy1XQRgPArhW4eIIgoUDHNeEtKOv6hMjhkm5vcmz6IzeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySD+hfFdrpp59wTAAV0GYw9Mbg50rNVhexApX8h0XKPUHce0x1
	gjh87Y1Gim6O1OWYY3rQXqa5iFpIN5mcaMR2R4uQsAOGDkPMEhwWNr+t
X-Gm-Gg: AeBDievBQBk9KlcmgEJuiobqSI3k6isRv0wDRYl0fTOmmQH5R/q+paWSXZjQcikB8ci
	723fMdwX52yERlgqY4GE8tU6KKNwJuWzs1srkqtCwsugwIC4VVvVRL+V4B4uYOAHQKg5AuLkas9
	5KvygxuT+G8NiXHkHCP8tLQUJzvsCIK4dYvWVtNjWZUbnUVrBC9Gm0J2R1vLR2Kf4oqsy4d6Apv
	7lvafb9uib+qU544Yi31VYH9gvk/THSmPu9t/QarsyOBkZFUucTbwGB7pvj91p8BvFG59+YK1mu
	r+l/iLTrf7gZSW/DmJUKsRDDvcKIQ0F3+zFnoqBpC1SSnj7Tmqs/EmLWlUWf1cZTgYA3tgzRBGO
	T6uSQ908lxEswF7yDsqI+zYil8+VBjK1/W/RaBQk52Kix4xwtHouPLLy+JvYGN/Ogb5DTPW6Aix
	9YlXsm5Gt5oazAVtp8JOcvLwhWY/nEkUhO1upsVaWRLFXFftEl0a7r/Jb8sXFGJ9ZAjqnecCZDG
	frmp4aOnlCUMK1OVvWgzmrs8tc=
X-Received: by 2002:a2e:be90:0:b0:38e:1714:b64e with SMTP id 38308e7fff4ca-38ec77f4ae5mr125096991fa.3.1777139064274;
        Sat, 25 Apr 2026 10:44:24 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb72017csm63002271fa.30.2026.04.25.10.44.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Apr 2026 10:44:23 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com
Subject: Wrong subject line
Date: Sat, 25 Apr 2026 19:44:23 +0200
Message-ID: <20260425174423.45523-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <20260425172451.21365-1-haraldnordgren@gmail.com>
References: <20260425172451.21365-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I know you are not Ben. Forgot to change the subject line from a previous message.


Harald
