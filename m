Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D7C1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 21:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfDYVKh (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 17:10:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44328 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDYVKh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 17:10:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so442754pgv.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fcZyyOOEwKmdz3zEK91QYfJGeBg6VIjt4tEE3uvAhuE=;
        b=b5Mm2CzTCn/ZlLW2FZS9q7g5HpGD5hQq7ZTvHCN1Kp8Z0vnNQ4aRWk1apR15Vg6P0Z
         pkhd2bduGAzbh+rnkxtltpO4UEQg7/iiIait69GcRgYgkF8HWBUIlHCGmYE+qeBItdh0
         nMDOXk6GAZMtyxtRqhqQLi+592a5FUTib8MVIXIrF9AF/jbZYHxOxLS0VvST580WKUS5
         CxyASm+0xyyqv+Ve9ETOw/jyVMRfslXXNGnaHUnDF4b52/2gmF33jRfmHBQUj8ErevL0
         DGHqLIGwNgktdwmb5DLWDIoMuPMPsqtmLTRSjIS0/euH4CGi59OZJ7KRt0soK4Yq5x4E
         YcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fcZyyOOEwKmdz3zEK91QYfJGeBg6VIjt4tEE3uvAhuE=;
        b=QnNdbLqJYL52XpalR8LtsQdoiwLkxXX+9rS6+0tnuguC319boLATmm+gRiBGLj5yCP
         SUUl4cfwABx1/gaBeohBNaGF7ns9FVoS9LWeYj4l66y3+JwNgsFlSr7l9E9cNRbOrSUu
         2TBzfXgTe/6o+SHUTpL0C3LuMAzzsiHXvikbW7zxBZtOJjVnqzsRFAEOaCmorfXATczb
         MvIMQn/s1jYSLbx3EklaxOp9TJoZTTFyTvv4RF6MQwsQ4pdB4hY9lOEChzkBvMhgDOcg
         e3I43Hb6J/HLVlACFHYkho82y6Z6bhk/ehBZX2t8k7rDJpJLpEfnMdsNWncmK3/ZzQZ4
         pFjQ==
X-Gm-Message-State: APjAAAU/WnJ5IkTLBmP8ZCIH24iR/vPEhio2d44Pcx2tuPAx7FrF5K1t
        6iHbbJZRi6ebl7ZBrrs2HeAtAGrP
X-Google-Smtp-Source: APXvYqxnG/V5Vg8QzaaqZvTpZTX8LQfmlNyZEi//KWIt/sPfqqZuV4JjLipDjz5CE46ECe94+QlmyA==
X-Received: by 2002:a63:5466:: with SMTP id e38mr40207098pgm.340.1556226635989;
        Thu, 25 Apr 2019 14:10:35 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id l9sm3097176pgq.48.2019.04.25.14.10.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:10:34 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:10:34 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] checkout: allow -b/-B to work on a merge base
Message-ID: <cover.1556226502.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed earlier that running

	$ git checkout -b test master...

would result in the following failure message:

	fatal: Not a valid object name: 'master...'.

I believe that this is a bug, so this patchset will allow this to succeed.

Denton Liu (3):
  t2018: cleanup in current test
  t2018: demonstrate checkout -b merge base bug
  checkout: allow -b/-B to work on a merge base

 builtin/checkout.c         |  4 ++-
 t/t2018-checkout-branch.sh | 52 +++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

-- 
2.21.0.1033.g0e8cc1100c

