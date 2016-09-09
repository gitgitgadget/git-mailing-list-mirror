Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AA01F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbcIIRgv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:36:51 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35262 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbcIIRgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:36:50 -0400
Received: by mail-pf0-f174.google.com with SMTP id w87so31428560pfk.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0SmFB/MbkY+qVv3KnKotGUlp/GQ6rR9XYyI5KQyN1gU=;
        b=fUUmoLOCsXMTgbpm4suurtVBVm5/tv8b++Wn4n0mQS4U4fBF/qbFluJi6nyGOxuZnY
         9/ihIozLbPvzSDRtnsH1Mv/BX3wvThw2Jd9zjpCrfqo5IMrw5aLUq74WRZW3VfEd+bHn
         2txYdrkAydQac8VQmOeYXprKXhm4lDn2lebJVDlKC3kqgexI3sP17eLwVRqLVbrtz94Q
         9yYDl6jCXkg24e5myiboorBSscTbU4b74iGMdBrmRTqFr+v4xzTeD26xKxT9kg+yf53i
         3MM5qpt0uYbLo3+4b9Yi7/zByZOvri9utAeYq/5JHsOH3lnB5sXNxfmckFyAX7lHjeHH
         SdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0SmFB/MbkY+qVv3KnKotGUlp/GQ6rR9XYyI5KQyN1gU=;
        b=NFSOt0nCDZxjroG4wB0+191PilA6tydPSFkkMjrXhwzgRNi5jwQw7eWyQxzl60geT7
         MrrMIynhK7O/Q5YVO+izloU6uyuo7IlUaPUPMCjB0qT9irHGwPgsOiXnVtyHtu1abNeO
         l1lpbkz8OlMmpEHYyYldaT8knyp7bsib5JnSkXmZ0inOnEwL/GTGzpyF9xps3qqMi3KA
         IVVpv1aePiPUPPkozn+z0bSwfimgQb5vFSWVYecMZhqo6gJKkT11wBzIJDeldrJXGp0K
         sbhZ9TTbPpkqD/Hsqx4EoalursyugfhY+DzA1qEdN2o4dk+phX143+ta2e8dns9YXx/J
         5YPQ==
X-Gm-Message-State: AE9vXwOQQJRCrNBEEOkqKBkOM+tYTtu5jlIB0a4lRtA3fSe6L5hXyWhC2prrosRSQYPNKxaV
X-Received: by 10.98.145.18 with SMTP id l18mr8614450pfe.18.1473442608757;
        Fri, 09 Sep 2016 10:36:48 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id d5sm6759803pfc.4.2016.09.09.10.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 10:36:47 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 0/3] handle empty spec-compliant remote repos correctly
Date:   Fri,  9 Sep 2016 10:36:27 -0700
Message-Id: <cover.1473441620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updates:
o Included tighten-check patch from Jonathan Nieder and Junio C Hamano
  in this patch set
o Updated commit message following Jonathan Nieder's suggestion
o Updated warning messages to mention capabilities^{}

As for warning vs die, I would prefer the "liberal" approach of continuing on
when facing a recoverable error (that is, "warning"). But I agree that there
are good points in favor of using fatal errors ("die") and I can switch to that
if there is consensus.

Jonathan Nieder (1):
  connect: tighten check for unexpected early hang up

Jonathan Tan (2):
  tests: move test_lazy_prereq JGIT to test-lib.sh
  connect: advertized capability is not a ref

 connect.c               | 35 +++++++++++++++++++++++++++++------
 t/t5310-pack-bitmaps.sh |  4 ----
 t/t5512-ls-remote.sh    | 40 ++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |  4 ++++
 4 files changed, 73 insertions(+), 10 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

