Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515CC12AACC
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126958; cv=none; b=I3Ze1BQz1ZB+m/xSb5ngmNlRN9TEetRCr4tFz+FgXi8PhbxaHzBANbaQUDky1ASAMdytutH3sVa65ps5rQU8g6e4GwbZQw2Ew1MS1oztsbOvQP88MCTJCS57ROoQvNRz55WL/hc7vv4eYmYaQ7uQCJadd4COCHNXH5hZ371b9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126958; c=relaxed/simple;
	bh=LZpgUKA2IXNSXNtvaukLedsTLZvZNfhEhkqFBuFJVIg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XxKBjx0s1jpKawGmm48aDKItKMmD0NNx4aWT/Pg/RNsxV/XEib5bmj8i/W+yZZ//6gfYYNZge2cl/mN9fAa0gnL2zg9L/SfwgpLyuHsIm8w4/9MO/H6Yj3k/imm9FfX897Q+0T1/4NQYvT2mptEaQF+ruDpVVOjEYdwzcxUcVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZwztX2i; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZwztX2i"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337d90030bfso5135971f8f.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 12:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706126954; x=1706731754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6YZWfLTU8oAAjJIX9RZthGI5i3qRw4WIyEaTjdYAD0=;
        b=AZwztX2igpF2Tg+h/YtLNpRpqJoVjriLGOC3lJJ0BwhZ3CfCdZbrG0En0nu0vcyDrY
         2Z7WV85yw1XUMQap1P7QlYLdnpo0Y7euzHOH9bxmUdjFL8tFaIKh4z8XX43wvMPF4JH9
         qHktuPkZBUYZCHcGJLLRTk1tR/f/j1rTJ4X8e15ZGp5OgklJbwIrMwZGV5wVdZogVHlt
         owfjZNgrAItxGFZSOwZ0dULUdEw6it8FxF6m6qwiKubR0YZtq0OMulqyDxpR8O3y3+xZ
         bNl1sDTlXPYhaYUEG/9kxtOkseGGkB3/emUl0iXeMqrABnW2r0Kgk+hcEpIQ3MoBF/KG
         6GqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706126954; x=1706731754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6YZWfLTU8oAAjJIX9RZthGI5i3qRw4WIyEaTjdYAD0=;
        b=ASPijUMc57MtrKcea/H2BbRnaT9oWAxKARrnPRR/SXjyICeqn0FyHFjFIIUaxkEX9A
         b1NYma/zqZJdXGoXIku45ca0kSVcvjOoVpJZBGPu47i4deeWRJHVf3H+CNGQsIU9MRl2
         sa0oLgR85yH10y2zhh1FqnK9Gju02obsCvFznqi0hdkyzC/JRkipIbEVTkhrFEoPuecg
         KLm/4vTdRAuBhm3eSy1BvgxdZpTjKwirfHaKjVVsH86mfUzI14746WyCBw1HM/TpemOk
         nrfPYmvd02jocZB4jRVyOJADbyqMiPfHjybz3+IwMJjowE5rmNULh0Kg9jFK+ITEzake
         Zujg==
X-Gm-Message-State: AOJu0YyIZRwcSOlys4F9QD/5vZW/KWFWJtpsLSJZYojK1g2Hdx/a7LLk
	ls2w2WtDi4iHK1ozw28tzY43n0UYtUnkaeU2KDBfV9NfQ+PINUHbJhkXS4Fk
X-Google-Smtp-Source: AGHT+IFkptwMGPArcd/AOmLRldcKBjUVjKhRt+rKs2LX0yYfz2VRJh9O0x5xV25b6xSewp3yneowOA==
X-Received: by 2002:a5d:5111:0:b0:337:c0de:19b9 with SMTP id s17-20020a5d5111000000b00337c0de19b9mr470029wrt.40.1706126953574;
        Wed, 24 Jan 2024 12:09:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d5909000000b0033936c34713sm8441382wrd.78.2024.01.24.12.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:09:13 -0800 (PST)
Message-ID: <pull.1648.v4.git.git.1706126951879.gitgitgadget@gmail.com>
In-Reply-To: <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
References: <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 20:09:11 +0000
Subject: [PATCH v4] merge-ll: expose revision names to custom drivers
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
    Phillip Wood <phillip.wood123@gmail.com>,
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
    
    Changes since v3:
    
     * simplify the documentation as suggested by Phillip, keeping
       single-letter placeholders as suggested by Junio
     * add fallback to empty string when the collision marker names are
       NULL, as suggested by Phillip

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1648%2Fwetneb%2Fmerge_driver_pathnames-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1648/wetneb/merge_driver_pathnames-v4
Pull-Request: https://github.com/git/git/pull/1648

Range-diff vs v3:

 1:  aebd26711fe ! 1:  47aca4fc8f6 merge-ll: expose revision names to custom drivers
     @@ Documentation/gitattributes.txt: When left unspecified, the driver itself is use
       The merge driver can learn the pathname in which the merged result
      -will be stored via placeholder `%P`.
      -
     -+will be stored via placeholder `%P`. Additionally, the names of the
     -+common ancestor revision (`%S`), of the current revision (`%X`) and
     -+of the other branch (`%Y`) can also be supplied. Those are short
     -+revision names, optionally joined with the paths of the file in each
     -+revision. Those paths are only present if they differ and are separated
     -+from the revision by a colon.
     ++will be stored via placeholder `%P`. The conflict labels to be used
     ++for the common ancestor, local head and other head can be passed by
     ++using '%S', '%X' and '%Y` respectively.
       
       `conflict-marker-size`
       ^^^^^^^^^^^^^^^^^^^^^^
     @@ merge-ll.c: static enum ll_merge_result ll_ext_merge(const struct ll_merge_drive
       		else if (skip_prefix(format, "P", &format))
       			sq_quote_buf(&cmd, path);
      +		else if (skip_prefix(format, "S", &format))
     -+			sq_quote_buf(&cmd, orig_name);
     ++			sq_quote_buf(&cmd, orig_name ? orig_name : "");
      +		else if (skip_prefix(format, "X", &format))
     -+			sq_quote_buf(&cmd, name1);
     ++			sq_quote_buf(&cmd, name1 ? name1 : "");
      +		else if (skip_prefix(format, "Y", &format))
     -+			sq_quote_buf(&cmd, name2);
     ++			sq_quote_buf(&cmd, name2 ? name2 : "");
       		else
       			strbuf_addch(&cmd, '%');
       	}


 Documentation/gitattributes.txt |  9 +++++----
 merge-ll.c                      | 17 ++++++++++++++---
 t/t6406-merge-attr.sh           | 16 +++++++++++-----
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 201bdf5edbd..4338d023d9a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1137,11 +1137,11 @@ The `merge.*.name` variable gives the driver a human-readable
 name.
 
 The `merge.*.driver` variable's value is used to construct a
-command to run to merge ancestor's version (`%O`), current
+command to run to common ancestor's version (`%O`), current
 version (`%A`) and the other branches' version (`%B`).  These
 three tokens are replaced with the names of temporary files that
 hold the contents of these versions when the command line is
-built. Additionally, %L will be replaced with the conflict marker
+built. Additionally, `%L` will be replaced with the conflict marker
 size (see below).
 
 The merge driver is expected to leave the result of the merge in
@@ -1159,8 +1159,9 @@ When left unspecified, the driver itself is used for both
 internal merge and the final merge.
 
 The merge driver can learn the pathname in which the merged result
-will be stored via placeholder `%P`.
-
+will be stored via placeholder `%P`. The conflict labels to be used
+for the common ancestor, local head and other head can be passed by
+using '%S', '%X' and '%Y` respectively.
 
 `conflict-marker-size`
 ^^^^^^^^^^^^^^^^^^^^^^
diff --git a/merge-ll.c b/merge-ll.c
index 1df58ebaac0..5ffb045efb9 100644
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
+			sq_quote_buf(&cmd, orig_name ? orig_name : "");
+		else if (skip_prefix(format, "X", &format))
+			sq_quote_buf(&cmd, name1 ? name1 : "");
+		else if (skip_prefix(format, "Y", &format))
+			sq_quote_buf(&cmd, name2 ? name2 : "");
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
