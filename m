Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996F4E80B8
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628430; cv=none; b=Ag7gyHKLzxOvEB8r6nLW+PU52UJKuOHpc4SVKcQkJ5GfJgTeJmwmJvv54S3yRxvfaVxcmFHHTl7EPgy7E+D/dJZjs6rc5vZT82XppC0pLbNIaFNFDtc/WPDKf8FHcRSkY+U76+/vWCEDavqA5RBONDsXnlS6HmZkkoTUYTnh1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628430; c=relaxed/simple;
	bh=lXTDhX9PQ7awXxLqLrTs7uKU1tgQsa7yJqsPhVZMVio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrcG+Y7acn/3gXIcEGrXzsjvJtHZaRx7ewO6y82okGEaxu0Sma6H9vUzInbtjMm5NUq8xqaZAoX+srQ9ZiXRyMZzR8XEXjQ31dMPYKLenxFHEs0JgAbTN+rwotMNyAycXrmKun7Tsz9Sr6lRuevEZtPq1W4zixvS6jSEEH8Dnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=ArlOfq6b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="ArlOfq6b"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so28421915e9.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788628427; x=1789233227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXTDhX9PQ7awXxLqLrTs7uKU1tgQsa7yJqsPhVZMVio=;
        b=ArlOfq6bwCJn9ZVrezIkUHx/U1rQieHYFTkkvk55RZaZVJTvUM5dmwLCDNHUvRPAsy
         M1JBhKSKQzcPOXQrQmBOUpTlZ13mqCGQmfLYus5IBNYaX5M4bVzHK+qVwdSnWhIjfBbL
         3/3lk1UtjC6N36gSShIvlRT3T0Kyitk5ZYBPhkt+mcB9L7wGEx7km/KptuFhSatIuoPe
         AzY71I7QJdaMa1xfBFuIr+WzWXsT+W3pkW3wcmItkOmL0OhvtRIIQ6WakOLTjEFKqb65
         rq68JFT6T+ykSS4h55F6ZeVcRh0vI1DapXQUjSKsX/5rbPUTy2GmxjhU7uULT4cXXBFo
         cedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788628427; x=1789233227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXTDhX9PQ7awXxLqLrTs7uKU1tgQsa7yJqsPhVZMVio=;
        b=AGgzFGSZn21BSgXT0Rsg9IEtPemaCLkIqsNYkkpZefDuTOoVMMsKMK02aqsmIsp/3E
         46wcz/QL62tJQIc6rb5hDGFtqmskZg0M1khRbn3fJd0r5XbC3CPhNpGCtX+wdYkoR95k
         Y+YeImzf38FdOoakNqRRsewqO78SzRQfmtpZb4ILc/leDocmRlX8MLBVP91kQkd9Q1tp
         Tk94+aZn1Yt0Mm3NVUx3PRBJizJFR9yEJ8nT47dku+Ih1cV+/dECTgUZJ16Li/LVxME1
         lq2CTgm2cSfxvDNTRgHfoa5wubj/2IlhJcAU8N55i43hTe6RHK/QJxO1D7+oXz8hnDfz
         pn/A==
X-Gm-Message-State: AFuF++k1Cua3QEEzC9SCqnM0N8VJps7cuMulEj6FDPdP3Ie2SGvcpu4e
	LfnPTsGSd9C+16If0C98im1pIFMO7fRuQ+y1J9PnN9eCiP/baNmOTBEpmhC9+X1HmPTiBRwAQNt
	JgTXpCTOnw/+K
X-Gm-Gg: AYBFou0g3gAr4cHJveuVGTMgoH8Y4cU3rBVVZSpb24Cf9dDasZixfnINYcer5u1IkCW
	zWoRXrWb56qg9vK/sA/AG0Uv0BUBIeOtPWoJTHcxMGDYjnwTkrNeRVbctZjIguq4GzoOkgDrDwj
	daqn7+Hm98kIyCdkaOnqFFIUCmxCWz9JkG6f8ruNhrpq+589VR6H0TMq5HDInELEVe6gpZd7xBe
	LnIcsZWFuq/KR/4GA7I7cleMWjR0e/e+BUCWjzGCz9ZXjEXe0khRj7Qa6vBmPrG2j90DdBBw4kv
	SvDMdZ8cu+EiSVHe2f+d/W20CeC6Go/RBzEmZc+muP/BNjT1c52tpGZ2XlrHlX9z0fb6xzh4Kr4
	mEpp/1Yd++ukq0GoLEpqJjCdngyL9nM1KMFL/qL0LeijY+MdqHFHhCE0K7/pvuq+unRYn7p65MR
	wbqljJ0UnfB7yhjHGqB3tND4XI6fC8nbIRaDXYNWBVAzybkkmq+Jxe0mwvZMr/uyMuZIxz17NUi
	38bbMw=
X-Received: by 2002:a05:600c:358d:b0:49d:797:8488 with SMTP id 5b1f17b1804b1-49d0797853emr30861845e9.1.1788628427293;
        Sat, 05 Sep 2026 10:13:47 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf772692dsm195898875e9.10.2026.09.05.10.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 10:13:47 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting --no-commit
Date: Sat,  5 Sep 2026 20:13:45 +0300
Message-ID: <20260905171345.34749-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6d9595fc-6dc0-4bbc-b060-b34d782c6215@gmail.com>
References: <20260903125524.67889-1-f@lex.la> <20260903214553.53942-1-f@lex.la> <6d9595fc-6dc0-4bbc-b060-b34d782c6215@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:
> I don't follow this at all - where is the existing check that
> CHERRY_PICK_HEAD does not exist when "git cherry-pick --no-commit"
> stops for conflicts?

There is none. That was my error: the guard in do_pick_commit() is
shared, but the suite only exercises the clean pick. v3 adds
test_ref_missing CHERRY_PICK_HEAD to the conflicting advice test, the
helper you pointed at.
