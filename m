Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49A2765D1
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715202; cv=none; b=FzwTDtY4cFfehCY0nvG60HU/4a8WyAsZPY0KLF1RhI9uK4HRx91t1DX5xQXislfHZ1mwqXGYgBTLzwYoprSokEBzSTxAtSQYnXxbuEcb2MENBOfH7vgoM00MG/kTtu/gKT5TiXfyIrgPrv/Lof16gnqsCt8pK3I/KNdCXP5rqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715202; c=relaxed/simple;
	bh=wry0tqlchA2oxS0GS9u0QoQjgN97qFm4SWD2dD52cCk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EvJBqXOU6OzxkCbuXn5bGHS0DhCRhvcqdobwNtCw2HPTOoeHirtWltb7XjnmOSZPKdVoPyCy0v3ZWX/U1i31J5NhURlMR3O5k078RBuY1Qi+Td3NpyJpnYY8U2f2lXWSu0ESX6rub+BWPc1HGAB18BAD8qPaqAbMQdh6Dqh3yco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3WBh/X5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3WBh/X5"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso137198f8f.3
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755715199; x=1756319999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ22ZDgr0sVNWv9fKx0q0HB+j1C4XSY5/y+C4c8vZaE=;
        b=k3WBh/X5nfZ1O0wmPfLSXgO/H60P+TBkw9v4glNcA7Klljn2HYJ0kUf4KL4tlfOtkr
         fM1aWG4el0rRu2u6kxjIqdcekFqoG8Jlt9FyPhhTmQXkT4PaFBp4aKaVDHgW1Q9wzbGw
         TMrGs3u0GwD44cb2OFa1q8EgDA6NJ1oJZU+HipDWHNUIoYlTTvLK01PTK+HSvRFeOKz/
         ZaM6XgWQmLKa8rdXAehO2AYJHJY79Hi+ewBUT5sqgl6ZfHCC+xIQyXDsxB0hEfnxDq+F
         4kJZ5tVAwgOm5mc3mS9gWmFBP/0xlaYhZXBsQDJK1NjXB4wqQl/GnvVBNnPR8ouuAOeY
         hVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755715199; x=1756319999;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ22ZDgr0sVNWv9fKx0q0HB+j1C4XSY5/y+C4c8vZaE=;
        b=ar4/U45mshOXQfEeTO1zzjD4dI6DYbZ6G5e/Ta8r+8hzahYmk/WFs+zHXA1p0WiO/2
         /kEx1DTwpUcwLLoOqvHic4+wHL9H2XYo1ZvbHPv7qeHOEdWPGYqZshegNGcvJVfQpDUa
         xL9EDY6rqIGzK2srJ5WIBlDP7ZBPNKxPlKoxmC0DtwVeeXF40JfMBoQOzzzmtmTaoee9
         YUQr21MWzkExjttZoJZFj14+ILPC4ulYx6/tjyVUrqN3Ap1EcBi59y4JtvdZ5Kz8VhNN
         fU1TmvpBNi2cxVDskok0rI1cm0VZOoSxdgVMyn6sRtcbviLRzjkklaDib/tqpgsW5N2s
         fylA==
X-Gm-Message-State: AOJu0Yzw4ZZycwFaXaEOcBYcHDEv/DZ0P1RHuy6zm/v8/cdMYGHrwfhB
	DXxs0aSNFczRieG9QsmF3VYhZd3S79KvVVquf6kSBkL+JdjGrGzBe3Ool7gPWg==
X-Gm-Gg: ASbGncu0pcX3eDTDCfA1kJw+7shvMWd8vqb+sYEq1LaYWjNWJ/vC3LYiVD4sPkwlH3q
	0+Hg2Rd7K6ti0GFmzTMlZvqMm3rFSoo9ion0WgGpR7vu3B52asErG+IM+fQwrCaTzcqqVMLR4hc
	s8J/HEAcl2GW3zD1oPVxnt6X/TvQzUMP39Jh0f+FVH8jKRTWZY9tCUlIczaXR91hBcDlmN9FgYR
	x5wuumdiMsWFi2+xWxB7bCb2PEMA0eRCZrosn/S7AsdYZ/0oXEQeeLm5Pqwn5eSz++HxpQ5/k2q
	9lC94WxpjNszt1jPg6i7hflNCCoi0BB9KGSNl9L39QtUijT2ctQlMM8bpDh5ulWoCv6o6gfGy4i
	tYlwK3t/OaKAjCA9o1slwf2NaiR9/0JPMf2Xy8g==
X-Google-Smtp-Source: AGHT+IEXcJxN/LghDwO7rije5k7Q7oajCuE824beVpF9fFDppRI5bIIXj/VbnA8iWvYVVKjeMoFdTw==
X-Received: by 2002:a05:6000:2308:b0:3b8:ffd2:22ca with SMTP id ffacd0b85a97d-3c32e134089mr2778585f8f.40.1755715198710;
        Wed, 20 Aug 2025 11:39:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074879864sm8892148f8f.13.2025.08.20.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:39:58 -0700 (PDT)
Message-Id: <5b19173c03da676b3e1effda7ba6d2ef5666cad6.1755715196.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 Aug 2025 18:39:54 +0000
Subject: [PATCH 1/3] t7700: add failing --path-walk test
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Users reported an issue where objects were missing from their local
enlistments after a full repack using 'git repack -adf --path-walk'.
This was alarming, but took a while to create a reproducer.

The root cause is that certain objects existed in the index and had no
second versions. These objects are usually blobs, though trees can be
included if a cache-tree exists. The issue is that the revision walk
adds these objects to the "pending" list and the path-walk API forgets
to mark the lists it creates at this point as "maybe_interesting". If
these paths only ever have a single version in the history of the repo
(including the current staged version) then the parent directory never
tries to add a new object to the list and mark the list as
"maybe_interesting". Thus, when walking the list later, the group is
skipped as it is expected that no objects are interesting. This happens
even when there are actually no UNINTERESTING objects at all! This is
based on the optimization enabled by the pack.useSparse=true config
option, which is the default.

Thus, we create a test case that demonstrates the many cases of this
issue for reproducibility:

 1. File a/b/c has only one committed version.
 2. Files a/i and x/y only exists as staged changes.
 3. Tree x/ only exists in the cache-tree.

After performing a non-path-walk repack to force all loose objects into
packfiles, run a --path-walk repack followed by 'git fsck'. This fsck is
what fails with the following errors:

  error: invalid object 100644 f2e41136... for 'a/b/c'

    This is the dropped instance of the single-versioned a/b/c file.

  broken link from    tree cfda31d8...
                to    tree 3f725fcd...

    This is the missing tree for the single-versioned a/b/ directory.

  missing blob 0ddf2bae... (a/i)
  missing blob 975fbec8... (x/y)
  missing blob a60d869d... (file)
  missing blob f2e41136... (a/b/c)

  missing tree 3f725fcd... (a/b/)

  dangling tree 5896d7e... (staged root tree)

Note that since the staged root tree is missing, the fsck output cannot
even report that the staged x/ tree is missing as well.

This bug will be fixed in the next change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t7700-repack.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 611755cc139b..1998d9bf291c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -838,4 +838,47 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
 	test_server_info_missing
 '
 
+test_expect_failure 'pending objects are repacked appropriately' '
+	git init pending &&
+
+	(
+		cd pending &&
+
+		mkdir -p a/b &&
+		echo singleton >file &&
+		echo stuff >a/b/c &&
+		echo more >a/d &&
+		git add file a &&
+		git commit -m "single blobs" &&
+
+		echo d >a/d &&
+		echo e >a/e &&
+		git add a &&
+		git commit -m "more blobs" &&
+
+		# This use of a sparse index helps to force
+		# test that the cache-tree is walked, too.
+		git sparse-checkout set --sparse-index a x &&
+
+		# Just _stage_ the changes.
+		echo f >a/d &&
+		echo h >a/e &&
+		echo i >a/i &&
+		mkdir x &&
+		echo y >x/y &&
+		git add a x &&
+
+		# Bring the loose objects into a packfile to avoid
+		# leftovers in next test. Without this, the loose
+		# objects persist and the test succeeds for other
+		# reasons.
+		git repack -adf &&
+		git fsck &&
+
+		# Test path walk version with pack.useSparse.
+		git -c pack.useSparse=true repack -adf --path-walk &&
+		git fsck
+	)
+'
+
 test_done
-- 
gitgitgadget

