Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE9CC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 11:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49EC61AFB
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 11:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbhKRL2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 06:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbhKRL1z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 06:27:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C3C0613B9
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 03:23:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so7912470pju.3
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 03:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0lETs4PgNvpNOoMla3yufhXwcOYMDEoDIT9XIWQzAM=;
        b=Tcvhzi0HgBQfw7S0EqAZ+EUczSNDyPUyVGOe/T/M52zAweMMXhVMBKsflsx5Gla04Y
         dwClJIUPKa3nfL6VEXoVnbhAmmPPaLCrdLt+j2b78WpS85drvOmXhXeveyQN/q8mcH1H
         N46nBqkg/saJS7xl6AFYF/xFKe5df/9O7p0rkHjL9uO3cD7vSieE098chzmI8IjPqbU1
         pKDyFYPjes/gaxDdYi8GtIKoIHVbpV/284XID0HdCOXAN/xW6y7UpwF7qKnKvVoZg7J8
         iRFItdmt6aAWDvrSTDvFWdpLhda32Zpien0EPvTIpNVHRkK/8ZqwLuvRp0BQYncqYyV1
         gYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0lETs4PgNvpNOoMla3yufhXwcOYMDEoDIT9XIWQzAM=;
        b=ikB0kibbVzicnmrd+dtsfsH5JSk2hfh7gE81528AWrZnv8c/UoXJXlBe69HMDma8Fw
         NF5jjdV87Pq/yL0oC+Rpe2q7Je1zu/zDCC0JPEsyro73hxDKGWfaU3QZB5So+zV5V2Db
         lP5ENAhnN/puXNtM7a/YSk7mLjZ/pN6lTrzW41nI2RcCpcj5aQmh8q7BafQpju0isPPI
         s8YPeWVAJM18bjYKyJ0N7qJkd4o27Y1Wai1e+FP3f8pXIJ33zURtiaHJ0CTtlApgLPkV
         AD8wfieOMb8xufBXkNRLVxYDi+GF9sGdhO+YfPzLXsW0/BiIp9FX09H3l8scIdEP5TYq
         eO1w==
X-Gm-Message-State: AOAM530Do5KBUAyrr1WTlN7noxnVnSSTp3KkNdpcUhAhB6TGaFoqp0ZL
        BYqdSFto3Z1nrq3KuWygx4A=
X-Google-Smtp-Source: ABdhPJy2i7JYNGo2XkNU59OvPYtjaOWZVsbn2tPPMYsEYw0vseljIuobgSa9FmG3Hd7MSKbvWtboWA==
X-Received: by 2002:a17:90b:2252:: with SMTP id hk18mr9634641pjb.218.1637234636490;
        Thu, 18 Nov 2021 03:23:56 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id q89sm2536243pjk.50.2021.11.18.03.23.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 03:23:56 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     peff@peff.net
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/3] ls-tree.c: support `--oid-only` option for "git-ls-tree"
Date:   Thu, 18 Nov 2021 19:23:48 +0800
Message-Id: <20211118112348.85948-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g62ef0b3803.dirty
In-Reply-To: <>
References: <YZKyC7c8b9PnyXG8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 15 Nov 2021 14:16:27 -0500, Jeff King wrote:

> This is a somewhat funny place to put the check, though. It will be run
> for every entry in the tree (so is a tiny bit less efficient, but also
> would not trigger for an empty tree). It probably should go in
> cmd_ls_tree(), perhaps here:

Yes, it's better here as a fail-fast case.

According to the suggestion of the new location I think why not put the logic
further head, after the parse_options() return, like:

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 1f82229649..003a9ade54 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -166,6 +166,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
        argc = parse_options(argc, argv, prefix, ls_tree_options,
                             ls_tree_usage, 0);
+
+       if ((ls_options & LS_NAME_ONLY) && (ls_options & LS_OID_ONLY))
+               die(_("cannot specify --oid-only and --name-only at the same time"));
+
        if (full_tree) {
                ls_tree_prefix = prefix = NULL;
                chomp_prefix = 0;

Will it bring other new problems?

Thank you.
