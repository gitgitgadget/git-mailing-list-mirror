Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733A91F404
	for <e@80x24.org>; Thu, 13 Sep 2018 22:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeINDNQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 23:13:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43274 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeINDNP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 23:13:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so8283658wre.10
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ykzYjUBAdUaum5SnR//VHC9E6V1oBVfIGBx9OjK18uc=;
        b=geJ1ipYXyzO48VkIfLVMUxDhauppA5dPTxtMcWj3+3Wu96tAamhmyUtajAzGWZY314
         +SmKpgMKxst9hqGvZnkVf2ZmZcmANjVovP/e4QImjKmHnPyrXGzZIJA8+DOjNcYHs4Zs
         JNL8mZFBaI1OT8xZRvBf5FGbxS/31ExZU7g1w12rAj92c66beAHHrhGf7ZrCPVT3PPAk
         GQWvGBgFUGAA4bEY9VEgfnX5yIoDFH88KGAKwJBOP7cLaAZeU1BFM7H/kXsETsePZGM3
         5FJBdO2k0SUoh+9TDqHf0dN6i5k/qr/rYVuy/jIzUJfWnxnCTUCwMWwEr7McCgGgGNu/
         /CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ykzYjUBAdUaum5SnR//VHC9E6V1oBVfIGBx9OjK18uc=;
        b=qB8dkjmjIGkjMjc5gna/rdqpaizgrYFN25XsSwot6oL4ORktDnk0MsF3U36cRPO5p5
         7QMl0ZPoezXpr/p7+coBcMObG7iTuLpYP6SmsvgBxt7b+t56LaMwcw7szoDiv7BJpkhL
         7Y7EsamLNx6uXp8OJOMfBcp8PqIge3GGR6K6Auim/ruePWSPvGRF4g6/Hghp7HJ4DavY
         dq3IOSG49BeLy1xaGe0fbraLNR1e8O+hl/hLPvyMpmmnEhow36o4FIdaEd38UtZDz27/
         j3D6+sV01SsF7l6MnPsSDcOxnuCsNG+fdiUVpH+qZ+cbEKJF4Qr32KwQGXae6q1IkZpr
         Q+yg==
X-Gm-Message-State: APzg51Du4MyFAYsdAT7EK1NxFstCkVXEeOQl6a/PlB5W2q8smAlJO2PE
        wHnXq4vfN82M4LWmkkGGHJl1L5zA
X-Google-Smtp-Source: ANB0VdYUlgqEqSafOsQJkz9Qx31S2ajUFebZuHylFpvolagi3fDTLf1WW9jNqZgdNVVjynCbNrAYKQ==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr13756wmg.123.1536876111050;
        Thu, 13 Sep 2018 15:01:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t25-v6sm44116wmh.15.2018.09.13.15.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 15:01:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shulhan <m.shulhan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/remote: quote remote name on error to display empty name
References: <20180913131833.32722-1-m.shulhan@gmail.com>
        <xmqqpnxhdq0z.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Sep 2018 15:01:50 -0700
In-Reply-To: <xmqqpnxhdq0z.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Sep 2018 14:51:56 -0700")
Message-ID: <xmqqlg85dpkh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Have you run "make test" with this change?  
>
> I expect at least 5505.10 to fail without adjustment.

For now, I'll queue this on top, and if this turns out to be
sufficient, I will squash it in.

 t/t5505-remote.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 241e6a319d..d2a2cdd453 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -145,7 +145,7 @@ test_expect_success 'remove remote protects local branches' '
 test_expect_success 'remove errors out early when deleting non-existent branch' '
 	(
 		cd test &&
-		echo "fatal: No such remote: foo" >expect &&
+		echo "fatal: No such remote: '\''foo'\''" >expect &&
 		test_must_fail git remote rm foo 2>actual &&
 		test_i18ncmp expect actual
 	)
@@ -173,7 +173,7 @@ test_expect_success 'remove remote with a branch without configured merge' '
 test_expect_success 'rename errors out early when deleting non-existent branch' '
 	(
 		cd test &&
-		echo "fatal: No such remote: foo" >expect &&
+		echo "fatal: No such remote: '\''foo'\''" >expect &&
 		test_must_fail git remote rename foo bar 2>actual &&
 		test_i18ncmp expect actual
 	)
