Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E647DD76
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218154; cv=none; b=rdfwiVtUwYYIeL8zqm0W1OC5p81DKvq7K+e9w2HxpzCxNHtFMtrHzpBnLTDbywV6hzkwO9Vwyr3bxDxm9nmQvnGRVwM/LUO3aK9/jcLq5gzj5crp3HU94pDHAgkZuTrhEcv+ZYQWI6w58umXFX2wRpOSi49CNxnxLzMSkVO7y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218154; c=relaxed/simple;
	bh=50fqmumaqAfTF5nPPWn2oG0QkM5xDE4u4FDEY2ceP2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNWf6mxx9ib9ARWMTVrOY8LlA89oAlyqv8dtmUDLXWCZ2K2ozReH69rYPrQ59jr0q7NNRsEZ3JyCxpQhXcr447BWEbj+OJvkCRBj+onbPJVuZFTe3M3JcBgRCSkV7fqfuFWnZlti9KFHk3B+SKoaSmFBxlPIBMe4C9Mg03nk260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrFY2Zf1; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrFY2Zf1"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48c58132824so666868f8f.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218147; x=1791822947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHKaE+1s1q8B1fNG5t2K/+celDMJdfVESmC0v0jrcB0=;
        b=BrFY2Zf1c1ZURj8OtDkahbN9/fLoTCiyKNgL70jGOgJ3WNYc0ep/+t/YR4st5N5fh/
         a4LSv5tC2PiPR3wbMSqiTGsYF2jssLmU+OjEfQcVbzakbj34jOlcSbQeE8oOx92fAN2a
         VST/9Btkxq6UA13r5rUrMzy3kF55dM9GgigHXUAZnOuWLFdImIdkCwrDqtdMY2i91e/u
         EefBu/FNQ8kHFq9zhqzFDl4SnSHkH2b4sIH0DtcLhurbhLUCp9qzJmzsHr4AjeLkmV4r
         l7uS403BbJoM7FsNaAAEjkDqVdbCisJONNdVIzuQEZ00b2yhX2S4JS0yyo8EdcUuyRQi
         M7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218147; x=1791822947;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vHKaE+1s1q8B1fNG5t2K/+celDMJdfVESmC0v0jrcB0=;
        b=Mbzf/PzcxSZOCfCySZ+QHZ2OY6XrPWGy3F+5OwLLNgl2h0TyfiBUuOeYgIf3V5aQKL
         0PBGnciZ6VRRoaeS/XI9RYSRN/iAPYgEqLD1+0tEXDMaHxvxQTeBqY/b2766iHTb1AKA
         Utkol9gk6scbDvoch3mNJlJ6Qj//Y0UnBKC9Y7Yrw7YDUDELZjmP7fDnrGha9sOeD93V
         khkEgI7+ZgcbMElFlQHkoG1giFD/I5lqOG9axXZ/bJ0a5ulyqRpT1hkHKAP+L0L1hOuT
         IS0xcuIJgv/TG0827/FXWtAGHu/86vFGxKKaaRI0sOSmSkDypnLWyU+2iN7yHXiw150o
         4QIQ==
X-Gm-Message-State: AFq9FYJIPzJ8jPNZ2XGUy6rkmHOteyPCrT5jN+w8co5YlD1TTztKCKYM
	HBTBNjEVJiWbc8J/l3EGTyQ15eV/BR1f04sJCgAD77yJ4UC1c3xyMlBbpiZQQXNo
X-Gm-Gg: AYBFou2zt7+aQprTmyS09bbqEub5z32DXHDdWxyueKTW9I2uWLp179W0GGQY0rbZ33B
	zTlGG2PvNkKdPC71vt+KqhUxTxgVu0+7y9hRJ7Wz74l7PfwRzD0m7HYu/fNMP7+Pfpuo5a8I48H
	gbwvmfzK42Rctb6GgWO3cGmodOKPGbB7/DiDBFWqf36EVIIu1RRSyCb+Ay35yAAQwA95NFs16AK
	xK+p7mSdrBbfpFuXsX429jiZGWEQupvOugqBWX/sZsKPNZEjEb8ps63q2TrlNItGNBxR9S8k6q+
	YPWPPaiPZwy+LnQVe4p3y/jsOYhNKB2nFX0M3eHBN7WME5rhDqf+jWQZriq4KpPwyy0bqlRIViE
	jEtJzrhkazjvN6mGa8vnui8KKgNbZOoWSGQ5gRIz2soDYGV34ojc+xKW7s8puGxj1N67ofGsVtH
	Zc/zHqsD4G0LgryzqEN16/Cwf6Nkf4i+/y1/GS56j9f0itsoygLPElaEyG4sT6rMvLCttVvZFa2
	3aWbM2cJ/pL
X-Received: by 2002:a05:6000:2086:b0:48b:174:eab1 with SMTP id ffacd0b85a97d-48b1271f6f5mr21262825f8f.36.1791218147119;
        Mon, 05 Oct 2026 09:35:47 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6229e025sm4540545f8f.31.2026.10.05.09.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:35:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/2] stash: stop checking for changes twice
Date: Mon,  5 Oct 2026 17:35:29 +0100
Message-ID: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git stash push" and "git stash create" check if there are
any unstaged or uncommitted changes at startup, and then again
when they try to create the stash. This short series removes
that duplication of effort which I spotted while looking at
<20260929074222.11942-1-kazumasa.shigeta@kanamei.com>.

base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-optimize-check_changes-calls%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/c46c1e377...95b7d582a
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-optimize-check_changes-calls/v1


Phillip Wood (2):
  stash create: remove duplicate changes detection
  stash push: remove duplicate changes detection

 builtin/stash.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
2.56.0.134.g299a3c16181

