Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1961F403
	for <e@80x24.org>; Mon,  4 Jun 2018 18:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeFDSsd (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 14:48:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33516 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeFDSsb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 14:48:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so14798793wma.0
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BY1ZwhX3+MLh7h0jD50C4sw8z9kl8x5lbpagMe5DPDM=;
        b=UgmFTGTH10uZurWM/eYiBfPWMG7nXBty/c5I/wBpgfq0SM5/b0w7do1IkqjtIJnZct
         ZI2uoU0CkYBJQVapeHCsZ545V2Hzs4eSP+/C2QzsSiECQw7FG3sEIA/QectzCAm0ToTJ
         fH9jY/mMtq/K602jyOO1yCil2RRFc5IFnwLhuByC++sy3oyV8OO4BuKidfuwD6J3MiY4
         SmkVkklUQgwVzozfNncrQBmMFw4Bno6Bgm+z2C5XgaDODoaKuk8TRJq5nS9grgB0Jdxc
         rBEMkYPvanCbk9qcAI3L+E5ye9RmOCbR6dpIFdvOmsK6TVuenbs8qwCwQqzaVJnLAyc7
         cSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BY1ZwhX3+MLh7h0jD50C4sw8z9kl8x5lbpagMe5DPDM=;
        b=Mlb8z2AB/WDwyZZEzguMXJaEcKqpB6Xg+6dcHyA6WLQITQJnbkRi0jrLId5Lwl7pj8
         kbYUmv3YnBBp1Hpzh6yHeArgv+/gSy3gl3V9XKjXEqszgRphx0Jpdg8SZEFPK5BuIH1O
         Siqvld5ZA2rJ+RaufLiaMQD8Dvopialth+saBquW+cusFs0QnfzUIcWU54B0dNX1yS+Q
         kd4wlbi5oxBsIQJJ/vrUd9tXvl77MZC1XSC54w9hgAqy9nHBFiiZcmFKxFhDkxsWh7Jr
         hyGNoM4v7tGRejWffZ6Cu3eIU4HFjBH+fw6JonOH1ieECaurccljLNsEZskJlTaxkChd
         V+EQ==
X-Gm-Message-State: APt69E00jCBD4nF7WFdM4D1HDd29LlyHLEuWAVoZa+xD4ZJlep4KBk6+
        7z5x/BiPapx8LKQyqLj2iGI=
X-Google-Smtp-Source: ADUXVKKs0fWmDkjNDgrSojbb0NEY2VLBBPz90jMsYT90u9RliIrqMKpbLtaefdjsre/UJLdCUAB2CA==
X-Received: by 2002:a1c:6f5a:: with SMTP id k87-v6mr9197355wmc.142.1528138110319;
        Mon, 04 Jun 2018 11:48:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:e56c:af82:eed6:eafd])
        by smtp.gmail.com with ESMTPSA id c11-v6sm27247266wri.49.2018.06.04.11.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 11:48:29 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, leif.middelschulte@gmail.com,
        newren@gmail.com, sbeller@google.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH 1/1] merge-recursive: give notice when submodule commit gets fast-forwarded
Date:   Mon,  4 Jun 2018 20:48:05 +0200
Message-Id: <20180604184805.36332-2-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180604184805.36332-1-leif.middelschulte@gmail.com>
References: <xmqqk1s474vx.fsf@gitster-ct.c.googlers.com>
 <20180604184805.36332-1-leif.middelschulte@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Since submodules are treated similarly to ordinary files (i.e. not as 'dumb'
pointers), an automatic merge should be mentioned if the user asks for it.
Just as it is mentioned for oridnary files.

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 merge-recursive.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index a4b91d17f..0990a135b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1093,10 +1093,20 @@ static int merge_submodule(struct merge_options *o,
 	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, commit_b)) {
 		oidcpy(result, b);
+		if (show(o, 2))
+			output(o, 2, _("Auto-merging %s"), path);
+		else
+			; /* no output */
+
 		return 1;
 	}
 	if (in_merge_bases(commit_b, commit_a)) {
 		oidcpy(result, a);
+		if (show(o, 2))
+			output(o, 2, _("Auto-merging %s"), path);
+		else
+			; /* no output */
+
 		return 1;
 	}
 
-- 
2.15.1 (Apple Git-101)

