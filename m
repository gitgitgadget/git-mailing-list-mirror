Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163E3E4C67
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914521; cv=none; b=HV1ECJg7mdI6TlSI0LcjdD+JcAAVWeUM6U60vPhQI1f80CbAOovuqPLeh78HvYoyqCGr5+PM5HoC5vPQjfFNpKElTSQeX3ReD7So9CzA7vA7XTJ/5rk1uil5qBxayRa5xl7SxTV0Vi3xzaL1gYljOnbSjEiATnu8wg+aHeLADoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914521; c=relaxed/simple;
	bh=LbHwbsSRObIKXgG6/GAGMTzOlaZOCtXaa7+uZISFc0s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V3rUUr8LBtEJ39olGkCY4t/ozvrg0LnlrDFdNRmVJH3kOkw2djL/7PdiVPmFzxL8UHfNIen6ERpISxNZT+hoVbPX5nhzjZZdDSI6tctDz3k8YB2aVI35xyJcDGSSaHxQS23aaRZwXj8Veb86RU1OR1I1CubW0bwHt+3IyxIlIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZgyQ1cA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZgyQ1cA"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b74b460d77so20919486d6.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914517; x=1778519317; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4xodm3fjmxi+KQJTMUvyrLC0OV52p21gKVMP81J1fM=;
        b=oZgyQ1cATPbmE6VgRpJEk8PD0PedVQuZ4I6BtN8JW9Cl/jJk5y0ygrJYJXHSe9VfxO
         y+UPjws50keXGFoM84hJ7fHrsDSTrJ+KM3d7cork98qVasRzYNHwnB8lqak1e5FNHA70
         k8xlU9ezbB8mRoXg7PNGLs2bJlU7wblm4/ybVOB2zy9POI8rkRjz8VEj/HrfQmcmNB8j
         +AdpaLFJJXpib8+28rStmS620X1MzQJjqHqrVuhJa7K82PRVvOS4S8Rozs9r91KCS96y
         IqDUFQb0qxrU+cNluUWogteYqqBUgyD1lFThou4qDv7LoOcIZEk5MVlZxu3DUq/sals2
         lQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914517; x=1778519317;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4xodm3fjmxi+KQJTMUvyrLC0OV52p21gKVMP81J1fM=;
        b=IUdghETVWWuwvge6/TXVbmF+LUuhA8/MK8qwv4EIMTN4G60r+c1lRJ6mY7Jo+v4NI1
         UhCEfRGJ3o4IqTeW+szO0D1mNUgVFRomV29h2NJw8f5W+dUTht5KQUP4cJpJE7slQyRn
         J8sC9LN9rUnc6TeO5bgBPJmakbOU4kb72zQNq9FAS71TYF1hKhAS+5toN3ipmIyb7Ol+
         F/TcO/Y5DsdHdgiIpbOaz9lnPfRJf4TT6SGWdk82iWRo9FtqChSS69iup3rfJV/rCX93
         H8Q0zhefm9nyvI/nTOOJs5YmLYYouGMZRB+YFZe4Ga2EdXrb9K4q+RInJK2MKJKbwzUY
         47qw==
X-Gm-Message-State: AOJu0YzdclWY/eHa+2w0i2nfnGcB2B9U1u+0sQXsH+OiEgFYLdd0xgPb
	oEGI0a6bI+xoLx9E4jc+11+15DaLhNgl4p4osmKg02TMVaHPIxwrKVkQjmDQMFjI
X-Gm-Gg: AeBDieuOWpvjNmn7cdrF7lzG3/kYEsYLW8hL8+lewaxFAx6wdfI7D5RUTZQVAM8ivy8
	hIXVVJr4ew17ptV1GOyMSdliipLa1ZxlAjm7UYuTT4QtQUWylvw4PZzfMxYP7yddllbdPbPZ0Vg
	JFC+IX5b673e073d5/297k3rlGC5CpjBtvhSXM59M40wZpdzJlDlZGr5Z4Y5W4g6APZHrDL5SCo
	+vT58JKNWJlsUS8v05Re/SDXo27FdzK/4g1reD/hYMQHOBQxeMPYu2houEi/+s4/2fOLIxMIYl+
	jBOaIcRCsSJ3Mr5O5grKhZfEVhkKt5dovRWjdCd0v1P03r4Wz5suno7xfrCllA8rVRk9ReFK3e5
	JcDGKeRh07VKsCZfabc5JjLpKozVe/fcj/T/ShuxO7+r5HKD14T4H0zAjgHQYbKBHb7/g3eA+Hd
	WKEP0IjcFCVwzpjELrFPz85xtCWDEClawvijid
X-Received: by 2002:a05:6214:3da1:b0:8ac:a553:529d with SMTP id 6a1803df08f44-8b667698fdemr172029616d6.23.1777914516983;
        Mon, 04 May 2026 10:08:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm123593336d6.18.2026.05.04.10.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:36 -0700 (PDT)
Message-Id: <a3019888d8465e0f77926a91a20db170fef6989d.1777914508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:23 +0000
Subject: [PATCH v2 06/11] t5608: add regression test for >4GB object clone
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The shift overflow bug in index-pack and unpack-objects caused incorrect
object size calculation when the encoded size required more than 32 bits
of shift. This would result in corrupted or failed unpacking of objects
larger than 4GB.

Add a test that creates a pack file containing a 4GB+ blob using the
new 'test-tool synthesize pack --reachable-large' command, then clones
the repository to verify the fix works correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5608-clone-2gb.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index 87a8cd9f98..af93302dde 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -49,4 +49,41 @@ test_expect_success 'clone - with worktree, file:// protocol' '
 
 '
 
+test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
+	large_blob_size=$((4*1024*1024*1024+1)) &&
+	git init --bare 4gb-repo &&
+	head_oid=$(test-tool synthesize pack \
+		--reachable-large "$large_blob_size" \
+		4gb-repo/objects/pack/test.pack) &&
+	git -C 4gb-repo index-pack objects/pack/test.pack &&
+	git -C 4gb-repo update-ref refs/heads/main $head_oid &&
+	git -C 4gb-repo symbolic-ref HEAD refs/heads/main
+'
+
+test_expect_success SIZE_T_IS_64BIT 'clone >4GB object via unpack-objects' '
+	# The synthesized pack has five objects, so a large unpack limit keeps
+	# fetch-pack on the unpack-objects path.
+	git -c fetch.unpackLimit=100 clone --bare \
+		"file://$(pwd)/4gb-repo" 4gb-clone-unpack &&
+
+	# Verify the large blob survived the clone by comparing its OID
+	# between source and clone.  We cannot use "cat-file -s" because
+	# object_info.sizep is still unsigned long, which truncates >4GB
+	# sizes on Windows.  OID equality proves content integrity since
+	# the clone already verified checksums via index-pack/unpack-objects.
+	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
+	clone_blob=$(git -C 4gb-clone-unpack rev-parse main^:file) &&
+	test "$source_blob" = "$clone_blob"
+'
+
+test_expect_success SIZE_T_IS_64BIT 'clone with >4GB object via index-pack' '
+	# Force fetch-pack to hand the pack to index-pack instead.
+	git -c fetch.unpackLimit=1 clone --bare \
+		"file://$(pwd)/4gb-repo" 4gb-clone-index &&
+
+	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
+	clone_blob=$(git -C 4gb-clone-index rev-parse main^:file) &&
+	test "$source_blob" = "$clone_blob"
+'
+
 test_done
-- 
gitgitgadget

