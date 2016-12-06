Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8861FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbcLFNqc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:46:32 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34355 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbcLFNqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:46:31 -0500
Received: by mail-pf0-f194.google.com with SMTP id y68so18777611pfb.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 05:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u92Ce3fEROA1LKyh0eaWoSaBMKcJkZWOdPn22Iziz0g=;
        b=wkSIb6N+97qODC7R3KcQS1qWJwl6TtCb04dM+afob+FdmJ01Md90hf38g1mWw3I/hV
         1eSKS61knHq052GvTwU5hyGtHnDwg78inOqYpvhYfU3oJXmOU046iVMbn6bkjUNPSG0r
         mig9S6ipBoxVAxj0rhlYGXwK6n4DR9vRc472+7Oz9vxwY+7DNplfmTBWtTdTpX8YUiIm
         SMGBuwxNcO5xUDmJWFu6ZVtHlNjB2FBxHMObBNz0OSTWfyuLVxOQ8zA1NK7+zPHQZhaa
         jWSc4pq8BiXUhNZ9BceWTx2P/N975PfVOnXiQAWAA1E2FESGblVVTeJe0VhO5V9UxTek
         Db4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u92Ce3fEROA1LKyh0eaWoSaBMKcJkZWOdPn22Iziz0g=;
        b=RjsxBBXNvygWrBjfWMXLy0GXtTsHkQMm03JSkimtzVIsMabGZzYZiiwcR8gt5GlO5q
         g/ad/NTJO+7wqHheeLBPY6+IMV/XVKK+59kEt3rkeiCNc6gloi1HZ0PZSUOZlMetSdDi
         K7yw/98KTClVJ0UmKPVsbMc9KV07hJrqaHmTeC+KlkXvRXfyvwjwb0jGPwC7hn2AyRmH
         b5NPD1T8U7/KrIKqLrRWIfjHapgeifae44mau/AP24kZgpCCdNY78894MJdFO+I29q7l
         DAEtJbK6/D2uQcGAzset+TAcgjrm+pUlirvl/ENAd8wCo4LXgLJs21MD3y8yJw+WFHyD
         w0lw==
X-Gm-Message-State: AKaTC01mFK+ECG6ia+ujYW26eN1umtoVcYhF2R+sY5LhIHNheHbx/zXLCuj3Bdp3mI1icw==
X-Received: by 10.84.217.20 with SMTP id o20mr136767739pli.28.1481028831857;
        Tue, 06 Dec 2016 04:53:51 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id w17sm35017745pgm.18.2016.12.06.04.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2016 04:53:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Dec 2016 19:53:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     rv@rasmusvillemoes.dk, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/6] shallow.c improvements
Date:   Tue,  6 Dec 2016 19:53:33 +0700
Message-Id: <20161206125339.16803-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After staring not-so-hard and not-for-so-long at the code. This is
what I come up with. Rasmus I replaced two of your commits with my
own (and thank you for giving me an opportunity to refresh my memory
with this stuff). The first two commits are new and the result of
Jeff's observation on COMMIT_SLAB_SIZE.

You may find the description here a bit different from my explanation
previously (about "exclude/shallow requests"). Well.. I was wrong.
I had the recent --exclude-tag and friends in mind, but this is about
clone/fetch/push from/to a shallow repository since 2013, no wonder I
don't remember much about it :-D

Nguyễn Thái Ngọc Duy (4):
  shallow.c: rename fields in paint_info to better express their purposes
  shallow.c: stop abusing COMMIT_SLAB_SIZE for paint_info's memory pools
  shallow.c: make paint_alloc slightly more robust
  shallow.c: remove useless code

Rasmus Villemoes (2):
  shallow.c: avoid theoretical pointer wrap-around
  shallow.c: bit manipulation tweaks

 shallow.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

-- 
2.8.2.524.g6ff3d78

