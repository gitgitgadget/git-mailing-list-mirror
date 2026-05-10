Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515A196C7C
	for <git@vger.kernel.org>; Sun, 10 May 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778452280; cv=none; b=s5kzFqQV3OUTM/l0ieXRVSBFnan7NwbDXFiRdfmqQq82rQB9aBNh/OsTcx67zENNctpamKrkpp0J/cN1vjs2Y8LhiZQ8Lz0CE73M9JiGjankCpkFA3Hw8/dg9eHnnsGTh26iTYU0OMqG6oqXcGK1nDbFc1tGd5nwhUu7ouIDdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778452280; c=relaxed/simple;
	bh=vPyaQ8cKbxmY5hd5rAzD6jnR+XRcgKi2KdXQeKeUrQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=u/Lkvp6sh7sKsvE8klyeglt+kI8EbQt1OdnaiojBch2nuiFC8lQ3+NeL54/52fa04lzg2LnCTBpMZbRAerFYLZKwONXG3MaPZr02F7dE14BXCk1dxLBCqDxyjXn5ZWrjTBTTa1Bu30E9HViMn3M+slZOG1mz+H89SBp6yWQ+EBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYKYDplt; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYKYDplt"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso33878366d6.2
        for <git@vger.kernel.org>; Sun, 10 May 2026 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778452278; x=1779057078; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0QZCs9oiCIxlfkhptonpD/kSgIIda9eFd+TrtrGBfM=;
        b=jYKYDpltaNBKbnaaO/wU7TvpVn99q+TGJmqeLfIsODJpA1QxSmOA7U6O/FoBhNTeqj
         gtv+6mpqS87emR4oHA6ZDO/01SB72m/ukW90BV4DOaYp9C2yfl596B0hWVakQOoGHWkk
         8M6TPGYrj5jSqmqmjPP58UWQfmiIxIEso/mmlFj1cmjUvaRyEf1ofB5UiEQGBHIJNjVj
         e+rBXLVwyTAubjXcF0bp+hx2rJej4utj7RgRHmoiZqFXQ7PnIv9pd3OLMFdte1w5H40Y
         n0eZ+ox97suWJM2s5hxhiFBgu9Nk8u/wm0bNSMCVbwCakhFhCQrUAnFCK5QvClA+vfy7
         2r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778452278; x=1779057078;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d0QZCs9oiCIxlfkhptonpD/kSgIIda9eFd+TrtrGBfM=;
        b=pvVjaXVwzCHkNSxerMJRosRCs4rsSMarLP//KRzVSrc/37G5wfm4CKS1Wpba7xKjt3
         W5t/LGC/1FOP7sMQJGocj6xgORnsGk4GeSymSFJfuG3LHG5uCKDX5Kr+Kb7BywwvJ4Sy
         vwwHIMAA3MGJqlMySgHuGjVHPy1OdEYAWQYRtgWehhV2Kc4kqRKFueRWGeRrQkm6efob
         /Un2bTIwcuoCORVzzmgLX3v2SiF80RN8iF3/bb+bHfXF+T07dr4MvlDe3Kv9E395bGRh
         YiKPJHsAWT4OHsTs3Q1lpPh8h2qdIePIxciTfMzxx5pZ1GOcPqfAeVx9s+5q1LKnonhx
         03og==
X-Gm-Message-State: AOJu0YwQpuXQ7WDMZCyvPqYeu04m5VPnDgIATmeHnXjER5ZuPATULAZF
	zZtqQ9T9CLyFrLLwVGTzYa17o5qANyXn6xlE7cktFM+A6QdBgfwIT7M24XdJAKsq
X-Gm-Gg: Acq92OHvTgBQ+Kkd7/h6SFuuBHAkbcgM8T5kxwbnFTNmXueBsG4iMv90XW0Q5f916u6
	eL1OxuDprVSAuJE+Fsl1uz5T8R2XM8sOBSbVvsos6o+P5CsHQJI5OYCxvUGV+xTr1OZygZkequE
	J0REBr88q/SUayCPz5jO6c84LQ6SJwy/05PxdFCr7z8dddQArUv858t4icNBT9h3+wHm2LwuiqA
	vbOrfcJQx1ovS8slAnX9u33YsTSo3qMRUvv0KAAAkpVlDZ2iA1k6XcsF2Nm3+WwnnTu0DUpDxBs
	iJCguHNvNVnNs6Uza5QSv4CPVwy6HxuLdplVQYtbCTCBJZwddC0n6Mze54VKY/9R3tFxa8SvBpN
	2uH7am2XUhsmJYRL50lakpF8WqPZFr+I8JLTBV3kh9mV2m+bwhaybn10LtY4qiHaS00tPs4bP2X
	YGVDhKjRbEAaQxYOVcDvaTwOevn1aZImWGWrg+KLxQwhEZCu457VXpxZKcsCc/+w2DvMcfSwpwH
	ojYo6MXCIGYIpqyk7WdqfVBd45G/WVuhjmqZ8e67dpvu7qYiNOOTKhx7rVaIE3yRXc0HeBGPz7e
	mucTzo/gDuTF96lI13MjT07LNFJMfH1dxhVnAthLdqs2p7ONBMdpVsQPLBBfnYNR
X-Received: by 2002:a05:6214:19c6:b0:8ae:62aa:665a with SMTP id 6a1803df08f44-8bc442dbca6mr351396956d6.28.1778452278317;
        Sun, 10 May 2026 15:31:18 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:456a:8ccf:9ca:b527])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3aed1fe1sm78141496d6.8.2026.05.10.15.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 15:31:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 May 2026 18:31:14 -0400
Subject: [PATCH v3] doc: clarify --follow and log.follow for git log
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Nyw7CIBQFf8WwFgP0QXTlfxgXhd62GMo10KKm6
 b8LdeNOl5OcM7OQAN5AIKfdQjxEEwy6BMV+R/TQuB6oaRMTwUTNKiZpi3oewU3UYk8d0g6txQe
 VQhdFq3nFuCTpfPfQmecmvlw/HGZ1Az1lW14MJkzoX1s58rz7GYmcclrWGpgojwxUc+7HxtiDx
 pHkSBT/aUTSAEillYKai+5bs67rG6xjffwVAQAA
X-Change-ID: 20260507-document-log-no-follow-72c33dc15017
In-Reply-To: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
References: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
To: git@vger.kernel.org
Cc: =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
 Junio C Hamano <gitster@pobox.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1778452277; l=4091;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=vPyaQ8cKbxmY5hd5rAzD6jnR+XRcgKi2KdXQeKeUrQ0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKTqt4msfgh5JWpt1JHnVfdZDPo9wNfcGAyPQqaprdz+g/0t8YNJiXMtUfb30CDWrZmers0DsYr
 yyblyfviGCQ4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The --no-follow option was added by aebbcf5797 (diff: accept --no-follow
option, 2012-09-21), but git-log(1) only documents the positive --follow
form.

Later, 076c98372e (log: add "log.follow" configuration variable,
2015-07-07) taught git log to act as if --follow were given when
log.follow is true and there is a single pathspec, with --no-follow
overriding that default. 1e9250b5aa (diff-parseopt: convert
--[no-]follow, 2019-03-05) preserved the negated form while moving the
option to parse-options.

Document --no-follow alongside --follow. While here, make explicit that
--follow is accepted only with a single pathspec but follows only file
renames. A directory pathspec uses the same traversal mode and can show
a different set of commits, but directory renames are not followed.
Mention the override in the log.follow documentation.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Retitle the patch to avoid the awkward `doc: git-log:` subject.
- List `--no-follow` before `--follow`.
- Clarify that `--follow` follows a single file across renames, even
  though the option is accepted with exactly one pathspec.
- Document the directory-pathspec case: directory renames are not
  followed, but `--follow` still uses file-follow traversal, disabling
  normal pathspec pruning and possibly changing which commits,
  especially merges, are shown.
- Link to v2: https://patch.msgid.link/20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com

Changes in v2:
- Document --follow as limited to a single pathspec, not a single file.
- Adjust the log.follow documentation to use the same wording.
- Link to v1: https://patch.msgid.link/20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com
---
 Documentation/config/log.adoc |  9 ++++++---
 Documentation/git-log.adoc    | 11 +++++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f20cc25cd7..ba9872e98a 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -52,9 +52,12 @@ This is the same as the `--decorate` option of the `git log`.
 
 `log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
+	a single pathspec is given.  This has the same limitations as
+	`--follow`, i.e. it cannot be used with multiple pathspecs and does not
+	work well on non-linear history.  When the pathspec names a directory,
+	Git does not follow directory renames, but it still uses the same
+	traversal mode as for file rename following; see `--follow` in
+	linkgit:git-log[1].  This can be overridden by `--no-follow`.
 
 `log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index e304739c5e..0fb3279d19 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -27,9 +27,16 @@ each commit introduces are shown.
 OPTIONS
 -------
 
+`--no-follow`::
 `--follow`::
-	Continue listing the history of a file beyond renames
-	(works only for a single file).
+	Continue listing the history of a single file beyond renames.
+	This option works only when exactly one pathspec is given.  If the
+	pathspec names a directory, Git does not follow directory renames,
+	but it still uses the same traversal mode as for file rename
+	following, which disables the usual pathspec pruning and can change
+	which commits, especially merges, are shown.  `--no-follow`
+	disables this behavior, including when it was enabled by the
+	`log.follow` configuration variable.
 
 `--no-decorate`::
 `--decorate[=(short|full|auto|no)]`::

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260507-document-log-no-follow-72c33dc15017

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

