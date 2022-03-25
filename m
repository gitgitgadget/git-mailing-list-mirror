Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AEAC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355233AbiCYOg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiCYOg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:36:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0587654699
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:34:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h23so11138753wrb.8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjRkRGElWytia6j3AsOmblyFcJ/YZrTH65Ed2hoYiZQ=;
        b=qP1krfLFDeNnLj5xzZaUC8E9SZwpi3Wd+Yyu99rXbnNA4hhSuc92Qo8QJzTI0Dxuyo
         XMYQB8rgCb8s9WY8Z43s/eNt+UCDW/BSNCUqcmGAXkMoAFBrjRObqK7v4/TNL48IE55n
         jYBGld+AeQHz1ii0SLkfcqlF7lcmvxyrx6Abd1xnTaUbuF2yFLqOKaWZ/OlqTrHr/VnV
         ad3RzB+cKi6BY8RFz6v4bDuKpU6H90eGcVlxcwKpxhc5d8KzNPRYgyhiIJpsDz52sKg/
         qZdbdx80zBhKGexLPp3HHLdONG8Xf+k27x1IWGJuoMYNEcKo+gpEDVcz6VKbO7qPjjIT
         /+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjRkRGElWytia6j3AsOmblyFcJ/YZrTH65Ed2hoYiZQ=;
        b=0dTZtgJEbJZrRPyhfGD2LZpe1nRJVr/OP7BbuKGXCVTpcFMnMmdamQFQJenDgHkZCx
         Hub0EmhfvvUjVj1NH6DeVRFPr0y5iSDsJOYckwzz0exPNIvUhNGpBeqm9dvaH1rArYfo
         i+W1REreLUS099FBKoCftvt0JBUTWMI/lxULXP8rSWPRh4MWgZPQLmoOcyqaEURpzhgU
         lVyTthSEJjHiJtsJQ+xO5e4ufmkhXySe9zGAgc4TDPyxdQZhtZ1T0cofB6gwm9tJcnvm
         N2lUr/Xq6XJ6SY4PDCiOEX4QtzYTOKcS8jJ14Sjj5iujrNzA1qlYYZcqlB5oStmng1bl
         fXbA==
X-Gm-Message-State: AOAM531oTP9TvYEMR7drPGRaUPAV/mxlWen++KYiE5mt9U7yjESGmv7j
        N1vyn8/LD4cSzI15tNtDoan1NU3RtFEwBQ==
X-Google-Smtp-Source: ABdhPJyd9FoShVVCYLOKFGfTYxJGo+cK5dx4L57HVP4f0LpfJvwkoPKUY32/f+Gwh7hmPKuhCm9/gA==
X-Received: by 2002:a5d:47c1:0:b0:204:1797:2c98 with SMTP id o1-20020a5d47c1000000b0020417972c98mr9600219wrc.502.1648218892182;
        Fri, 25 Mar 2022 07:34:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b00203f51aa12asm5208180wrq.55.2022.03.25.07.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:34:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] http API: fix dangling pointer issue noted by GCC 12.0
Date:   Fri, 25 Mar 2022 15:34:49 +0100
Message-Id: <patch-v3-1.1-69190804c67-20220325T143322Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
References: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pre-release GCC 12.0 development branch has a new warning about
dangling pointers in -Wall:

    http.c: In function ‘run_active_slot’:
    http.c:1332:24: error: storing the address of local variable ‘finished’ in ‘*slot.finished’ [-Werror=dangling-pointer=]
     1332 |         slot->finished = &finished;
          |         ~~~~~~~~~~~~~~~^~~~~~~~~~~
    http.c:1330:13: note: ‘finished’ declared here
     1330 |         int finished = 0;
          |             ^~~~~~~~

This is on a locally built "gcc (GCC) 12.0.1 20220120 (experimental)",
built from gcc.git's 8bc700f4c3f (Enhance vec_pack_trunc for integral
mode mask., 2022-01-17).

The GCC warning is specifically about pointers that survive the exit
of the function. See a comment added to
"pass_waccess::use_after_inval_p" in the GCC commit that added the
warning, or:

    /* The use is one of a dangling pointer if a clobber of the variable
      [the pointer points to] has not been found before the function exit
      point.  */
    [...]

There's a few possible ways to fix this, but the simplest is to assign
NULL to "slot->finished" at the end of run_active_slot().

This isn't the only caller that assigns to "slot->finished", see see
the assignments in http-walker.c:process_alternates_response() and
http.c:finish_active_slot().

But those assignments are both to the pointer to our local variable
here, so this fix is correct. The only way that code in http-walker.c
could have done its assignments is to the pointer to this specific
variable.

It was suggested[2] to guard that with "if (slot->finished ==
&finished)", but that'll still trigger the warning.

1. https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=9d6a0f388eb048f8d87f47af78f07b5ce513bfe6
2. https://lore.kernel.org/git/xmqq8rv2nggn.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This should clarify the feedback on v2, sorry about the very late
re-roll.

I.e. I *meant* in v2 that it's the only assignment to slot->finished
itself is here, the other assignments in http-walker.c are to the
pointer to our variable here.

Range-diff against v2:
1:  777838267a5 ! 1:  69190804c67 http API: fix dangling pointer issue noted by GCC 12.0
    @@ Commit message
             [...]
     
         There's a few possible ways to fix this, but the simplest is to assign
    -    NULL to "slot->finished" at the end of run_active_slot(), it's the
    -    only caller that ever assigns non-NULL to it. It was suggested[2] to
    -    guard that with "if (slot->finished == &finished)", but that'll still
    -    trigger the warning.
    +    NULL to "slot->finished" at the end of run_active_slot().
    +
    +    This isn't the only caller that assigns to "slot->finished", see see
    +    the assignments in http-walker.c:process_alternates_response() and
    +    http.c:finish_active_slot().
    +
    +    But those assignments are both to the pointer to our local variable
    +    here, so this fix is correct. The only way that code in http-walker.c
    +    could have done its assignments is to the pointer to this specific
    +    variable.
    +
    +    It was suggested[2] to guard that with "if (slot->finished ==
    +    &finished)", but that'll still trigger the warning.
     
         1. https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=9d6a0f388eb048f8d87f47af78f07b5ce513bfe6
         2. https://lore.kernel.org/git/xmqq8rv2nggn.fsf@gitster.g/

 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index 229da4d1488..2f67fbb33cd 100644
--- a/http.c
+++ b/http.c
@@ -1367,6 +1367,7 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+	slot->finished = NULL;
 }
 
 static void release_active_slot(struct active_request_slot *slot)
-- 
2.35.1.1509.ge4eeb5bd39e

