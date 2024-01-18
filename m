Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE5288D5
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592587; cv=none; b=Igl/dUvaOUoHK09ORnO3Uf32uMrovto/NA6HMZ11HlzsvcPnK/eTwh4AdI+CXqx1fwJnGtI4L6buix9FiULESzYlg4qYhcSlhxI7DSB39oSKopnjzAC3UiXO8odimVSKPhhH0GUH1yXj0IEij8CC+F+d1ZWT7RQ+vObBpppYqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592587; c=relaxed/simple;
	bh=342rsN8wFK98ACTPxeJGYDSYtHfyTrI55Xr+oD3BTXQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=FjDk8gzj9O0koUqtpRlSprCH7Hx9fBZWW67WK3vt25CGd+jDFq2NJgN8K9eyGtE7Lr/dvtuOG3AbZI6GU6YjasPKn6f42bV2XWtlMBrntBnUVp1g7YVzP+C++gvbMfGfi6sLSJKNdNW4B4dll0sHl8QI2wxUpn177j5kACVyMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExgYrr4y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExgYrr4y"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e958cd226so4812895e9.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 07:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705592583; x=1706197383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXjre9Wv3+ZHcZraTTUW4bC7QkLv44zl9RTocy39fxs=;
        b=ExgYrr4ynAFfi055HgcfT9dZD5m51Eo02PK6OrhwbLbe+u3fn4qoWOSFMGGFJes/n8
         +3yqi1FmIZAtNMY6MDuQjqPJoqmqBiK59H6mNypsAZ0WHNCVk0oqdudkRrpAIDtne9+U
         pLcc7P21poBE7NHj8EJKPYefczMSp2wiMPspPnt7li1b1lz7EnWh+lvlfWoqkVzFHEUQ
         SP5nRnpIXkjxTEn3zKXKZDdaiTWcKY38FIRzl4k5shzRqe0cb7vuIGs7II5FosOBsNhY
         2A8PD6OfGYxhXfFEFJHnsQN3zn0fpTBVgfuS/3DIDZpYczELre36DbR1b0CyymUv6IX9
         3k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705592583; x=1706197383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXjre9Wv3+ZHcZraTTUW4bC7QkLv44zl9RTocy39fxs=;
        b=sYEYm04isVoiJF6bBwCLPtyRPMsj/YHPScofwzfOWInMy7IrEspyiWKWZ4WOMJ55eH
         YUHl08piC/zNkM+Cw2WKh93L2kYOOM6/tsdL150RgIkcZHRtWpYxaoB31h+o0FFsMK7D
         eitCkOp2q2Anuaj6BfRJ6dAe5bqJB1Q2B4uLJeG47gXj+AC+YCCDrt2x7HsvThRlp+3i
         yriSBS4dSHN297/05g+fbtKNot66zV7r8VkdLpmOA4CXBcy73JyyS3xPd/CCOBnhcnkD
         cFL3SZzfrM1Y3y5C74k0WWVbTYqfZYyC3CmDg3SHhFaBK99a1f5jS28OxZY7yv5I0vBg
         BMHw==
X-Gm-Message-State: AOJu0YyqvDzSAF7y9rHrW+kTlL5VNnArRsRNg4vDFY8g7iB+SSP5cSH1
	5J32UazePxWImMbRtljddS4rT1OlaUHJqKiVqrp4233mCHMRgAWhQvQTeYi0
X-Google-Smtp-Source: AGHT+IFawwAnDx+DRaITLuHvnSZLoPHXJ4xLAV7w7r7/7T2QcKb+g+5UNP6W1q7iJU0FiH74XIclhw==
X-Received: by 2002:a05:600c:26c1:b0:40e:44c5:7c9f with SMTP id 1-20020a05600c26c100b0040e44c57c9fmr568955wmv.74.1705592582524;
        Thu, 18 Jan 2024 07:43:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b0040d87100733sm26323788wmg.39.2024.01.18.07.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:43:02 -0800 (PST)
Message-ID: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
In-Reply-To: <pull.1648.git.git.1705587974840.gitgitgadget@gmail.com>
References: <pull.1648.git.git.1705587974840.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 15:43:01 +0000
Subject: [PATCH v2] merge-ll: expose revision names to custom drivers
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

Custom merge drivers need access to the names of the revisions they
are working on, so that the merge conflict markers they introduce
can refer to those revisions. The placeholders '%S', '%X' and '%Y'
are introduced to this end.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    merge-ll: expose revision names to custom drivers

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1648%2Fwetneb%2Fmerge_driver_pathnames-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1648/wetneb/merge_driver_pathnames-v2
Pull-Request: https://github.com/git/git/pull/1648

Range-diff vs v1:

 1:  e648f9f0696 ! 1:  6dec70529c0 merge-ll: expose revision names to custom drivers
     @@ Commit message
          can refer to those revisions. The placeholders '%S', '%X' and '%Y'
          are introduced to this end.
      
     -    CC: Junio C Hamano <gitster@pobox.com>
     -
          Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
      
       ## Documentation/gitattributes.txt ##


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
