Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B63BC4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD802071A
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 09:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImKGXDKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgKEJLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 04:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbgKEJLm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 04:11:42 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6CFC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 01:11:41 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so351110pfn.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 01:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EISwZqKGYfuyB737qB3MeJhTYBu5ZAucmY6suoqaF5s=;
        b=ImKGXDKj+kn8nAT55SwrLkWR8ewbzE29SdONi/GCmOSZNVn5TgqPO9XJOqN6iF+0FU
         DHMcA9vZO5P/gGoSVKxquhjccLfyMgRS2VB6X8up37i+Uu+2EIYX6mAgL6IOmYOAX2/f
         zycA4ZEGJ/J67LNuOA1YFkMyL1SUJUboyy/OxvmIthav7pCno7rcjix4e/3ntt+w3jtJ
         Pl+iVcmxFulfpJFJNP46bfMmCIwapaUQDgvkamttA8QssvzuXrJly0PxvXVyhB8vAcmH
         mHLcTN8RqomsoXiI2nBNVN0R2e8up64IXmIF7b3SswFWxcL2giT7mWVvPeRDdBbSHYJi
         dnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EISwZqKGYfuyB737qB3MeJhTYBu5ZAucmY6suoqaF5s=;
        b=TsQfIgoldcYzASqSHgOmAtWWZAHjCK0kK3wSEA7ryCGIbrdm/kBemXChi28pCdhfn8
         p1b0MmXXvJaEs44FpC8OgIO28OZUc0Ki0/WToF6VigUpRFSj+xU692VEpi6HNHnjC1yM
         ere4Bcob9LnSoQB8SCmM1TZAX/gutIPxU25kuo17xCgoL2oFqDkW0wsc1jyVCc1FlR3q
         bl+GoK0uQUFTg8DL5YUOWgpqRciXQlwYeNen3Z3totpH3njH2BGXCGnliV96z+emOJWG
         JIq5Zoy7d1h5gkgOqyQqYo69DLVzL2Ljx3fmAo+i7S/wCGxuHQdvWDkvE46WiUzdcI/a
         GVmA==
X-Gm-Message-State: AOAM5315YD3J4E5YY5+vD9WS+7Xmz3nlJHQwyD26/ngVAqAzHMqn+qLh
        4B03YUvOYhPFaVvNlbZ8UquRtOiOnRcjaQ==
X-Google-Smtp-Source: ABdhPJyP/oW4nounF46nQ95jXbsdu06kSSzmCC9spYTd2xrktLEiuvm8aYGS6keiLHSOVjoCaBHfoA==
X-Received: by 2002:a62:758e:0:b029:18b:a2a:241b with SMTP id q136-20020a62758e0000b029018b0a2a241bmr1695499pfc.34.1604567500460;
        Thu, 05 Nov 2020 01:11:40 -0800 (PST)
Received: from marlonpc-debian (pa49-184-232-176.pa.vic.optusnet.com.au. [49.184.232.176])
        by smtp.gmail.com with ESMTPSA id e20sm1526215pfi.30.2020.11.05.01.11.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 01:11:39 -0800 (PST)
Date:   Thu, 5 Nov 2020 20:11:36 +1100
From:   Marlon Rac Cambasis <marlonrc08@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] doc: fixing two trivial typos in Documentation/
Message-ID: <20201105091136.GA28535@marlonpc-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed "speficied" to "specified" in config.txt and "occured" to
"occurred" in githooks.txt. This should help any readers of these
files.

Signed-off-by: Marlon Rac Cambasis <marlonrc08@gmail.com>
---
 Documentation/config.txt   | 2 +-
 Documentation/githooks.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 025ca4df11..f292c2689e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -265,7 +265,7 @@ color::
 The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow`,
 `blue`, `magenta`, `cyan` and `white`.  The first color given is the
 foreground; the second is the background.  All the basic colors except
-`normal` have a bright variant that can be speficied by prefixing the
+`normal` have a bright variant that can be specified by prefixing the
 color with `bright`, like `brightred`.
 +
 Colors may also be given as numbers between 0 and 255; these use ANSI
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 4e097dc4e9..ffccfc7760 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -655,7 +655,7 @@ p4-post-changelist
 This hook is invoked by `git-p4 submit`.
 
 The `p4-post-changelist` hook is invoked after the submit has
-successfully occured in P4. It takes no parameters and is meant
+successfully occurred in P4. It takes no parameters and is meant
 primarily for notification and cannot affect the outcome of the
 git p4 submit action.
 
-- 
2.20.1

