Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F044B8DF9
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593318; cv=none; b=n3l7VVQ0zPhXsUJO/S3GCfJf09W3RKRIkuW+1cKVi30ZubASVNJBu6JbSPz7BJcPgjV9EqsfICkp+jjihvnGU1I2PsMJPhDe8OCm0yYwY11vsuUH6BF8VnjEyrNFhHhEmPTOwE1tBNB56ktU/+jjPHnTTCqZybq9jaLLPV8mDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593318; c=relaxed/simple;
	bh=hsRDD0kDtVFLor+ZsgPzabzYIDE2jsDOLm/rGIoI2SU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YII8Qa3NKdKWYHTWyPFv2siUBKoHof5MImlJUTLWFzxxDP59QO7133fYvuqnwTGJ0ype0gGKxrsAugkR8jsi49W9EH/pI+m5P7SyHQs1dpGKJ1pQcPxiwHxDY+mrPAzKu4QKjSVYB4RyeLGszxZbMmOtObg05tJnco6SFhX9dhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pR9adr9/; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR9adr9/"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137f18f45dbso838609c88.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593316; x=1781198116; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCBWhPr67l0pTXFnTG+XjOKPJgRBbQgk6RbnLQarnd0=;
        b=pR9adr9/6PwhrlXTlwU2nne24tABvsXW4ceQAzCDKzlXGKhzfXMg1aVq6A95GP13ej
         TZFDSmVgUC7JRUR3WxWnNxMdcEV28MMltxQ6txZ8//7CRbMIPDhWQEzmkwzSAOpHVZnh
         wrCGmX94CvOYPkbo+j2GA3E4B1+itNEd/ZFDASlKMlVKIWMUrEIQ1SxiFUZ57ycieg1w
         F3QIEAsyaVov2bQ/3JC976v1hXsbggoWM/xmcOSBG8pMcc2F8miLh13onOVs2lDvi/C1
         CTmOkVvPfTfhK8fchpex+dZZ80cRapzlnIisc++2BuLLxau+8lRcdA7kOViNy9MZIMMX
         aYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593316; x=1781198116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCBWhPr67l0pTXFnTG+XjOKPJgRBbQgk6RbnLQarnd0=;
        b=UVGUy24aUgjML49b7R+2KrIW0KtMPk8mTPvkuIsBytZzD4hSQuP+JK5VVU6mbZg2PM
         HYu1UyKALm8Udjsm70Poaap7xs6idN/DBzrpykME/bA2Amajug3obhTEd7gcCL35hGNs
         McjCcLwcnnatPb3eFD5Ju7zXuzlDffvM35s37su9pa9qGV882TWoQV0x7LhOFiJTMtoH
         uSyOl9Ux97/z2dHXa34JgZiEKojDUGXCQcPZ7tgKg0zmheV7UBw+0co0MvTojupZtyWj
         YZAYuvNlYWmL2wolTY2AU4aDC+4aylnhDz+jzzBtRuO14y99/7gEH36GFqiMfi5CT45c
         77Uw==
X-Gm-Message-State: AOJu0Yx0EJkxGpgi3HdG3KdY1HE767VMxVoaO+v2jdEBVJj4r4awmWOU
	gAAfz7i3SLIGYo4yvb7gNMqw7GowXMah62D91baKHaiuIGbmN0oxvX+JgCcKTg==
X-Gm-Gg: Acq92OF6lDqL/Fez6mm+op8Odf+HNm8Plrg1lk2S7FtSTx/ezcWSR4Fjc1PGcL/cBSv
	mJDPzbkvXLFCdYqi3DEYgecn0z/Nq+55uNI92zedrjxEbobh5VhE/BnKUiVwnYgdoELjiZxpO9H
	Sfi7lWSxhl/XrdsncGnyUJjoI7dV5iweyolAv5SgKPRconnM8Fi9nZr02SC3XFTg5KTiIsSEYBR
	uUg4rJhLVzxRq572X1HxBG3h5n0eJZeecV6MIrPCS8kTO8h5eqgtSyoWY7Iph5etX7ZF2hbt2Y3
	Vn6lQpsVqZ3BzyKrcb7f+j919eARZtN33Q6vt7WTlFJJhEq3GQFrzv9DpULJnTlI5tvPgTcxc5v
	SjF2sEDhgYmqbU6wuYAGKoUXykFu6elqJ+NCoOMCF8Lh6nGTCVpnZaAG7ippcwxM07Py1LhGbgl
	0ygKHMs7bi4F/wAN/qFTtwWOnT5rLtarmzyoMIDw==
X-Received: by 2002:a05:7022:211:b0:138:637:6227 with SMTP id a92af1059eb24-1380669d57amr12938c88.11.1780593316030;
        Thu, 04 Jun 2026 10:15:16 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13803eb106esm650136c88.5.2026.06.04.10.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:15:15 -0700 (PDT)
Message-Id: <84e1cd0aa060f3c05f58d8728a31c16d9ee49a7c.1780593313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 17:15:07 +0000
Subject: [PATCH 1/6] hash-object: demonstrate a >4GB/LLP64 problem
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

On LLP64 systems, such as Windows, the size of `long`, `int`, etc. is
only 32 bits (for backward compatibility). Git's use of `unsigned long`
for file memory sizes in many places, rather than size_t, limits the
handling of large files on LLP64 systems (commonly given as `>4GB`).

Provide a minimum test for handling a >4GB file. The `hash-object`
command, with the  `--literally` and without `-w` option avoids
writing the object, either loose or packed. This avoids the code paths
hitting the `bigFileThreshold` config test code, the zlib code, and the
pack code.

Subsequent patches will walk the test's call chain, converting types to
`size_t` (which is larger in LLP64 data models) where appropriate.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1007-hash-object.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index de076293b6..7867fd1dbf 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -49,6 +49,9 @@ test_expect_success 'setup' '
 
 	example sha1:ddd3f836d3e3fbb7ae289aa9ae83536f76956399
 	example sha256:b44fe1fe65589848253737db859bd490453510719d7424daab03daf0767b85ae
+
+	large5GB sha1:0be2be10a4c8764f32c4bf372a98edc731a4b204
+	large5GB sha256:dc18ca621300c8d3cfa505a275641ebab00de189859e022a975056882d313e64
 	EOF
 '
 
@@ -258,4 +261,12 @@ test_expect_success '--stdin outside of repository (uses default hash)' '
 	test_cmp expect actual
 '
 
+test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'files over 4GB hash literally' '
+	test-tool genzeros $((5*1024*1024*1024)) >big &&
+	test_oid large5GB >expect &&
+	git hash-object --stdin --literally <big >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

