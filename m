Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112D1EA7D
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289187; cv=none; b=MqjYTtyUFOyxwWaItoJPc3Bq3mK49aXF8ZaODLE/KQXO1kbClQS0DSD8ZOORNHyEfvvLgJ/DJnz4QkkjyQcp2kfr1AKeb91GlHanzuwfqNU3lRmWqK+jErIwWzXzd7Iq+F+swqBhX8w1WMoDpx2ksUvd0TItomiciDApGOvU2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289187; c=relaxed/simple;
	bh=tuKf+RwY7GtXE76x4ySPNqJGiPLqQ8oGIymxbEAqh0s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hH7BxjMOzjSn/jX1BD9gr2bVI9mIv+hp3CHrX2LdibTG21b6+g/gsraAJXuXZktFOa/9o7T7vE/s+FhTF1SGka0NbnrHX2zWDg1/PnfeYsp+r0szukmbPwqMg0sMkdb+TjqknS7wgZ2Vi0PqRpg3O3Qlo1HCLjtAxHBPsGyJtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnjZX9N6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnjZX9N6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so12967445e9.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706289183; x=1706893983; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC8jWT/C7WqkDa1vvGgTXcbRk3q+dtF07loxlkg2IKM=;
        b=RnjZX9N6p78cA13N5+UtnjfG36rrV0Zpsdcecq2Pr62nLTSy3lZz/vaQQdrb/6LGKd
         jf9iXhu6KNGkp8G4EkemzMMZy2UvsOcice74/ZkPZ9naagchA0khnqId2HgQyKQnkbo6
         jXvfRm5p8TOVJ8DctFnx3EaMt0/cN4il+3NsOw5k8hY1Rw57ZXAVGmc0X3CNhmXukI3b
         CwkaVl+j9Ll8bPaK/19aRoQk884Y8TnSng9jjcYNOCDL+/7JMgKBUT4/I84rdApt0fDm
         Xr8ehhGifUCcXFogL7LPeC8l9Cvxek0dT18UyyR4X8Ydm+PdrDHHjP7fU1aVdCIT1ef+
         MDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289183; x=1706893983;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC8jWT/C7WqkDa1vvGgTXcbRk3q+dtF07loxlkg2IKM=;
        b=Lc/VKlWzy5gv8felg+udf5MeqZhsRf1r8CJyClF+MYKhSK43Yb116LqeZK5F/d182m
         fXUVhtO48lgir6t2hfk/l0wia9zsX/kRfyCv9k3/0Iop7JYithPgW//j4sxUkx6dtam/
         3FUhkXr3VfUO+f+IlvUjvA2Vy5UCU48e13eIYcKx8Qv5OqEV3JjQneBmxn9BQh0K+wyt
         vGg/kzc3M+1QDlF69fJvC1wEDyWV+k3TfpTrxpLkRbFqnjYNaHcfmnHgP8QPo/F5JTSl
         qiG95mdeUT3RnbioYl3wulfF6dTMkcCXHrZ17RrdiaFxZhrzcaMQu0nyrK36VRbQCMVN
         OdNw==
X-Gm-Message-State: AOJu0Yz2DZru1g0kYQaa1HnAkV3uMBU/GKNrFqVb+UjMYroHIIBdXra2
	iGxApLe/jSFVcuX9eDR+XbvGjmhsM9IzAWoMuh/dkfV+woYTKbGsCz+Iomus
X-Google-Smtp-Source: AGHT+IEsMNLc42ymKnSAFmy+kMTCY2b3sHmApzLMexcdPGgdRt+49unzoaNWqoOtS2MZ980HOJlVwQ==
X-Received: by 2002:a05:600c:1c1b:b0:40e:7e40:10c6 with SMTP id j27-20020a05600c1c1b00b0040e7e4010c6mr50003wms.182.1706289182991;
        Fri, 26 Jan 2024 09:13:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b0040e541ddcb1sm2435640wmg.33.2024.01.26.09.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:13:02 -0800 (PST)
Message-ID: <b3b3e8bd0bf2c83b57debef81edc39970beaf05b.1706289180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
	<pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 17:12:59 +0000
Subject: [PATCH v2 1/2] index-pack: test and document --strict=<msg>
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
2015-06-22) allowed a list of fsck msg to downgrade to be passed to
--strict. However this is a hidden argument that was not documented nor
tested. Though it is true that most users would not call this option
directly, (nor use index-pack for that matter) it is still useful to
document and test this feature.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-index-pack.txt |  9 +++++++--
 builtin/index-pack.c             |  2 +-
 t/t5300-pack-object.sh           | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 6486620c3d8..f7a98bbf9c8 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -79,8 +79,13 @@ OPTIONS
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
 
---strict::
-	Die, if the pack contains broken objects or links.
+--strict[=<msg-id>=<severity>...]::
+	Die, if the pack contains broken objects or links. If `<msg-ids>` is passed,
+	it should be a comma-separated list of `<msg-id>=<severity>` elements where
+	`<msg-id>` and `<severity>` are used to change the severity of some possible
+	issues, e.g., `--strict="missingEmail=ignore,badTagName=error"`. See the entry
+	for the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
+	more information on the possible values of `<msg-id>` and `<severity>`.
 
 --progress-title::
 	For internal use only.
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1ea87e01f29..1e53ca23775 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,7 @@
 #include "setup.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d402ec18b79..496fffa0f8a 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -441,6 +441,28 @@ test_expect_success 'index-pack with --strict' '
 	)
 '
 
+test_expect_success 'index-pack with --strict downgrading fsck msgs' '
+	test_when_finished rm -rf strict &&
+	git init strict &&
+	(
+		cd strict &&
+		test_commit first hello &&
+		cat >commit <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
+		PACK=$(git pack-objects test <commit_list) &&
+		test_must_fail git index-pack --strict "test-$PACK.pack" &&
+		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
+	)
+'
+
 test_expect_success 'honor pack.packSizeLimit' '
 	git config pack.packSizeLimit 3m &&
 	packname_10=$(git pack-objects test-10 <obj-list) &&
-- 
gitgitgadget

