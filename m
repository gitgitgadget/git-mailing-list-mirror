Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5723820248
	for <e@80x24.org>; Thu,  7 Mar 2019 00:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfCGAvB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 19:51:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33095 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfCGAvB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 19:51:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so15455071wrw.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 16:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XzUvOkfZDVT4zEabbnrDbyI1oMiizbcBSJVjka9Su6k=;
        b=VrxhXG4JQaJzYD9Pb5iiFsIzmZ0QafMM40Xj2NgBRLHEiuX67lNdqtgdR5VzzGol05
         fUrEyLn39aTK24krLV/1gdEsqE657O6NiuQCi7r02RVE1r6NVbBTP6EdSIMblZ5MKycA
         /96GfXftS5j/YYqiqDNRYVWuPmPfg4qlzIkmXGtKQE9fkcbG+WJzvrIFbJNXORviJF3h
         geUUyj9g+aGqPnUmIygxTqu3k+uHjUSBlWuQkaI2aU1yfYZrlMF3FsRiSkaPBKLP2+r9
         nWBeftYVZPtohqlWCDdGmj0xwreujXQG+CHHv5g4qCNUCmDtr5t2klw9LLZkYATFVJkg
         3LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XzUvOkfZDVT4zEabbnrDbyI1oMiizbcBSJVjka9Su6k=;
        b=LCNg3imrZiv2PeINuShBTQp6f9EsgsgxFToEojJgPbsAMWOfyy+b45TeN2fzPangR8
         h7HGb8lOI83BhHYXODizKU2aR53PTQZLn5QPlOBdNeg1X2bydePMSvjMDcBZ0cwvnvfY
         6gaqryLzVSUE76lQMXfhkrrf+AvEBrR7T1WNSZvj20bA9HWCQjgnkXFR66FZVsdxrEle
         V7Gs2Gmp7632slLx5kzF5CZOANgadR9VRXSFqn9HYsG6OZPKh31oN1yuPGbB4Qjr8ccK
         JjaeOD8Mxk6QHWOKgQfaXC9sibBd8BYA5Q92fY637o1LqhShp8YuHONZRztGOHT4hJiH
         GG2Q==
X-Gm-Message-State: APjAAAX8oEERwFlArILeJTwgb9mDjOpH8V6Obp+a+trKqGD42Mx0EZlV
        8PtnpYhgh6hdgwcMvSeGBDA=
X-Google-Smtp-Source: APXvYqztbwNjtwlso9kqQ5ycijGujFtUfEIAFBzGsiJXYCXJlGyio7Of34TUZO44Pn6RoZXhVANKaw==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr5016153wrr.218.1551919859025;
        Wed, 06 Mar 2019 16:50:59 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p1sm5163334wrx.50.2019.03.06.16.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 16:50:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
        <xmqqtvgk69ik.fsf@gitster-ct.c.googlers.com>
        <20190303174214.GF23811@sigill.intra.peff.net>
        <xmqqlg1vw9f2.fsf@gitster-ct.c.googlers.com>
        <xmqqh8cjw7ob.fsf@gitster-ct.c.googlers.com>
        <20190305042050.GE19800@sigill.intra.peff.net>
Date:   Thu, 07 Mar 2019 09:50:57 +0900
In-Reply-To: <20190305042050.GE19800@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Mar 2019 23:20:51 -0500")
Message-ID: <xmqqbm2no6by.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Mostly I was just surprised by the new behavior. Perhaps the right
> solution is not a patch to the code, but to the documentation. Something
> like:

Let me forge your sign-off and commit this to prevent us from
forgetting.

Thanks, all.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Mon, 4 Mar 2019 23:20:51 -0500
Subject: [PATCH] config: document --type=color output is a complete line

Even though the newer "--type=color" option to "git config" is meant
to be upward compatible with the traditional "--get-color" option,
unlike the latter, its output is not an incomplete line that lack
the LF at the end.  That makes it consistent with output of other
types like "git config --type=bool".

Document it, as it sometimes surprises unsuspecting users.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-config.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 1bfe9f56a7..611a32445c 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -240,7 +240,9 @@ Valid `<type>`'s include:
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
 +
-`--type=color [--default=<default>]` is preferred over `--get-color`.
+`--type=color [--default=<default>]` is preferred over `--get-color`
+(but note that `--get-color` will omit the trailing newline printed by
+--type=color).
 
 -e::
 --edit::
-- 
2.21.0-4-g36eb1cb9cf

