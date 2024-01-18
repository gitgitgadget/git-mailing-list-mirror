Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E624B49
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587980; cv=none; b=ZhZC+dJEUIztR+8whLZKY5qAcnYnEYP0LEo6euniySrcaWTlVeDTlPYvlkULommagXsVhdGKF0gzIQToKDNm4TmykzxXTSfos9Ikhf/yvc7Lp/jkuLazUrHsVXh1clfghMSzY4P7dM0JdUKwPwNC45DmZPG/ayzgMv9QzdTb9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587980; c=relaxed/simple;
	bh=NryrQTmwgdGRNyIhM6MTf3smHTPf9UR2OAfAczftvbs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Fcc:To:Cc; b=b20RuyRIQe87mzLBxPa6HBI1JHTV+6fb2ujfFmeonXPG3kEQsdJbtkLKrQfy3DFb8Dnm/qZMLHSuZ1+BuAfxSg/60EUSbfj3FYtcBDssFCzy9MZVCvrRX1MvJuhUKjjUeLrL0ZTkEdWk2ErqkdZcoTP7bDgLhbqjYXRPuiiIk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3zM7LfD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3zM7LfD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e88012233so22160055e9.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705587976; x=1706192776; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xbCkZrH9/ke/gYr45zoSI453Lc06UqtjxKzNEV1T3Hw=;
        b=Y3zM7LfDYsEIHLNTU7Tdcg53fFvG9qq05o697T6M3t8o8TwmgfK2+qwf/9AAPBwuDQ
         21fNPTd7tDmZjil4wtdFrZXSJvKAOUU311D3JaUVcNJCwN+qRAAG9j9Rugpr1oUQm/ph
         YnKcHAWw+CcmQ2N+/k3WNZzjhc5UhPfUl/ny1NRJpVe0YOVOR9TrGRyXSWvEU5YgPZ20
         84rgMP9vtzPoYjbLGNvTSt8dRWx5Xv3cEKdXDEQiAjL8zt2V2ubGmxesrQyhn2155QVk
         xpTQ/OOYIkQ576uCSN38KWtFna2/qs1bfp8ltRiQTQwJ5yZT4tJqsAjLybi4397AZcDM
         S5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705587976; x=1706192776;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbCkZrH9/ke/gYr45zoSI453Lc06UqtjxKzNEV1T3Hw=;
        b=JTzI3eRI57miv4RZWYrQPeSHsf6L7pPpPxA7o7dXNSFarCwB+GjdLaLTnUv0hyC+KV
         6Bwy3e/t6MQjACaqauclvRtoylukgtQso+8liJshE1P5mqeNc3VB2aA+ccAAB8rxLENn
         ZO+s9P352ZoDm8U1KkZfm1nB0uAFHv3RcOpyj4Fnll5vghNGzV11MyfWrBB97I18mLy/
         4Wfa4G9v+5JX2QRxSMP/KGQ9B1FGBfgGrGgmqxPaTZ2YI26+0nuJcRcJfTf7aLK9DOgq
         nkVgfPGbVezFsGONmyLRDQ7Uu/maeFUtR2iJ3SLKVJ+IDaT9jDMJClgu2cyA9vDnnxPj
         iVzw==
X-Gm-Message-State: AOJu0YzjX7x4F6KAdoZnfyl8Ed53UTTPpRvck/YeUUjDxzEjumzI5Cin
	hY4uLLT4fvRblq/GjbqsaRhBxh9iKgygPgK8p9oATxpNqjXd8kLV+eIhn8a2
X-Google-Smtp-Source: AGHT+IHRuSpAmET1bO/RNTrUI/ee1+nhlCptkXzDcefp8uyFMiCnyWaCsEHqdl5V/Xle1ICHRtbuzg==
X-Received: by 2002:a05:600c:340a:b0:40d:9377:d97c with SMTP id y10-20020a05600c340a00b0040d9377d97cmr560823wmp.65.1705587975945;
        Thu, 18 Jan 2024 06:26:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040c46719966sm29826611wms.25.2024.01.18.06.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:26:15 -0800 (PST)
Message-ID: <pull.1648.git.git.1705587974840.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 14:26:14 +0000
Subject: [PATCH] merge-ll: expose revision names to custom drivers
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
Cc: Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

Custom merge drivers need access to the names of the revisions they
are working on, so that the merge conflict markers they introduce
can refer to those revisions. The placeholders '%S', '%X' and '%Y'
are introduced to this end.

CC: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    merge-ll: expose revision names to custom drivers

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1648%2Fwetneb%2Fmerge_driver_pathnames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1648/wetneb/merge_driver_pathnames-v1
Pull-Request: https://github.com/git/git/pull/1648

 Documentation/gitattributes.txt | 10 +++++++---
 merge-ll.c                      | 17 ++++++++++++++---
 t/t6406-merge-attr.sh           | 16 +++++++++++-----
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 201bdf5edbd..108c2e23baa 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1141,7 +1141,7 @@ command to run to merge ancestor's version (`%O`), current
 version (`%A`) and the other branches' version (`%B`).  These
 three tokens are replaced with the names of temporary files that
 hold the contents of these versions when the command line is
-built. Additionally, %L will be replaced with the conflict marker
+built. Additionally, `%L` will be replaced with the conflict marker
 size (see below).
 
 The merge driver is expected to leave the result of the merge in
@@ -1159,8 +1159,12 @@ When left unspecified, the driver itself is used for both
 internal merge and the final merge.
 
 The merge driver can learn the pathname in which the merged result
-will be stored via placeholder `%P`.
-
+will be stored via placeholder `%P`. Additionally, the names of the
+merge ancestor revision (`%S`), of the current revision (`%X`) and
+of the other branch (`%Y`) can also be supplied. Those are short
+revision names, optionally joined with the paths of the file in each
+revision. Those paths are only present if they differ and are separated
+from the revision by a colon.
 
 `conflict-marker-size`
 ^^^^^^^^^^^^^^^^^^^^^^
diff --git a/merge-ll.c b/merge-ll.c
index 1df58ebaac0..ae9eb69be14 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -185,9 +185,9 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
 static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 			mmbuffer_t *result,
 			const char *path,
-			mmfile_t *orig, const char *orig_name UNUSED,
-			mmfile_t *src1, const char *name1 UNUSED,
-			mmfile_t *src2, const char *name2 UNUSED,
+			mmfile_t *orig, const char *orig_name,
+			mmfile_t *src1, const char *name1,
+			mmfile_t *src2, const char *name2,
 			const struct ll_merge_options *opts,
 			int marker_size)
 {
@@ -222,6 +222,12 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 			strbuf_addf(&cmd, "%d", marker_size);
 		else if (skip_prefix(format, "P", &format))
 			sq_quote_buf(&cmd, path);
+		else if (skip_prefix(format, "S", &format))
+		    sq_quote_buf(&cmd, orig_name);
+		else if (skip_prefix(format, "X", &format))
+			sq_quote_buf(&cmd, name1);
+		else if (skip_prefix(format, "Y", &format))
+			sq_quote_buf(&cmd, name2);
 		else
 			strbuf_addch(&cmd, '%');
 	}
@@ -315,7 +321,12 @@ static int read_merge_config(const char *var, const char *value,
 		 *    %B - temporary file name for the other branches' version.
 		 *    %L - conflict marker length
 		 *    %P - the original path (safely quoted for the shell)
+		 *    %S - the revision for the merge base
+		 *    %X - the revision for our version
+		 *    %Y - the revision for their version
 		 *
+		 * If the file is not named indentically in all versions, then each
+		 * revision is joined with the corresponding path, separated by a colon.
 		 * The external merge driver should write the results in the
 		 * file named by %A, and signal that it has done with zero exit
 		 * status.
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 72f8c1722ff..156a1efacfe 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -42,11 +42,15 @@ test_expect_success setup '
 	#!/bin/sh
 
 	orig="$1" ours="$2" theirs="$3" exit="$4" path=$5
+	orig_name="$6" our_name="$7" their_name="$8"
 	(
 		echo "orig is $orig"
 		echo "ours is $ours"
 		echo "theirs is $theirs"
 		echo "path is $path"
+		echo "orig_name is $orig_name"
+		echo "our_name is $our_name"
+		echo "their_name is $their_name"
 		echo "=== orig ==="
 		cat "$orig"
 		echo "=== ours ==="
@@ -121,7 +125,7 @@ test_expect_success 'custom merge backend' '
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
+	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
@@ -132,7 +136,8 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file main^:text) &&
 	a=$(git unpack-file side^:text) &&
 	b=$(git unpack-file main:text) &&
-	sh -c "./custom-merge $o $a $b 0 text" &&
+	base_revid=$(git rev-parse --short main^) &&
+	sh -c "./custom-merge $o $a $b 0 text $base_revid HEAD main" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	rm -f $o $a $b
@@ -142,7 +147,7 @@ test_expect_success 'custom merge backend' '
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 1 %P" &&
+	merge.custom.driver "./custom-merge %O %A %B 1 %P %S %X %Y" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
@@ -159,7 +164,8 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file main^:text) &&
 	a=$(git unpack-file anchor:text) &&
 	b=$(git unpack-file main:text) &&
-	sh -c "./custom-merge $o $a $b 0 text" &&
+	base_revid=$(git rev-parse --short main^) &&
+	sh -c "./custom-merge $o $a $b 0 text $base_revid HEAD main" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	sed -e 1,3d -e 4q $a >check-3 &&
@@ -173,7 +179,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
+	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 

base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
-- 
gitgitgadget
