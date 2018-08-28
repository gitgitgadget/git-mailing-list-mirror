Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0FF51F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH2BVV (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:21:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeH2BVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:21:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so2841524wro.11
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6MkByH/Rive34WpRM9YyC6n3B7MmOLP4gJ8Ad141xI=;
        b=oKoidsSQ+OisrEZNSnFsyJqm0GtN6DEEd307dRoc4bt/9AHETWD1RRAoWUelNVG/AF
         EMg0PiSlybRhpG/c3TFfZrNOb0VSFeQdcByRUc/54ULsqlmn5r7bSgLHa8G4QJ+/Q/zv
         ChJ+3JoelxLPEwEbd+QJhfoIFqnuB4w4efGczVoIm2efXHrSgz/Dujyfwm3gCngTRr2L
         p3OBQJbqdqL7q5PAVXDa6xhueip4MQgnT7mhuRBVPHlkMOUzMPE8Mp5FrzaLGLlmjzKt
         oJGLVB5feYj2koj8F6cznMOTz5Bru0t90wmevPz8TzE8uahA5JESipooXRtztOQjDMl9
         hi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6MkByH/Rive34WpRM9YyC6n3B7MmOLP4gJ8Ad141xI=;
        b=m9LfUSpY+Kvgmo/odPTFx7GE1FycZg+xfXYqbmrnODXckGvNBh+zrwUmH/9hyX+LxQ
         NKmG2xzmW4DNFYSvb8OI1LCM3deKbKXPMkoyhj4ebvUw9Azkg6hbxR1PzOboCOORwRNt
         DsmMO1GjUWga4m8a6L70QWcydeSEc1Hsnl7GcfjnnZrbp9cTbclWtKkYQsNptwFdADgD
         GKYYa40hhtd+9CXBCDBP5e/IhYabs2zgaI4t3hEKkbFf3b2/OFXBot9eJBc0erhyavw4
         HY34VFtNLAGdyfXqepmKnQZg0Jke0J0ADm4pFKbs5pcorDiAnOmIkEPeFVMm5C2FGJJL
         ijjw==
X-Gm-Message-State: APzg51AaLQkne+9p1mc+Rq8gfEpZv/Gzgs32+wPafl/gEqAIWbIy7xXT
        dFZ12+lJUDwp2LGCYgvQ24T6J6Gi
X-Google-Smtp-Source: ANB0VdY7dVdqZDoET46+HGYfSUZTQz8Q/XRDoGu+DSlZCGK1aIvK8ifvpv7vbsYFX3FelVzRKXrO+w==
X-Received: by 2002:adf:9385:: with SMTP id 5-v6mr2424452wrp.157.1535491668081;
        Tue, 28 Aug 2018 14:27:48 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id 199-v6sm3778130wmp.37.2018.08.28.14.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 14:27:47 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] rerere: mention caveat about unmatched conflict markers
Date:   Tue, 28 Aug 2018 22:27:43 +0100
Message-Id: <20180828212744.18714-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.1088.ge017bf2cd1
In-Reply-To: <20180824221005.5983-1-t.gummerer@gmail.com>
References: <20180824221005.5983-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4af3220 ("rerere: teach rerere to handle nested conflicts",
2018-08-05) introduced slightly better behaviour if the user commits
conflict markers and then gets another conflict in 'git rerere'.

However this is just a heuristic to punt on such conflicts better, and
doesn't deal with any unmatched conflict markers.  Make that clearer
in the documentation.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

> That's fine.  I'd rather keep it but perhaps add a reminder to tell
> readers that it works only when the merging of contents that already
> records with nested conflict markers happen to "cleanly nest".

Yeah that makes sense.  Maybe something like this?

(replying to <xmqq4lffk3ez.fsf@gitster-ct.c.googlers.com> here to keep
the patches in one thread)

 Documentation/technical/rerere.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index e65ba9b0c6..8fefe51b00 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -149,7 +149,10 @@ version, and the sorting the conflict hunks, both for the outer and the
 inner conflict.  This is done recursively, so any number of nested
 conflicts can be handled.
 
+Note that this only works for conflict markers that "cleanly nest".  If
+there are any unmatched conflict markers, rerere will fail to handle
+the conflict and record a conflict resolution.
+
 The only difference is in how the conflict ID is calculated.  For the
 inner conflict, the conflict markers themselves are not stripped out
 before calculating the sha1.
-- 
2.18.0.1088.ge017bf2cd1

