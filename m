Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633C01F453
	for <e@80x24.org>; Fri, 28 Sep 2018 01:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeI1IEh (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 04:04:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46824 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeI1IEg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 04:04:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so4550211wrr.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1YYQYQ4rHfmuNXJL3foRHgkeQbnwQTZS1Zh4+tknlKg=;
        b=YVvQOzzhOL70hfO0UCjpbuQGPfrm7SJYxcX+17jfxMthWxsfS2k4wc5ofgApLblxYe
         8x2Q2UZPBA3YhZFkvq6PCTDWMiuWLOTovQoShbAn/k9nwRd1xQVN7EATTRKT1fL4D0pv
         T2ZAl97OLLJqElbzOV7Uku1lHQQtJPaUqJKhQz0B5C83JBorC3FUj43s+CHUCMb24cRw
         s3NT+YeAumopUus6JQ9b9SL1jlh89nPcDmXj5YXT9tnTZ74l+8411f1HhjG/Go+285Su
         jSifSmTSrHi1CkVlw/NL7g7vs0Qp7eGsqEkdONxvo4XPzfhPhxp1idKGMM1yUrT/5y0e
         vrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1YYQYQ4rHfmuNXJL3foRHgkeQbnwQTZS1Zh4+tknlKg=;
        b=I05K2CUKree6yKV+BeQVdT2h7LUhmVX5n/sikadcwBoxDWroRQzok05oDlgkY0wTpz
         s+ko+q5Mp+3q9ZbpBzjAsPIn0Xtx8oRsstFtDI9/CcIQl3Vw5JyQZQwElb5k/5hKHU1H
         0XOF67SVM3sc/JmMvKkTxaPdSAD5dCGUlirBrtQnmHc5ZzQuWSppUr5hZYHzCgZoMtlF
         aiFBj1qzk7bMqKgRoHINIT6s/980tG+0bBthOPXeiCPP4gFF9D6kv7LNjOwkl5U17Pz7
         iPsAs3ie0t2WIRd6jPpAnYLPM6JyzDVy/fo3mFsAuUwCIBivKV7He/SNK5AUIK2ASHad
         jJ4g==
X-Gm-Message-State: ABuFfojEGa73LMrAt2i74uJn1GXHJDZJ9OKVN2YbzDOWLVLH5Yo4/gj+
        T2wwNX3YPDEhwH5kBvJSHfw=
X-Google-Smtp-Source: ACcGV60+SUV8dEz3lluhQnL8YFG4Qeg4Iy3Jw//+E1Fp3aQaeC1kbBKGBvHamqe2ClmdLyR9nkJOxA==
X-Received: by 2002:adf:8483:: with SMTP id 3-v6mr10942540wrg.34.1538099003850;
        Thu, 27 Sep 2018 18:43:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z89-v6sm7668974wrb.3.2018.09.27.18.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:43:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sam McKelvie <sammck@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: Alllow staged changes for get_superproject_working_tree
References: <20180927181054.25802-1-sammck@gmail.com>
        <xmqqbm8ifvka.fsf@gitster-ct.c.googlers.com>
        <D09E2583-BD1D-4C56-9C19-6B1E97CEEDAA@gmail.com>
Date:   Thu, 27 Sep 2018 18:43:22 -0700
In-Reply-To: <D09E2583-BD1D-4C56-9C19-6B1E97CEEDAA@gmail.com> (Sam McKelvie's
        message of "Thu, 27 Sep 2018 17:30:21 -0700")
Message-ID: <xmqqmus2e6rp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam McKelvie <sammck@gmail.com> writes:

>>> Subject: Re: [PATCH] submodule: Alllow staged changes for get_superproject_working_tree
>> 
>> s/Alllow/allow/;
>> 
>
> Ok, no caps on first letter of subject.

Ah, that, too.  I meant to correct triple ell, though ;-)

When one reviewer says Reviewed-by: but you later found that the
patch was not good enough to deserve a redoing, feel free to redo
the patch and do not add the Reviewed-by: you got for the old one
to your second submission.  The difference between the one that was
reviewed and the one you updated invalidates the stale Reviewed-by:,
essentially.

Some reviewers explicitly state "With this and that nit corrected or
left as-is, the patch is Reviewed-by: me" to tell you that as long
as the difference between the version reviewed and the updated one
is limited within the named issues, you can add Reviewed-by: to your
rerolled patch.

In this case, I think the nits are pretty small and I do not mind
tweaking the version we are discussing on my end, without having you
to send an updated one.

Here is what I'd squash into your commit, with title corrected, if
you are OK with that plan.  In the meantime, I'll keep the following
as a separate patch on top when I merge your fix to 'pu'.

Thanks.

 t/t1500-rev-parse.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index b774cafc5d..01abee533d 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -134,6 +134,7 @@ test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
 test_expect_success 'showing the superproject correctly' '
 	git rev-parse --show-superproject-working-tree >out &&
 	test_must_be_empty out &&
+
 	test_create_repo super &&
 	test_commit -C super test_commit &&
 	test_create_repo sub &&
@@ -142,20 +143,20 @@ test_expect_success 'showing the superproject correctly' '
 	echo $(pwd)/super >expect  &&
 	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
 	test_cmp expect out &&
+
 	test_commit -C super submodule_add &&
 	git -C super checkout -b branch1 &&
 	git -C super/dir/sub checkout -b branch1 &&
 	test_commit -C super/dir/sub branch1_commit &&
 	git -C super add dir/sub &&
 	test_commit -C super branch1_commit &&
-	git -C super checkout master &&
-	git -C super checkout -b branch2 &&
-	git -C super/dir/sub checkout master &&
-	git -C super/dir/sub checkout -b branch2 &&
+	git -C super checkout -b branch2 master &&
+	git -C super/dir/sub checkout -b branch2 master &&
 	test_commit -C super/dir/sub branch2_commit &&
 	git -C super add dir/sub &&
 	test_commit -C super branch2_commit &&
 	test_must_fail git -C super merge branch1 &&
+
 	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
 	test_cmp expect out
 '
