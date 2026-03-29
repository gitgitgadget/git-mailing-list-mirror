Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352952F6596
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820479; cv=none; b=iBzIY+STm7qbuh12k9a5HTypOtYU/zO1cD6CbVxDIytv6ZadedzwfjykWtk5JyMt8eJjKbWTfKelOXkEi3WfCo67hp0sY4Bcy7sd1V7NxmkWK9icVnN2UTaTME4j7kJNWWSOFcnCR2HF+YM+il6h8E0xDQES4YoU4xSKSKdhCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820479; c=relaxed/simple;
	bh=whY8EINIDNEdneZvdDT8jRXibDGw+VlVX0f+t5qKEU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7EiS6eJ4oWvmDQKsan6GS47IqpDrmgO3JPAl+/JxJ4532W+yQPX0mMTXZw0q9L3wihrqhkD6JBEAia/L5C0k10DtVeRNJqnZ4LATDwxBWrdHa9g+/69a89G9nM8JeRUZoWjLrpMyaKayeiJ+AKii9hc8U3GTmhbw0TSfA9T9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=eNJx0MBx; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="eNJx0MBx"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64d5a7926cfso4703289d50.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820477; x=1775425277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5IpTXdeD0sZF30Jys2MWYQngQZ+jkpTWoZPNSjYkwI=;
        b=eNJx0MBxn6LIlZJN2qVqViZFBCRE1zZQRMbqNHgIsyUEe2ZoA6wjBCsRAkQTqVLP7v
         riJcEBezXMmA9xrmWf2nKD5svhcrvihFimU2NdW1qN1s2hA4rQkxTxofD94jtu/Jw9rM
         LuhGc5pmEdziXaWKDAJgmH1kGb5Wk38RFhBgK0eFhjjCXf0NUy9P61TpikyfV9rxnUpp
         RWGSuge8/4hARY+QJtg8TJmC2Ao2bwhTYiD5iBV0/uz/DGqFqc0Z45/joaneow4u9kLM
         5AV57WhYtvne7ris/AsK4NqROlMBz2RWG08AxKnXh5wDmEwSHRFwydyVVXvzNbxZtnqR
         TQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820477; x=1775425277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5IpTXdeD0sZF30Jys2MWYQngQZ+jkpTWoZPNSjYkwI=;
        b=DXMwezbhQXCX/+WXbzRzJeBv/Ipc97XC6yN8M8tOt6vkv0472ARgFXkvSONbUng5if
         uALA17XFhMpv02HED54qinPMCjq1ZTBFg3HYYhDrHGHiea0RbYe1cNkFqnSnciGzV8qr
         ZsGHfLX8/7RcgQcKumBIlHJ5OkJ8Ivkv2jf3dzyUwpEm2EHXCUkdnKkB2Tr50dYTlNZB
         XJDGgUdNaT3VpOwfYpH/rw5YXt0WFxqvDApzrf6T97q7k+7a1GqR/LyisQIiMBRRndL0
         muvsa/D2bEMtknA0/FGI1cbN1rhqZlThozkISj2a1Qut0re4vTLH2DKSsUVRuCu061Zi
         q97A==
X-Gm-Message-State: AOJu0Yy120z0+O7MgqlKVe8WlNZMYRYNGmXg4/fwq217X76+NKUUBver
	VHcoFTpiZG29vGZwC/yTGamZLPoXoFXm5rnt5lUpnFbn3sM/ZU9cTZkgCNf1VGGYusLVvpLvEBf
	/ZHUXXy2XEBdM
X-Gm-Gg: ATEYQzyXrvE8+pdZgVSJII9PZo9yVHSeP0ISgK49tRVbX6TN4cVcVost755omPw9zGx
	ignIN43fzeVCIWRDTIlV8Cq9ApnpRmRm9AMh6mTxRzQp9Xlg9eKFhZ7OSoYrWpOx3wp8LUUt/xU
	my4NkXKy8vVC6vhX15QkgjtAEkTEdxXcigVfQiZIVZHVV7euXEiCipytGQL7hSv222vW0Zhx5dQ
	B2+NcPv8q2o/YEKw3uvq5RX9+tvjqd2tkECjVIfUH9PEFOEgn5f9nAfR2G5QMor4cHBB+kXNo5K
	yiaOwEU/DhFrksA900M6y24BYFREZzuDjHI+mSLqFogLOO1+l/eWGj3uki4xrx91Q4oys91mfMG
	6sJykygpyG1bN6MDNdZlVXdLR71gr3f8rqRk4lj0XjLDguiuUA0GVcFDMY5i+rhrWXDjmjXEETz
	5ggCdnrpunQdMyrQmzehnFDRtkHxNfeTnzJUpPn2I93ARD4A5e3BwXNzxnDlGLtpHC2RHjN5zu4
	L2IBKDB+ZLb7NjWXS3221DF7X88EA==
X-Received: by 2002:a53:ac95:0:b0:650:1a72:99f8 with SMTP id 956f58d0204a3-6501a72b986mr2032853d50.43.1774820477113;
        Sun, 29 Mar 2026 14:41:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6500936f692sm2967370d50.19.2026.03.29.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:16 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 10/16] repack-midx: extract `repack_fill_midx_stdin_packs()`
Message-ID: <cd5eba0f665a4d3a4febc47f1fe5f13200a4f941.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

The function `write_midx_included_packs()` manages the lifecycle of
writing packs to stdin when running `git multi-pack-index write` as a
child process.

Extract a standalone `repack_fill_midx_stdin_packs()` helper, which
handles `--stdin-packs` argument setup, starting the command, writing
pack names to its standard input, and finishing the command.

This simplifies `write_midx_included_packs()` and prepares for a
subsequent commit where the same helper is called with `cmd->out = -1`
to capture the MIDX's checksum from the command's standard output,
which is needed when writing MIDX layers with `--checksum-only`.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 83151d4734a..78f069c2151 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -292,23 +292,42 @@ static void repack_prepare_midx_command(struct child_process *cmd,
 		strvec_push(&cmd->args, "--bitmap");
 }
 
+static int repack_fill_midx_stdin_packs(struct child_process *cmd,
+					struct string_list *include)
+{
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+
+	cmd->in = -1;
+
+	strvec_push(&cmd->args, "--stdin-packs");
+
+	ret = start_command(cmd);
+	if (ret)
+		return ret;
+
+	in = xfdopen(cmd->in, "w");
+	for_each_string_list_item(item, include)
+		fprintf(in, "%s\n", item->string);
+	fclose(in);
+
+	return finish_command(cmd);
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list include = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
-	FILE *in;
 	int ret = 0;
 
 	midx_included_packs(&include, opts);
 	if (!include.nr)
 		goto done;
 
-	cmd.in = -1;
-
 	repack_prepare_midx_command(&cmd, opts, "write");
-	strvec_push(&cmd.args, "--stdin-packs");
 
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
@@ -350,16 +369,7 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
 			     opts->refs_snapshot);
 
-	ret = start_command(&cmd);
-	if (ret)
-		goto done;
-
-	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, &include)
-		fprintf(in, "%s\n", item->string);
-	fclose(in);
-
-	ret = finish_command(&cmd);
+	ret = repack_fill_midx_stdin_packs(&cmd, &include);
 done:
 	if (!ret && opts->write_bitmaps)
 		remove_redundant_bitmaps(&include, opts->packdir);
-- 
2.53.0.729.g817728289e1.dirty

