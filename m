Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F48A1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 17:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeFKRb6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 13:31:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40770 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbeFKRb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 13:31:58 -0400
Received: by mail-wr0-f196.google.com with SMTP id l41-v6so21257137wre.7
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Hdl0rlCtMXWryOEjoWghSbLu7jIBMHlvFskzvdfsazs=;
        b=JMgyJUH4WRi3XVoUzGpwzyc+lBN87sVZDlt4ezfXeV/0KQj77YQXhOFcGujejOrlwP
         Cud3CokUyOFLa91UwfRtVE3Q1/SGdIm+dhRnFV7x2Ze4ZqmXl7imqC/iuEsfsTRXY5d4
         1GuKn5WoMFhC4o0T5FAqlBjlOCCMNAbdARMPQA7VI+3bI6BvjrRXJhSTYTi+TmP+qjc0
         SSAZG3li7tl+uaLZWR5nb9ZcybgzCBVQqGWs2f0J0Ex43onPzIA8FD9BpmmexFp1NLlh
         WwmdXZ7PjcYUtKK5WaAeunarpPeyRf1eUS8dafZxMKmNvqd/MxYuqHtxrj+aDjbB6Lgp
         jkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Hdl0rlCtMXWryOEjoWghSbLu7jIBMHlvFskzvdfsazs=;
        b=ShtlvqGabS7itCA5ixqpxRdfNZtDE2iGlOcxSfkGllPZXhbEi0Y8pGGWsw2egN7vNE
         Xdi6Qc0gw8vJB4+Lolehm0clbLHZ5pBXR25+IkbuR+QEfsjvAyPyIWoNP6F/t5tqGN2S
         XLEMvPc2iRm7wxwo2a2r7m3J8Vbq3hWRLH+o1TRtzrsE5aD9Vgq3IcOtkm30iDwKktl6
         WALAFxEN4rSfqCFlfXyjQ5fK6Md04YEz/0TLKSV9nbcKMCRPrAhXKmjHyX3P3+tGEJgA
         KquHTDdMtHTYfxhdEQkOXOO4bI/9aJ7XZKXK5+v3ySaoiZcBfYCjf9PishhD94+DChr7
         gB/Q==
X-Gm-Message-State: APt69E3J2AHGwhNo/yUgKou52XN7m0xjD+1n+IR0jqC3pxNm00EVRPvv
        4LurWGpS19L/RwYuNnOI6Ig=
X-Google-Smtp-Source: ADUXVKIuuHbUKRBycmcdY7A0POisVMhZSWPnafu+XZRdaLL+x9oyUdEy8xRG3EB2I807Y4uQaoxmmA==
X-Received: by 2002:adf:e20b:: with SMTP id j11-v6mr58090wri.205.1528738316918;
        Mon, 11 Jun 2018 10:31:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:91be:6792:9b61:28df])
        by smtp.gmail.com with ESMTPSA id m65-v6sm11725448wmd.1.2018.06.11.10.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 10:31:56 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        leif.middelschulte@gmail.com, sbeller@google.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH] merge-submodule: reduce output verbosity
Date:   Mon, 11 Jun 2018 19:31:28 +0200
Message-Id: <20180611173128.9917-1-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
References: <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
In-Reply-To: <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
References: <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

The output shall behave more similar to ordinary file merges' output to provide
a more consistent user experience.

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ac27abbd4..5eb907f46 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1208,7 +1208,7 @@ static int merge_submodule(struct merge_options *o,
 			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
 			output_commit_title(o, commit_b);
 		} else if (show(o, 2))
-			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
+			output(o, 2, _("Fast-forwarding submodule %s"), path);
 		else
 			; /* no output */
 
@@ -1220,7 +1220,7 @@ static int merge_submodule(struct merge_options *o,
 			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
 			output_commit_title(o, commit_a);
 		} else if (show(o, 2))
-			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));
+			output(o, 2, _("Fast-forwarding submodule %s"), path);
 		else
 			; /* no output */
 
-- 
2.15.1 (Apple Git-101)

