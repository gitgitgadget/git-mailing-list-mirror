Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3794E80BD
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628418; cv=none; b=sTl4QHl+7EfoqPJ/OChekRCjoyv3tUah3fioi6/Wt/OHZ7Gy08w1H1fMOxw6zVW0OM/d7BliBpuJAYvInrkniPJ91A3ov/lrm07kcgFIa37S+YjTukWK5TKrWt8js6LURrgUUp0IWq7zMFwa0YyG0J77iSpZenBA5wH2qmAGyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628418; c=relaxed/simple;
	bh=ZQrD9onszmRub0jmIvYhGQf+f8sk3o8YFmZ+CIweLwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyh8GZHf5jbAV/SvYjUjONTF3pG/KOc3zh5YJS8jsyBJ5pfJd9efpvf0MxJZXt2lLK1n7FrZYK06JYDHR/w75fV6V1T3cJW1PJNu8jUVhu26JqSdWqfsAV4qwGUCr6owf/eaRzU54inErdm06RtzmfXQCcI0krmWQIZa3FaEb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=GFDBpMsK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="GFDBpMsK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so18280615e9.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788628415; x=1789233215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AT6Y96DN5dc32Xo9c/rc091IPvnt+Ry/4MDylqhd7AY=;
        b=GFDBpMsKGKEaOd1JvX7akrkKP1ZdGh7D7pzXxkOgAnLsuLIU9+JipX2RGNk738BA9H
         E2PWO8s0OqmshpVR94tVdp7rlkwcQzcq+mv9hIVD+0NxzA8hsdeoiw6ykTeghKqjvClg
         yk834kXE0SBOEhDgjO2J/gLGUPErAcs9pVrx1wQ7yOsPiHbCTblbWS49dbQYVYaZZzEV
         p/XtcvS4bsUrNM/yN9mwumV+oHpnAK2KvaaR90aay87lTNHQF5veUa9C32qLzE5lgYQ0
         ilTCgEKS4rv2YdAKBBTnucyhr+Rnw0545/HOrtAo6VtS/SVWXqGaS+kQ8hvL81dT/8I1
         inow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788628415; x=1789233215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AT6Y96DN5dc32Xo9c/rc091IPvnt+Ry/4MDylqhd7AY=;
        b=bK+FfWZOfRRjK5YhfIrb9tKZjrrmUblYe+mxt99bKCyGyT/M5MPCWqlKQkw+JcQ+/W
         cHVPBmPrSodljwDSa1TcIbDaYx+2CYIw5ryVlw6hWXuHUduZnMGSMeG3o5DL15WgOhfl
         tgj/myZGSYVzvxidDNRBd8TLoR1sPGXjiRJNqde+PkTD/YoklnIgEEz0JVX+N6HJTj5K
         yfhXsTZ5sEXmg34oibAmWBull7riMpj/b1K2N1ea7Rp9i+PxmwGYkaNlO77d095o3Dms
         A7FvDStp8cy6qhybI7LNhuD+WWDVcXupMR7u+baBkp4zty15MiwwByptVDAo/qdaynU2
         bDaA==
X-Gm-Message-State: AFuF++nr3H5ecM/ddybmn9FALdrEz+lA2MbPtRjupQXapnNKjk3FdUxq
	x/qNufX4JBCFKEuTXxrH3xJOQzxJltI24YgjkOw8qCENq3pzUf+0yBfw+unsxeDUyHaeFEHkvX/
	6GvBwMOXVRHjR
X-Gm-Gg: AYBFou06Bfn5IEHDKI1H7gbo87dkZtCb4VsFTQh+9eg0CzCZfDluRikLJY3s93bJVAe
	kxKBWzJ3pqHdeGnqiVkTwqg1+wxL4M9wu+PBuN8SRF83QcWbBOijA47O0gwGOuP8SttL9htxPsL
	q1d++rtOIPsbS2fxnE94aEubwqf4n7JVvPSTL5CF+GsRhs6zRHOO0FJB+cSb4/6iIUbEz4f5j06
	ClnR5FsRGWYcSTfYEj3AnhOQ/hr5oEvcH/wdaXKE1Ws/i7NG1lGXyy9unGfOV/meRVOYQW+5DIC
	NVHSvbec3ZkHymsIHj3KYQCZFzmVzdhpe8H5UhQQYGWXtstFpmywcVZ4Gwe4PqtgRGBEjkTAuly
	gMrPZxsuo66kCefvyvpRvriLT39DQIhwhmK5HqAzA1UT/r33lW6CnyxV8rIB1rO0s0FLRKugJWm
	uzlIrd6F0fVhXyD39eJely9fyYyTQbfzWJCtq8El8bKyYMxj85wgKAi41VlbKPiIVNbOC6
X-Received: by 2002:a05:600c:6819:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49cf81fb1acmr132327085e9.2.1788628414568;
        Sat, 05 Sep 2026 10:13:34 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm252763335e9.4.2026.09.05.10.13.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 10:13:34 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH v3 0/2] cherry-pick: document that --no-commit skips CHERRY_PICK_HEAD
Date: Sat,  5 Sep 2026 20:13:30 +0300
Message-ID: <20260905171332.34670-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903125524.67889-1-f@lex.la>
References: <20260903125524.67889-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 was doc-only. I had dropped the test claiming the existing
clean-pick test already covered it, which was wrong: nothing checks
the ref after a conflicting --no-commit pick. 1/2 puts it back as a
single test_ref_missing call in the existing conflicting-pick test.

2/2 drops the "git commit -c" advice, which belongs in git-commit
documentation, and says instead that the missing ref is the point of
the option rather than a wrinkle.

The Assisted-by trailer is gone from both.

Aleksei Sviridkin (2):
  t3507: check no CHERRY_PICK_HEAD after conflicting --no-commit
  doc: cherry-pick: note --no-commit skips CHERRY_PICK_HEAD

 Documentation/git-cherry-pick.adoc | 8 +++++++-
 t/t3507-cherry-pick-conflict.sh    | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

