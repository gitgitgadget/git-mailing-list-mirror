Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD113DDAB
	for <git@vger.kernel.org>; Fri, 17 May 2024 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967273; cv=none; b=BP1JqSzVsmHKPOMjGpNx/A3eDp9lpje1XefjxsT5TZPvotz2FPHmOfLqJI/9O5BMZDZgM24IF8kQf+aZYcNdFZaXTa1+PkXaeTUhhkAwL9O/rC1r3h0wvBGPeO5UZE+N6mFv0pwZ/ZeBVPOZrV09jT51OHnFAloYUUOB61PBdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967273; c=relaxed/simple;
	bh=PwjAwil4yUOwE8rGUsdunG//+ZzYwnVp7Pwr2jkMUjs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gXo/TgY9vnbB7LPj4EIwT6gq1Xh+11s3+hQd7tYra8b81lwxNQcl02tcZBwvgb+v97mvXZrXUXiNVealWqNTN3CjQBSOsiU/T/sig+2KAWACEahot+CNBJKJzPV8whhIsKfapwvVnmGn5HPxdgIz6ZfpB+ComMfcIkAV9bCQVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4EfMUA7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4EfMUA7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-351b683f2d8so295317f8f.3
        for <git@vger.kernel.org>; Fri, 17 May 2024 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715967270; x=1716572070; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnKoT/GJp2jyFWnwM40BYbxFeDJFzNpFwOIZlhwADqo=;
        b=e4EfMUA7g78DGohoZEe7inIovE+++9f++CYsI0bkAjGMrs6x0AkE9Qrc6ckGpiwNz1
         s8U7UJCOuHRyQ6Qp3Pi5QAKr9HcDzNPAjNVM8Rdh83iV9wzC701OiXbbW36b9Gwiv4TF
         869rr6jpLcSaMgB+LQ52Zc+SDlYnDvOfWSEN1cKY79P52dJwSP9DVCtEqzpImVK+ycMj
         OeSmud26ehEkF6591hdLwclV6hN77sAMslYnHFSDMIIRAudB8cuXUaobmPjWyVBjyYh3
         iEUXTt7vW3Q25u/dHpV2uNltAHk3pb1yELNtD/qY1uEFIqE7PH1ccTyB0JbFBfNJo/Ku
         NWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967270; x=1716572070;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnKoT/GJp2jyFWnwM40BYbxFeDJFzNpFwOIZlhwADqo=;
        b=TSj+4R7snp614gxNBZFwcCW0BzTKGqyvOGwkDkV9nZUSdT2WDNyQ90lDLYK6olk2Sp
         GQb68+05wB73b9ju3qRoFqxoFubmCkX/Zi/acXnAwa6An/X/G89XjvzgNyVA9V7JNgLw
         BlSrwyXu0Tr6mE4W2KfhLeNQlEpIi1IquKNuRt4CbafMU0tTcpSfrBrCrc0Z94HplXB2
         izrVkpkGxlDyzGuCWk6luhViTg1BapQ4waqd3F2A9Jm9sNr7DLzr5a8bO952zO4BU7xy
         VflVebEgrqC4ayXu9wNklu6Yyy3YDOPl/rZNMwWPzIrDW7pA7uTKM6U/qnFrUxzUFyzN
         IfoQ==
X-Gm-Message-State: AOJu0Yxo/NSJLQYawVobZ578+gRWqEuAhMKJICPgRo484tTEx9LZLhJS
	xfAh6FUymM73vE4VZrT5Sjk+WWwlzWjXzlSBF9R8nqcV7vkclld6L1+7OQ==
X-Google-Smtp-Source: AGHT+IHf4TfHYbeUNriQHd8mF7uIXb7mOUU7R8ojOyqIgCmzPHDyTa0zkuvpKXAzR8wUFXv1IliKbw==
X-Received: by 2002:a5d:698d:0:b0:34b:2a61:b3c9 with SMTP id ffacd0b85a97d-3504a73ece6mr15228238f8f.40.1715967269401;
        Fri, 17 May 2024 10:34:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a789asm22080189f8f.51.2024.05.17.10.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:34:29 -0700 (PDT)
Message-Id: <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
From: "Tom Scogland via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 17:34:27 +0000
Subject: [PATCH v2] archive: make --add-virtual-file honor --prefix
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
Cc: Tom Scogland <scogland1@llnl.gov>,
    Tom Scogland <scogland1@llnl.gov>

From: Tom Scogland <scogland1@llnl.gov>

The documentation for archive describes the `--add-virtual-file` option
thusly:

  The path of the file in the archive is built by concatenating the
  value of the last `--prefix` moption (if any) before this
  `--add-virtual-file` and <path>.

The `--add-file` documentation is similar:

  The path of the file in the archive is built by concatenating the
  value of the last --prefix option (if any) before this --add-file and
  the basename of <file>.

Notably both explicitly state that they honor the last `--prefix` option
before the `--add` option in question.  The implementation of
`--add-file` seems to have always honored prefix, but the implementation
of `--add-virtual-file` does not.  Also note that `--add-virtual-file`
explicitly states it will use the full path given, while `--add-file`
uses the basename of the path it is given.

Modify archive.c to include the prefix in the path used by
`--add-virtual-file` and add checks into
the existing add-virtual-file test to verify:

* that `--prefix` is honored
* that leading path components are preserved
* that both work together and separately

Changes since v1:
- Revised the commit message style
- Added tests for basename/non-basename behavior
- Fixed archive.c to use full path for virtual and basename for add-file

Signed-off-by: Tom Scogland <scogland1@llnl.gov>
---
    archive: make --add-virtual-file honor --prefix

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1719%2Ftrws%2Fhonor-prefix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1719/trws/honor-prefix-v2
Pull-Request: https://github.com/git/git/pull/1719

Range-diff vs v1:

 1:  1b685d8ca1a ! 1:  b9a0ef282a3 archive: make --add-virtual-file honor --prefix
     @@ Metadata
       ## Commit message ##
          archive: make --add-virtual-file honor --prefix
      
     -    The documentation for archive states:
     +    The documentation for archive describes the `--add-virtual-file` option
     +    thusly:
      
            The path of the file in the archive is built by concatenating the
            value of the last `--prefix` moption (if any) before this
            `--add-virtual-file` and <path>.
      
     -    This matches the documentation for --add-file and the behavior works for
     -    that option, but --prefix is ignored for --add-virtual-file.
     +    The `--add-file` documentation is similar:
      
     -    This commit modifies archive.c to include the prefix in the path and
     -    adds a check into the existing add-virtual-file test to ensure that it
     -    honors both the most recent prefix before the flag.
     +      The path of the file in the archive is built by concatenating the
     +      value of the last --prefix option (if any) before this --add-file and
     +      the basename of <file>.
     +
     +    Notably both explicitly state that they honor the last `--prefix` option
     +    before the `--add` option in question.  The implementation of
     +    `--add-file` seems to have always honored prefix, but the implementation
     +    of `--add-virtual-file` does not.  Also note that `--add-virtual-file`
     +    explicitly states it will use the full path given, while `--add-file`
     +    uses the basename of the path it is given.
     +
     +    Modify archive.c to include the prefix in the path used by
     +    `--add-virtual-file` and add checks into
     +    the existing add-virtual-file test to verify:
     +
     +    * that `--prefix` is honored
     +    * that leading path components are preserved
     +    * that both work together and separately
      
     -    In looking for others with this issue, I found message
     -    a143e25a70b44b82b4ee6fa3bb2bcda4@atlas-elektronik.com on the mailing
     -    list, where Stefan proposed a basically identical patch to archive.c
     -    back in February, so the main addition here is the test along with that
     -    patch.
     +    Changes since v1:
     +    - Revised the commit message style
     +    - Added tests for basename/non-basename behavior
     +    - Fixed archive.c to use full path for virtual and basename for add-file
      
          Signed-off-by: Tom Scogland <scogland1@llnl.gov>
      
     @@ archive.c: int write_archive_entries(struct archiver_args *args,
      +		strbuf_reset(&path_in_archive);
      +		if (info->base)
      +			strbuf_addstr(&path_in_archive, info->base);
     -+		strbuf_addstr(&path_in_archive, basename(path));
       		if (!info->content) {
      -			strbuf_reset(&path_in_archive);
      -			if (info->base)
      -				strbuf_addstr(&path_in_archive, info->base);
     --			strbuf_addstr(&path_in_archive, basename(path));
     + 			strbuf_addstr(&path_in_archive, basename(path));
      -
       			strbuf_reset(&content);
       			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
       				err = error_errno(_("cannot read '%s'"), path);
      @@ archive.c: int write_archive_entries(struct archiver_args *args,
     + 						  canon_mode(info->stat.st_mode),
       						  content.buf, content.len);
       		} else {
     ++			strbuf_addstr(&path_in_archive, path);
       			err = write_entry(args, &fake_oid,
      -					  path, strlen(path),
      +					  path_in_archive.buf, path_in_archive.len,
     @@ t/t5003-archive-zip.sh: test_expect_success UNZIP 'git archive --format=zip --ad
       		--add-virtual-file=\""$PATHNAME"\": \
      -		--add-virtual-file=hello:world $EMPTY_TREE &&
      +		--add-virtual-file=hello:world \
     -+		--prefix=subdir/ --add-virtual-file=hello:world \
     ++		--add-virtual-file=with/dir/noprefix:withdirnopre \
     ++		--prefix=subdir/ --add-virtual-file=with/dirprefix:withdirprefix \
     ++		--prefix=subdir2/ --add-virtual-file=withoutdir:withoutdir \
      +		--prefix= $EMPTY_TREE &&
       	test_when_finished "rm -rf tmp-unpack" &&
       	mkdir tmp-unpack && (
     @@ t/t5003-archive-zip.sh: test_expect_success UNZIP 'git archive --format=zip --ad
       		test_path_is_file "$PATHNAME" &&
      -		test world = $(cat hello)
      +		test world = $(cat hello) &&
     -+		test_path_is_file subdir/hello &&
     -+		test world = $(cat subdir/hello)
     ++		test_path_is_file with/dir/noprefix &&
     ++		test withdirnopre = $(cat with/dir/noprefix) &&
     ++		test_path_is_file subdir/with/dirprefix &&
     ++		test withdirprefix = $(cat subdir/with/dirprefix) &&
     ++		test_path_is_file subdir2/withoutdir &&
     ++		test withoutdir = $(cat subdir2/withoutdir)
       	)
       '
       


 archive.c              | 10 +++++-----
 t/t5003-archive-zip.sh | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/archive.c b/archive.c
index 5287fcdd8e0..64777a9870d 100644
--- a/archive.c
+++ b/archive.c
@@ -365,12 +365,11 @@ int write_archive_entries(struct archiver_args *args,
 
 		put_be64(fake_oid.hash, i + 1);
 
+		strbuf_reset(&path_in_archive);
+		if (info->base)
+			strbuf_addstr(&path_in_archive, info->base);
 		if (!info->content) {
-			strbuf_reset(&path_in_archive);
-			if (info->base)
-				strbuf_addstr(&path_in_archive, info->base);
 			strbuf_addstr(&path_in_archive, basename(path));
-
 			strbuf_reset(&content);
 			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
 				err = error_errno(_("cannot read '%s'"), path);
@@ -380,8 +379,9 @@ int write_archive_entries(struct archiver_args *args,
 						  canon_mode(info->stat.st_mode),
 						  content.buf, content.len);
 		} else {
+			strbuf_addstr(&path_in_archive, path);
 			err = write_entry(args, &fake_oid,
-					  path, strlen(path),
+					  path_in_archive.buf, path_in_archive.len,
 					  canon_mode(info->stat.st_mode),
 					  info->content, info->stat.st_size);
 		}
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 961c6aac256..0cf3aef8ace 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -218,14 +218,24 @@ test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
 	fi &&
 	git archive --format=zip >with_file_with_content.zip \
 		--add-virtual-file=\""$PATHNAME"\": \
-		--add-virtual-file=hello:world $EMPTY_TREE &&
+		--add-virtual-file=hello:world \
+		--add-virtual-file=with/dir/noprefix:withdirnopre \
+		--prefix=subdir/ --add-virtual-file=with/dirprefix:withdirprefix \
+		--prefix=subdir2/ --add-virtual-file=withoutdir:withoutdir \
+		--prefix= $EMPTY_TREE &&
 	test_when_finished "rm -rf tmp-unpack" &&
 	mkdir tmp-unpack && (
 		cd tmp-unpack &&
 		"$GIT_UNZIP" ../with_file_with_content.zip &&
 		test_path_is_file hello &&
 		test_path_is_file "$PATHNAME" &&
-		test world = $(cat hello)
+		test world = $(cat hello) &&
+		test_path_is_file with/dir/noprefix &&
+		test withdirnopre = $(cat with/dir/noprefix) &&
+		test_path_is_file subdir/with/dirprefix &&
+		test withdirprefix = $(cat subdir/with/dirprefix) &&
+		test_path_is_file subdir2/withoutdir &&
+		test withoutdir = $(cat subdir2/withoutdir)
 	)
 '
 

base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
-- 
gitgitgadget
