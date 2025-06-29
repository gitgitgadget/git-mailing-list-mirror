Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43021D595
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751203249; cv=none; b=Ved0UEPLwobBlsdFFO6NX+m4TRzUgxbU8ZzA85MHCzmra88ZtagJBcwmBIvzIm+Sl0lS+UEgoNQrTgf1wcAHgYAiHAipJLg89+5GRtcohWEcXPV0MTnqbx0aie9haxUyKI8KPZ7NquhAj/bDDJoWC+2hMz//U+bmlamjoDxgvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751203249; c=relaxed/simple;
	bh=Ci0IGeiSXqE8gxO2e8sFSaFghb7UqO3Bu8LFuDieZDs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=mppws8+78e2foy3yo8nRIyfIl8ARrvjIVY/XnBB0Jg4NWqgERvJc2fXwhaZ3AjgR4e3MCHBQLCIPJgtP3uhAogyriN0HXkPP2AX5myMhSZecWLR4v0ohCzgdgvwI1EQLkrCH3Qxwe18X/7TdvkBImtVVmjl61QplObPW8SCu8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/JGvN1M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/JGvN1M"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so3070905f8f.1
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751203245; x=1751808045; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIuc7HQDmJphmTaGbeQ7G5D/RpNeCF1tIJ26RTyrN1Q=;
        b=B/JGvN1MuyHM30k85ZWx53/+HrrtJ4WJES/baaeJHUeqsWg0B5PWEW/AS1nbVtXHRm
         gRF1A9EoQFT6jeRiyZeWhgGffZHlbwBwnpCYk2h22HCB0azJKm8a0hV1QZYHBfbfixu5
         zmwCavZfv7M+d75izckQdu+O3FyiUGR5Cw+vITtQjx016EdnWIBpyL9JZ8Z2EfwVDO3f
         mfMF89oYAhmW0mZVhQfGiiJTrHIYCNuVvF6V2uyY8f4KNPCY4uC9ZXQ5+wjNzHEw1DrS
         DdlH+KjmgHDDrXQrrMLnqYeaKEOiEaO4OjKoNeBvhjMbNciNIvg+60SPJzMXroeFaq6A
         pCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751203245; x=1751808045;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIuc7HQDmJphmTaGbeQ7G5D/RpNeCF1tIJ26RTyrN1Q=;
        b=KHDmMAVmR78TOVjDSixP656PCy1apQNNsMmrD7bP3pvt8uKxyGCEa6CjaVxtCNsFgW
         HDnWqjJCgwq+aMx99MFBRtQcWhTLtYk94uXq8H0pe1RoW1TuqWT+ywXdiKU6MEqsloeZ
         PoIdub+kHk8RtyDC8NN680gwOX05SVIodgKY3GADi5a68W57LCFZXjP/CT947x85VhkR
         /3CPDbXE/18U2PVkxNbLIXTJsLRYRWgWrL4fgZ4YxQoJXVZzNp14MqCD7XqaPb+7t46a
         D8LkZ63AwBIgxghem/99PqHZQrhJWcDL0e2Xa5nP+41xLOZNiFbEs1GNY1h59QcS/sK+
         1AmA==
X-Gm-Message-State: AOJu0Yxp+lbGsCRb/hTszRjE2D8bOFHLazfrsaPw3svb481hQJeIebgz
	XIfztrL7fdSoiJCyII+8+fp5Khx4wFtY9I7et98QGqq9kJMiOG3wVTUUFYBJGA==
X-Gm-Gg: ASbGncs63c0ZJG5d4HgHEW/kGIXo9AXNdvMTCw4d2k/Bfg94m222Cgy1wzjBJND4RPH
	VcTNjP0DCRrqfnhIbjpBJ9jnKNaX8EuMg3h5dI/TGHHGIB9+J3wtsvULh+86X1Bq1T/NZbqYJ9v
	f09/R4aFG67aHBYqf1KODnPQwxe2wts8VVTEFNmnf+oGLI2cJ6b0FCGDyqu/9KdSLrQ8uNby3CS
	SAUyRrmjJUZpBob5TGlnLZArYVhp1QdaBEMKbCuxXJnRzCRzX5+yuVEjuQBUjGbqKM83u+fzD/V
	Jsu/DCAiMznGmY/uw7zdBcVPZxyXhEiP68NLehgCjxwt3uCZoarCCT+GjEkcs2D4TjWc4MIYuw=
	=
X-Google-Smtp-Source: AGHT+IHfEoj1XdcsayvmmWI73bgkw9I+Iodi798/aMqSZ+88Viqhda5qJE1jarIfGwUet/SKuf2p0g==
X-Received: by 2002:a5d:5f8a:0:b0:39f:175b:a68d with SMTP id ffacd0b85a97d-3a90d0d6cc7mr8363963f8f.11.1751203245156;
        Sun, 29 Jun 2025 06:20:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8aasm7656954f8f.27.2025.06.29.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 06:20:44 -0700 (PDT)
Message-Id: <1f6c951726bb98350c443dd75024150f316fe0cd.1751203241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Jun 2025 13:20:34 +0000
Subject: [PATCH v2 2/9] doc: git-log convert rev-list-description  to new doc
 format
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

Use `backticks` for commit ranges. The new rendering engine will apply
synopsis rules to these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/rev-list-description.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-description.adoc b/Documentation/rev-list-description.adoc
index a9efa7fa2722..82c680e57013 100644
--- a/Documentation/rev-list-description.adoc
+++ b/Documentation/rev-list-description.adoc
@@ -26,8 +26,8 @@ endif::git-log[]
 means "list all the commits which are reachable from 'foo' or 'bar', but
 not from 'baz'".
 
-A special notation "'<commit1>'..'<commit2>'" can be used as a
-short-hand for "^'<commit1>' '<commit2>'". For example, either of
+A special notation "`<commit1>..<commit2>`" can be used as a
+short-hand for "`^<commit1> <commit2>`". For example, either of
 the following may be used interchangeably:
 
 ifdef::git-rev-list[]
@@ -43,7 +43,7 @@ $ git log HEAD ^origin
 -----------------------------------------------------------------------
 endif::git-log[]
 
-Another special notation is "'<commit1>'...'<commit2>'" which is useful
+Another special notation is "`<commit1>...<commit2>`" which is useful
 for merges.  The resulting set of commits is the symmetric difference
 between the two operands.  The following two commands are equivalent:
 
-- 
gitgitgadget

