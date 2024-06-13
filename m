Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7B13A27E
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310318; cv=none; b=UgRGwx3TdBhzx5EphkOg2imrcbFyVVj60oAMTkfq36i0fGsZTL1ykTP0VZeiOoe9BYgk51rnn1IrZjNNBle5pMhMEG+BNk3DCMiKkhe1pKk2y12H4HBB3udH4faNurVzmCkaBbHdMszoE3WsogGBvNLT16jpEXCDGV4QRJxIbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310318; c=relaxed/simple;
	bh=/U0obEsi5f14h0Xy6+/HcwRIbiQSQeWcG8Mtp0iLwbQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MCPOz/3LaG/FaDgCw+rDT8br0qHcqWy4DySAwEp6yWYEda7TjMZXilO03bkhHvkle/BZt0Ul6pM0EVyql5XxoK8OI9Zw1GvlmE4LJMyaN8OOR8mid4iF/tL52DmsU8sdXu9Gje69XEwQc5q5cy/lVvAswx7db2lxWT581xcTzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgHCmTa3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgHCmTa3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so13327965e9.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310314; x=1718915114; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAuGnwSbBnJA5elepqauAEZFpJHQJdEqOknjIGfEOcI=;
        b=MgHCmTa3DnxNta35Mqk78rnZtJ4qpmzAKzG4w6m13sZsYwTLMmzqU/4ehe7Uet3+0L
         bmMNY1iqN2nZg0Gkip9CIHlpiLzD2ixA9PypnT+mPOCuvzxzrvuxVK1y5cia6UWeoNXj
         KQnNl2EN5GQ/bM9ddcp7Adk/8a5HJnMjpiMkgnAWpqnN7pP8kC5qkhhmyLK7bT39dGCO
         E5POCbPd9OFNat26s21DU7pQsBfYUphOBGvzvWeX7kjB/WMjHFFqrMG3Cfkl98BcdboM
         x35D0qZIfboviMfinoogQw7jX7l31uibB2IvyjndOYW91dhD4osSV4A2I5wB2l1sC+jc
         l4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310314; x=1718915114;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAuGnwSbBnJA5elepqauAEZFpJHQJdEqOknjIGfEOcI=;
        b=ORT6t3u0QIHtFw+jAl2eB3YWQ7/7JOY4ZbJs03yPPmAKhkQajZX4XrrLegmEvLMDh9
         jQyhztLh63dePOIkmqYt/54aVkMSZOql5UBukxk+SlZAVl9vc95cDAA57nVzWaeq6cLw
         qi0DyHXA+SzGRCHXeGP8bPqXWrCgjtScwxaBgGdmRUhktneDrvYMeoaAcB1qyI2+eBxq
         xK7Ee9SPdqT/U8ql6IRC9ltWUBKhsQhyKMW/ExgfYUN3Qon5+4o0ATb8EYEjCYUL7xsC
         WP9SIh9jEV72lkC0i+UI9hE3RXWi2EBjZQFeBOpSijUjR7Sz63TpdWGn4Caey8XNxcH8
         lipw==
X-Gm-Message-State: AOJu0YzcyW22OeYkwxyKndMO9+yh4YdQvDio2hVQK3mSku6bhJOhBkvQ
	V/4BYMATkOnuizLB2B/lHlbZWxySHfjPq1CqOvJ/1zbeDOKz4HcBXkLO6g==
X-Google-Smtp-Source: AGHT+IEQ7Njn0QtFIdJJJjPliJsFy/txo+Ggle7Ok3hSEgAFmwJuA4zkv4KajpQW1O31ADZczJfycQ==
X-Received: by 2002:a05:600c:1c9a:b0:422:6449:1307 with SMTP id 5b1f17b1804b1-4230484f994mr8704635e9.32.1718310314351;
        Thu, 13 Jun 2024 13:25:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73b1sm74396945e9.45.2024.06.13.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:13 -0700 (PDT)
Message-Id: <975fbddf3053d678df5cdfc75521b1be9e2533ce.1718310307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 20:25:05 +0000
Subject: [PATCH 5/7] merge-ort: loosen commented requirements
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The comment above type_short_descriptions claimed that the order had to
match what was found in the conflict_info_and_types enum.  Since
type_short_descriptions uses designated initializers, the order should
not actually matter; I am guessing that positional initializers may have
been under consideration when that comment was added, but the comment
was not updated when designated initializers were chosen.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 39799e65a36..462bc6fb6e1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -553,7 +553,7 @@ enum conflict_and_info_types {
  * Short description of conflict type, relied upon by external tools.
  *
  * We can add more entries, but DO NOT change any of these strings.  Also,
- * Order MUST match conflict_info_and_types.
+ * please ensure the order matches what is used in conflict_info_and_types.
  */
 static const char *type_short_descriptions[] = {
 	/*** "Simple" conflicts and informational messages ***/
-- 
gitgitgadget

