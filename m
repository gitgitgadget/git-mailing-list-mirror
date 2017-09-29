Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6933120A2A
	for <e@80x24.org>; Fri, 29 Sep 2017 09:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdI2JpC (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 05:45:02 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35043 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdI2JpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 05:45:01 -0400
Received: by mail-pg0-f67.google.com with SMTP id j16so1076726pga.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fkoXDKEt+i5fAiEGVwng0eB1lp3T7GSb9F8EpQzQNl0=;
        b=Lf/9MFTRMo+7ZuhTpRsN6SVvYuc2ccnUHhFv6h8QGzPprmutmeW/DKdWusjv5DzC6f
         ZARHCZ1zTZFBrT7mYMM2230kMhbpnQpIM5PRHkO44YoQwFw1DLz2zJLINSTE3HpwNDb3
         mBkE/b5GCL2RRRoNhXjnGWclMF9vubxoSpPpbM/h6GwPNzx2VoRd/LnLPMT6Uu0JDcpx
         9GaBKZTK53ztuj/CWBKGpoKLVMkD1LCkXz9Exuc8tCmO9g2HYUvcqePE+v3wOTzwcNQA
         3B3HbKgGXznSDpvF5P6CP5sr1LbMzr1u3hmklLjmzhtBdvHcsBhKk2NSMwoSxoGA9KFz
         3/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fkoXDKEt+i5fAiEGVwng0eB1lp3T7GSb9F8EpQzQNl0=;
        b=rAGlIbLLJEDau7/9er8kdUr8C3mqlUJVsrERxRj2eJQZO84ScdelkrgAIlHn03iSRc
         MMXwbB6oE16jhodpGp4digoxxaZLMACtB1ndEOaTZ31bvub7mMTFB4/r8EtZc26lKQKq
         JqzpVoTWT6Uy55WpdHA4I33ErAGPVaUwItu0fdyHwBUY2aSP08bEnXU4wlPdNy5qiHel
         KurnfJiMo5H+Vv5VjFR0u3Qo95f7yV87ePhgIh5zqeK0L/9U6RBvqLWNAL7wuiVR/JzR
         58qrpC0DZK3GvX44TvUbhPFYLapnYG4rmMpwELMcPQFIjZ16nBXFFFPm9qGuJm9KY9Ms
         diZA==
X-Gm-Message-State: AHPjjUgT+9YSTSwAlkGLKYCThM4RsZyVM+aQRGUMGo1Ba+FOfan7F54u
        XDF5s0hG1t1KP1y+vKI1FXA=
X-Google-Smtp-Source: AOwi7QDCffB3kLAR4uncfn1I8T9M7LQEfjc+rbGMfkV396sCtK2Ba9cvuU2tOUGLT8fKU1lHspbmPQ==
X-Received: by 10.101.68.65 with SMTP id e1mr6921920pgq.134.1506678300755;
        Fri, 29 Sep 2017 02:45:00 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.87])
        by smtp.gmail.com with ESMTPSA id s76sm6930477pfj.119.2017.09.29.02.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 02:45:00 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sbeller@google.com, Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v6 0/3] Incremental rewrite of git-submodules
Date:   Fri, 29 Sep 2017 15:14:50 +0530
Message-Id: <20170929094453.4499-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
References: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

changes in v6:

* The function get_submodule_displaypath() was modified for the case
  when get_super_prefix() returns a non-null value. The condition to check
  if the super-prefix ends with a '/' is removed. To accomodate this change
  appropriate value of super_prefix is passed instead in the recursive calls
  of init_submodule() and status_submodule().

* To accomodate the possiblity of a direct call to the function
  init_submodule(), a callback function init_submodule_cb() is introduced
  which takes cache_entry and init_cb structures as input params, and
  calls init_submodule() with parameters which are more appropriate
  for a direct call of this function.

* Similar changes were even done for status_submodule(). But as it was
  observed that the number of params increased a lot due to flags
  like quiet, recursive, cached, etc, and keeping in mind the future
  subcommand's ported functions as well, a single unsigned int called
  cb_flags was introduced to store all of these flags, instead of having
  parameter for each one.

* Patches [3/4] and [4/4] from the previous series were merged as a single
  step.

* Call to function cmd_diff_files was avoided in the function status_submodule()
  and instead used the function run_diff_files() for the same purpose.

Since there were many changes the patches required, I took more time on
making these changes. Thank you, Junio for the last reviews. They
helped a lot for improving the patch series.

As before you can find this series at: 
https://github.com/pratham-pc/git/commits/patch-series-1

And its build report is available at: 
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series-1
Build #184

Prathamesh Chavan (3):
  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_listed_submodule()
  submodule: port submodule subcommand 'status' from shell to C

 builtin/submodule--helper.c | 281 +++++++++++++++++++++++++++++++++++++++++---
 git-submodule.sh            |  61 +---------
 2 files changed, 265 insertions(+), 77 deletions(-)

-- 
2.13.0

