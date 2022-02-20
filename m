Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4407C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 19:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244683AbiBTTsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 14:48:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbiBTTsD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 14:48:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A818BB847
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:47:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o34so8378367wms.1
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B/r84I/t8D2SurBjE+JQEG7aveLCjjILT3Gqm+/qgSE=;
        b=j8pwmiOR4Lss3Nprcsb8LkklrhVRHqcg9EaLqPskW8GRX05euXr+zNJGVkk0dNouQb
         33BIVSiWZ4Nw+QoZzaP2SYYEhqpJsZtveCAZzKhF9645vOsvzFqKVcF6U427cS+/DPKI
         iKSfpuuRax5aVOgpEVILyyRS2UoGSop+eK3kcnioibauTd/q7NlIdnNsn1d2LWLaEBQs
         yYff+soUnuuph2czOsNHKh/HZv/3qJTiLsejUIz8w7tyQBYujZXbVKjgCc/B6vHKjl/f
         qBJd5aa/AUBwCfbUJh1zniV/gMMfqQJKS0phPKFZZEdglmi4tsF2gd4STrXJvHLtEuZ/
         9JQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B/r84I/t8D2SurBjE+JQEG7aveLCjjILT3Gqm+/qgSE=;
        b=bYryFtGLbjcUDWarx6WkdyyYnjfPx/aruoGETPaISi1Y70otOOEVPOM4zFbsLr3oc9
         G4ypSFVJv99lQNL2Xiiom8saZnH7M6vliCKHYWQMZ/yfoezrDNe+u08y+i2D+kyg5MTM
         HbHY/ytIeKnj2Ui85ncOT0nHrEa1I362mQTT2Y0mqnYHhqIwiXV2xwpoEOkGLUTcHdGN
         TCRAbwJp3FWLvtG0LbK+gY/f30Z9DTiifVqpGoPDDtO865QAE2++pXpUxAD651/1bkoM
         j/5WRgWFeqdtkUjwpUlLqLPs8IvzdyPrhuyo6hh2eto8rb0yyp65SvpYu+kMGL6BB2rg
         VycA==
X-Gm-Message-State: AOAM532kGQFCUeQmPfr7W+vl1UD4OcOr3G3SKvbqnJecq2rTKB9Fdnvd
        kalLg9ggXAw/akROXV1L469QTLDc0SA=
X-Google-Smtp-Source: ABdhPJyzrDIHGjoaeLDro3Re258acN4KgUosz/nMTrKJoT92iQApV5324SlAwWT2XXKM3cVtV/PeBg==
X-Received: by 2002:a05:600c:1d28:b0:37b:dcc4:dc2b with SMTP id l40-20020a05600c1d2800b0037bdcc4dc2bmr18974564wms.76.1645386459975;
        Sun, 20 Feb 2022 11:47:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b00354d399ef32sm5668284wmq.39.2022.02.20.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 11:47:39 -0800 (PST)
Message-Id: <0b5b8fb591e434a2a24b1f58d1ce3fc7da48a28e.1645386457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1219.git.git.1645386457.gitgitgadget@gmail.com>
References: <pull.1219.git.git.1645386457.gitgitgadget@gmail.com>
From:   "halilsen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 19:47:36 +0000
Subject: [PATCH 2/2] gitk: include y coord in recorded sash position
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Halil Sen <halilsen@gmail.com>,
        halilsen <halil.sen@mapotempo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: halilsen <halil.sen@mapotempo.com>

6cd80496e9 ("gitk: Resize panes correctly when reducing window size",
2020-10-03) introduces a mechanism to record previously-set sash
positions to make sure that correct values are used while computing
resize proportions. However, if we are not using ttk, then sash
represents only the x coordinate and the recorded sash (`oldsash`) only
includes the x coordinate. When we need to access the y coordinate via
the recorded sash position, we generate the following Application Error
popup:

Error: expected integer but got ""

expected integer but got ""

expected integer but got ""

     while executing

"$win sash place 0 $sash0 [lindex $s0 1]"

     (procedure "resizeclistpanes" line 38)

     invoked from within

"resizeclistpanes .tf.histframe.pwclist 2818"

     (command bound to event)

To fix this, if we are not using ttk, we append the sash positions with
the y coordinates before recording them to match the use_ttk case.

Signed-off-by: Halil Sen <halil.sen@gmail.com>
---
 gitk-git/gitk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index c31a8b4e2f8..0ae7d685904 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2991,6 +2991,8 @@ proc resizeclistpanes {win w} {
         } else {
             $win sash place 0 $sash0 [lindex $s0 1]
             $win sash place 1 $sash1 [lindex $s1 1]
+            set sash0 [list $sash0 [lindex $s0 1]]
+            set sash1 [list $sash1 [lindex $s1 1]]
         }
         set oldsash($win) [list $sash0 $sash1]
     }
@@ -3023,6 +3025,7 @@ proc resizecdetpanes {win w} {
             $win sashpos 0 $sash0
         } else {
             $win sash place 0 $sash0 [lindex $s0 1]
+            set sash0 [list $sash0 [lindex $s0 1]]
         }
         set oldsash($win) $sash0
     }
-- 
gitgitgadget
