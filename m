Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6AA26A1DA
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945547; cv=none; b=uwSexG5P6AantWuKwPQpAbIqb65vFt40KQE4K7iVGxxD9v410KxZ6fRHNT8k9PfMR2/nBfJIwMCNvetCHmEw0zykq0KLaaBZDSzt5XzUhTPLSdFxystPlUvBDRoZsA7t3+lKqmmfD8n3ugIuByxq7RT00SjvlEoI5OoEANjs8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945547; c=relaxed/simple;
	bh=vvk9ntWeQNtdrMdNOofVne2jExdehtMKyWCjUK9OW/E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WfP5mTDh9ZLRBSOyL2G3w3SdiJUAYOHGC+1bgNr9OMIfbXOnmTJX6NxWQUeQscEhBWHlO3RirS4u4oYQnU2wTzXJZc0ErhM4zhZdsmWHcZ1uhhwaRNtvFung9Ptza34tqWL5DRx+ol+dynoUmlc/dC+At8VkJlrxGHyBbKh6IVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buuSy1mG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buuSy1mG"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913d45a148so5031164f8f.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945544; x=1743550344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N68L1TkrReIgM3ZQq6pPf0NhGCdwRZzpEY5tSQYZ+I4=;
        b=buuSy1mGhBbjW8VC5cipzBcnMKZpYRwkvE49HjJ+MkbziQJLYxEEDJjkgSa4/CaxiO
         qhFaDyniCSM8E+XVVNZqZCY93jdFgHtWTS9uGRHiVwkOGSUDOFkuMTw7sDBTGSmL3zc7
         zXeR8cMIRfw7hPs4XKX5gA1ByKpkw6plZg6bRpF0t7/+6UNw7GKeYIhK9ukWdKnW1P28
         hckWYAtthC4YEWso//1ZlBp1xExqlO5NIstGwfZPK7my4vFEdHrZ90Ufnaff5R+aluPd
         OF9SkYTgEzB1ACOsGYWkmCridqHPtrgrhemmSFvcF9qT/Ijp80xYoF6fA9qqzB3TFMf0
         3kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945544; x=1743550344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N68L1TkrReIgM3ZQq6pPf0NhGCdwRZzpEY5tSQYZ+I4=;
        b=lSJXSuZK+oZLhtbblCtoF+qcmWQo+VsvgCL8zI8Yz7EUDRjkqvw8CYp26oZj7uJOE+
         JEuYFmfBswBVk0E4Um19iiO2jr5x9BQjhpoGqCaFp7FSCm7HdCK8KPpGL6eeK+03LBea
         BfGUtdwNZjWQ9/ADNYYVZ4wLHZmPFGm1nWzZaAogUoGS88WpHLtRB+lPuh3qT9h5TR89
         XsLBiAPS3Ev5kdPd1stQlt0zf5NpgtkuloWIGfHiiiJ0ekoQ89xVF5qSP00Ielswv81H
         mmDqsQREuRcwk9FpWEVEP40xvaWxKyyYECr1iAE6kBZWayk86MnLCgb820t3zkNXUrq6
         naoA==
X-Gm-Message-State: AOJu0YyMMGydyrEumUNkTtCDHmcham95BWCILDrWf5HNJp1UpZY+LtTr
	h5TMwWS1YZqJLGiKHyOgWfjA++S/AWakGQ9bu9EA3xN+coJcj9le3Z+y0A==
X-Gm-Gg: ASbGncvafHG9QndRLve2jwtaK9QTgfGCC+n9oY2W0TD42BvRCApAyrFOy//RgsEFIFD
	rOTOXPPn9jvKBRSP9GnOzmBxoOA7ehC8upKoa1qQ4rCq58YTYou0zDpDkZ3/yF2h4DQUTd/W8Kc
	/EsKmxhSxdw5CtEN3KWMXrVlztptCcx8B8iLs6OCkPD5qRMfzAz2opJHJSdsGXnT+LZYbudcrb/
	BnmZolVjKEk4ZUKE0qBCDep9xBq/6qWEydXac5EypnVAF5nq4v5UpYBulWHtJWOqsWhFqgKQ9+F
	yDhuioDDH5ODOz38D8ILWafh3vzbUa6fL6xrSGkKmSY8lQ==
X-Google-Smtp-Source: AGHT+IFG/EB8a+WXPOdra3p9t3wCf/I9vi8GXPRgmczQAXZhC4PQvLDNsBnBBrxJ0YWCMaPqkBhcvA==
X-Received: by 2002:adf:9c88:0:b0:39a:ca05:54a9 with SMTP id ffacd0b85a97d-39aca0554c5mr2697663f8f.29.1742945543556;
        Tue, 25 Mar 2025 16:32:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b4bsm14870922f8f.25.2025.03.25.16.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:22 -0700 (PDT)
Message-Id: <dc626f36df34df4897289e508dbf608512a93870.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:12 +0000
Subject: [PATCH v2 08/10] compat/regex: explicitly mark intentional use of the
 comma operator
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. That is why the
`-Wcomma` option of clang was introduced: To identify unintentional uses
of the comma operator.

In the `compat/regex/` code, the comma operator is used twice, once to
avoid surrounding two conditional statements with curly brackets, the
other one to increment two counters simultaneously in a `do ... while`
condition.

The first one is replaced with a proper conditional block, surrounded by
curly brackets.

The second one would be harder to replace because the loop contains two
`continue`s. Therefore, the second one is marked as intentional by
casting the value-to-discard to `void`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/regex/regex_internal.c | 7 ++++---
 compat/regex/regexec.c        | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index ec5cc5d2dd1..7672583bf7e 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1231,9 +1231,10 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
   for (sbase = dest->nelem + 2 * src->nelem,
        is = src->nelem - 1, id = dest->nelem - 1; is >= 0 && id >= 0; )
     {
-      if (dest->elems[id] == src->elems[is])
-	is--, id--;
-      else if (dest->elems[id] < src->elems[is])
+      if (dest->elems[id] == src->elems[is]) {
+	is--;
+	id--;
+      } else if (dest->elems[id] < src->elems[is])
 	dest->elems[--sbase] = src->elems[is--];
       else /* if (dest->elems[id] > src->elems[is]) */
 	--id;
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 2eeec82f407..c08f1bbe1f5 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -2210,7 +2210,7 @@ sift_states_bkref (const re_match_context_t *mctx, re_sift_context_t *sctx,
 	  /* mctx->bkref_ents may have changed, reload the pointer.  */
 	  entry = mctx->bkref_ents + enabled_idx;
 	}
-      while (enabled_idx++, entry++->more);
+      while ((void)enabled_idx++, entry++->more);
     }
   err = REG_NOERROR;
  free_return:
-- 
gitgitgadget

