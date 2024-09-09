Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BF1BBBCB
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890218; cv=none; b=QHSciZ9T2/Q/6Elej1paTQDYzjgm6gklIu0QA2Z95c3u+XEb+V+eyogd1XPg/vMimzvDNGEQPKHrzV+i7TlJejRz5J8hQhARBRsGDWF2sqjBCmzLXygH24LIs1svpxODXB40aD0x+LRyNyr1j28pcFyXPDJhn4NOvSEZkDAnzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890218; c=relaxed/simple;
	bh=ZTdGffGQw/6yzjEDsa+fFvN7dJNRjvQoaeBIrQ5Uxag=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UDHDmHueAcM9ACyuOyTaQvJtk5g1Acy0QtohEFlMIssD8J6iBFmzz5gY9/nn1buHC4Fem3slUJH1nn1gtYPiywDPSEFUvfIZOxCKEuxqGmuNOYKPa1EvEknyooR/OYsrNE7tT0ggwUGX8RZMwAE2C5al68irIiKi4XWY5dMe0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZGAYs/0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZGAYs/0"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso7702594e87.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890214; x=1726495014; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzsVBni1hzwxIPcF8nKjotNk3XdDVEZ5QFNKwj56i64=;
        b=YZGAYs/0C4uiDcgU0+Sr/UD3kG2jQIRWU/otZ8L4hLvLmb3TG9RPGY3oBZ8OwVtgd2
         ItPruIetU6rFp+eM8bhr0ch4c5jLZBsn+YVcAN+AXaa2MZoFie0TaOLTX+vBX4Y8RA+O
         kxTEA7mwlIO1xShUOw2I2NvuLkNaI1nZBKExqnQU2C/3bseroL/hlk106JvFN0ODeld5
         f5/bAiqOa5JGlwRISX43M1ceNQpjaDakGWsKG59LE60z/lvMKhSKdP7+bhgyN8igG/PZ
         DjBkxsLci57EJyp4eHkctPfpc46dJ/0CXsjTLTHLrUzpVK6Y+mvGqfxoFQFoSV7sQxiw
         rT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890214; x=1726495014;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzsVBni1hzwxIPcF8nKjotNk3XdDVEZ5QFNKwj56i64=;
        b=nXvNtTZ4cybNd/XHhEFJO4d0CMYz7Fuw7pv7Mabm+8dUSi6u0S/fHaLpKTwN3/0yjc
         bGyYlJJszQBgAjjc/jciYvl+Y1CRp3+vlHQR17G7EZQYB19CylUpf2Z6n9s+C6vSRCWK
         HB+jWreTs/rmDcRa8oyjLGANpiLniycnGsRlZYzzUVCVP4S74mOxTb5P+qwf4MYlKL/z
         MkQYevXvk748UGqmZ9C7TtzdsZHL0SsoH7/Gp/RLfpodv5EJ6JuGQPVi5vkFY0Kk3tYV
         6jpKTesmOcmBcDKe1v68sVJrmYM9lWfA+wNNZ6qdkUtoOmhTYh3ax2k1tv2x64iiEqlm
         HF+g==
X-Gm-Message-State: AOJu0YwUSU4h4hj9H8ZUN8QuHqBuxnpKj+c2TERywZA8FP8hMaCQ9oxS
	bFA3Xn5O0QrtsQJ+b6zqQfbQyC4oEwstIWlfCiFEwRSNdTUO7ldgpvMWXg==
X-Google-Smtp-Source: AGHT+IEjALTE/VTRr907ECzSYVB1/IEDUsqErdpcn0qZnML2zRVuJFTMYEDyAXX6C+XqZOj780HzYg==
X-Received: by 2002:a05:6512:3d89:b0:536:2356:5dce with SMTP id 2adb3069b0e04-53658818beemr10680681e87.58.1725890213789;
        Mon, 09 Sep 2024 06:56:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2582d490sm351696466b.14.2024.09.09.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:56:53 -0700 (PDT)
Message-Id: <eb0aa5f4e94647c12c595964ca1fe1c2020f0642.1725890211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 13:56:48 +0000
Subject: [PATCH 2/4] git-repack: update usage to match docs
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This also adds the '--full-name-hash' option introduced in the previous
change and adds newlines to the synopsis.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.txt | 4 +++-
 builtin/repack.c             | 4 +++-
 t/t0450/txt-help-mismatches  | 1 -
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c902512a9e8..457a793fa89 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,9 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
+	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+	[--write-midx] [--full-name-hash]
 
 DESCRIPTION
 -----------
diff --git a/builtin/repack.c b/builtin/repack.c
index 87d0cd4d2f2..4fa2c25246d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -38,7 +38,9 @@ static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 
 static const char *const git_repack_usage[] = {
-	N_("git repack [<options>]"),
+	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
+	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
+	   "[--write-midx] [--full-name-hash]"),
 	NULL
 };
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 28003f18c92..c4a15fd0cb8 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -45,7 +45,6 @@ rebase
 remote
 remote-ext
 remote-fd
-repack
 reset
 restore
 rev-parse
-- 
gitgitgadget

