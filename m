Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB77C1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 15:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbcHLPh4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 11:37:56 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34597 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbcHLPhu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 11:37:50 -0400
Received: by mail-pf0-f178.google.com with SMTP id p64so10143836pfb.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 08:37:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=N5rQOQe/o6wI64BO+O7O940BqCGWRQWm0fh0fG360Po=;
        b=YplNw6tCTTLXoEHDEzcfyw+3RaxQf04RhZW4hXqIVYsoyYCKIcu39IZpcA0gajmeH0
         oJD3TpasapkkhIBbgcMr6CzAi8t1kMSXk+cpVGd16rK+D6VUHrjfQhhPl/If0/t2+jDL
         TSrmaor5dnEa8Gbv9wkcoaBaQM52c+QAaJqGX6mc9GYnvCNCvw3w3sK7oeBch06uXApA
         QfjpnXuaOYGDvq7SKUP9wRtMasvj75RFZhVbJxh6drlHhJNPQSxffJRDP2EjFHVa1j2B
         27o0uDDW4G3BJcfSvxl9BzrlkhXU1zW/A6w3FPbKOnbD7oqJlltcDYS0qSjE6zytFFsc
         nrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N5rQOQe/o6wI64BO+O7O940BqCGWRQWm0fh0fG360Po=;
        b=SyHsuuxbOz37ElZRzIY7YCIhm0Yym20fvEpnk1APpvCXNXYZfZ9etxd4B16FEc3vIS
         Epn0ohJrElmrFBYsXbkuCGYaZLKUPY5+8GT39+Gje4E9T18c9669GMGS+yuRlQVY+BF6
         ILws3lm8rXD6X69r55EVy7UIc+gh0dI5RIMfLJz6a8NPuRa+Cano9y67R/1i5SG0Jpcx
         z86XEUPkwTjDxbnMQKoCzMvybTT7daPiowfNZIZDZ02lXx0XOQKKaXdFgVk11U/rKmfV
         b4bTIvEEngo6iqNWLgAmoeUwjss6eeVRQXvAw4xTKuCkUfEeWSSDwM8fjRspcdXszp2a
         tBEg==
X-Gm-Message-State: AEkoous6Hg2IDontVcNk7ONnbghWmN/N51Zbz/GA/zQudZThWNYZaWBc6TTD2DZNT5DOhXdz
X-Received: by 10.98.75.219 with SMTP id d88mr28550979pfj.91.1471016269203;
        Fri, 12 Aug 2016 08:37:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9ce8:bfb9:108e:f4e6])
        by smtp.gmail.com with ESMTPSA id bx9sm14016021pab.17.2016.08.12.08.37.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 08:37:48 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, jrnieder@gmail.com
Cc:	git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] checkout: do not mention detach advice for explicit --detach option
Date:	Fri, 12 Aug 2016 08:37:44 -0700
Message-Id: <20160812153744.15045-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g46b112d
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When a user asked for a detached HEAD specifically with `--detach`,
we do not need to give advice on what a detached HEAD state entails as
we can assume they know what they're getting into as they asked for it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Thanks for the review!

> Is there a reason for not unsetting `advice.detachedHead` at the
> end of the test?

done

I did not consider to clean up after myself... what a selfish world!

Stefan

 builtin/checkout.c         |  2 +-
 t/t2020-checkout-detach.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8d852d4..85408b1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -658,7 +658,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		update_ref(msg.buf, "HEAD", new->commit->object.oid.hash, NULL,
 			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old->path && advice_detached_head)
+			if (old->path && advice_detached_head && !opts->force_detach)
 				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 5d68729..3ee60fb 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -163,4 +163,18 @@ test_expect_success 'tracking count is accurate after orphan check' '
 	test_i18ncmp expect stdout
 '
 
+test_expect_success 'no advice given for explicit detached head state' '
+	git config advice.detachedHead false &&
+	git checkout child &&
+	git checkout --detach HEAD >expect &&
+	git config advice.detachedHead true &&
+	git checkout child &&
+	git checkout --detach HEAD >actual &&
+	test_cmp expect actual &&
+	git checkout child &&
+	git checkout HEAD >actual &&
+	! test_cmp expect actual &&
+	git config --unset advice.detachedHead
+'
+
 test_done
-- 
2.9.2.730.g46b112d
