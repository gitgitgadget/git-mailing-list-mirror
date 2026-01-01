Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A02A55
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767296999; cv=none; b=oJK6ImoTDmSs2sl5Ol4QeTBOIm00lLa0zZQ1KrS9bK5/s3Wabwb2P+JNOXzKQMHQjJv0pdUeYZhNjormE5mN7cbWMdQJiyqsgG6zBvWO6TwHZ8WgGt+QZWMaRgXAtlfNknUrarKmY/F8cCIBEahLG28FjNkKhtgufTGhSak6V8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767296999; c=relaxed/simple;
	bh=6q3SjDloWL53WFvyyXlXT5osRY1w+7688NAc/VXKNto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zo6+kzpA2VRuSfiM3WL7vAEvCehHmAdTncfLNxfq8a63GxnK5FbVawI6rS02yE8hZKfzIvgsNdarfycgoJxwMtSyBcN7QKu4Kq9/UjColA5cmhpDvxOwlPSqad/RHZrir7WK7dOHn2ktDHWvBLQHPtb95Ds5h1sRZs64OBx8L80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq/febPJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq/febPJ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59445ee9738so9234774e87.3
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767296996; x=1767901796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q3SjDloWL53WFvyyXlXT5osRY1w+7688NAc/VXKNto=;
        b=Yq/febPJD+m5FxOXbndwYCjqmpAn8xsq1562hCC1O8Y0Uz34p44V06ZM63Un6ZnyKd
         vl+8M0OykW3VNtyXBTmOMTkoQTf15E4BBDirXU0fXogPVqmMtjecOUQDAVzRxqeyTES5
         JDjZ47yn3OHDV2jHzkp17FA7NIcqt9OcJdcJt/x0UBxIDTq++goQeoGtb04LQEBCUiXU
         eLa17QF87e0MzZrn90a56RPeLgZi6ZkfuItEI5GHyaS3CaSN2QU2reSYYQPpjl9hECYY
         5lE267yXVU7/v9bkZ6lD0JZ4YDqECSdoVcVegZLVKJU2JiBeDQrTxo4fkI4u3oxgKI2x
         i5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767296996; x=1767901796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6q3SjDloWL53WFvyyXlXT5osRY1w+7688NAc/VXKNto=;
        b=ppGpaof9cgO5sd7HIBb6paZ+vjTSo1BnzhFFhK0oChSqlJv064ta5la+XGMQ3vTQeb
         V9sNMLp/k0jctZZ2e6sOB+EPvCTov36/SlL/efn7wXMJyZNDcdFu14hzeD2SyfVkHJkz
         DkQ67b3JT8ypZYzMUvTx+SiIhIZcSrkYtjlJuir5SK7tn93kceb5I/Px/tGyaQ06Re/+
         DOuNcQ1zWBakptyxbdFQsguHAoyGmdSvrM1L4LTw1Mh6lXJtbQnZbkxcmi5CW4AnbflL
         iODEwjpRuRr6Akquwhq8kLmo4v14u/QeJ0JXWBTd5c68riuNpJoSf8sQkMAUbV1WrkMG
         rNdw==
X-Forwarded-Encrypted: i=1; AJvYcCWoK9cGw41jgZnsFTfa8U+Twgg1OttBiX8ZSFSc5PITdHYbaIqhwYBlmK6m3hJYNQPQIFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJROvrbcDJwv+xrg+EmyAFujL6mSCJ1JkcUudb8Aycze/qqIV
	j1EJ3kpUVsB8wcGuhrb78FJqDbIpg1uX1WkOO21/cCRNhF7bswl6IvNwFLq/7A==
X-Gm-Gg: AY/fxX7ztHr2AL+DnAFUpz3Te+yu8KW2zuHmY7JzJ1vKEideMt7gR/vTs6x4zT6t0+K
	ukeEVWR5Wm4KsMDFWAo8cC4H3KkqJLUNAnfuj7Jqm95xNOacBZ9F7hmTQt6KXGUoJ4u+VcvNoMX
	Zddad595pNjt8gbSoMaAdEwtUrZskAJr2KpU7lNu1POsn5lLuAPkrGha3uMKV9/VIiJp/617969
	hurT3Rmd2Gmg/lQCefOFX/GGAavD9/Yxn9g7V4PS6wt8AM15aut6/HSCMW8PHMmmzByd6wMSZVE
	WcH2PJhyWyK+Vgcrm1pCyDEvsb0CDedmWXMfK3b/4014g1XkoURjWmMGVXuwGiQFVKiqt6GDB6r
	RpgNiBEX8wNIFt2bHqdKHYohw3gk11223a0E88GYJ9u83kI8bszeOT81ZE3+7DSAxK/bYaSjK+O
	ewr+YsBXM+yGVJZGYy3mKZrOEBN8Jkt06IxdlSSaufHU9+w/kqEUY94fl7QwkR4zduuvHJvwM+o
	YsmbLXio7se
X-Google-Smtp-Source: AGHT+IHu1/5vsrysC/5I2O3AbePO103Z/3mVlhju0Squ+Wku9H8Xv1EV+e9gx/0x/9ul1GiieLi7ww==
X-Received: by 2002:a05:6512:3d03:b0:594:5000:4554 with SMTP id 2adb3069b0e04-59a17d5db51mr13959372e87.28.1767296996124;
        Thu, 01 Jan 2026 11:49:56 -0800 (PST)
Received: from localhost.localdomain (h-85-24-230-171.A753.priv.bahnhof.se. [85.24.230.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd90esm12031967e87.31.2026.01.01.11.49.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Jan 2026 11:49:55 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org
Subject: Re: Code review?
Date: Thu,  1 Jan 2026 20:49:54 +0100
Message-Id: <20260101194954.14649-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251229121731.90086-1-haraldnordgren@gmail.com>
References: <20251229121731.90086-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I found a way now to eliminate the config variable, and instead uses the
push branch when it's different from the tracking branch.

Let me know what you think.


Harald
