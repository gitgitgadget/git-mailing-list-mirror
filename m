Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7904772A1
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440129; cv=none; b=oYH0L0DL9rRxhKhd98OlEIAalXnzgmVYUntzjkRkShHcQ1gOGzTbxbITnIv3t2tdAqAzeS9ByYmcfvU6txAkKpJ6XbRgP+Yacys9wFZWiLBGzSfEyn062X2MKVyWha5kmk68RpgptJflE6X4LrkMaOApHCj31zfXIX3unWDDadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440129; c=relaxed/simple;
	bh=ct4Hrl/LiAErNRccPk5hGSnKukCsWb2dXWweMaJV0fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXOD3cFgJ9BsUqvE7oypX1sdYXOPNUPo7IGUm2ADA4MpbYEuc+SAzo/gW06kzukAoLRII2owjfSXJFFb+pff8/hl6lqNexkgks4tq+oBZaf9EtSXlneYofhQtPvKqOpBN3r2NJBPF6Zco04iqOrgaskWRg2g5EVyLVLlsllwOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=VpM3E4Rq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="VpM3E4Rq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1689386f8f.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788440126; x=1789044926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9SE/pFxFV5zThsw+Uty52J63vHMN6IjaA7W2tqH6cc=;
        b=VpM3E4RqN2ZbxPs54B1cp1CjfP5csLX1GrpLlV5ZsbVlURkNAEjtNE/T3ymosBzc6t
         OAt1P2PNuFOWcwdtJ/4uwWB50m6iWAF9YIvswpCSzQard0dDxsQYdEsVtsdGz4+wWvWN
         Lz7TmBXi94SSdDD1XWU8AZd1pMn4BN7npMGn5IKIR31wBbaakfUz4uf6KhZyVU64SpmU
         L54UFbGwTgnixNAKdgWOTMuemgxswuL8jrpwxsRKLdwmZZokSc83vYqBc/PnKfxQSg1m
         x9H+YU2OeR3UMJNvExog9yMiTqc0T8TXunWZLdrooVvNV2mmfBchoc15rhfGe8VuTTpT
         TZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440126; x=1789044926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9SE/pFxFV5zThsw+Uty52J63vHMN6IjaA7W2tqH6cc=;
        b=blIx9Q/B/VncD/47dkBU3c+Fbc/BTgxQvcOu279pa85hTJnELMEX9m2cawGWEGELec
         nkYHBQv/WVYWVUckYLXr7Hp/dq2DT+QNflr4aqU5m6ibKD8wzgUpzXJ9Lmh/1QDGtsH9
         NUP6wcVlOWQLK6vsiq9hkoQRIvVPueH+wHj0OxB859extgabQk/mgUYUVzhqrUE7a2Wb
         7IWZ8rx3MvqiI3BZnqT1wy9pLO0Qt3jRdGoeYjEFLzhQ6fx07T8jW33q2slqIe3EasQw
         cQS5kC6XOhiHOa3gIO1WrSS0LFXwqcsrhRX5V38gZeQPJDTOiLGRq8cmzyGXN780bIIZ
         eNXA==
X-Gm-Message-State: AFuF++lfLxc3HP64JxcctAzSJ5GgYsZHsH+lsTJFn6hRrB4/kHl52jDP
	WWxo6kY76CRyhKMi04uHCUvZ9YIwa1CeY6PF+VLA3ToaBL6SA2RWCbGcXnZozfmk7JQpZ8qMhlp
	sWgvgiZqmdg==
X-Gm-Gg: AYBFou1AlNSwg2g7gE+Inw+W4CVmDr9Hft0XbxDpfJ1LGd3MfRW3DL8dyPay7Hro1bR
	JOV37LvAU+DNllWNYcg1KligoV6sgHSIxBOz7XBKEZecrWKvcD9haMHO6a6K2ivnqhEopjcTNQY
	GiiiqenchcnD7eWnqL+t0pdZwB+U1ojhgCy8UKc/orRCl49fL2CZh57SA84824ojFi4cjx69fOi
	qvkGGgnDRYF0xd25AQmhmORQ+22l+ExRt5XuK4rOvheuyi+im1KGO4NiOQNZW0S2TDh+vuJE307
	qi4oGernMbfRaI4BTHQWMecZ0HdAhcFfDb7/RRwadeHjUS0ZtjSyiUTDDXDzcmozPN1BfCZ5RfK
	+VyOMF+SkzM3hc1tOMCMh72OOoU3rZjyY2BnM78SWxO9LswOqAgf+C25+eTp6+sEACWj/RxN+Ep
	O8/bmoKlvKhvyQLBxe0gaJQUJU2CsIh8cOjQDiKzJOq9zL999Fvxiq5JIUkTmiIxGHqjeX
X-Received: by 2002:a05:6000:701:b0:484:3600:35b2 with SMTP id ffacd0b85a97d-48488f00a25mr19250047f8f.5.1788440126108;
        Thu, 03 Sep 2026 05:55:26 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeae34sm14684502f8f.32.2026.09.03.05.55.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 05:55:25 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>
Subject: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting --no-commit
Date: Thu,  3 Sep 2026 15:55:23 +0300
Message-ID: <20260903125524.67889-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests here check the ref after a conflicting pick, after a clean
pick and after a clean pick under --no-commit, but not after a
conflicting one under --no-commit.  That is the combination a user
runs into by accident: the pick stops with conflicts, and the ref
"git commit" would take the authorship from is not there.

Pin it next to its siblings.  Letting the ref be written under
--no-commit when the pick conflicts leaves the rest of the cherry-pick
tests green, so nothing else guards that path.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 t/t3507-cherry-pick-conflict.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 44596cb1e8..2ce2e88184 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -100,6 +100,12 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
+test_expect_success 'failed cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --no-commit picked &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
 test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	echo foo >foo &&

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

