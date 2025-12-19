Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B93358CA
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144768; cv=none; b=bVttnxJGnyA1nSXShoA6IM2hYhCXG/3O/ChE0N2dV6i33jbEsOY3/bvwJnbr8i4zp7Ncql7Npoa54n9OBFdwU6wdTyOcuqjDnFKnDB1xi76sWw2+J3HqK3x77QkhcW0iFtp+uaQZRYsNOfgbPPfS0ZA3i23b2z3IGj/gVjYBBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144768; c=relaxed/simple;
	bh=uoSao9/7Xr+3WDUMIYalw4mWHmR2Kp06JzJ1dsJu5dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pa8mz9a0pmvUtgpE6AXEXFze4Lqw32IHGXTFy3mHweC+3iIbNOxtTBNTxcGQKkfRSJxMdHlP0VeXLXwkzVGAqA0lK7xQa3pAwr7sEP/7hORVlUPaDQ+EHuFgHyn4Wr7TyEWc5nDQ7grDe963ARzsK+2HJOndMlp/v4bxlJPD5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt6CspPx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt6CspPx"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5942bac322dso1969071e87.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 03:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766144764; x=1766749564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoSao9/7Xr+3WDUMIYalw4mWHmR2Kp06JzJ1dsJu5dw=;
        b=gt6CspPx/sJYJZOOopApJ2ay9NgytStc0tuPHvXt26Swm0Ov86I6kbOv15/gO6xMY1
         FWmeSSLRaLDppm1SMIyfnLaaes4T6MYb7VV8ElwY0/ybVQFW/MatqY7FH7zUeTU8MsVE
         khctB+zqE5NSTX6EOaRX/x0OgH9xHavayLTSKOhhNcCJSI1f90nbr3EPRTCgEqtSMyUZ
         jO49aKiYEqOlJONRUzlw6ji1vHo+5L6gHcn4rrIRe4fCfelVGU3/Bjjcc5BlQoNCYOu0
         qpu/4KNl1zw3qo1hwI6/szaKewI+U+GDfVLHQYCyTMfZm0+snGJkXjZm49Zq597FbcY+
         Htmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144764; x=1766749564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uoSao9/7Xr+3WDUMIYalw4mWHmR2Kp06JzJ1dsJu5dw=;
        b=Gr1wQfC/72AD3L81/mcB/M/ht5boWMTgWVxesfrgYAlcQjYmpnWAN+HJn6sQIxx1vk
         K+zw0cKRP5LmmfAJd3g+OXKaefyx1EIhdvsV3fGllPOfz0vKcCaagVgdHZG3LP1Yi6zk
         GFf7tStdOW0ad9J6dtUpj7tELF7DLCwwKff8YaPPiaaMkdzS3+jjWACpO6M4snVhcCD0
         Kj1HwJje2VPNRTpKj34H7kOTNwim7t9fhh+aCRkKmt6NNmItMMkXg+/vWK0QnO8iktmz
         wQV0v3CFtGyajgmqjeg4xi9kjnX8xbppaSILpUFfTHYjz7e76W9vZBZUOVaYz096zKEe
         HFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPhyxgZSjWAQr/p8Bc6Rz8xwa/FAehnOuHQQdeBWQkN4V4wGCAP56NNrkLl7GOxkdsf4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfuRp0LUGMmbrhEN+2q81uotg32pgw9tuuT6sTMMGS8lGsvo7
	dyfnzpVW+oOi5AZPzk/FiSxXEHXrEhp3NikrFHziw9IEZbK1mrwlH452
X-Gm-Gg: AY/fxX7uGIHa68XZOYdEJ1F6m0mDL+TkrCoGMSf54N+QLbKVNgS2DeD9fJo2mBtHC0l
	U6zxGl83TiT7GQjh1wzQzbqTtUXeFd281Bip9y4A/poG4TiGZNIJRTWD27skSdZ/GiGqFMBTw0y
	FMClCAn9kOjudeXecR0q1bwYl62yxhd8/65ycN7VVfV3ssSyc8K2hx3zB2WyThOw5POZ/d8xdAN
	Pgw189QF0TgbU8HjmLvBiMFhz/Qd5rIrHWrgJxUkwnLQ43y9ZtUkC/QFbyzyDmKDpHVA4XKOSPq
	nHm4UaT1MqF+zEJpMKWnDfKYQgN01eij5gx6vU82IW9t+9ZSHaDNOqAM7MGtm4dr7e/o++LH+L6
	sAYh1WaLLAhQVHY4BixEvPs4rM6qmDz4n3WcHFl8vrUxHq25P+aCFQZZSUSICD3HuUb5iZu9SeI
	EOEakwiEqyYtdDGGIMuQYI5F+nhdP1FttssageuFTHK6BJ+HIXK8Yn0HZ+JuDmVFzhuwA+lN8=
X-Google-Smtp-Source: AGHT+IGVe1l+eW20H45VhOM3PqWG/fwhXs3eXvueg4K6CgYYtVU8tjXdUCJDDuFCJmE9/h9t11X+gg==
X-Received: by 2002:a05:6512:234b:b0:598:ef4a:b9f1 with SMTP id 2adb3069b0e04-59a17d09277mr1129987e87.14.1766144763882;
        Fri, 19 Dec 2025 03:46:03 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd8f3sm650155e87.36.2025.12.19.03.46.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 03:46:03 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: collin.funk1@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Fri, 19 Dec 2025 12:46:02 +0100
Message-Id: <20251219114602.96489-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <035238d7-f98a-4072-a363-9a57650abb95@gmail.com>
References: <035238d7-f98a-4072-a363-9a57650abb95@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip!

Yeah, getting rid of the extra space in the beginning would be preferable,
I can take a look at that assuming that this has any chance of getting merged.

Harald

