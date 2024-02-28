Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999633987
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113466; cv=none; b=dZ2NJwoQAHOtoDiRJ3za4ozSkeEEq4RyS49BN8jfZEfDjTbYaSkCNjlR5KLbE9oX9CzOeOpEP8ctZD0dCul32TnmuBCJI55pXsGlRJbGjA9jXcFJxx30rkZ9DdhUg+3gf3JnTOCId6SAjeKMBatQAcILQwbeXixbEwe7zMCJiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113466; c=relaxed/simple;
	bh=CIKQ8Bb1sUrqihQ5MJIFUcbno3QB/yb6ILzqtp+yaVo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EUJZ8feY/kHoh59QCquKSdGcYNWEFgMjwZiy0bHQiYX5cLOdQYPXgxU8YGa/m/EU8sbUazINhuoN5Zj1uqfe3BpdSCr4NPX/rkuupyPpPLTccOqTCc6VwfHMosnBIw1UymIkSuJs7K+k+vPcZ1mQGRsjPJlaV5bY/daPizX3nrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3P7VK6a; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3P7VK6a"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33aeb088324so3336482f8f.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113461; x=1709718261; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTSR9XKJE4GOW6G6lNSpqCjAzTbfFv8qkdL27MvMrxQ=;
        b=N3P7VK6a6FYfrYYzaOwHFvK0vL8GR7OfL8t294kC1pS6kdqa6hShHwh7SSPsWrqCEO
         Hmrte0AMvFphcVVLeL2vrdO4aiNJm1FEi/OvKf1DOwr1X/ef+SaTT67/XZNb6YldL/Qw
         L1Chu3dSTZ9VT8n0PtHerk0x7dvyzOzE8GWYKk10ekB4/30IwUdIAMaizWGM7B8M8lnD
         S5D+MEg1AVDgfmU1xJ8pIGStU+kmZ5Z0H/7REcsewNgyUjCBKf+SOFzUooEXBtKU8HgL
         X/kIHSD86N/OMCtIKcsCnobjwy2DYg6HxgNfHlfF3tQixWyn+7li1evZxffD7qkrVzoJ
         ue9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113461; x=1709718261;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTSR9XKJE4GOW6G6lNSpqCjAzTbfFv8qkdL27MvMrxQ=;
        b=jUwP4d/MGK41LL8sxjLdnWMBqn9fOJwULiB202G+7axBLZLWkoxrebQDruzECs6Yig
         N3TIZJCTy1Rd6ytZI6fj5qTP12I2sp39rf9mbUjiBZigNAGR69wFLBwkHXmBgmtiqGak
         ewq+eDm+qmZyOnH5gTs+4Ewb8oYhuK7XNIlROJWMQp6m4Jn63wkos/zKQ/dNDzufXc+S
         7QTAmQP5f8ZjoHpapFGKuVyrorHOcckRkEQUMu6DBY3oOC7iO/NMEi3bEnsKAezbgGXn
         6ny82JUBLgY9bJZQY8mYsGIa+dMktEridROODRuF72uvVRis7seSG4gvFHmQtrqlMVPx
         /eRw==
X-Gm-Message-State: AOJu0YzDChArrbTsGky3kIf2X4/hMu7gKrD3AJbGqU1IFpLSLtD/gT1C
	DmIv4sF0pFq+Kfr/vvbI9gK+lwqsWztMsa9KPYUrZzUEow180Xabt3TQxIPv
X-Google-Smtp-Source: AGHT+IERQaxzaJ17Fw1ABTDYiDS4oc59xewG07391iz1THE0oIrl6ZuShy9cJ5EkRk0X82R25kH3Ww==
X-Received: by 2002:a5d:64cb:0:b0:33d:f89b:147b with SMTP id f11-20020a5d64cb000000b0033df89b147bmr1613611wri.26.1709113461115;
        Wed, 28 Feb 2024 01:44:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3-20020adfed43000000b0033d9ee09b7asm13800868wro.107.2024.02.28.01.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:20 -0800 (PST)
Message-ID: <647fa2ed5c5418d2298672a239b7723912358cd7.1709113458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:07 +0000
Subject: [PATCH v4 01/11] commit-reach(paint_down_to_common): plug two memory
 leaks
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Dirk Gouders <dirk@gouders.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a commit is missing, we return early (currently pretending that no
merge basis could be found in that case). At that stage, it is possible
that a merge base could have been found already, and added to the
`result`, which is now leaked.

The priority queue has a similar issue: There might still be a commit in
that queue.

Let's release both, to address the potential memory leaks.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index a868a575ea1..7ea916f9ebd 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -105,8 +105,11 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (repo_parse_commit(r, p))
+			if (repo_parse_commit(r, p)) {
+				clear_prio_queue(&queue);
+				free_commit_list(result);
 				return NULL;
+			}
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
 		}
-- 
gitgitgadget

