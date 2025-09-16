Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A14290DBB
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047388; cv=none; b=jmZf4vMI/KUyywdkVy+R7FBPecgv/SHTaJHLMkraJjaoecPXxds47r9Bv1wNsgPnM1kM8r6S/GJpVAm7Nr0xYjSnkbByTJBw40D1fGY81KmhdrnTlzELEq8lf0/cUjQPnUgcnOsk1ROzLUGGqFoNz3TcX6svUwNYTtpMFNFkxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047388; c=relaxed/simple;
	bh=8xO+jpPcH3LP2WZxDOtRhf11xHIAQXjin39EzquACgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exeIPUIFSfwE13zjaS9IyDcGEazoJtAcI2647EWw59tMMYNCnxLtCuuxWIzXzsp5oHgWAcbO/1fJtfl1MpvJ4kPmf9TqZL3pS8zHGB1fX9JPLMH/AH7p2JVIVB+rDPdtVRv9lL8dHGmHeX0/GyFVrWAf8Q+wv7rRJGRejqY64UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxvtOCdd; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxvtOCdd"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3318dd36a8fso2842061fac.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047386; x=1758652186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8SlLS/j1nMnzulDrCEL1Loi2HlQOrVil0cEohL/WaM=;
        b=OxvtOCddPmLSodil3cbWmq2JzAqtwrZ+DS8xsGlFXkfiXwziMOJRjGRZtuR6rijTST
         rjP/BZO5Jcmn2RJRyiLGeDrUBi+AO8S7T1NMYDamEC+1ovUEiKsCvN8+gD+HcFX4/RQJ
         MePQCxnolb2YFJ6msUwPNPqu7nk3rmoByHleXbrDbNeBwAnNh9G9vRSxksDWxDNTxsE0
         71uQ686HDBpMVZ2zFro9ChwGnF8o4nrJw8KzTQyrwfMnZ21csGznWfEvyB6tI0DSBXqc
         KsSl36+EBcWvHXker68GBQRnZigVTfVSuSNnybQHykZcXGynfkJ3gLI0NpSSdo0VXPvm
         hMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047386; x=1758652186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8SlLS/j1nMnzulDrCEL1Loi2HlQOrVil0cEohL/WaM=;
        b=GnSwRchsmQo3Xu+x2V2/HOqRjAYaZrFgCqhc3aXrItAWW3+ND0hJSwJJoBqsjhFism
         xyTtEP241aPmNaaGmlMt/Co5vJtzdJn2GotpTlnzG4SAa65f/ChjbwhUL5I0K0nLgndm
         2t7P5jbq5Q+7jl5PoLFogflVrhGM4DXih6ys2ZVMr20X6ZUX141rNX4SaFSm2nNquFvA
         YzLd5W9AU8uL1w3UsaIHadWKEX93ki+l22trRmTye+Jh81jFOnvJS1XfCEgIKsEByFbe
         LtYwljBIpG1psnlVxZXKuH5Bbx+GNmk9ED8ssd0917ctbnf085s2dPzMsOr1Yue+kDOG
         vXEw==
X-Gm-Message-State: AOJu0YxuCjmcwq8YEwbsRXln5VRnEza8h7K8AQMkx5j2RXudALulMfbi
	k89ef3frUiLU1OA8vOmPRSAPBscWFNngzZ+7EMxhj/Jt6798jeBZqh3ifOmcIA==
X-Gm-Gg: ASbGncvkU1FNwAErAxbLjaQ4MOC2yUY8TWPWp92dFSTdSkFA/E47DnFq0QA/VmKzU4l
	AZCT2sgjS9bPZnKZzWnc1cfG+xvj+KbSuSdxd1JQe8zvdm3vGALcbfAeOYdxvSnG+oGuEdy9v5a
	RFPD42WDxvRetlGEtwtdRN51gS5PUc6KbwI1DKg27gA1yZBihfItb1Ka1sHAmAWOhZEPXpAdi7S
	lFqK1DbGaAZvhBJK6lbaIdsSxmcpMLqc8gLgS8HfvCpk7RBTWHQeqhmXfl8Jq6vFbcafi5UB09s
	ibVCvSCbPveoaeImcLGMbY/NAKyWSRyCrcxanLGgQ7/aQvvCY0ROdjXF5i2UVgCBDnqgmfY9pe+
	WOnrOvdJazuJHwpRGz/WDnR8lAZVdcKY=
X-Google-Smtp-Source: AGHT+IEjI/1N/K3zA4n0qR/oN2mVpsdA2zoU2IQrYhgcm/fOqgKqucYllz48iy/MY1Cir96l0aN0mA==
X-Received: by 2002:a05:6871:4b11:b0:332:dc4f:1e40 with SMTP id 586e51a60fabf-332dc4f20dbmr3801465fac.27.1758047385699;
        Tue, 16 Sep 2025 11:29:45 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d32d5653fsm5003058fac.7.2025.09.16.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:29:45 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/6] builtin/update-index: end ODB transaction when --verbose is specified
Date: Tue, 16 Sep 2025 13:29:34 -0500
Message-ID: <20250916182938.2193476-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250916182938.2193476-1-jltobler@gmail.com>
References: <20250915202956.3784935-1-jltobler@gmail.com>
 <20250916182938.2193476-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 23a3a303 (update-index: use the bulk-checkin infrastructure,
2022-04-04), object database transactions were added to
git-update-index(1) to facilitate writing objects in bulk. With
transactions, newly added objects are instead written to a temporary
object directory and migrated to the primary object database upon
transaction commit.

When the --verbose option is specified, the subsequent set of objects
written are explicitly flushed via flush_odb_transaction() prior to
reporting the update. Flushing the object database transaction migrates
pending objects to the primary object database without marking the
transaction as complete. This is done so objects are immediately visible
to git-update-index(1) callers using the --verbose option and that rely
on parsing verbose output to know when objects are written.

Due to how git-update-index(1) parses arguments, options that come after
a filename are not considered during the object update. Therefore, it
may not be known ahead of time whether the --verbose option is present
and thus object writes are considered transactional by default until a
--verbose option is parsed.

Flushing a transaction after individual object writes negates the
benefit of writing objects to a transaction in the first place.
Furthermore, the mechanism to flush a transaction without actually
committing is rather awkward. Drop the call to flush_odb_transaction()
in favor of ending the transaction altogether when the --verbose flag is
encountered. Subsequent object writes occur outside of a transaction and
are therefore immediately visible which matches the current behavior.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/update-index.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 2ba2d29c95..d36bc55752 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -70,14 +70,6 @@ static void report(const char *fmt, ...)
 	if (!verbose)
 		return;
 
-	/*
-	 * It is possible, though unlikely, that a caller could use the verbose
-	 * output to synchronize with addition of objects to the object
-	 * database. The current implementation of ODB transactions leaves
-	 * objects invisible while a transaction is active, so flush the
-	 * transaction here before reporting a change made by update-index.
-	 */
-	flush_odb_transaction(the_repository->objects->transaction);
 	va_start(vp, fmt);
 	vprintf(fmt, vp);
 	putchar('\n');
@@ -1150,6 +1142,21 @@ int cmd_update_index(int argc,
 			const char *path = ctx.argv[0];
 			char *p;
 
+			/*
+			 * It is possible, though unlikely, that a caller could
+			 * use the verbose output to synchronize with addition
+			 * of objects to the object database. The current
+			 * implementation of ODB transactions leaves objects
+			 * invisible while a transaction is active, so end the
+			 * transaction here early before processing the next
+			 * update. All further updates are performed outside of
+			 * a transaction.
+			 */
+			if (transaction && verbose) {
+				end_odb_transaction(transaction);
+				transaction = NULL;
+			}
+
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
 			update_one(p);
-- 
2.51.0.193.g4975ec3473b

