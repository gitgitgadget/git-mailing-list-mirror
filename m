Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231838F623
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680002; cv=none; b=lNjmwkU72zbAn1AuSGOa+CkNn55X9+gU6tXixxow9MuL/IGdt2QN3r7QJKNoffU6tz7L78/WiuPq7ALd95nbrVJV8MueLTxKf153QBzerid5FwBK1+eXqgNd3bRs57o0PWbtm0XHd1tdUBwhpPFD5QzQYVMQ9MpptR+JFWqBvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680002; c=relaxed/simple;
	bh=vHK3qpIutfp9wo03d7k6dq3wYKaS7S7bniwS8WzNBCc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kDBPau590VtNw/l99yu1Jbs8wzINkmyMoYUfMxF4byw9C6u3IgD5RkrUxsi5NY5NjcRW5N/JEQa8D6xbuIS7xCtzCAVJrMhxzaVAaeJ28GbkdZYQ64OMu3WYsRS69sHQOvmPhDPEtWud+4NMjdj5kztWVEUis2LDKrHnYzXkLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD7VCfB5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD7VCfB5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9f316d68so1134465ad.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775680000; x=1776284800; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1nLk0QNK2qPMlrc6G7GTvQpkU3DiALtvCSf5NOBDYs=;
        b=DD7VCfB52SXLLkG8NeWn6GLL8cDHnnSzhTwUTIDaz1lugJsexjJ9b7+8ALx8yk5WEP
         J1tUMz3Taoq7nvf1mT56L6Q3adPlGZfY9TYChywV1Qnq9ySylU0+aAUCQlDGpTeKzxF+
         lC5SCk5eHVv52usCNOYRk4EPRs0fPFQ0gAX4onO1uEvj6ns583soGH2vwtJGAUtZl03p
         pxVwqc6XRAEMyFKbPzZl0p0jTQ/tQ3wzzXv+KVacJ4HEpoqnFLBBObVrTTHn703e8wi4
         1h1cJBIOPkgXUI8mVZnGh4w23s2/psBEJLIuYJcxj4elJiw1HxHqjQ+QoODmiklCbbds
         ZrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775680000; x=1776284800;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+1nLk0QNK2qPMlrc6G7GTvQpkU3DiALtvCSf5NOBDYs=;
        b=a+8MzA5cr0RgTuedVyTQ30zmEyktgzPI4kpPbiLvOMBW4V82Y7v1bUg56Km9kU7Fl1
         rioFoSTCS4XbATtcXpDJvvJCgX4N9c6gMURF+G7J5MkrQN/UwS2XkyYzHeWsVFoo71VM
         BwvLMRBvRUqDaBZNfZYG8dkLTfjV/XyPDNutI2kzD+Bah38z845vh5U9kmfSBCML0/2t
         8cjA8MnomvEKVkWG8sAwNIyJeHJtbHZHZHpOW/f5qSIunEoP8KolS0PccwRqGR8I8Vof
         GUiXXVfqMuHJGoQN0uYd5DOTRwfcsEojAn3+IjiYTJU+x1XKCpPSXy2tP6OPZWimz+VD
         4b5w==
X-Gm-Message-State: AOJu0YxAi79PqPnHCqAmqe/U1M48SbAl/7qWzRW2zjKfAAfZtlATBkQA
	kYzFbbSYlfwHspALHPJ7DRmJFRRJb0lwk7H1d8j1f1kh6ZsgfKeo26ax7LLqKQ==
X-Gm-Gg: AeBDietPr+32rNNds3jje6ryRxQVrDMAYmJ7823wAYfmS4JtjferC9EoYA05u+OjMcQ
	u7WUbfOuYFBNp/jgqx1/avGg2RpY1tlIOQPxOkeCQ/PCoW0GlQqZkaFlP2tUrsGRTDs1/YTD7wL
	IARhJUmL1g5tZplLvOxPiRXxf/cpD8vIplEzJIW+GVpB75xIPQ7oV1rZmjgNYpYEll3uPUBCRqP
	R1e/bGgY6XqJ2XAMrK3wQhsLgXEIfupcJ5UralNhnvoRP8xUh4eOjLb7IKmAWz+lKeSR0dWeCxc
	1ySuTBUbxE/PXwJiv9yD6HOlNIPmJ44iZIIfOTLAkT1QLOenTbIuwnch2dVBX8BgzSbTcgs0Abk
	VVEKDwYh4SB1vC46EQhvK8JWUC6x85ChTw3pD18C5/V2qf1I8pGS003hvIy9YfBxmPTaOVt/z1Z
	Tq06AzkJiPzF51KqhF/kcM7zXmVYe1
X-Received: by 2002:a05:7300:8c04:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2cbf950432cmr12556265eec.4.1775680000515;
        Wed, 08 Apr 2026 13:26:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c3010e9sm28282569eec.14.2026.04.08.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:26:40 -0700 (PDT)
Message-Id: <699e198fa9bdd4b6829d7fbd550b7d387bb884d0.1775679988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 20:26:28 +0000
Subject: [PATCH v5 6/6] xdiff/xdl_cleanup_records: put braces around the else
 clause
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 471d9567c9..18ee7e815c 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -333,9 +333,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->reference_index[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
-		} else
+		} else {
 			xdf1->changed[i] = true;
 			/* i.e. discard */
+		}
 	}
 
 	xdf2->nreff = 0;
@@ -344,9 +345,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->reference_index[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
-		} else
+		} else {
 			xdf2->changed[i] = true;
 			/* i.e. discard */
+		}
 	}
 
 cleanup:
-- 
gitgitgadget
