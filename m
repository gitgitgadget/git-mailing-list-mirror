Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6248CD59
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525913; cv=none; b=TswrmbW/4DqIOndF3P1ek6eOIzo1fmw8Yj0O9DsUZ6jIQn5XljF6yDgewyZ3wWiG6RuxjnRTnwY+bhf01NiQ43SLka6Ufbl0yXu1YQWLGAadoTxvUM30xwCcy+bIuvqP83W0pBFO8nCQ8igslJNVbZJXH1rXL6PZN+xHoWZmKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525913; c=relaxed/simple;
	bh=F8abJ7KLbaeR7ifqrBz+P88y/49Sb23vh933PvGrch8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifz48odOEgf7PVug94xK2xpmiTifelNw1vrvG9WBPdg5F/tWB8SZJJ5ZeQnwOFCLC0MquT+sHt5WNF7tsBvT7Ihu4mxwgmECnMYutHdOVUpqlIIfkVX1bv6QD0XuWdd+abcA3LnDsG3bACtP9d9Yw1oTz0gMywlQ4zIKKLQacsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=UY8EcT6y; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="UY8EcT6y"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-485850cf499so528957f8f.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788525910; x=1789130710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8abJ7KLbaeR7ifqrBz+P88y/49Sb23vh933PvGrch8=;
        b=UY8EcT6yltxx3NGO2/349vdSXZFY+emb7s21EFdmZJhsHfLahJNu4OcL5rZ6Bg/eo7
         pJakKhrJJU7fJQRk9Bh8nkmaHpsk+wBvEsYfREvZOwrfHAXIJzvCVeUpI+zVgofnLQm9
         zwb6gjX4akzhPDOxD1SFJ7e2MdZOa6dJlUvxuzWxeaKVbTnECamZLbh8buuzcoJa2bVe
         4dny0f4ix0C/EodSp5/MxlQQZ4cJN31ST0Gn5yftooLhQHUIViL9nLC0yXEwOA8xBc6z
         Inag0WFvzrtcfWcIDcOFA/5tMpSTCAXpqRp/tmvvd42JSEqq/GbqUwCPgQIIBk1e3ELz
         aOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525910; x=1789130710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8abJ7KLbaeR7ifqrBz+P88y/49Sb23vh933PvGrch8=;
        b=dayV7y6TE7uHmizpyIVM0fX6+SkhVWMvXFABzyPThOckJmSDM8FjhcwDAKoQZAW1Ml
         eL8ptC6LspRTmkeS3vwtc7TImOJjXwRd2ksMzTlFVwSh3KgensmenaDON/teO0eIuCNg
         kdcWK3UxuI5e0cuXHYk1ioXEMew5AEmSGBR/XTtOBjQcFANn1YBl+7C4c+SeH74pFrFh
         bgNMan+ZbskseL8WQCMlYgtCN5sDCQGQPw0gyGLE9BFQ+zKkc/aGAC32GPt0MPDxrV62
         i+2lEOdXdFaBY/la3bO3PP3hJ77Af3tckfdpYXx3oVl2H7QpJzRWtOVIs2dU+po7nG4f
         NhBA==
X-Gm-Message-State: AFuF++k6ZY9xDmovGPYW0gP4SGGvhxw4OmQ4ZE91F9kHDrf591yCbL+C
	f98TpBbtwDpsNCVLd4RMji1yMpMJt9ji7MOVVj8+mWHfMwNfJK9YSK3kp9UM7N4KfAWKiF+y/Nj
	hHPxk0nqXOA==
X-Gm-Gg: AYBFou2myc9JCGKerjThOl66F1blE6s19/elDArKUWXKw/rIJk23fAIN45DC83wRwEe
	RGJKLKrLRzcZ1mzV2t1roja14jq1KUffLoexKOyOmKtjuAI2nJLLiAC4++bJBZ6X5PShqeDAP6U
	DW2Rr/aL7+TmB3NjZnmztnHivEN082WxvS4ZzUHtor7PxN4l36MpAYX9Bm+ZIPaRrTKWrD1dsAZ
	ALKjXraXgr1Y+sSib3f1Zns7kXyzwDkUiY9FMQYgPUhmUtFtxdFeiSLJ6vpIdKDJiUlUlW1MmWd
	Zvg4PSceH+nwqUH9QpF8+v05V5QS2OT46GMzIqkIyWRvJidsKgVr6DXwJ6dw4kncvr578FBbrUr
	VYXvj+QR/Ss00t5xh6PmyKpzEcltIR9H2nyY6bgtxuoKcVK18KqcxY5EwxL+5jGQajIOErd07M7
	AmPEV6yTUxVkVda/SjWsbV6W5dejtRVrvBbxsRBqMRltO+9gnAAIMOcxCE29wJjDcnaq99
X-Received: by 2002:a05:600c:a0b:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49cf8262133mr65319805e9.16.1788525909557;
        Fri, 04 Sep 2026 05:45:09 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf771e9absm68637105e9.9.2026.09.04.05.45.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 05:45:09 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting --no-commit
Date: Fri,  4 Sep 2026 15:45:07 +0300
Message-ID: <20260904124507.12977-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5e77651d-38a1-451e-b96b-33c91c414eb5@gmail.com>
References: <20260903125524.67889-1-f@lex.la> <5e77651d-38a1-451e-b96b-33c91c414eb5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:
> What does pinning a test mean?
> [...]
> Using test_must_fail() here without checking the error message means
> we don't verify the reason that the cherry-pick failed.

Dropped the test, so the wording goes with it. "pin" was jargon, sorry.

Your placement was the right one: the advice test is what tells us the
pick stopped on a conflict, which the bare test_must_fail did not. But
the clean-pick test at t3507:98 and the conflicting case share the
!opts->no_commit guard, so the assertion had no coverage left to add.

v2 is the doc change alone.
