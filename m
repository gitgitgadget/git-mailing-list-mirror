Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79A2147E5
	for <git@vger.kernel.org>; Sun,  3 May 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777847543; cv=none; b=PNmfbWDDVblKQp2toOMkUqnQAomEz3aA39ALw3nqJiDoYscQZQlxth1B3ayS6xUj+4UW7uinoVqaontQz7FulAagoV6hov+MO+z6RPuChsvkImJ1t2uhevBXCM/lLcNx0BO+dFPI4oQDHHEBeXAzwdwSbC3ml7dO+prYD4lJgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777847543; c=relaxed/simple;
	bh=Xsv6RyqT2HcJQ9AZktceeG21LwJcyK8f0hbiuDT7RJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmj/sQWk9kyLWQNI1P8xZo3RW0rJyKtyPhzZbsodqZ1hloujYQ2Q67lez9ZBRcYtK9jVh/kZyeFe3CZhUBsUK8pg4t7GMqw0VoeDWu4fCX7mOp6B+vIW0wTobNfF35czpDav48b4TiiTpBHjIly3razvYah61Xj7EzZkHMSps+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrTw4Kd/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrTw4Kd/"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso3869725e87.1
        for <git@vger.kernel.org>; Sun, 03 May 2026 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777847540; x=1778452340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsv6RyqT2HcJQ9AZktceeG21LwJcyK8f0hbiuDT7RJ8=;
        b=NrTw4Kd/huLdJpQNOUYz8lW/cmNtGIVhIe14J6XMiSLkqPn8aAsn0D8SRa643ezi5N
         ++3YbQ201AxnHjdjHvAm/AcOPYoJaVsPTul4EHq9XHX+uaLH5swX1Iag+peIYUn+lhxV
         4tXSaaTsfiOQiBVM/Oiq6BQOYrm3k4Quqyy3kbSPxx5NRX4bzwsNuGAKCfwS5hkwAfAk
         znXiDmLiSzful0yVToK5pqQyKl3TyNqoASE1YvlHqmuAsoC2rhTg58MlKGCJvSyStc5L
         Vd//9Drg4r5f2/2+gnaruLX/31KnCyxsiBFWY0sx7kaWg0ZwDiQrrTQmFsg6a7V0lDbf
         c4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777847540; x=1778452340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xsv6RyqT2HcJQ9AZktceeG21LwJcyK8f0hbiuDT7RJ8=;
        b=PjmoBdm3iwwLSdjMwjOiHlH3N8PX0zn6NJy+cugPkteDFviWwiS0QYtDc543JC+7DE
         8IwEUBpFQunN8ROOSf5rqO9UnF2adVKjtMWVH4lJZWrrlilC1WqfV20/qphO4dIgBEbZ
         YtWjqf2ePjITxpkxORuuYLUqIRMiR0ufWpZutmWIBDed6vmqAN8IyRxHVLMxIMeZNiy1
         2apG3D+PhTP+Kcas3ly9S3frePCvYtL3ESuB9wzisVqOm0poqvHEgbuPmhEKfTi4y5vL
         dOTwNrWbXzRR++ik4TF2KUyllA+qIwMQPLbcatGJoxkPeeAafTN6olbl/2QEku3s/+e8
         wGEg==
X-Forwarded-Encrypted: i=1; AFNElJ/KbshSrNZF4pAYCFeBUz1vFDguq41cn8+i130zInQGJ++ZlYSKGwS+t1LXR9iVvplZqnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaIV8QMOVCcgay5EzY1VRQX2L8T6dmAFraCE9Lj8Nam0yQDmi
	BgC3hkYykdLoHh7SwbZ0yt4/mIzZwmqCze8ZZLT3uarDrM76Dj9BRNZ+
X-Gm-Gg: AeBDiesYzmieUSxdpeupDV8cVJiGm8eyXeTN/oBqcOi456wquNk3nh/ybrs6uCZyRYW
	dR73DMbSYgSUOAaF5z2M5T6gCQDX6SEmmfrQaGxVm5rIAwndkNHf9LspIheGppn8s7OEQ84PMQV
	j6kaAr8ynCu0eZxW6jKTMv/DwmCbWxxnyRI8BXXLU1wOSJ7Sx0yVNJhmSnMIQU1JNH4yluVwpnY
	zkK0sklr2X/ZTr3Pztj7UZ6df/x9ySEiAR/kYW5SIqeuEgkLWnqy6VY3Ab01xBaKV2GnSdgw18k
	RSmh2eWESedh7/DVMc2iyH/aatuwxcTkjyYpoJQEjilOS75AdODLaAVhe7JH12lAgDDNEb8Y/rg
	52qky+b7AzCL1sa3Fl0YuvJwYDiELOr2eHRL3UJvS8Ckmx3vl2kWgrySYwWEVub3eu0Eb+S12XL
	u5O6wBpGaCSTn9IznpNXbKGB8dWP+Vd23m7X6ech/BtwH/FdTsA6KX/TQgbCRalYL+hhZ0
X-Received: by 2002:a05:6512:31d6:b0:5a3:fd47:aae6 with SMTP id 2adb3069b0e04-5a8631c0fb4mr2275643e87.32.1777847539580;
        Sun, 03 May 2026 15:32:19 -0700 (PDT)
Received: from localhost.localdomain ([192.194.110.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a870149b4csm438218e87.77.2026.05.03.15.32.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 03 May 2026 15:32:18 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	marcnarc@gmail.com,
	ramsay@ramsayjones.plus.com
Subject: [PATCH] checkout: add --autostash option for branch switching
Date: Mon,  4 May 2026 01:32:17 +0300
Message-ID: <20260503223217.990-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <xmqqse88ryyk.fsf@gitster.g>
References: <xmqqse88ryyk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> How about rewriting everything up to and including this "Tie the new
> ..." line perhaps like so:

Done!


Harald
