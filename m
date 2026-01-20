Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8843BC4F4
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921385; cv=none; b=BMHuH2/fmE276HTP0XR45wvbd0h/uj8aw1i+2cBqcYqh3g95f1SJge2dQrRbSEjvjWppcoz1Ouf9J8vhv8m0TgZUx/LxyM+KaKtaCt6SE97iaGxDDKGgr1efD/HFDY5B3DywTYQFTMoaZWIOa32YsKCBzIe2D3aU7X005QvV3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921385; c=relaxed/simple;
	bh=0rmlYtlg8VJshJGzZ9VkUijOS46LP3xSlaiakgnqzFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M01tOGuD+e5AWfGVgA2UCR5Nq3A2kCgAJVqIMns6pZWvR1+TJw7VZx63PFCKWZqQqjpHwRsdFdIkIAzx0TtlDjs/sWPC5rA/m1MAYhkY7y5tPmeSQoJmsJS6QaNL9X9UbFoakPoUeh8gQl4fSa1cJAEtFRh6TzjaQIaZMHJQ8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAqzQ01o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAqzQ01o"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso4540707b3a.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768921383; x=1769526183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rmlYtlg8VJshJGzZ9VkUijOS46LP3xSlaiakgnqzFs=;
        b=kAqzQ01o7+6uOZmyeDPshGzg7oQSymuGtucB3yLQDou1xWsjjHV9BfkjwanhKkdLFj
         CVz83w6n9aukD3+QhyPLwyVreWkc2iUwg08eztzt3YJ5wsCQwYXYgNmwLbyo0W0Y/V8k
         66RDDsMZsc9uZsv8y8dQcPrec3duFcz5++BWSS1kV5UQoqhZdWOmYwSQHd7oJ5IMVsrK
         zC2t3dHt/3vBChVaO7dbTjNBggvM+DejDQv2K/noLDEtCfo+ImPK12IN2xNjohSu270Y
         BVQJ0FnqqmP78ToQmq9JO8rodAHnBjLk+Ax1Rt2f34Y4/WMmZ21QnGVYzKG/orLz+FQA
         7bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921383; x=1769526183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rmlYtlg8VJshJGzZ9VkUijOS46LP3xSlaiakgnqzFs=;
        b=HlniAJINsysqt6/+1OSvfL8lvaoVv7GMWv1A4fi5mtO2Fwwv2AEvIxPHTThYxQTTWq
         KfI8+T4ddpgFl7wvPS0eQqQpl55bJG2/njALzC1PsG5BW1CMuDQ0qasKS0lDMQeUrvPd
         JLIqMFGphW1Mzv/dhs9fM3J//4NCTZ2ZfzC53I4GYJddY8VPjeK7T9tXJu0XJbczmZcV
         zG39wc6Ks6apOx8Dc94bzt/OghiXm4cQLGP/1+Qq6wCscfdai7TJcvAVYRWqNZKGq4PY
         qZYqEmX9zUkCQU0k0BUEK0GfkKTuUsvNEiNmSgA1fV6m+8ebIcY+OpZyih+327pUZ8UD
         SKqw==
X-Gm-Message-State: AOJu0YwVNRcU75/F+dVKrEljwMeBZPCA1i3LzNokX5mzPuh09rKFV3wM
	9dwnuKCxjfvXKOk/Wy03VLJUJJI3bMqUL7KR9WHjLotf7F5whNaI8rnFiSy4ZQ==
X-Gm-Gg: AY/fxX7HVHLp88+wi1eZPZTC7qoBQgbGLVbu+kIglnSCSq0tbD58/tZFGReEvLChzYT
	615ZMpFxNIp8w6NS4914fDuAMCMFtsyrOUuW+I2RHSFsZ4COg2WalA2PDaHpGplQdAtI09/qhXj
	WHFBZ8bLI/qWdEjlFpDA/jmcDxV0qfSDtyvLeicDaRhWcoymdRZ/Aw+njx/wIZKVU2i1u+h2UmH
	oxlXEHvb7R4Jdvx0DSSJrD3dzqrhCCC1/MN92qrrP9VYzRyORLaOz0/YfgFiFpWV3TvcT5hPAXN
	UcIOmA9NVskt8COLUNxZ5HStcABzYt2kFswUeez465b7PUn71wai88YauuZeK3Ql5vFo711O1TO
	AQiPkwLgSOrE2yJyYpBuddyDcpU22GQbR2vs6TEDQy82ZZmnrqqkD01i03WGEh7YbHJh2rcBRgC
	KnFQ/uCKeO8vTZmlBueBK+oLxy+lAZQL4TW/+rfl2CV3GheghrFbuMDAxE
X-Received: by 2002:a05:6a21:9988:b0:34e:8864:793c with SMTP id adf61e73a8af0-38dfe62934fmr13832303637.8.1768921381135;
        Tue, 20 Jan 2026 07:03:01 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:1da4:f9f4:783c:7ed5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2330d4sm12535223a12.5.2026.01.20.07.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:03:00 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: Re: What's cooking in git.git (Jan 2026, #06)
Date: Tue, 20 Jan 2026 20:31:45 +0530
Message-ID: <20260120150241.601132-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqa4y832ok.fsf@gitster.g>
References: <xmqqa4y832ok.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi,

While going through, I noticed that patch [1] related to
t5500-fetch-pack.sh doesn’t appear in the seen branch yet.

I just wanted to ask whether that got left unintentionally,
or if it might still be pending any updates or changes.

Thanks :)

[1]- https://lore.kernel.org/git/20260113175913.474414-1-shreyanshpaliwalcmsmn@gmail.com/#t
