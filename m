Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC9530DE3
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878462; cv=none; b=mwQ4/fwPCbKRsD29yGT/3zEqrYNUcMwRI0aukI4ijOIyLZjV8zWWswCn70wTClKLSqPAKt6jw2pbJ+n7f3e2LpCcWG2udFZmjl93pTh0scaqd+qAsarFWZ9RaxYeC2/2O7DOO8yjbh26bkYg7lWCNDsvI4OCZ1OumU8KSGcrGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878462; c=relaxed/simple;
	bh=b/1jVgsGT2GlTpzHSkoE//YxupNqC8QUhm16MOt03cg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L5FVXftJ0u3agOVRm1+a1kbF4iqAgt7AWWujGxbYZxZGuGvW387WSR+EF8RciM/g2u0YhFOggjpq9zTkLdKScm1ExijUB252nd+KJTudVGx6VWB8j7NJsG1a0VzTQFCLLs4l+K/ApZbosKm8XBoEFc5PDhdIolvUZmBeJu30Ktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUbpGwCP; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUbpGwCP"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c3so5336147f8f.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790878457; x=1791483257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oM4W81x62PncxNq5s/75hVavqdoP0I3Dhm6JYW28BBs=;
        b=VUbpGwCPsjRGtJogbl/CHmMzv9D8RuC2kV5JQ0eXU+3nrADKHgUvnQqJADwY7BARAF
         Qce192JvAa9l/y8G9h1FCPo1D+7a9HofBh4yK25KKZqCu1azAf8mDDXoPuJGkcpO0p9d
         Z2cevRV5wZziob2UxZIy8qDynzXZGfoTrVKMGj7Tl+ZvN1pEfOkPnc0ra5TaJ63XYn7f
         +5X7i+1bjFaCHve+UxINZHBR7kHY9UmFU8zGb4FjnycVNm5R+GnQBWX7i1a/9m4i3bzz
         sgdQ04EXZPN6mCFRXhPkRe/uUREd2C5sY6DC3CrcF+h/a4bUnkzvQTSw4d8gvKQs7jXc
         JiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790878457; x=1791483257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oM4W81x62PncxNq5s/75hVavqdoP0I3Dhm6JYW28BBs=;
        b=pSUBEK3ZyJZlYm3qHsXVuux2Q2SSqclIqy4Zhuu/0eEtBbD5IxZIAusHBNARWSU+4m
         mZTIfj9Agk1t33A5l+ayz2rrJBUcI2T5o61Jbl/2ZUn8G30vnv1eeHX1Lu6288DKselx
         rBLjy9cqnsOcpwPnNZ36ZFK/BYGkFwri4AxE4I2gx9ql/N5QfkApLiWGgP9VkfuSbJAp
         FSfXv7AJdzdlbv5Kd2wFptoZcTJvUxdSNf4YzKnVwGvHMvEmRR54bidoYOmhrwonDqv5
         TvTipjW84NJ7+0m4xOjDIPX0lgf41FpUZ/q9UGFyCxM1YMqFvJFoWHsgJyn9Zbso2XQ9
         4UYQ==
X-Gm-Message-State: AFuF++n/5Geqp1amb9VemggoZ8iPbR7eRQfBCCqSygH0OglsNA9BLHQB
	J6l1tQJw6M4d19zAzGyhg0hooYMER/+YnOaPvz8L5eU5RuMDaRGQLhwN1BfYtQXHH1M=
X-Gm-Gg: AYBFou3rJUUh1fPJlPaDxmIWprOusl9DLoJXw8GGYF3Nu0QvuOl4mFxlRyHPvWV3Fbo
	hocF8/E1DXMNqQjrQP/45L08ulZLGXMwmjwl6YanPTWyAazVn5jKvInYhLzyFtvaYE6qfljWcx0
	L/K42+EsyfJaZK4pxJ8C49e5w74AsQdXrB8I3JDJM2DgUG2C1LchBGzrl6CTjDwMY2TRwSOBzAy
	hvVqXztSEHaoTiPfhKcTwi/pfg7R3WnoZOjpXDh6ztF5xxBXcer885jxEeXWyvBetuOly3Z+B32
	5O+gqjT0d13wxnEbnwr8DCfCmll/pODJfTewU54zcl//6ty7SwFeLeNbL/hCH6ISfzK03ch6/OV
	tXiFUUvPdpzs6RIzKZz109ww/oGm21oHWsd68UY6a6yDwRqvGPID/D+H6u2Mu52X0T9P16hkTEX
	+pgOTSx+L8YQ7Pxty1PscrfJ+Fo8ixO5iL9b/SKWOZpEpTR+XGETknCspPcg==
X-Received: by 2002:a05:600c:c494:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-4a027564de9mr8241185e9.20.1790878456677;
        Thu, 01 Oct 2026 11:14:16 -0700 (PDT)
Received: from DESKTOP-OI0N70R ([146.158.109.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027d75507sm2820955e9.1.2026.10.01.11.14.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:14:16 -0700 (PDT)
From: Khan Zimov <kaliugov@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] doc: fix typo in user manual
Date: Thu,  1 Oct 2026 22:14:12 +0400
Message-ID: <20261001181412.846-1-kaliugov@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sentence following the git tag command continues the
preceding sentence, so "You" should be lowercase.

Signed-off-by: Khan Zimov <kaliugov@gmail.com>
---
 Documentation/user-manual.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index 5ec65cebe2..1652ab3e86 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -632,7 +632,7 @@ running
 $ git tag stable-1 1b2e1d63ff
 -------------------------------------------------
 
-You can use `stable-1` to refer to the commit 1b2e1d63ff.
+you can use `stable-1` to refer to the commit 1b2e1d63ff.
 
 This creates a "lightweight" tag.  If you would also like to include a
 comment with the tag, and possibly sign it cryptographically, then you
-- 
2.52.0.windows.1

