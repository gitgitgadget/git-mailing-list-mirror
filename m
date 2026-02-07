Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8251350A22
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476305; cv=none; b=qUzAr0zhX0VtARuMfBc/Ol1yonlKqpOfL5jdiTGd7+NMcpSoQ+kzeohAcP9Aa5zucdxMoWFIQmWQRJJqA4MHQ7SkXbPeNFGLqRsijFx8XNdIKuW4f+augUAZZOcDXvLTNnHCcma7i4Cem7giM2gAM1dl1YF+n7CJC09kCRHA36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476305; c=relaxed/simple;
	bh=WyMU6xhVXtADH2q3uL6AnUzqU+a+jiBkc6uaFu0SObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPNoSH5yWC1eR84ZRvor1wzUjfaMmAg2WyMV21Svg01ym+Zr8nUwyT6Lj3Gf/mF2ZjUPdLVeh+mT8dMLNjBg7pyTMaRqEK/Inny+kfuoV0qs+Gj+lsvH8JFj2TzGuGHEP3xK2ARGBKC3raZbvPu1g8avUN3rDHIwnXS1oWrtXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbeTcbNO; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbeTcbNO"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43626796202so2149681f8f.3
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 06:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770476303; x=1771081103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmS+176cq+lst1ItoNkMBQNRpNLOvlk6KePDp2KzfFk=;
        b=PbeTcbNObM7rwe94KCr4eok/IiI5hxQdV661qADpX9FBxGfx61XRhmXe+g9K9e1ZKw
         HfBe9m1ugdtl2VTdE7AhLX5Xk8Tz8wf0JnttmBOrCAOyHRE+uDAGdghad2bxPt6Oo79P
         n2ab8apTwdNTOO62fE2AY2D6IsBp30kxQsj+qp0DRXDG2XznfQYQJAEtChVvo+QqwIxO
         GQJarm0gtbPjaoAIFFpB/a5R5uEWGA8oPWMlheyt3Wj/bNmzgOKL0zuJRDi4GyTn6Tol
         WCDYAlvBTmBb4dBj37ey+iBB4jBxtxxMeEdEIVlASOBCw5zpZPHRESKWa05Rtt+rNG2U
         WBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770476303; x=1771081103;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmS+176cq+lst1ItoNkMBQNRpNLOvlk6KePDp2KzfFk=;
        b=GqUMPmUtbEDKpB3CIfMC3cPGm+1mpM8nDn0oppaAX0+PAxEBEU+l39WNrt86UgTv8F
         69PmBoLfDB79d8GN3Fo+UE/jLTXE3CRRyzFrfAURoHVMC5G/mOMkliegtHGkMtrMJFFj
         Lkcl/T3Bj6BS1XUYqEJvJRdTvIn50cXDHOZnLni3JIAaQVZMGgIu8f2SB0TVBa8xPe4M
         vnurQ/jzqAzpAiogvO2mI4YDQ6VeAWd14T8vd2OKq8Mwhc119P150Yp+83xfiaBIc+aD
         sfIoxIy34vmANHC+hakri6dH5gTmMSuDs9vV8khv864i9sH2Fy0WBSG03xexYYxigHYD
         YCAw==
X-Gm-Message-State: AOJu0Yyv24Z2r3j+SwdPdALS7jsRKI4Ha5h1c8H4aLNInghU/7wkElX8
	yNEZ8o3D1fVAhQIxX9lSN1kRtvNIl54Iw//Gvtl6IC/qmdLV7trLb5piLfkbF2BE
X-Gm-Gg: AZuq6aLWAvgJHR7SsQtmiepVvMkfpDe4vLqImWt+WeHOyNImoN4tbjqKLsJzMe2ezI0
	4dBuPyn16DXO83Udm+LIv+MKn/CF6swxMyoEE5F0o10QGwB+Q6OLXnBcUdrERy2S0zJn6T7V/ET
	XFPjz/8SML1uVTEVxX7KT5By6OMzWsvcdUfsC6Zxic4BmzkcEL6sTTQ7tVKH/MC0jhEEPW96ENe
	lWS3c3/UKiA/ChX1RsHcJF1LnfIc64p1nNr//r7qfsGfCv1v/EzPPsP7Bc7Tv8kEDg9XCYShRKR
	GgMvrnm/Ui6a9PuULXpPaRkXBJYIlyNx3A6cC/kw0SbjmGj1euggtjfA9g6+pE4D1gJYvxrsCNM
	iREkKZTLmSt+Pq5j7qIIgrVDGH0LfpKKYrjioVazy9rNWoipNW3xO9kRDG2FIxWQMJFS5ipWAfz
	cI/TFDbOraChjGRIE=
X-Received: by 2002:a05:6000:2012:b0:435:db6e:e3b2 with SMTP id ffacd0b85a97d-43629242602mr9913603f8f.27.1770476302944;
        Sat, 07 Feb 2026 06:58:22 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd3b8sm13780317f8f.11.2026.02.07.06.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 06:58:22 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	pyokagan@gmail.com,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/3] templates: add .gitattributes entry for sample hooks
Date: Sat,  7 Feb 2026 14:58:00 +0000
Message-ID: <5f5e30914355ba108d8f4ce9157369e979f585e4.1770476279.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1770476279.git.phillip.wood@dunelm.org.uk>
References: <20260206090358.GA2761602@coredump.intra.peff.net> <cover.1770476279.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The sample hooks are shell scripts but the filenames end with ".sample"
so they need their own .gitattributes rule. Update our editorconfig
settings to match the attributes as well.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 .editorconfig  | 2 +-
 .gitattributes | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index 2d3929b5916..6e4eaa8e955 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -4,7 +4,7 @@ insert_final_newline = true
 
 # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
 # them in sync.
-[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
+[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile,templates/hooks/*.sample}]
 indent_style = tab
 tab_width = 8
 
diff --git a/.gitattributes b/.gitattributes
index 38b1c52fe0e..556322be01b 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -18,3 +18,4 @@ CODE_OF_CONDUCT.md -whitespace
 /Documentation/user-manual.adoc conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32
 /t/unit-tests/clar/test/expected/* whitespace=-blank-at-eof
+/templates/hooks/*.sample whitespace=indent,trail,space,incomplete text eol=lf
-- 
2.52.0.362.g884e03848a9

