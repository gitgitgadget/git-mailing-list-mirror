Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5B1F936
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100297; cv=none; b=VQ1jm+QenFF4YGI5nEIvBdArLL4Nu9yJ0YH1OOrtqjAYfAjvWQTaXfi0MmcgiyPugHPEicNX7rEAP8bObEYnnWchlkP+mPBD6cgfos5NNBAXwTKDbgw2/3LGkv3GMLdjLX3FT+IEeDmNL3YBPORyLFlZoB+jJ6X4UHAUFe5LFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100297; c=relaxed/simple;
	bh=cGcdCB7hlVZ8OEj80QAB00wTHWaPSK8jAwzw6WVl3ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8/8fvL2QwzX/V9ZUlNPvKIpH27uX4OW+H27DKV6yfulNScwr36MvyfQYiQ+7Ks57vd7tofg4a/jtD95+PmyQ1fmf9DpRphHVztnsm51Gr+IYHJZSU8O2z6aanBPaiL+ilxQOMDm15Jgw4ADnhMlSieKf2JHPpA/PlaEkZgA1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXboHn10; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXboHn10"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78682bab930so172537b3.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762100294; x=1762705094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5MrPiIq8cPivNEmy/9wlvBaIvONyPneIk3YhMmZoZ0=;
        b=IXboHn10UTlk/ClygUtJPvX3CNgpl2mqd3O3bCbeDtC8vOvSJiB0iPpWqlR2n51ZYc
         ualAis7lFvoVjtkpYVW6kORHAHOL4zobKAVwdeXIudbSsGpMFjECz5EkeKpmC3ZjMZ6b
         JPm1jHvqPaeyoCf27ACxdjM45uBHgXPngdmktIRb3yLYQ7pXOl8oo4l5arBuVj14Z5Wz
         ZkT07nJWUVTrxrlYVKCIPAQmSpKzw6VSO1nRGdUQMazI9gYh4WN1GELy2kfPhD0FjWtS
         2VJukVyDn0MKgn6iROvENFv89vAWkKI4AhVB8EifuB3CGv4WYYpTwUMmwDVYGXn1NATy
         rEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100294; x=1762705094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5MrPiIq8cPivNEmy/9wlvBaIvONyPneIk3YhMmZoZ0=;
        b=lcoLIpvMhaHU1krTtePTTIOeyLc6CSyMrp80SKmmNj2SEN+Bu8PxKnPXXkmnxFucl2
         dhrcPJvE974xwUB8GXYJOsmtTrhcwg6m4e+PyzA3BfKhbVEHnscseN07jw7qLvwfQ7Aa
         I+HLVEEZyU1rNux0wC+otjEZDZMQJV7nSwfyIKwkf4z/1VEmi69wnKs+CL/l6VNbFjEn
         vFfmPEzhxRCqC9d+tf37b/aFJ1VO7wWo6S7U9wkgnzNkJCvhOo6Cqanb8m8V6/zUP0io
         5lYgguhPYVLnCUlNrvZpybWqBstRzdJddW3uiPTf+MeOLFmw1CT2s4FfeM5JCWIxT3sJ
         IJeA==
X-Gm-Message-State: AOJu0YyY5jtcoUNZOyzNiC8mLB9fB2egPatvRrWWCUfb6EOHb/z1jMfI
	yJELIlg6V26DMq8T1TyaF0cko7/MNjBr1llwYdmqBeTATm9H0WbWl2b6aj9mtHIm
X-Gm-Gg: ASbGnctmWiri9LOiTr31yU0Y/O3fBO2/h9P/e03LIY2+SQRhl9TOgGyPLyByIYmvgTu
	nYVxp/sbesyqSOCXgL8bQo7VPYzV/lQdrgiarDiUqoUmXiZpSfDYCgX+s4MuxTiNgE8rVFVbuFq
	W5BjutAihZaPzvwG8ULzlXvhczNpP0HMu1UxN2cC/1Zrzqm0CJ4ZuYxPCnVJ3NvH4Zvc/VJ/MBh
	WIzdS3PRDzbPwsOq+ckKDOFzelnwVnVdr0hvi4YMVX/MC7oVmQM3YXhWlVfotkTaVKlmom0zM03
	tnQoJLFxrd7f7ptUra8CS1ypYxQkdTajVrEkdYNVGYLKqHSIAZLzc9Epr3IsQ/wGKnN648KQY6D
	5L8DCKZPCPuRYVZxYYRZFO6RtuK7vzaNoJbwKZhNI7DN/gCCFC+keulDGrsYU56nsqKxZq07+y2
	7IVzTW4bR9/BWHZ9iJTSdUxwF3DG3XymtFsDOySw==
X-Google-Smtp-Source: AGHT+IEEDYtzC390/cNiZC33DkhxcNU28LUKhpOmqng689JzQ0Zv3FT+VmKT4XxBoMBC3DPrwd33aA==
X-Received: by 2002:a05:690c:7088:b0:784:9364:3cc0 with SMTP id 00721157ae682-786470d33f5mr95408317b3.13.1762100294100;
        Sun, 02 Nov 2025 08:18:14 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90a8:8b00:c038:e715:f394:297e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c6185c5sm22626967b3.32.2025.11.02.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 08:18:12 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] parseopt: fix :(optional) at command line to only ignore missing files
Date: Sun,  2 Nov 2025 11:17:44 -0500
Message-ID: <9ec696eaac647aa01466b101129da2b12ef5dbd5.1762100242.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1762100242.git.ben.knoble+github@gmail.com>
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the configuration option magic, the parseopt code also ignores
empty files: compare implementations from ccfcaf399f (parseopt: values
of pathname type can be prefixed with :(optional), 2025-09-28) and
749d6d166d (config: values of pathname type can be prefixed with
:(optional), 2025-09-28).

Unify the 2 by not ignoring empty files, which is less surprising and
the intended semantics from the first patch for config.

Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 5933468c19..6211b55a83 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -226,7 +226,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		if (!value)
 			is_optional = 0;
 		value = fix_filename(p->prefix, value);
-		if (is_optional && is_empty_or_missing_file(value)) {
+		if (is_optional && is_missing_file(value)) {
 			free((char *)value);
 		} else {
 			FREE_AND_NULL(*(char **)opt->value);
-- 
2.48.1

