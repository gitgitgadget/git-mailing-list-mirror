Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178C3F54B4
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147969; cv=none; b=ekPe5xVijbYPopgRcZgXlxgbDZfJ7QnHwPRKb3tFOCyp4YTb1Buawf/kPHii9wNYh+uRXVRE3n39tM3q6q7Oxh+AkdxjUOIvdMylT6bQM1ojbW6QQ8pyjfJHWxuEx3RD+r7VHE0VZrUiEBiGlunvzg870cCh0uFsvpNV4I8sn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147969; c=relaxed/simple;
	bh=WGMKPBz/1ZwQAXv3m3zek9+yjEMDvEKoGAgrIltImKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJtRXRd+6ECoZDlNihmKTJK7kRq2Wjq9tKOUxfAnPS28t4j6KFQxtS3ci4N7z73Vuadqoo5C/3ds9j9gjJuUp9eaVVwalewIwOxbnYuQMjYDTlDxh03CWaWi02gv920LAUju9dGlXQ7HUafRUHRybXxCjGrT6/XFVeBd9V/wmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIq/2/Ab; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIq/2/Ab"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824bcb2011bso137448b3a.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147959; x=1775752759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiVcZOPrEI/nAsR3YzdbZI5PCbN56AHB10S1J+ybwr8=;
        b=aIq/2/AboC2aRvzzX+z/w73gdG4ukQcFXx2j9BhmPwSQ9OFLSOJn3vIMpmUMM8XX0W
         M1qUuLPSEdKxclGJp+RaAPWa3fE5pi49qxLTVaimkesnE8IercuNgfkCRuk3MJhRM3iC
         wVGzWKM2gxagLBGViRUvRIkN+fbZvyGXRMYy6GTVTcxa99k/mUhj/VGhhpJKAYHy0uD/
         QiNPeDfNZlnxdwJln2v9xwMwcQUchSrERlnXhPJikJKFoql7OPy2K3+HIRF41Vf6lJym
         egNbAPoW1/2vBT8QT44lwd80C1cncc+vRTeL9EyFpx/t6zvDkhAZ8W7ACK37u2nm8DNf
         Uotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147959; x=1775752759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oiVcZOPrEI/nAsR3YzdbZI5PCbN56AHB10S1J+ybwr8=;
        b=EXEadzK+AIcsv6AfGH9ddmanqJoz4VXT2rWp6S1yzSaOPoUTEkRKLnOoGMEJ4F5EIe
         kiVh8lQIo5eD8PD+7rYidXbO2+iqwI7Rp2IbG1P1IhcmNquUbzWeJvYt2oJQFSoD/poz
         IFG8kaprgoTf5fMBeYMHIQJRQ2tqMb00Wv/Rb3Gvg7ispqWmsT0pJ4bWek5yo6gvq+oH
         u5c2ptrAtAZEnWXdo+moYV6qbUjCEgZe01cZNJs/8QjG95SWp2eTS+Qv6vWf5Z/kR8uV
         DGX83KrJtQCI7xZgYLcXKEVS/yeaa+BnRaC4iWYHOU21/vaPVgOE3J8V37fjmsNA9QgN
         mNWw==
X-Forwarded-Encrypted: i=1; AJvYcCX8091ufmCZgHUmTeSEUuleMf8QIzY8FoPwsgFQpiDxb9wWujkxnb91+HmxAtEvWGll164=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+j7R/jByta/tFfOBsXeAK7wa5gAwMB8M/vrc6jLHTzPFqt8h
	3nzYXJ87t+EGZzLBOea7XETJ7ITZuKjN8pXepunNvbrehYMrn94ehZoL
X-Gm-Gg: ATEYQzxVHh7CYbphR/8gxylTbTYKsOMcsTEdFevZPp0ETl2NkKzspSr2qrkJdi5CfO/
	YG46FRomXSlCM4+hK/ANijJNmUSVFb9QubyNH6WrGYt0yQ2qX2TMY3pHap1/Ou7bEZKbSmDs1yk
	rv/4LYZ9GkSWXLkRefVlQPdYQAShQZ0sLdNsJF4Vl5tSl3RefEnoItI/82ebC+ZVWilshS89/kf
	sbsy7/IRgxYUsLDHKT7XDKVQgHwC+lzqtKkIrHq3zjRu9hR+LcQbcHqoqTUdAoYRqwBVjBu5WQ+
	xqxR0jIxNGrJ/+KIsanO6enubnPJv3cHj22855QsjR4zosLA+3wrZseiT35xo4ESCTgL9HvgsSm
	t2K675+XdNGGzgYg+rnO/Ko/1Pz4z54TS4y3CuCB874dvX0rGFf1Qdez5z/Ld1HEkBpKnwOpOJm
	f6s8z9b9ryEZW5ZdipMVlL+ZQcq/FU0TkZt6sLfbKsL9GGsghnS4iLa0bFQNjlFZN82toI
X-Received: by 2002:a05:6a21:1690:b0:39b:de8f:428d with SMTP id adf61e73a8af0-39ef71ef4a0mr5282179637.1.1775147958685;
        Thu, 02 Apr 2026 09:39:18 -0700 (PDT)
Received: from JAYESH.localdomain ([157.51.119.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6fdd7sm3576656b3a.48.2026.04.02.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:39:18 -0700 (PDT)
From: Jayesh Daga <jayeshdaga99@gmail.com>
To: gitster@pobox.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	jayeshdaga99@gmail.com
Subject: [PATCH v6] tests: use test_path_is_missing instead of '! test -f'
Date: Thu,  2 Apr 2026 16:39:04 +0000
Message-ID: <20260402163904.14046-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqecl7u2ue.fsf@gitster.g>
References: <xmqqecl7u2ue.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jayesh0104 <jayeshdaga99@gmail.com>

Using plain "test" commands in a sequence of checks chained
with `&&` makes it difficult to determine which step failed,
as "test" silently succeeds or fails.

In this case, we expect that `.git/refs/heads/f` no longer
exists. Replacing `! test -f` with `test_path_is_missing`
preserves the expected behavior when the file is absent,
but provides a clearer diagnostic when it unexpectedly
exists, making test failures easier to debug.

Signed-off-by: Jayesh Daga [jayeshdaga99@gmail.com]
---
 t/pack-refs-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..4a85d96c6b 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
-- 
2.43.0

