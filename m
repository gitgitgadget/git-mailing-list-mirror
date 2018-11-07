Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DF21F453
	for <e@80x24.org>; Wed,  7 Nov 2018 01:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbeKGLWb (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 06:22:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40608 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388857AbeKGLWb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 06:22:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so14252750wme.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 17:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HHj2oslHD+aQnT1v9BOPiaVAjct2mMrGtg8i79LiK0w=;
        b=kf2EsetINXJ2siH9MwxsN1fA794p5YfPeBq64/hQ3IO8qxXRlZX+jN4PW6fgTHQSgM
         Yykk3VqUP4xe/ncZeMkkN2+JHUBO0PL4dKHymUSnnixFRCZ3SKzyFcqNXBBrc/s0zhaZ
         wmX1QvZGiOwMuAviuNVIzzKANKQJtC7fMsGnxOaZEKV2P3QpNZ+Xs0B0GKagCOVlUNPq
         4RKv5XjBUEfss0tW2KQ2I0AbpTxgrZ1mJCLOBti5Byc36nrSzLpMGpcP4zGTD0jcRw8p
         CjvwKsXk5YHGmK10LShhHQBy6ZdPxjVHtzTGDuiTjHAfRN9kINDWiPjoD9PBFroskv2p
         B4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HHj2oslHD+aQnT1v9BOPiaVAjct2mMrGtg8i79LiK0w=;
        b=flnzvsboMw+yaKh8XlTqhzQ3kgnQeAOotF2cytn9y87yy9r22aBP43Y/YoGcBRT7y7
         T5zYfIegO7t7guwSEabHvICHbbDapDyr3jP4E/OioX0fBu1zZ8JvVvvk4y52v8k1zscS
         aZv56TAsqIGgaQ3dSVLiDZw8sdbzUxQfhy17miJhdb3GCXVsZlXFqsO3MN5sv6szyl5o
         /Si3gkGFGARx3f/ivok4z2UPJVr4ykRYvZFi57IyMFRzaPz/Q1rtcaL6u1cnajnLK/+q
         M0unksFKDP1eglxt1vuKY+1ow+k7MJD5DS3UyPBVWW1npL7geUdUsA68MH1F1seZwG7+
         hfIA==
X-Gm-Message-State: AGRZ1gKxF/bODomLP8i0RaMegTrHVTDDJmR2+R1VK/myQZrfBUbQDpIy
        Zv1pI1R8jJ47DD/Hg3pI6CE=
X-Google-Smtp-Source: AJdET5cjS7w1oAnoSkgG8RYqrwRqjPeUxVAHBnJNHa6F3AaWETsFSkB76HjNaxVouafIE9kr8g+fjA==
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr246732wme.8.1541555656754;
        Tue, 06 Nov 2018 17:54:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j203-v6sm5527092wmd.46.2018.11.06.17.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 17:54:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] pack-objects: ignore ambiguous object warnings
References: <pull.68.git.gitgitgadget@gmail.com>
        <pull.68.v2.git.gitgitgadget@gmail.com>
        <002868ee6bec3dac38749d0f05bf2db8da0969a5.1541536484.git.gitgitgadget@gmail.com>
        <20181106211234.GA8383@sigill.intra.peff.net>
Date:   Wed, 07 Nov 2018 10:54:14 +0900
In-Reply-To: <20181106211234.GA8383@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 6 Nov 2018 16:12:35 -0500")
Message-ID: <xmqqftwdd54p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So we'd never expect to see anything except "1" in our save_warning
> variable. Doing a save/restore is just about code hygiene and
> maintainability.

Here is what I plan to queue.  Thanks, both.

-- >8 --
From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 6 Nov 2018 12:34:47 -0800
Subject: [PATCH] pack-objects: ignore ambiguous object warnings

A git push process runs several processes during its run, but one
includes git send-pack which calls git pack-objects and passes
the known have/wants into stdin using object ids. However, the
default setting for core.warnAmbiguousRefs requires git pack-objects
to check for ref names matching the ref_rev_parse_rules array in
refs.c. This means that every object is triggering at least six
"file exists?" queries.  When there are a lot of refs, this can
add up significantly! I observed a simple push spending three
seconds checking these paths.

The fix here is similar to 4c30d50 "rev-list: disable object/refname
ambiguity check with --stdin".  While the get_object_list() method
reads the objects from stdin, turn warn_on_object_refname_ambiguity
flag (which is usually true) to false.  Just for code hygiene, save
away the original at the beginning and restore it once we are done.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d1144a8f7e..f703e6df9b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2988,6 +2988,7 @@ static void get_object_list(int ac, const char **av)
 	struct rev_info revs;
 	char line[1000];
 	int flags = 0;
+	int save_warning;
 
 	init_revisions(&revs, NULL);
 	save_commit_buffer = 0;
@@ -2996,6 +2997,9 @@ static void get_object_list(int ac, const char **av)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	save_warning = warn_on_object_refname_ambiguity;
+	warn_on_object_refname_ambiguity = 0;
+
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
 		if (len && line[len - 1] == '\n')
@@ -3022,6 +3026,8 @@ static void get_object_list(int ac, const char **av)
 			die(_("bad revision '%s'"), line);
 	}
 
+	warn_on_object_refname_ambiguity = save_warning;
+
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
 		return;
 
-- 
2.19.1-856-g8858448bb4

