Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5CFE1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 20:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932915AbeAKURd (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 15:17:33 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41099 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932437AbeAKURc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 15:17:32 -0500
Received: by mail-pf0-f194.google.com with SMTP id j3so2526364pfh.8
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 12:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nVerDQ0GkCUEiZqNJh1G/qlrC0k/RqZ+p+MlxDqjaq8=;
        b=fsKa0sCr5sdkmhc8AOSW4arsQWVFTDBwe3UpnsJcVETEtLcQmzMYl5n0O+CzdlV3eu
         90ccFFDYTehFDovOu6YF8zr9f//MWpk6i3wHCfWlbXSNiCSXlNgUQQ6f55VP1COyeXOw
         ZF9TnJdKzjhkbeI9N+BrJUvxLpp5u9U/QmP5uhVzxUjNcvCE+6LCcZgwRr0Z4viLVO3+
         BPrsbverBmqK0/EnhcD41odjP9A6mz3bw79/s91FvDNJgAlMwFNqZr7SJZ4TR3I3Eri8
         HvxszxzSVas5nZkP6Wyhn0tWFnsogHZhpNQvDyMxOnXELP6RkHtc5ntTrOK9g+3KY5wj
         bwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nVerDQ0GkCUEiZqNJh1G/qlrC0k/RqZ+p+MlxDqjaq8=;
        b=MnF9l7+erlatHLDGCBG1YVKWU/PCwQ+DF+Qfdv/NcFW/quDw42zEXuAmt0XD7KufFx
         NGari9N66dTyxsmNpODFuEOopgYWQJeOcPr6vJ/PXn/Q13Z4OxRu4xGm+/Wk+nE8RJBm
         aAALl1vsGG74b0cJhIYmhmdLD/hFxcdEnUHzXzWrTVRbhYC1QxYyk5JIcxAqTghtJtbj
         lTPeuUjyTYeFKDWfFwZF8WDTSgb0x/dbQeD6G5GDpKFZXT5o1sEcUES0PkeD0p7drIrM
         LVRGDSfwme3dfG4DGOqxUbJ97jHPs3Xc1jd2FaGnL1zqv8i6lrSFH+vLEl38T7UZZBYp
         toIQ==
X-Gm-Message-State: AKGB3mJlGa38WMIk+3Lnn3Ewl6zonpLL7FcT1y9xThk6MZBW7rnE8Req
        9sgoKb6Yj/jONGzzcXWSgnFAgUOF
X-Google-Smtp-Source: ACJfBouNHsS63wKpuQD1CYg0Vs5vR94WikxJ8JNS8zoWXA1pwh8Ot4Wm9IlWpiMlGT4unEXd8pn+TA==
X-Received: by 10.98.68.135 with SMTP id m7mr21118906pfi.9.1515701851687;
        Thu, 11 Jan 2018 12:17:31 -0800 (PST)
Received: from localhost.localdomain ([27.63.158.37])
        by smtp.gmail.com with ESMTPSA id n24sm42260201pfi.33.2018.01.11.12.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jan 2018 12:17:31 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v2 0/2] Incremental rewrite of git-submodules
Date:   Fri, 12 Jan 2018 01:47:19 +0530
Message-Id: <20180111201721.25930-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180109175703.4793-1-pc44800@gmail.com>
References: <20180109175703.4793-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes made to the previous version of the patch series[1]:

* Since later on with certain patches, the number of bit-parameters to
  be passed to a few functions depend on many parameters, I prefered
  using a single flag bit.

* Memory-leak of the variable 'remote' in the function:
  print_default_remote() was avoided.

* Additional condition were introduced while freeing the variables:
  sub_origin_url and super_config_url.

* print messages and comments in the deinit_submodule function were
  corrected as suggested in previous review of this patch[2].

* Call to the function lstat() for identifying the directory mode was
  avoided and instead 0777 was used. An additional improvement is to be
  made over this patch, but since the improvement can not directly be
  part of the "rewirte in C", the patch would be floated saperately on
  the mailing list.

As before you can find this series at:
https://github.com/pratham-pc/git/commits/patch-series-2

And its build report is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series-2
Build #196

[1]: https://public-inbox.org/git/20180109175703.4793-1-pc44800@gmail.com/ 
[2]: https://public-inbox.org/git/xmqq7esq4tf6.fsf@gitster.mtv.corp.google.com/

Prathamesh Chavan (2):
  submodule: port submodule subcommand 'sync' from shell to C
  submodule: port submodule subcommand 'deinit' from shell to C

 builtin/submodule--helper.c | 342 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 112 +--------------
 2 files changed, 344 insertions(+), 110 deletions(-)

-- 
2.15.1

