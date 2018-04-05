Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09FE81F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDECAi (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:00:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39158 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbeDECAi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:00:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so16923893plq.6
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zpg4hVqHucEHl2U0Yt+gCMHqDya9REZ88M3JcGO2AWI=;
        b=GJqX25iv9OKnHm4giK9+hvlN1aJ81Y4Prqk4dlYWg1bwA1Uo5rX+DlZZ29VtZb7TTi
         c+7eyJRjWcOm+lhL/Wwff9E+rnYKGOgRvAT1ibazCkm/PQilKulysz2Nfu19KaG1oV9x
         KrLWOYgiAXWn+PPMiQS2Hw7RnX5m89BXE4I0ICyDBS3V0Ysc2dYCrdCjC2a7+yl893oS
         9PQqSHhJmwkX+P1XCgGl8m35qthL8MZVWnLRUCNd55FeHDMYdtMcwvJjF3dvJxTIOzgm
         YUpawRlTWJ04CKir79xsCbaRpE+scxhH+YQ0MWakVD0fPTv/xG+yy6a1Q8q9Pee89hbb
         bWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zpg4hVqHucEHl2U0Yt+gCMHqDya9REZ88M3JcGO2AWI=;
        b=QSj7DtORKY7VPlGTeU5mdIkGrakiYGAt8gc99OJ0YOum+38oEdSuonjtn3FQSC6piB
         219a5EfJanKtMB94Gbwt+FNrl65arZZAlB9sG+ulfr/wNWTfxqS6a53KwJ7EfDHj/2IK
         RJ/OUf7qRn9PrSlxuey2kIO+83c0CSyUEDYkVCPpNzxvWl5VScTBVd94wYOQo9CqvxWl
         uRMm7mIH16RZ4afWOHNZtN5cE+7p77H5ZKoTU2Pgw08PNL4JTt5kSjwP7MCrw8uOTHoU
         o0zQENvbNgdbEvZYJxIvjt9vWdVbIfu88WLegn+sc2YjH8BJZ05aS5Ku+NnASHHtVasI
         mvZA==
X-Gm-Message-State: AElRT7GL8Bs0ez7q/+MDyJZ9T90jC5KNv0Nh3ibiYd/GbrRQKuDdCkHG
        I+Hwg3cS3GYr0Cv3W5WoUYuw9hT3otjoSw==
X-Google-Smtp-Source: AIpwx4+CB5YJasEhHrs/SgRpxpb0lhR9sHE/b25iEJP400Bd8aUyXCBJN4cbPsTfDKOxI3i8Ey4eHw==
X-Received: by 10.98.157.199 with SMTP id a68mr15503024pfk.237.1522893636898;
        Wed, 04 Apr 2018 19:00:36 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id j3sm12319886pfj.60.2018.04.04.19.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:00:35 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:00:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com,
        me@ttaylorr.com
Subject: [PATCH v4 0/2] builtin/config.c: prefer `--type=bool` over `--bool`,
 etc.
Message-ID: <20180405020034.GA8879@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have attached a fourth re-roll of my series to introduce
"--type=<type>" in "git config", and prefer it to "--<type>".

In particular, since the last update, I have changed the following:

  - Clearer wording in the second patch per Eric's suggestion.

  - Stopped spelling the required argument to "--type=" as "[type]", and
    instead as "<type>" (cc: Eric).

  - Changed "unexpected" to "unrecognized" in the fatal message when we
    don't know how to interpret the argument to "--type".

Thanks,
Taylor

Taylor Blau (2):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: prefer `--type=bool` over `--bool`, etc.

 Documentation/git-config.txt | 66 ++++++++++++++++---------------
 builtin/config.c             | 77 +++++++++++++++++++++++-------------
 t/t1300-repo-config.sh       | 29 ++++++++++++++
 3 files changed, 113 insertions(+), 59 deletions(-)

--
2.16.2.440.gc6284da4f
