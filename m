Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85422F1E
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142814; cv=none; b=VU1MIg4h6Sm6u7Rv9JuC8+yu3L8Mo0jw+lmOwPeLOhnAsJ+7Zbs5HfRuwXp6nt0/n8U0XOgr8V/x3TuOQWeC2C4pCrMq0hj0hfqyRBBBdUkGiE6O3HiNtKN7qJ8oTOR1eqX7rWEksqoQ8ggkuJz09yG5z/tFavWQJz0HbI9P25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142814; c=relaxed/simple;
	bh=20mhjGFRnIwoO7ihnhPqrzqou0z9XnEAhjdkdr/vuS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/46/cV0L/008MRFpkkftpAPDdqgYqQBVUSluZS2FIcCVEFH2KOh7DOFeRI+BZyAZcfvCJc49LHiAdgqEKU6h1vgezge9hRp0NaT/ynWHmmqH7RTCXztcquSF1eBlMKWZE9+fmr4m7XTiMApHb/uNr0ys1CEFDNHyW8sVCUXOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsvtzTBe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsvtzTBe"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ddd1624beso6967f8f.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142812; x=1709747612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20mhjGFRnIwoO7ihnhPqrzqou0z9XnEAhjdkdr/vuS4=;
        b=NsvtzTBef88BJlGnOT3QrRKR5FhiD6mQzZ6hJ9T+0qHjCya7Pni1i7IBry71arjmxD
         ykGI1IdMw8StxvGyaXQ3Ff8BM9CF66rH8QZFY2dMBM2vh7lg1+8rc+8ypVFrUjbIKl12
         Ch0JFe04udv6QT13CNPBWBuTHtuGvl2qmZxNpP2coGU+fqujRGely6G8pCRdUlx6C7jR
         fD6d1hhUGCDDsK6Yzy5kOd4KeomaYvqsCOrW52hkEb8YeTZ3lc6yTBOJkR36Jc3NiNbu
         uy++NwHnLcxaABb/8SzkVTMmPqXtLjsd2QqGUid4LxxtuF/1Moohw1WN0OxGH9IEiU2Q
         +csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142812; x=1709747612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20mhjGFRnIwoO7ihnhPqrzqou0z9XnEAhjdkdr/vuS4=;
        b=Jm98v41DQUyG1kc38jDq2m4xZLhTMoARsnlfyqhD+jDHf0zAeobuiHNC5dzT35Jolp
         jWbHU9Dni3noxPlmW4PIX2j6BvUqlnIw47+Hj3/3ka9YI40zS/OOzZyZdo0/S1yiLky2
         SQoZf/2GP25QAtxFQZoQ5AXE+MgC+awpHcJvYaIQdpmZyQt2YjDoNWB/5MVS1ZtnggDi
         YTwhPAXmcSIFu2oNQAh0PLBavZJZnVJlzic2GXpMdTGX3J334PQ6SNgwxSnktUnUY9pt
         jI3OqBD5OuK/1kSKpqHoimzm9rEE79xvWo+7MJ/kglUHpSahALfPbmWEhBWVQKWHORrw
         JCvQ==
X-Gm-Message-State: AOJu0Yz9Evfvk4zyJ5PIRqnJZW+DKfB7DdRpHVs/48hCZshcFd0ptAk1
	icnd79kG7O2AcKUzhFZWbDsAryVdhCBuThBV+tfnTNA5arUBdLceLpxL+AQ6
X-Google-Smtp-Source: AGHT+IFD/elQ03C883sHKsIdp1K3XzHrIJ4lSiyL/2PNT/YWS3hVewCQeBGFG5+K97nSWNIulhvCFQ==
X-Received: by 2002:adf:ae42:0:b0:33e:6e0:cc1f with SMTP id u2-20020adfae42000000b0033e06e0cc1fmr227487wrd.15.1709142811449;
        Wed, 28 Feb 2024 09:53:31 -0800 (PST)
Received: from penguin.lxd ([2.26.197.149])
        by smtp.gmail.com with ESMTPSA id p13-20020a7bcc8d000000b00412a5b6ac5csm2718562wma.36.2024.02.28.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:53:31 -0800 (PST)
From: M Hickford <mirth.hickford@gmail.com>
To: julian@swagemakers.org
Cc: git@vger.kernel.org
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
Date: Wed, 28 Feb 2024 17:53:29 +0000
Message-ID: <20240228175329.3371-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.44.0.rc1.44.g96c8a0712e
In-Reply-To: <20240225103413.9845-1-julian@swagemakers.org>
References: <20240225103413.9845-1-julian@swagemakers.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neat idea. I recall it was awkward to configure git-send-email to send with
Gmail. I had to configure a security-compromising 'app password' [1][2].

OAuth is a great improvement.

[1] https://support.google.com/mail/answer/185833
[2] https://security.google.com/settings/security/apppasswords


