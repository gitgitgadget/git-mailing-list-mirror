Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B924C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhLISxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhLISxk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:53:40 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC547C061A32
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 10:50:06 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id r23-20020a17090a941700b001a74be6cf80so4131784pjo.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ceiIiKjHHxs4kxfdiDQ7XtGkI2rq7i8hS9RoA31blxQ=;
        b=S7XSeutx7ZlfCht1BwNDMwHLZAF+qbdPHDIGVE7oG/DtgGQqM+CQ95NTMvaWm2p9tk
         DEcXJf1oUgidauHBkgda8vX+4bbTQtTZZCiJLsUcuslfjJGOykTrVE0E1TyFowihepJk
         faZqdoxxmzZW07VPerFxliHRsGGMOaKu3xbW7JouUcoltgb7NS2wODXnCkegNReZ7D+0
         J5qwyGgBosu1Ylw9r+0NDYI6ggRNbBNj4G4B8WOK6p3DJAWmUuLG8AUNPNwrcIs0CH7I
         YZaQzTtMM+4namlLRiOH4hSHBiM+VkWFOsEr1Ese3H/sqhZKWcPjl8ln5gsLB9sHVpHE
         LnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ceiIiKjHHxs4kxfdiDQ7XtGkI2rq7i8hS9RoA31blxQ=;
        b=i2CHkOPxUfw33cuk6AYjVOQvm2J2HKzvaLE73KYt4+65Soe09zNfDHbU9X0APNqQKv
         Trv/nAjhe3Qukw89238gky9PCwcSYy2AUnb4mxTA83utHQFkGVpBMBBbfHHvBX6MFcOe
         fb8Z7QmCIpjAUeLtXBkCZTUdrRPzBZibyLRUF69T6+rA/hlxGlIEn4Gpp2+vvIMF92UE
         ge0X46MXMxzS4t9TxUD3fWBCu5+RI7F08o0/lUKo/CRoGUzuFu9WJbzTUgMvhMolBj+9
         RBLaANgWXqZ4z+tE2dtXFPZ3vz9xo2Ac26hKhZc9ycfYLReqDYNis0KMt7DORPJq+jhO
         FVtQ==
X-Gm-Message-State: AOAM532WFzAAlVOInSdDxqKYN7wDN6ZGOZxaNKQ+GvCOG3STP/Jo0UT1
        LhghHspBu6G6+Pz7aLOYv5RVer4NKacj4c/RO4/+JnKT1ut+tC2UAGwt75RVYapY79rHuGapByK
        2p2z7JZ/vSDZ9eN2QixAxHDsZd5UjdwJcr1+FBiNi1+I2JPPe8Ayauef1C59TDko=
X-Google-Smtp-Source: ABdhPJz2Dt5YuBqrdo+A9qm1jH3Wsfz5+h6XJWP4dhurCNFsLKswOSzSwIeyuz3H66Vw5RX72Xw8X0unJYUiTQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:2445:b0:142:2471:644e with SMTP
 id l5-20020a170903244500b001422471644emr69503133pls.48.1639075806326; Thu, 09
 Dec 2021 10:50:06 -0800 (PST)
Date:   Thu,  9 Dec 2021 10:49:28 -0800
In-Reply-To: <20211209184928.71413-1-chooglen@google.com>
Message-Id: <20211209184928.71413-6-chooglen@google.com>
Mime-Version: 1.0
References: <20211206215528.97050-1-chooglen@google.com> <20211209184928.71413-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 5/5] branch.c: replace questionable exit() codes
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace exit() calls in branch.c that have questionable exit codes:

* in setup_tracking(), exit(-1) was introduced in 27852b2c53 (branch:
  report errors in tracking branch setup, 2016-02-22). This may have
  been a mechanical typo because the same commit changes the return type
  of setup_tracking() from int to void.

* in validate_branch_start(), the exit code changes depending on whether
  or not advice is enabled. This behavior was not discussed
  upstream (see caa2036b3b (branch: give advice when tracking
  start-point is missing, 2013-04-02)).

Signed-off-by: Glen Choo <chooglen@google.com>
---
I don't know what the 'correct' exit codes should be, only that Junio
makes a good case that the existing exit codes are wrong. My best,
non-prescriptive, choice is 128, to be consistent with the surrounding
code and Documentation/technical/api-error-handling.txt.

 branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 305154de0b..ad70ddd120 100644
--- a/branch.c
+++ b/branch.c
@@ -324,7 +324,7 @@ static void validate_branch_start(struct repository *r, const char *start_name,
 			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
 				error(_(upstream_missing), start_name);
 				advise(_(upstream_advice));
-				exit(1);
+				exit(128);
 			}
 			die(_(upstream_missing), start_name);
 		}
@@ -398,7 +398,7 @@ void setup_tracking(const char *new_ref, const char *orig_ref,
 		string_list_append(tracking.srcs, full_orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
 			      tracking.srcs) < 0)
-		exit(-1);
+		exit(128);
 
 cleanup:
 	string_list_clear(tracking.srcs, 0);
-- 
2.33.GIT

