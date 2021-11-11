Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA30C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAA261452
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhKKWDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKKWDm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 17:03:42 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318CC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 14:00:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mn13-20020a17090b188d00b001a64f277c1eso3631144pjb.2
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bH83OBNKI6vI0cJQWRZdknf31r7RHponkAZ5rAGbaPs=;
        b=LDpYru3gAMN+44VjknSEQY1qd18gYePOlyscS5z1QhG77F1f0RnK+cZaYt89XQXp2Y
         lkEluZtHLKJZuV/ha+2rJj5qN/9wZwxbmc/pCfsF0SUywp3fnj91Mqr8nAHeKx+w9Smf
         oN/mWDIzNClb4SiY2ZrXIIRKf7vvAd9bZoVqKY1SCn5HdO7uzgUi3oQAOxROsUvuOfu3
         NNsazGl6lHHUGFlq6ncjtIrtQChZL98F2S1woFkdJ3sx7x23LqXCGMbv88LcssKcqk3R
         qxrwqcvzSQgGR2T8AVqOwi37eaUmUIPbhgPq7NQQycBIT1LyQuGBLdhxgTGAgDANBSFp
         Xclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bH83OBNKI6vI0cJQWRZdknf31r7RHponkAZ5rAGbaPs=;
        b=ptE1toIDxT8OGGH42TucgZin+VOHgWeHwe6YIglfgretebvaxLak273zCRwfBdKyCK
         Jnx3F54R2kLHKykBNdqtIBxsbGoDD4f2tT/S5Gldg7Qu+H7O5rHdxOzzClJPgqQX9Bqw
         2EmbJptm9dY2KS2q9gqGMYH8pv8hpBGw4JxiuEnWGQ5E1FAbSim4BIM6ruRYbkEG+xH8
         TRQqUD+lnldx8BcpTmsbXVOWU3Swcgh4whPcZ5f9g46B8peMMdC0c49Wqig4mIsMaVEM
         ay8TCzVM5eEDdhiz5DPpkqfhLxP7ZyQn2463JIQL75/VH4TtNovc65C9QEJmLImZaeYf
         BGfQ==
X-Gm-Message-State: AOAM532PhQYHsN1W0mcO93RmROFC14GaYNgCrjYBMU9wvnvRqpRXua2n
        wWAE8Kw/i43W2wdH7b5DwnWVTwxbLrrdobmbtKQFrHQ/e3lZx9ObmQureU+onx4q9WopAzNFoNh
        JVOWh/Ru/014WOCC0N1OaACNN9LUJqRiBpWlD+9zJ7pk2Q2hWc9PPktTnbcisQGnTfA==
X-Google-Smtp-Source: ABdhPJw4+nfr+glZr/nadqMScCU5K0vDQROnbFomsuvxur0IeKYgqcupisnYWZT7yavGZP/wH0EcpwUEbrJcgwc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a62:1887:0:b0:44c:872e:27ed with SMTP id
 129-20020a621887000000b0044c872e27edmr9654878pfy.71.1636668052811; Thu, 11
 Nov 2021 14:00:52 -0800 (PST)
Date:   Thu, 11 Nov 2021 22:00:48 +0000
In-Reply-To: <20211027193501.556540-1-calvinwan@google.com>
Message-Id: <20211111220048.1702896-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20211027193501.556540-1-calvinwan@google.com>
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: [PATCH v2] protocol-v2.txt: align delim-pkt spec with usage
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Calvin Wan <calvinwan@google.com>,
        Ivan Frade <ifrade@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current protocol EBNF allows command-request to end with the
capability list, if no command specific arguments follow, but the
protocol requires that after the capability list, there must be a
delim-pkt regardless of the number of command specific arguments.  Fixed
the EBNF to match. Both JGit and libgit2's implementation has the
delim-pkt as mandatory. JGit's code is not publicly linkable, but
libgit2 is linked below[1]. As for currently implemented commands on v2
(ls-ref and fetch), the delim packet is already being passed through

[1]: https://github.com/libgit2/libgit2/blob/main/src/transports/git.c

Reported-by: Ivan Frade <ifrade@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/technical/protocol-v2.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 21e8258ccf..8a877d27e2 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -125,11 +125,11 @@ command can be requested at a time.
     empty-request = flush-pkt
     command-request = command
 		      capability-list
-		      [command-args]
+		      delim-pkt
+		      command-args
 		      flush-pkt
     command = PKT-LINE("command=" key LF)
-    command-args = delim-pkt
-		   *command-specific-arg
+    command-args = *command-specific-arg
 
     command-specific-args are packet line framed arguments defined by
     each individual command.

base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
-- 
2.33.0.664.g0785eb7698

