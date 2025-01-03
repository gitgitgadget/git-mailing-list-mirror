Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCFF1FA257
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912054; cv=none; b=WJDeRl7cq9NkjsLu8wUExJyj6k5ob23Rrzaaa2RswkUT/9IYws/Ixwn8GwFzc4Kr/KsG9ukLmQyGKnoIlHuHzBlqc8NC5vc6xq0Nlzjj1LaICRcNhPTMwAY/e2XNJQcJE9oWlqJ2JV0tSD143mGdrbZpraPQopxge7ZO/M6Vru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912054; c=relaxed/simple;
	bh=2eBcb7RA2kvcWQcXhaD7FWqs3zKlJ0Dosw4LDoJ6jlQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=rL2sGKuW2w51E0W7/EimKsGccz6uyGtOsVQmux+hyeMw+5agFNoaZKsbOk9XWK8M0UJu9DqJG9rHgsrRyGZrvJ/ICdn9k1HLPyzU+SRdXBI+8ndfvecEl8YSl4RfOTFUKAdrgop0b/ACLqWweUvUqSACtq+WhgloSxNb3y802U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJlOqLkp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJlOqLkp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so2571585e9.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 05:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735912051; x=1736516851; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bkiYjWCsNGEalujTo0xma0moIRxCzBGYwSSvnuPR14=;
        b=cJlOqLkpYClR/ghq6XLVhrDuM8BO4r15zyeQv6RrDLLQbDGO+VgxpIRAeBMzp+uS2E
         qBuSO8qi1NHB2h2rSCqq3kUC7s4kg4wu/kxqxOkq8UwvjFbn/n52Wx/cQN175ZPIShLe
         LMDCNxyynVYo4mcNHJuG4MJ7kC506f3S85E9LU+1xLdBNqU5QhUB+KlMhaLd8BaO/f2Q
         dPp3OnN6a0A16y0+0NPPEWQd+jAMg7QwTVuDXhQFlknEyL5Uf+nNHXv4LhWfsHVFMupd
         vrzwUVxdntq7rm51lg04BMDM/1DI9F8JmL04MoXyovWkR7U3ziJbDLgqK23Bi2LON7DU
         OKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912051; x=1736516851;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bkiYjWCsNGEalujTo0xma0moIRxCzBGYwSSvnuPR14=;
        b=iKsVtZigAgpLoidLLC7DsxPBMn4vlUr+slJ5f2xr71W4DGJH5n04uoKLzTs2wh9orI
         vzHRPpn53vqbNqWy/Mz7thPq+PFpUmDspD1+3S2y1NAMvPyYlB++9+jGqjgvshKCaJBm
         3pD9LYXdNdaagpPPWhqLG3H4G7pqrNnxnXjNchvpEDvXkX0xRy2AWlQyQ+UIARF8LKY4
         yJKtiX2wSGWIuDuUhj5lk4Xh7X5W0DVGv5TXF35OkbY7xGf7f3fAjOd3G1Fz+ryIfvUg
         TG4Ue72QsDwQGtZljT1o+ebBRS3Yf/y18Ru+jiTr92tFeRdGRxuBb9sD5yXENQ6wiPvg
         0Pwg==
X-Gm-Message-State: AOJu0YxAQwCEiuhwVgLFsgA08BITaJcPat/Xh2nMgRCkBRJdgpg13gcL
	5h50rTE1vXTdKhriMvfL1n8vqFGS7FKXT3wpd0J8EXfuKG7anOOeMyCqng==
X-Gm-Gg: ASbGncvtVAiqofNAN8I3qcx+ZZSRbzoG8/lnoduANBunFdpCbn6dkNfPo5uREEVG73I
	LltpyLbl+SPZ8x9e0hxgXTnGfzw+yiFDzaZy9H6YywcUAmB7XVi8rlz3DKYsgF1KAyP8tm5UkyX
	rBe2wdrUzSC02Dq60kWJ2F3CTa8LFF/nnHfNkXMBJWFKK6wPqlnmVh3hjIneRfJbbA1HpGSsjvT
	tx5hYwemGMrs+LvRkgro5VogiAU+cTGRglMBHJIR0G0JWk30PdvF3M4rw==
X-Google-Smtp-Source: AGHT+IH/rbSPBi2fPFPQULGqnob6P+wBFbDzUoTEgbDEtCIWmavvy9jR2Jr5FzatoIU/+Djcfjc/IQ==
X-Received: by 2002:a05:6000:188e:b0:385:f840:e613 with SMTP id ffacd0b85a97d-38a223fd52dmr35752544f8f.51.1735912050937;
        Fri, 03 Jan 2025 05:47:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436724169afsm433483315e9.25.2025.01.03.05.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 05:47:30 -0800 (PST)
Message-Id: <9f8d4e74b7be64584235a0c7159576e083f90888.1735912046.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jan 2025 13:47:26 +0000
Subject: [PATCH 3/3] doc: git-commit: migrate secondary files to new format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/i18n.txt           | 4 ++--
 Documentation/signoff-option.txt | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 3a866af4a42..baff780a7e3 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -34,7 +34,7 @@ project find it more convenient to use legacy encodings, Git
 does not forbid it.  However, there are a few things to keep in
 mind.
 
-. 'git commit' and 'git commit-tree' issue
+. `git commit` and `git commit-tree` issue
   a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
@@ -50,7 +50,7 @@ of `i18n.commitEncoding` in their `encoding` header.  This is to
 help other people who look at them later.  Lack of this header
 implies that the commit log message is encoded in UTF-8.
 
-. 'git log', 'git show', 'git blame' and friends look at the
+. `git log`, `git show`, `git blame` and friends look at the
   `encoding` header of a commit object, and try to re-code the
   log message into UTF-8 unless otherwise specified.  You can
   specify the desired output encoding with
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index d98758f3cb7..cddfb225d1d 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -1,8 +1,8 @@
 ifdef::git-commit[]
--s::
+`-s`::
 endif::git-commit[]
---signoff::
---no-signoff::
+`--signoff`::
+`--no-signoff`::
 	Add a `Signed-off-by` trailer by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project
 	to which you're committing.  For example, it may certify that
@@ -14,5 +14,5 @@ endif::git-commit[]
 	leadership of the project to which you're contributing to
 	understand how the signoffs are used in that project.
 +
-The --no-signoff option can be used to countermand an earlier --signoff
+The `--no-signoff` option can be used to countermand an earlier `--signoff`
 option on the command line.
-- 
gitgitgadget
