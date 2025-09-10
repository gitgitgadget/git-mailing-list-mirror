Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280EA2D46DF
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531682; cv=none; b=Y+Z6XmlW9Zc32o4QB1jr4ZXibw486CuUYNShhfEn8LaIatlpgTkdkiUqKg4Lhf1iKH4iogHfDyNFXZuq472AKGJM8xlITYLX9iG3QCMYu/R2ZJqvFMQ3G3OE1qvG3gKhkKr38BHcEBpj113j5D3d6vmVcEmbp8RtT8RvjuW7E40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531682; c=relaxed/simple;
	bh=WsrRMwDrHzx6Kc8pGMErNSkVPuzBzEvYm2gPSTgCSC0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IGb/cgPORbYQo0+8GXYClW3iftBQcJz6r1bBcPbe4F+o+xRA9hAj8QjqpXRf3u/N8+IkdOn4+lXDSufJaT2S91M0hlsndUk/yE0bPNSvPjTTRQy3F71JULzDGXRZyf2YMQ4Wn1Orx4U2QF/CTwD6d1APvJKx81fNlqu+9IPh4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJy6wrgK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJy6wrgK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77246079bc9so8339177b3a.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531680; x=1758136480; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUEyqd6EHtNIp9Gj0AG6+jvIsl23q47PYC2QSfsPW+k=;
        b=QJy6wrgK0PVxJjTJdsMU82pmGqKsFdrPi0skcyX5emGC94Fdwhc+I1uTyCKMqc6qyf
         JxJboNmcaxmTWapSUjRO2d6ANIm0PtUfG2mal6LTUeNVeX4z04uh79T3b7yozJXkOEpt
         5f0Nkh/wNqXt+3S/pht4wBjIxCTx/HWn6PaU/crOhn58mU+U4UoPJtB3cis+2ZfQ30yY
         zheJQcQkVzX5zisUx7yEhHEisrxveb9gmuUWgWJpVgG63I9EVVdV3JrmPBqrXLXEgZpE
         GD+DpDpIB2n4tM1ZUsSQrF3LwyxxVKk5IFBjI4QLd2xVESwU+4vtGTo3V2HYfWfBaA/o
         DyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531680; x=1758136480;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUEyqd6EHtNIp9Gj0AG6+jvIsl23q47PYC2QSfsPW+k=;
        b=GedsWxj3jdDWYyPX5YaVcUoYnYxDpSqOhgn52/JlL2psEgSMbaU/BMKXoxkc+qeVHK
         TTcG6gqN25VjrlDZgUzJNezqrx4mlCKCFOUJ0pIevT4zY0Ik72+M303/H8dn8gs/pn+C
         gXsbd5DWHCXMDkmmSoRKBy3XNTfUacNeNlhtFdaRd76eAN/Y66suSX2f1O0TRGmKtYgh
         gpV+AhiG/8yaWeCYEQlOqHo4pII0uiwMUC96FxpaPN2RJygSgiDyYZcdbmLiVN1DcJM7
         MBA50vHNmcWuDDfI1u22nZzsbAnEn60xerWr8VsHmjWIyoyMpakiFR89eNn4rJVcZt8d
         yGqg==
X-Gm-Message-State: AOJu0YwAAYVrqywng0mTvC9wTGU+et49nR5K0r7fl/5pu4NARs/NbWOW
	GHRL8GvkbmIKv5uMkgZFfgtomZ5552F58d6sAXextclaFyW+r0G55SF3JZWp0w==
X-Gm-Gg: ASbGnctOr9LFNx3VV7oHGwcAMxrLZx0Mh2iiHccuN85fdJmHf90nxiAq//96Wuvfrly
	utzvQkz7nZxdsCYe+Fm/s1E4XSzfUkdE01lu9bNWJ66Hs0n44TtOHz6VAKVIkAaD9WK1+6HsFll
	r5/PWAI8rOdxPKSS7IZIlscNEONUgorSbBD/hYNapuEutVZyBIaywaeHpVWP8yOBm9aWoGeQC5Z
	F/EpaCDMTqPvGfdoWPntAC7yvZ7vccnweD5SHQm6tIpAVG68RB8/91cMQ7zngiwU6WNIO8m8pOF
	qCeLCAeb2QEiIb9hfklpxOvHJMNjyBCqlJJtGAaddtHLdx1/8uUQ6jxNBv7flwXyJdSeH9niuoT
	AgJD6v4Wbr5zTluebEMvBL8HKI/M=
X-Google-Smtp-Source: AGHT+IHm1GJmvYoGa57NiFAt1OCOJ7XMMc3vuSHtRt+BAUkk8LUfH1W+wl0FAJ3VU89ifmD9h6o2Ng==
X-Received: by 2002:a05:6a21:328e:b0:24d:d206:699b with SMTP id adf61e73a8af0-2534547a691mr22826531637.41.1757531679951;
        Wed, 10 Sep 2025 12:14:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6b964fsm3322493a12.41.2025.09.10.12.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:14:39 -0700 (PDT)
Message-Id: <7b1e2f265baaa70483c8319793f167f7c91f3930.1757531669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Sep 2025 19:14:28 +0000
Subject: [PATCH v4 6/7] doc: git-checkout: split up restoring files section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: one user mentioned that "When the <tree-ish> (most
often a commit) is not given" is confusing since it starts with a
negative.

Restructuring so that `git checkout main file.txt` and
`git checkout file.txt` are separate items will help us simplify the
sentence structure a lot.

As a bonus, it appears that `-f` actually only applies to one of those
forms, so we can include fewer options, and now the structure of the
DESCRIPTION matches the SYNOPSIS.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index dd3cbb210d..1e19e13a0e 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -12,8 +12,8 @@ git checkout [-q] [-f] [-m] [<branch>]
 git checkout [-q] [-f] [-m] --detach [<branch>]
 git checkout [-q] [-f] [-m] [--detach] <commit>
 git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
-git checkout [-f] <tree-ish> [--] <pathspec>...
-git checkout [-f] <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
+git checkout <tree-ish> [--] <pathspec>...
+git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
 git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
 git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
 git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
@@ -72,14 +72,17 @@ uncommitted changes.
 +
 Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
-`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
-`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
+`git checkout <tree-ish> [--] <pathspec>...`::
+`git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
-	Overwrite the contents of the files that match the pathspec.
-	When the _<tree-ish>_ (most often a commit) is not given,
-	overwrite working tree with the contents in the index.
-	When the _<tree-ish>_ is given, overwrite both the index and
-	the working tree with the contents at the _<tree-ish>_.
+	Overwrite both the index and the working tree with the
+	contents at the _<tree-ish>_ for the files that match the pathspec.
+
+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...`::
+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
+
+	Overwrite working tree with the contents in the index for the files
+	that match the pathspec.
 +
 The index may contain unmerged entries because of a previous failed merge.
 By default, if you try to check out such an entry from the index, the
@@ -90,7 +93,7 @@ using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
 `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
-	This is similar to the previous mode, but lets you use the
+	This is similar to the previous two modes, but lets you use the
 	interactive interface to show the "diff" output and choose which
 	hunks to use in the result.  See below for the description of
 	`--patch` option.
-- 
gitgitgadget

