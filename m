Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2F19CCF7
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766936818; cv=none; b=Zj8I8pU0l/FEpI9lTjCFgf3QKA3wx2HLi1zWHq/5mpzwCnKLQtuGyNI9O2SoNshPODCKwffD6/9WbKObpNfZoMi2F/tu/H54fS+q/4w20tn2zYWLQjyvXVkBb7bxtv5tCfrZBvjoSHjdAKUDf8JddWFlp1VVFs2FLn27VBPCIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766936818; c=relaxed/simple;
	bh=5wfB2KPbMzLIPs/Cv9Pyv7WxoTRkI83RTERCSAcKsIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=euAv/x98OUbc+lcGH8NwyDuImbniXB3+fLFo7v1caotJr08BYRdJwr94p71y2M9MQbkazjVZRTWpo23QH+DO8YjfQ1nsO9r9n6Dvy7DRJD7W41mD1lJOt23j3NR0bY7qhqDL+ty5H//LNRmWEcgZ951kauUMxuxTWqUxTyQVRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWzJBUHH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWzJBUHH"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5959187c5a9so7310812e87.1
        for <git@vger.kernel.org>; Sun, 28 Dec 2025 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766936815; x=1767541615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wfB2KPbMzLIPs/Cv9Pyv7WxoTRkI83RTERCSAcKsIk=;
        b=aWzJBUHHOgBR4xw7F0AE4X7UsTOUNeRGW2NjkhcF1MB8cBbOVMIf5xu/tPldgVHlco
         tGyaFj+EzeEqC8OYaLyGNghVa+yPpl6WZQAfzhY22ASEJ67/abm3C7mC6xm70mX4NFFa
         x17twCodz+6OoSVaLP7W+p7bNOl60u/71H7fLclBPNz1LY6Aeam2n5JxiapMenfkYCBc
         +TyV4z0m03Kg1hrEPxUVIUxou84ZyYrRq7P7EfNzPnStjtjsY7I1Epe3fYSZ1AdKHR+e
         +UfG2AUtD9bFoq9fsQ60AELaLMvfW5Or5hCxCQm6yGF2dBAZT6sN7gAGQ0ZgvMiNlIuy
         5tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766936815; x=1767541615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wfB2KPbMzLIPs/Cv9Pyv7WxoTRkI83RTERCSAcKsIk=;
        b=wz7dkctybVR0SchJt3ZeqoucUwoHnDwmgsXIVhPYzgyMmzjUn+ZbjmfMqUfiuj71EX
         rWVpavew8B7R7MRwQi0CjOcglOm6IvXemVDuxlt1G7E/YCWiWZeg3eyqfbsQnT3yjdTX
         iI8WtCTt+3z8P/KLPG4ToQmxTrauOBVtIrjtWLdHiE6arSz7IJ2ysqpH03Bi1EhPE4lr
         m49BPHZcTsstf/EvvIkcwNDMdUviI5sRvV2quy3U0bhQmNjwsSRy9gbBcVa1dWnJVu/i
         fmpBUBwlgDfZcyEmpBZzCNsZ9FK4jVBWL9cjARMpIH6mFxbIdnyL3acR+YTeoXwu77N2
         zA8g==
X-Gm-Message-State: AOJu0YxpRmw5U/AXRsuB+zgNd3I1kMEA4YwKj2OPxa6ry96Ff1LI88HV
	6hIhMEQwrKF7QM9gd5+PwCfMKFkorpXg78ofoAe7SmfvAY4bduRDkt/PGtikYQ==
X-Gm-Gg: AY/fxX4ErPEqOyb3jiMxcHRxhaQS31b+Fh9+kUsYqvuS4t9aos6j3Iop/3AEfwlwVwP
	x2tWorPAmKxC4niKu6c2sSihqYX0q+9QnASfaIpnABPpgQAItVHSxy/sk1Q98sKAq2zThl6a5Fp
	/s6azojJ3lhfnlHj/9/qCTLE4McPxTCpEpdbZk2aSaTmMNroQgi0lm7N512hQcMRE6LP6T29gf+
	9yTklkgrkPe1M1yS2CFowl4yRNUq5HRWaxsCmhIK8DibnKl+cJxaXQXPFf2JXgWrQ7mL8rJYHvX
	v7PlqREYpo+jclgB3EY9N33lbKzEH8wazraL9a0JwB2mcdoq4i0gbmGDEii61oIQS2N4ICto0/E
	7LSiZ3qrm9FYmSSEmM9zRPaHR5F75WoTsDiyFketlwsNvtXs9yJThOX/hX9mEuKPf71xd8ltpzm
	IWimxj2lgaGarI45D+PBgrpAso5lB4ZEGb24dU4VSG5NB8Rca5RtAXfpaW1JDwYXgKt4A7wqw=
X-Google-Smtp-Source: AGHT+IFgUVIsRN7i+ib2gLGu7GPcJs3bTc9mBKkey2kVxdGq7DIHXkmD9Z8Gb0h8N6Ne4znQZNElog==
X-Received: by 2002:a2e:a595:0:b0:37a:2d8c:c0a8 with SMTP id 38308e7fff4ca-381216e10f9mr87217331fa.34.1766936815027;
        Sun, 28 Dec 2025 07:46:55 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812264dcc4sm77951141fa.36.2025.12.28.07.46.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Dec 2025 07:46:54 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Code review?
Date: Sun, 28 Dec 2025 16:46:54 +0100
Message-Id: <20251228154654.82235-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqjyy6kew6.fsf@gitster.g>
References: <xmqqjyy6kew6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks a lot, I sent a new patch!
