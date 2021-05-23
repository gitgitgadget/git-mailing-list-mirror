Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25034C47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE84F6117A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 19:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhEWTaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 15:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhEWT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 15:29:57 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337EEC061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 12:28:30 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso5839233ooh.11
        for <git@vger.kernel.org>; Sun, 23 May 2021 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OgHdT/eBr4Wfq3HdGidYBtwnFbQ0Wh3avLz46edWxK0=;
        b=B4B9Uy80RsMJDYeSBEc7dE2sH3y1hqLWd+6exCgo4mm82h6PC2EZR/4MU1Ra5DB9SN
         plOGrnEIqmrAnz+ci2HHDFTtignSBGhue/IA00Ilejov0gUPcnSR8gBuE2jb4fWAaXgK
         VYPsA5xVkqVZ5uegC1hDBqxAccyR/+MtdIg+BPc8VzHZN3SzMCdrEoMP+UhSVt1XuP7Z
         KQbuLVsvXxBuIeMvj+yCIfdKXL++5JijrR0wzP+1neCPW7aqG/aNHILIeW1rLLk7F9G+
         QySqptA8/brXv5FLaLbT96GLhgMj2Xs2jXEr4IOtTM8tJXYV9Zsa/MXtwCKmHy6fxx7p
         dvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OgHdT/eBr4Wfq3HdGidYBtwnFbQ0Wh3avLz46edWxK0=;
        b=XbftPWmFd3RC62/r3QA/MpC2NUuwIpmw9Y8sWkabqHrZ/tfGgVWkWup4N5ru7NVOuJ
         lxy5Bs4fzbDmVq858JAe3bdgAEvUd0Uc89mVzRrPl3k5b7Qg4Uo7o+AiXSZtx+yxk88l
         8ht++E7KpouHVhNVeDqsdxPQXsPoqo+h4JBKmfLHWb1pZ+CFNxsaD41VG0RHUlLUr72N
         EdZkexzqzlpTzrLD6jOhsw9jRFHGKXQjTcX1tMK9o+gJbytM/VzEou5kRR33R/fWXLB8
         6eaE3ymw5N1TIn3YS6RFhrGesUdI9HUw67OB+szxtKVj9KsfsZ9eDLAnzpx81XsMYvMC
         xZaQ==
X-Gm-Message-State: AOAM5335EtIpsrdlhBcT3z4UOhWjlqJ4+btwfO70QkNNgv4g0wcl1EyP
        J3d+FCi0gtH2S6EtFVv3Rb8=
X-Google-Smtp-Source: ABdhPJzKfK/JsEYJMD+DctuzQYKFPOw0uOevNqlqq0y0TNGMPVqqjSW3YfbSTFc6+7YzN3NIbcIprw==
X-Received: by 2002:a4a:4581:: with SMTP id y123mr15261192ooa.33.1621798109301;
        Sun, 23 May 2021 12:28:29 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 64sm2413038oob.12.2021.05.23.12.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 12:28:28 -0700 (PDT)
Date:   Sun, 23 May 2021 14:28:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     aidgal2@gmail.com, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>
Message-ID: <60aaacdb6a7da_53920893@natae.notmuch>
In-Reply-To: <d801fe76-f40d-91ef-653e-925aba0fbdf4@gmail.com>
References: <EE7D39E6-D826-49E2-AD0E-090A83DFDEC1@gmail.com>
 <xmqqczthnwuu.fsf@gitster.g>
 <d801fe76-f40d-91ef-653e-925aba0fbdf4@gmail.com>
Subject: Re: Formatting options are ignored when tracking functions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain wrote:
> Le 2021-05-23 =C3=A0 14:11, Junio C Hamano a =C3=A9crit=C2=A0:
> I do not have a clear opinion on a migration path; if consensus can be =
reached
> that not implying '--patch' is a better behaviour, then changing the be=
haviour
> would be OK. If some people use scripts that parse 'git log -L' ouptut =
expecting
> that '-p' is implied, I would expect it's pretty easy to notice the bre=
akage and
> add the now-required switch... but I'll let others be the judge of that=
.

I agree; it should be easy to notice the breakage. I don't think any
migration path would help, we should just switch. But the git project
has a tendency to worry about hypothetical users.

This is the only thing I can imagine doing for those users:

--- a/builtin/log.c
+++ b/builtin/log.c
@@ -262,8 +262,13 @@ static void cmd_log_init_finish(int argc, const char=
 **argv, const char *prefix,
                load_ref_decorations(&decoration_filter, decoration_style=
);
        }
 =

-       if (rev->line_level_traverse)
+       if (rev->line_level_traverse) {
+               if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)=
 && !rev->diff) {
+                       advise("In the future you will need to specify --=
patch. Hit Enter to proceed.");
+                       getc(stdin);
+               }
                line_log_init(rev, line_cb.prefix, &line_cb.args);
+       }
 =

        setup_pager();
 }

-- =

Felipe Contreras=
