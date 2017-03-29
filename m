Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B3C20958
	for <e@80x24.org>; Wed, 29 Mar 2017 22:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbdC2We3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:34:29 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35155 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbdC2We2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:34:28 -0400
Received: by mail-io0-f170.google.com with SMTP id z13so8481549iof.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YrBClZr7cakuODdlPyegbLZbHSaIC+Yoq23Jf0mXOk=;
        b=D5/ySwceUkYVNN/b/YILH5Nq2cc7Ilcpgr1fOWfQgIE/T1J3KX6Dpak4QzWnsF36Gs
         vDzqsJwvX+YS2Q+ex4hbyaKuMaLhpFbMFt7fludD9DqqNh5kf1NBFAivBDF4W4wIQbE4
         Mhv10H2e6crcM4R37CzrvkUsXh24XnNviLHTYLb0TfAZgD+AZW3rJtBKBwNBPKB39Vje
         rt5GB3pINrvZ8QP90OtbRaQlTalMJOZJ4eVZhPBeZPDB00p67PqnG9FZ1JtP2qIdkbw7
         t55Q6osRuuZhOFzwmC1mEUTahs0MFV7TIQQmgZpwgxE8yq1v1vi2t37NUMB3qIjHhyDW
         OkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YrBClZr7cakuODdlPyegbLZbHSaIC+Yoq23Jf0mXOk=;
        b=UDTprGeKl5rNcHWrbKRmaNJSq1SRr/FETiUUSmcnUIXKQdyUXXw77qT48fyaLtmj+P
         CpGyfSrqXEE//cVWy+NEYigd2/yce97BRA7WDc6mJ67hveKpneesw3XSip5RJRJ4kfHQ
         aHL+MG9XYiVVGC4ccZ5uO9gZl1CsJE97WS/xzMbRX1CxU8xJ89OyGp0Jx0lO8oXBXziL
         EHUWdHxzKgMBhFGZ149pA3Cj3I0pn+IymWTSPCBNsmK/xrtaqJTdPwXv1QSyT5cNKXJT
         znx3gHihEppo+h/Svpq5QMvLCGg4VOC12qimHF98voPtcfmQuTIgEvDUpWBUG1m+w8Wi
         kdEQ==
X-Gm-Message-State: AFeK/H0bvGjWzBIyoaHHRQn8Z0U4dyqHHII/RPXs0VdS89Ofx49ZPUSQsLKvbm7zjHy5e+9B
X-Received: by 10.107.8.91 with SMTP id 88mr3307185ioi.142.1490826866882;
        Wed, 29 Mar 2017 15:34:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id c76sm4043854itd.11.2017.03.29.15.34.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 15:34:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] unpack-trees.c: align submodule error message to the other error messages
Date:   Wed, 29 Mar 2017 15:34:24 -0700
Message-Id: <20170329223424.4678-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.442.ge9452a8fbc
In-Reply-To: <xmqqy3vn93a9.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3vn93a9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the place holder in the error message is for multiple submodules,
we don't want to encapsulate the string place holder in single quotes.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> Nitpicking about wording: unless the user has adopted a strongly
> object-oriented point of view, it is Git that cannot checkout a new
> HEAD, not the submodule.
> 
> How about:
> 
>                 _("Cannot update submodule:\n%s")

> That's vague, but if I understand correctly the way this error gets
> used is equally vague --- i.e., a clearer message would involve
> finer-grained error codes.

Makes sense. Here is the patch.
Let's roll this as its own instead of waiting for the discussion on the other
patch to settle.

Thanks,
Stefan

 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8333da2cc9..0d82452f7f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -167,7 +167,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
 		_("The following working tree files would be removed by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
-		_("Submodule '%s' cannot checkout new HEAD");
+		_("Cannot update submodule:\n%s")
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
-- 
2.12.1.442.ge9452a8fbc

