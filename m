Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC64410
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcoMV9cq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28cf8de47e3so706466a91.3
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 16:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704415421; x=1705020221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgC/X0NwDMAzvQ1wjJCOtnA+dpzdkS/leJmlGzRwc8I=;
        b=YcoMV9cqtcBrJ36k9oYIDBVAhIgfKfdODoU5ejINAemnjfmjG9iTW+EuvJu0TUgZh3
         U3qEtV3kLzaviw9nmF5AzQDUXtAw2gpySEI8vBQ1W3R0lz+Ol+y9FiHTqpw48BzZQOzO
         LLLHEi4Mkkxb06/Y7MC5elxLZCADeseEswHMfAb7WBcDxlBRd/1a9R1NjTcoLJ985fhn
         pB5CrXL103GXdMavwy9rgmSabe69jshIzcSCYOqrIud1xcSNEH9yLx4V9xiq3sAokyAZ
         8qYG9mHPW8nTx9QRhRK8np+HnzSb+KeWmthHItU5P0UHx9KcHGv4q52Et42SM5zqohbu
         KnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704415421; x=1705020221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgC/X0NwDMAzvQ1wjJCOtnA+dpzdkS/leJmlGzRwc8I=;
        b=hbL5pV3hnRYonxi2jTg0VGyFhgoPwdRevR9PBW/x8bgVzaFZZS34nw+9fCYvDlrGhE
         lWsfNB2oQqre9tUebvBHf0KNqCc+3wtuSYhCPp0z/djjwnUum4A7L1G2htT72XnbDO/s
         8tGcADHq7LF9vGw5SrchqSUrlk7N1wbCvbaVV5qxXi/lfjalZ70oIi79CzIk90Lp5mkE
         YwfISLANk30Hqu1RNGTGeyzQ1uUpodfeNft98n8T1glVDpKCy2tmgZoC2NqGf+ccQ2b1
         glthIGvmVZ4fkYq/e/9mIINKOGWVXee3PKvnQzdzfi6odccRBxEDvEqDZtRjpenk1TK0
         Uh2A==
X-Gm-Message-State: AOJu0Ywkxc/LUmumxtiTNJI5sd1jck+gi+ttXvUOFKERLjloN5ihZui1
	S8wLyjifnfYpMzyWtiweRnYbwIFW2fU=
X-Google-Smtp-Source: AGHT+IETBg89lDuKKidBh2qfkWwYn+Gbg0Jv6QN42P/hKJ+pCrqWPNGtalbUnzeRtmNXoxBipZ/7fg==
X-Received: by 2002:a17:90b:2413:b0:28c:9781:d91c with SMTP id nr19-20020a17090b241300b0028c9781d91cmr1093651pjb.62.1704415421502;
        Thu, 04 Jan 2024 16:43:41 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:c2a2:6c8a:c793:9aa0])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090a9dcc00b00286920600a9sm4303636pjv.32.2024.01.04.16.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 16:43:41 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] rebase: clarify --reschedule-failed-exec default
Date: Thu,  4 Jan 2024 16:42:45 -0800
Message-Id: <20240105004246.1317445-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZZcE/Kw24YKlqSOT@nand.local>
References: <ZZcE/Kw24YKlqSOT@nand.local> <20240104080631.3666413-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applied.
Thank you for reviewing!


