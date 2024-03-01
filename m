Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764DE224C9
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709261444; cv=none; b=E5IJZWFr6WZU/xVoZ5ClNnS92+R7WHJcM67ZotHzezehK1tPZLybOUcUvRvmQKuNmXcLssvQS1UcKbwn56GB9WqN1ffd9nhtfF3h6gdQt1wkSkajinkNIbOUXltrtQsFqK3EUjPuhRU10JZGBgBiyXuqn6Z3j6O/IV1OpkNTEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709261444; c=relaxed/simple;
	bh=2kAr3Ect6tAetcqmD2G9mfML9cOK+uYObMQ7cnNFcqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ9yYDDIicTfdhm31TOtvdAy1NFa7FLqpJcYAk/EbmXq0OcXPn/JnY5fUXARv07biUkfNmo+RQxONhtYlE6/wj7JfnPOuZusrfi+Z+FsExt9gbgkYBZh5IV+WoOgTtGmhVzlp975nhLCMhk9xJeqk6qJKYCIIRvhZGGyAWhE1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHOPKmuB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHOPKmuB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dcd6a3da83so12085485ad.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 18:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709261443; x=1709866243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kAr3Ect6tAetcqmD2G9mfML9cOK+uYObMQ7cnNFcqU=;
        b=CHOPKmuBfDPCY342ExN+gIc0eBio6vJbwFyPolnMYhtSfQ+LsUeG/V/t6eqAnonuMA
         WHI+6rk8sInK4MqVJmBoK8zNTDaciGSfcR3lJsuskd/s6Xb9U10zoG9zpUduvgADczfr
         f516w1TyUUDlFBfg7RHV15tjuBwpm+Rpo75t7rRoUX5wq7u2ev6eGHFdflH9j/9veXix
         8XL4ga7Kz60Gplv4daWG2NdVs8LBB4efwlLvm7kCj7usCzUTnjarsiQqJ5Z/R3dlJbhD
         8pXiUhftJKX9ZMSfTRJwPNxyjOEv8gEMvVVten+pYQZCnGhEbXEkK5kBF331U+wQcWkr
         ihZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709261443; x=1709866243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kAr3Ect6tAetcqmD2G9mfML9cOK+uYObMQ7cnNFcqU=;
        b=Dd86uE6VSOEc8dYihFBjxgIEcLJGntwMYdqSypX8kaOpYhUUmdJBIIMF+kaKFgtRLw
         kjVsoVHQj4YhAOjW/OkPtqBYxXqxxQ4I2C+imy0dtIAJh4ZJKyfT/beP7q8Yr2Xov0Yl
         6WG24PQV8MeKl+VjXuHaRA3ss2wYUVnUIXba3PeLi4nS6W5FxhF3QVQOuSp8zJU0eRc5
         Jy3SAJLvRW6SotZkd/0YqvgQlAFf6fzGyoxJtyU8Zynza4ITuCmlT1OZXfXUELCa9hq/
         4070W2BoJ345/yG68RnIgmHcjyTmWVVpWGlhlkfIFGiiOMofrpPzfq06hbZThdTcVTSn
         YinA==
X-Gm-Message-State: AOJu0YzmFDmylh4fhQ42v2OQ/rySgsUwid31Yxg90dx7tLcnXzmMZcMI
	MtYjEEv3cye7LjiDHnsurMtUejL0qRq0K2Mas7+zqcUoAk/FnsN2PnVrKRUhWCtKhw==
X-Google-Smtp-Source: AGHT+IHSACMs8ZCuamnEthQbyGJA+1z5PW/aGow9+uOxFq7yVOTAn4ANtfNYpEZpmVpjCo0gYq5osQ==
X-Received: by 2002:a17:903:1248:b0:1dc:744f:5317 with SMTP id u8-20020a170903124800b001dc744f5317mr340406plh.50.1709261442602;
        Thu, 29 Feb 2024 18:50:42 -0800 (PST)
Received: from ArchLinux.vdiclient.nvidia.com ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b001db86c48221sm2273777pla.22.2024.02.29.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 18:50:42 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: sunshine@sunshineco.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] [GSoC][PATCH] t3070: refactor test -e command
Date: Fri,  1 Mar 2024 10:50:34 +0800
Message-ID: <20240301025034.26592-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CAPig+cR2-6qONkosu7=qEQSJa_fvYuVQ0to47D5qx904zW08Eg@mail.gmail.com>
References: <CAPig+cR2-6qONkosu7=qEQSJa_fvYuVQ0to47D5qx904zW08Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your comment, I will find a candidate script later and submit
a new version patch.
