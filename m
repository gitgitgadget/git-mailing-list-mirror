Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D448664C
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261073; cv=none; b=QY5tkvRXh2i0J/+Eeo2Nf3arBYWnhnGSZwkbQqSxKVfjJyjSI0tl8UTqoC5BKZLZtEGd+rcN8Xkd3cscTmd0QakbP0e/PZJ1S4gJW79/Lw05r3XbmYdbJr3WpIMlhQ55mJSsM1hVFwDxc1Jm5pi4yj7YaCsf0FxpF55k8ps13Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261073; c=relaxed/simple;
	bh=QVV1qXmYDsmOrS6ffGbBbNuPiIPtmfsTJqae6GZOe2g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c7nGthdsqD9GuuBfzp4zG9cryYR1hKOmvUK1j+I/eZEmK/J1q3mvrk3u76x3fX1wIwz6CnmbkHbWmbSc0ZdhYSpVWsS2a58vE3mzn/EwhemQgbREqowSm8SrMMbgUbjAgbo6SR2gjFPhr56L2wb+mPEYkjPr7m9DayYCzXMnT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIr0R3C/; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIr0R3C/"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so11283435ad.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261071; x=1790865871; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lUtkdsXA7rRHdhupl73KGFXozEtWRZaeJMfUCOypKJw=;
        b=CIr0R3C/Wmk6M1CO+GUzCEsSKrPuCQlm5ucJiXuuZI0V7sIt+hp3p/tJS+eXxlG9eL
         sDWXQTvtco/5RskdwUTqirBR1A9wZkVHTHr9CK6HQqXIpEWuKmYJhJPS75tjr2q7H+b9
         AY0ausG9KK+f4OhLuZrUC1yN3HnDXF78BKbEUL/3LXtp4R/ynaaNvQXU5mzqHmpvREwS
         rooibIPwWDz/63U5/7X4CAsLjMBsS/6zccDYSbE67WU9yULZ64CInnBaBfbSJkH1WH9B
         d9RpAy66C9zcxDzQucG+reZ8OjQCxYotEG/NCFb4axmBtV+LddO0vTiOYd3Ipo0IHOeO
         dzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261071; x=1790865871;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUtkdsXA7rRHdhupl73KGFXozEtWRZaeJMfUCOypKJw=;
        b=0tyticr6H67sjN5u3aiVWIk1aaY9pjuT5R6cpXngItwgVl3JFOL91n1+vDTLEYt0KD
         G78oaM397qdLhVlNAZnaipSeE0cGFfT/QrcaQIWUxZ8Ocm+jSp4SWVBdW5wFLWuBQnG4
         bJGah2epLd/twIPoMeGLe3IC0uSy/GdaWA6EvEWjNPKXm72U6oEs190vj/xAC1SU53IB
         dMyosH5kODXmaWT5UP2oe1ugFq2cqeJhfwVmEslckCSV9c5zfhU7fRwJcKqIufVg4u3K
         AuZTR6kQ52/Xglr1ivNHI7+RiIoaooMe+Eyq+azyffxP4u+1MndZ5QnqL7+QK2v/BRi5
         WrQg==
X-Gm-Message-State: AFuF++lkHdFKEIXMkTciuO0sPsUYB+3hStNGCHXxb3dh2twRk8mSJDvR
	jDtlGyNwu+TKAAcXphy6o6gbbby1jLY2QElVrE9BQ9rkIx/yjE1VZtdw/vWWV2fr
X-Gm-Gg: AYBFou2XD7XlEvhTwTzoTFM8D7xdC+2mOncJus9C6dT99Phou7IpnnC4VzSQcNrzFqZ
	hNlopkJ/T81CdU4gkz9Ed1+ihWi1/j2eqlg5AZBA6M8Lo8PQcMrz3t2BAQvh6Zv+fdGfK8YQEBP
	sbEOyxXayqMIohDRtbiv5KJq+JYvJPuH30kWKKI0WG7xr6bmc/UjyljcUIyu36C4vpEtpCUcYMe
	27u8D7CQdHuA0pkZNczFEEV1h5/RjYJAmHo2dA8X66NkXrPZHTVGhpwAg0zbu3/SIylMMJfYD+F
	5qoldGr3M70pq3Ae/NS2UBEwW2ewphKueJuQs9HpPrY4HwbseWujF0O4DXyC+tW2WUPKqt4Ij4W
	aBy9vqBbTD9G7v8AaCWHywoce7iwoVOiW9l0Ty4YJL0+VOR9afiES3gn6f5G7EndLEVAiF7tVyk
	PB3bXAh5g/YDgcsVV/PkBdEEBg064FsQ2p4F8fNag/B3d/aKN+l/+rElps3Hpl9QcAaPXbzS9s7
	hGPFJnYyGBxtg==
X-Received: by 2002:a17:902:fd8e:b0:2df:84e0:9021 with SMTP id d9443c01a7336-2df84e0985dmr12471945ad.7.1790261070452;
        Thu, 24 Sep 2026 07:44:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c0641sm28841965ad.32.2026.09.24.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:30 -0700 (PDT)
Message-Id: <03a6b43b5803e6bd9ebba1a49c34cb42202a7f44.1790261062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 14:44:20 +0000
Subject: [PATCH 5/7] [doc] git-cherry-pick: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove the discussion of merge conflicts and replace it with a link to
the guide.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-cherry-pick.adoc | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index f4cd8b9db7..d93829600b 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -19,25 +19,9 @@ Given one or more existing commits, apply the change each one
 introduces, recording a new commit for each.  This requires your
 working tree to be clean (no modifications from the HEAD commit).
 
-When it is not obvious how to apply a change, the following
-happens:
-
-1. The current branch and `HEAD` pointer stay at the last commit
-   successfully made.
-2. The `CHERRY_PICK_HEAD` ref is set to point at the commit that
-   introduced the change that is difficult to apply, unless the
-   `--no-commit` option was given.
-3. Paths in which the change applied cleanly are updated both
-   in the index file and in your working tree.
-4. For conflicting paths, the index file records up to three
-   versions, as described in the "TRUE MERGE" section of
-   linkgit:git-merge[1].  The working tree files will include
-   a description of the conflict bracketed by the usual
-   conflict markers `<<<<<<<` and `>>>>>>>`.
-5. No other modifications are made.
-
-See linkgit:git-merge[1] for some hints on resolving such
-conflicts.
+When it is not obvious how to apply a change, there may
+be a merge conflict. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
 
 OPTIONS
 -------
@@ -259,6 +243,7 @@ $ git cherry-pick -Xpatience topic^  <4>
 SEE ALSO
 --------
 linkgit:git-revert[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

