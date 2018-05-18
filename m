Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5C11F51C
	for <e@80x24.org>; Fri, 18 May 2018 19:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeERTsY (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 15:48:24 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:53118 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERTsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 15:48:23 -0400
Received: by mail-wm0-f43.google.com with SMTP id w194-v6so15820461wmf.2
        for <git@vger.kernel.org>; Fri, 18 May 2018 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Hk9UD/K6zTamH3bNPS2VGq51PwPRCW7iLApzHzPZDM=;
        b=vh3vlmTtBrAQEcQKiF91Xv7IW9i//SKH4r0Z6BZPKfxNIttVhRRmE9KGrSDbtkX7TS
         kYqv8WGpAXk8s6NKo4BE9I+KVKidwKkWKtf56rzDS998+2ZEAPUddGz9UBVQfEOmD+yv
         sDguE2/gKJdGFgoe17yzZDTzy6niufIdSg1cpXJExzjCXXC8jpAc6udBapQVSeVtX8BC
         6MGp7UwIG9TaXieIV+0qhH6SUkuoJtA/g9BrRSK/8XOJah/vRX9378rVXZf6TI85KXAp
         Cfy1/5OOgxWlD/68I+jXSOWP1HIdMLWTMRRddGBUHS1FvzjwzZDNTTASJ3UUgEE1l3co
         36XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Hk9UD/K6zTamH3bNPS2VGq51PwPRCW7iLApzHzPZDM=;
        b=rqgkSZ32PK2SLrvUMZBSoXsP1mxsEBVP4oZ5OEfKLyMwPDE/nCHm5ZlFesG09I8Nji
         O7niQ01ggP8cBmqGVIrvPyzi9KrT1Bgk6L9mo0MzsAW19FHY6rMhjT3Z1+WvK08UZJlR
         IK+39/8X8XNnAbc6lZHfxRp8/fXlAsvDP7wHxJ9VXhH8YN9pBa2euBL+RMXmH5lWBq1g
         7xi/BEvPz8xRR5itiAIQAw9WLasvbbSCpufzLW4tLYyq7cUQ6WBi1+OvUBFNYENGFVLR
         jF0Hy8B9VRAP4hlnDIz/h70oTuB1tn1v3qT2XeEst1IuA2xvbYmEZXcc+REQoEXLxo2Q
         Fi0A==
X-Gm-Message-State: ALKqPwcUMl801sasqGNXURMg/JpVSF70SAvCMWOt2VdtqNbqb3obNReI
        W1YMdk4d4BODpF7Wrvj7GbtXuwYi
X-Google-Smtp-Source: AB8JxZpnozO0FeWGfgJLdCkFM5i016KkIJXlJUIrMb9iEOhrOdXahTu4CBjcdLez4cHdWOPpy95p7Q==
X-Received: by 2002:a1c:d810:: with SMTP id p16-v6mr5552793wmg.133.1526672902486;
        Fri, 18 May 2018 12:48:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:445a:d637:6fb:6000])
        by smtp.gmail.com with ESMTPSA id z63-v6sm12585270wrb.34.2018.05.18.12.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 12:48:21 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        leif.middelschulte@gmail.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH 1/1] Inform about fast-forwarding of submodules during merge
Date:   Fri, 18 May 2018 21:48:02 +0200
Message-Id: <20180518194802.28355-2-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180518194802.28355-1-leif.middelschulte@gmail.com>
References: <20180517184008.25445-1-sbeller@google.com>
 <20180518194802.28355-1-leif.middelschulte@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Silent fast-forwarding might lead to inconveniences in cases where
submodules are expected to have a certain revision, because 'more recent'
(therefore fast-forwardable) versions might break behavior/contain regressions.

A use-case is the integration (merge) phase as part of the feature-centric
'git-flow' workflow [0]. I.e. a feature might be well-tested with a certain
submodule revision, but break because of regressions (or changes in general)
within an updated version of the sourced submodule.

This change tries to support the integrator by telling her about another possible
source of unexpected behavior (differing submodule versions) she might see
during integration tests.

[0] http://nvie.com/posts/a-successful-git-branching-model/

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 merge-recursive.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index a4b91d17f..e2c99924d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1093,10 +1093,26 @@ static int merge_submodule(struct merge_options *o,
 	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, commit_b)) {
 		oidcpy(result, b);
+		if (show(o, 3)) {
+			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
+			output_commit_title(o, commit_b);
+		} else if (show(o, 2))
+			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
+		else
+			; /* no output */
+
 		return 1;
 	}
 	if (in_merge_bases(commit_b, commit_a)) {
 		oidcpy(result, a);
+		if (show(o, 3)) {
+			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
+			output_commit_title(o, commit_a);
+		} else if (show(o, 2))
+			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));
+		else
+			; /* no output */
+
 		return 1;
 	}
 
-- 
2.15.1 (Apple Git-101)

