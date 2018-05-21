Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2751F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeEURla (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:41:30 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33997 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbeEURjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:39:16 -0400
Received: by mail-wr0-f175.google.com with SMTP id j1-v6so5845317wrm.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=26+EVovvouLsd90p+0Oc+gTUN4tFzM33z7MLHumP/wU=;
        b=D9RTfBEKF179Ri5OnrAB91OWnAmiFp7A2uFAt203inVBEKG7h0HCxIcEvs8beQvMcJ
         jwxbD8nps8oXFoxAZFuS/fgphaRxbmpKimDeJt28nHm6ALlzxRoi+dM+c+cMJNm4B9zD
         hiS9afL6wzgNxBbVusDeqlmDIEWFJsD8iE8po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=26+EVovvouLsd90p+0Oc+gTUN4tFzM33z7MLHumP/wU=;
        b=Yi9Nzl880w6V8JfT/WvC5KCcymWKdaQav2/yzlHKJm9a/uRMvUqzE8/7JNXNk4O1Cm
         0oyUB052RGHN9guNAhmEpppuM6cJ+7sKB4Wjodeu7sr/KcUwOJGDvfpgZuqffGhZCGj4
         NnaEcZ2Qw5deQ6ftT1I+zx0lSqHUlcq8/Me9B81/Fh8k04Pn+Mf3h9C5kyjqjBuac2nG
         HWUXhcrZG6bv8bNRBOp36M1luMS5Q7zHl4vteCs2np0zm/DAXiCgiI54+trp16UJFKBA
         0wu48IeTrwLnlzW3KEshVN6AdRWRmUljUPIDrTwLk6rtoJwMa/JrwFPPpv3fNd7Nu+58
         riqA==
X-Gm-Message-State: ALKqPwcRCiMniZD/4pWprTLpFIHBMhZEk4AT6t0r0qSFa+DFmg5zaIAZ
        x5TNe+yYAvG6683BsdzDL0FNb5kjamg=
X-Google-Smtp-Source: AB8JxZqnSb7VLVnRWEn+ImHvYVaWcprbrQKXRzCIPphFCqus/hcxzOnylOFCnd9KTXFCsFxAt1Vk6w==
X-Received: by 2002:adf:9ed0:: with SMTP id b16-v6mr14678421wrf.170.1526924354408;
        Mon, 21 May 2018 10:39:14 -0700 (PDT)
Received: from loki.times.labs.intellij.net (gw1.times.intellij.net. [195.144.231.194])
        by smtp.gmail.com with ESMTPSA id m15-v6sm15066671wri.8.2018.05.21.10.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 May 2018 10:39:13 -0700 (PDT)
From:   Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Bug in update-index man page
Message-Id: <91956FEA-B350-4F51-B882-24783C85D613@jetbrains.com>
Date:   Mon, 21 May 2018 20:39:12 +0300
Cc:     Aleksey Pivovarov <Aleksey.Pivovarov@jetbrains.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I've noticed the following text in the documentation pages for the =
`update-index` command:

       <file>
           Files to act on. Note that files beginning with .  are =
discarded. This includes ./file and
           dir/./file. If you don't want this, then use cleaner names. =
The same applies to directories
           ending / and paths with //


It seems that the phrase "files beginning with .  are discarded." is =
incorrect, because update-index works correctly on files like =
`.gitignore`. It also seems that even names like `./file` are handled =
correctly after cfb0af1d50247e66ea1d46014650e60e9cfb87b9. Could you =
please verify and fix the doc if needed.

Thanks!
Kirill.=
