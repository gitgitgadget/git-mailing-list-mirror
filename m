Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BE2309B6
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622294; cv=none; b=GO3cjE8y1VZl3dS4jYhlH5sIDbaIAJtXJPyDmWo6avC0vgtWv1Qmt6wx9RykHk7+hEepm/vPMAmSHxNotrKS8i0WKe8Qd3IexgqfgRewdUQnVKY9qVLTts9uc87YhPbTkUXXBdtzFy55r8/QfWpDdDysoVvQyHm4QSG1gm7DurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622294; c=relaxed/simple;
	bh=2X7YFvFI7VW6GQeZVXANiquzJGbk31SWsHCz2ZXytAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeHMzIFLc/8ZL2FBSCj1NIiIcZtax8RSM/gZazZX6mh9t+FVTo0XUYs/FQ1ryIlV+x/GQXFiwJPUJNYQOPZoh7pbLyN7d/wffwR0wk5QP80hLFWRAmkT/sPNSOD1ZrsQRZ9M9L2O3TBRksu04T5drHQdKmA3Yod/dG1bvn0gTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA+EXbLe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA+EXbLe"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso48204055e9.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622290; x=1742227090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1nATC23aNFFjw79hGB+599N1SNvtcyWml8/eV5YPXQ=;
        b=YA+EXbLe8SDfdNFmeX4RIoSW6vPjuaxrhgzi165iHyvntfo9sKEQ/vpCKhj3YztEzG
         sannkOPzKeFef5yBThlJpTjjuav0whvj7ISMk8S1FdCjXIL1nCaSaW3CJkmezB4N6iam
         sZz9nguE+MkmZgtx+0k8vu9jDq4caYEFuDuEoQ03UnA2Pqw27xv3nU0fPuwCEAm7KZmT
         CgAtjnJFDw2M06bsSlP1Z3ED2iG8SgaVFyMmPfj1dgsDE8d7i9I3w2/QcHQeXZT4feBd
         AlQMmurOL6v8d7zhkzVJ+DN69YH78jtpCIas5BlyhSgzPBbl5q8bcuDeM4ZIm4kF9xZr
         sGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622290; x=1742227090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1nATC23aNFFjw79hGB+599N1SNvtcyWml8/eV5YPXQ=;
        b=GyXzSUuzselm5xauvgPGIoE6QEj2XVUMyNRLxXtH8ajUG/Yt4LFhxOl5IfetOfRTk8
         Od72mrJqikCqYdaUovPviDqEwKj/OLPZpvBroYn7RQO7gJVsOXLOfaLgOg511wfoAbdz
         DQ+JBrkMES2RaWc8o7PqNd0z1IVMUrwQvgTglm+yT37MzBVuqEk8MHzoQmF4FpLmvq31
         XXbI8T4Sv/N4wYWcJyyIxQ7iuD8unXVT+zDOxBc3LqYFORqtwFzPeuMKJgFAhzOJNZvy
         etmbBI9jjLdchqj8mcvyVVx3aE7gIYeKlsRodugsnqI5u2gqCPVNEyNFTqYpmw/n75jI
         SKaw==
X-Gm-Message-State: AOJu0Yx0O8iAgl1jEKd7/GZNe+ZnsutGHKOvoJb/g76gE2HnZG8Gfeay
	8rUKG7+i3jjcRo1pBlTiN9ta/VAkLTQnqXGV6ZMN468rAGIaYmOXFKaJAQ==
X-Gm-Gg: ASbGncuYzV8wPQFam4aj0ikNIiIReOVvgYcZscXMvvy91grnHlnLDXdyjIAeLVcXmw+
	ysQ4+reEQT+WQ0bOiFFpmXZarYX8rv+iARTPEKIVxCUco+vJ4GSWeatldbTZ/uo577HozWSqkBn
	XOSlfSy8Ww84fISoTi2djgA/jcvXMesgVOhkGk0CHBfvDOQvEwn17IrU46cRoHLDpzePef13aCs
	Kg6kSKZKb/nXl6bUJKxDYx4sjHcaQp1J9nY5L8Pfa+yD2D3HN2KNJABtfrSpZFJ2vrsOt5mvBrh
	k5LFo8FVVKMH0TsHNZErpccXnJrcA0violEgIcVtL1echuMnKioWolVqBCv0BB5QtnTv32H173h
	RDIZysy2D4CUWVMiBriJ/OQCHnvg=
X-Google-Smtp-Source: AGHT+IHjDdjHdXGCVMXVf4Hn74O2Ro2vfSh0ch7j7XhF9jCLORx0NTCUF7HAB08cl2D64U/qEQXgeA==
X-Received: by 2002:a05:600c:1553:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-43cea36ccd7mr59919955e9.22.1741622287565;
        Mon, 10 Mar 2025 08:58:07 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm15551831f8f.62.2025.03.10.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:58:07 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 4/6] git-fast-export.adoc: clarify why 'verbatim' may not be a good idea
Date: Mon, 10 Mar 2025 16:57:44 +0100
Message-ID: <20250310155746.879481-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.89.g148d1db992
In-Reply-To: <20250310155746.879481-1-christian.couder@gmail.com>
References: <20250224142744.279643-1-christian.couder@gmail.com>
 <20250310155746.879481-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Shumaker <lukeshu@datawire.io>

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-export.adoc | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index ab9a315fa9..2bb52261a0 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -29,15 +29,20 @@ OPTIONS
 
 --signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
-	after the export can change the tag names (which can also happen
-	when excluding revisions) the signatures will not match.
+	after the export (or during the export, such as excluding
+	revisions) can change the hashes being signed, the signatures
+	may become invalid.
 +
 When asking to 'abort' (which is the default), this program will die
 when encountering a signed tag.  With 'strip', the tags will silently
 be made unsigned, with 'warn-strip' they will be made unsigned but a
 warning will be displayed, with 'verbatim', they will be silently
 exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
-they will be exported, but you will see a warning.
+they will be exported, but you will see a warning.  'verbatim' and
+'warn-verbatim' should only be used if you know that no transformation
+affecting tags or any commit in their history will be performed by you
+or by fast-export or fast-import, or if you do not care that the
+resulting tag will have an invalid signature.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
-- 
2.49.0.rc1.89.g148d1db992

