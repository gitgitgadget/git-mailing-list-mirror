Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793971B3925
	for <git@vger.kernel.org>; Fri,  2 May 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213557; cv=none; b=ZsAyvZnMQxjHsDyfTq17cdEpFZfMDcLkQZTJxChbq0pjMk2k0esFI19A8V7oKG7pY3COIkWmzpUJ7hQdGkIe4HMCnpdR1EsRa1SSEYmjxsoyodI2A/0r7PFUPnegzqf1CX9KKpYr0bnKXelPGtnQdmYBNUMQI95GlRMLOvQgzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213557; c=relaxed/simple;
	bh=/45QhP2STHt+Z6v3P14LVV1y5gwonq4aGT2kBZlrPYE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VOKQKqGvDlU5J+zT72JzDlUFlXNsK0I8HjY3xl3TLTIdW+R2OJ60Agf/sRcmWjnu8FaM0+5DDYUw7gBy+3s1zkDdE/kNMdG08OzyX4jlR8BIRK3xw7H6Zb5vcQLH7IGhD9ON3/ZqGYjur//mBBdFFuM4dA2RNDUX2lzM6fiShfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW8NJyTZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW8NJyTZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso15088595e9.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746213553; x=1746818353; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPjmTkKaX7EDdTLbb/cqOeXWtFpi/Z1POBQAUaFg8Xw=;
        b=fW8NJyTZFRbvw6I3ODuIk7Zpo0M69t2G2hzUDHAO3P/gopqHYdPNUTl966GKDUL4kl
         gbTnGkuuozUSGugOf9lK5XdGuMo1c2suG6dxI8EqI73m51xaOfO68Auk93DmGJEdGaYC
         jUUCPEU57rOBxZh60eplr1rFc1BKHZw+V5eeX8m7OQ/ZUOUNFwa3B2jJHX5ujdEiQP7/
         QYeTRzgrW7o4PJGrb9QNdioQFKjuHkPIIgA9DsFkWtMEZJtqc1nyBM3kUrb0nMJO7rIe
         ynPYu4mqAaX+masJbiksKw7he2dnCcZpLUaoQePIubgyOaMzWedeK2LZqToW3uCwqlky
         up7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746213553; x=1746818353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPjmTkKaX7EDdTLbb/cqOeXWtFpi/Z1POBQAUaFg8Xw=;
        b=Tjb7A+pxpBSCeXeuG41DakRvlj1gz7UBuPdJkfvsRtE6VB/UbubgRkf95Zlg8ClrnP
         Xmis8GKpXlaRMJYxrBwZBdPU2/Hxk8tl/vIWKxQDlFJLY49qP5bdUnhs01DhCvIwezH9
         ZcHafv6wpkwwbhaSBuMXazZWRvXTDI8KQNxujLPmSgsk5zSNUekqR40FogfTk1PMIlJM
         vmA3rnN1LgQOw4zjKYHAYK4lCRWN2aNETDFqWDNAptJ76xPYNtPLLxXVQossVxsAzgpu
         SuDxwsmhRBEGQge3Op7jF5IblUPSREMvuV5C/InIRN72Ad3LhH/ja8Q2q3kFoa+3mu+j
         jmiA==
X-Gm-Message-State: AOJu0YxveTaRCQIcBw4/z+92oQZtzkRTLTZ9QUg17pb0Lmys9v15yCGQ
	8rlJQcZMOmhAzBWwbSkDReR6SaaS2LCV3o92VFqAWU97K4f1HCsH1cTX2w==
X-Gm-Gg: ASbGncur0ZUOwoY0CkwDoAQeRrj81oK3DgPdBvGwbbdftWGmYLB/LrUtmMUYwlV7rjm
	LeqRmPKqdVLQ17XuHgha70n4N+/9u3Xs9cbfEtkJimCQYPhXJDjTnXVugfdLTdTxw+/NsJQUmD4
	/gnwLf50yZMjphq1wHoT1LD2jYySlLWl6RNUYYCf37YRhMdVOEWb0tNTB2JlzLCg80HpgjNLHCO
	mwSKpN2k1as823OB76qLX4wX7I2OAdjtc4++vSsTpHQ3UEe7vDHinsiIsiPltRa4atorrYXv6G1
	Wzg0HqRKAo1uDI+OIeMcUjeJZn9oMe+D5ppnpLt6qA==
X-Google-Smtp-Source: AGHT+IG2hARFlP4GwLbwoLmCJG051j+SfepiucJRbd7+pOZ2qbZXPAPp71qHISCSA72l4L1TExox9w==
X-Received: by 2002:a05:600c:1c1c:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-441bbf34170mr32297345e9.23.1746213553140;
        Fri, 02 May 2025 12:19:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d1636sm52744455e9.13.2025.05.02.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 12:19:12 -0700 (PDT)
Message-Id: <pull.1912.v2.git.1746213551473.gitgitgadget@gmail.com>
In-Reply-To: <pull.1912.git.1745941503913.gitgitgadget@gmail.com>
References: <pull.1912.git.1745941503913.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 May 2025 19:19:11 +0000
Subject: [PATCH v2] tree-walk.h: fix incorrect API comment
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

When commit 50ddb089ff68 (tree-walk.c: remove the_repo from
get_tree_entry(), 2019-06-27) added an extra parameter to
get_tree_entry(), it did not fix the ordering comment about the meaning
of the parameters.  Rather than just changing "third"->"fourth" and
"fourth"->"fifth", give the paramemters meaningful names (or actually,
just take the existing names from the get_tree_entry() definition in the
tree-walk.c file) and while at it, tweak the rest of the description to
incorporate the other parameter names as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    tree-walk.h: fix incorrect API comment
    
    Changes since v1:
    
     * Updated the documentation to explain that oid and mode are output
       parameters, and slightly tweaked the description further.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1912%2Fnewren%2Ffix-tree-walk-api-comment-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1912/newren/fix-tree-walk-api-comment-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1912

Range-diff vs v1:

 1:  6375bc7d351 ! 1:  a47aceb6394 tree-walk.h: fix incorrect API comment
     @@ Commit message
          of the parameters.  Rather than just changing "third"->"fourth" and
          "fourth"->"fifth", give the paramemters meaningful names (or actually,
          just take the existing names from the get_tree_entry() definition in the
     -    tree-walk.c file) and strike the comment.
     +    tree-walk.c file) and while at it, tweak the rest of the description to
     +    incorporate the other parameter names as well.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## tree-walk.h ##
      @@ tree-walk.h: struct traverse_info {
     + };
       
       /**
     -  * Find an entry in a tree given a pathname and the sha1 of a tree to
     +- * Find an entry in a tree given a pathname and the sha1 of a tree to
      - * search. Returns 0 if the entry is found and -1 otherwise. The third
      - * and fourth parameters are set to the entry's sha1 and mode respectively.
     -+ * search. Returns 0 if the entry is found and -1 otherwise.
     -  */
     +- */
      -int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
     ++ * Walk trees starting with "tree_oid" to find the entry for "name", and
     ++ * return the the object name and the mode of the found entry via the
     ++ * "oid" and "mode" parameters.  Return 0 if the entry is found, and -1
     ++ * otherwise.
     ++ */
      +int get_tree_entry(struct repository *repo, const struct object_id *tree_oid,
      +		   const char *name, struct object_id *oid,
      +		   unsigned short *mode);


 tree-walk.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index aaea689f9ae..29a55328bd9 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -176,11 +176,14 @@ struct traverse_info {
 };
 
 /**
- * Find an entry in a tree given a pathname and the sha1 of a tree to
- * search. Returns 0 if the entry is found and -1 otherwise. The third
- * and fourth parameters are set to the entry's sha1 and mode respectively.
- */
-int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
+ * Walk trees starting with "tree_oid" to find the entry for "name", and
+ * return the the object name and the mode of the found entry via the
+ * "oid" and "mode" parameters.  Return 0 if the entry is found, and -1
+ * otherwise.
+ */
+int get_tree_entry(struct repository *repo, const struct object_id *tree_oid,
+		   const char *name, struct object_id *oid,
+		   unsigned short *mode);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
gitgitgadget
