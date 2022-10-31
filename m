Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7697AFA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJaXrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaXrr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:47:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D5C15719
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:47:46 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id s9so7038375ilu.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ18aPKzEc6NcSUJCNRGW+wabaWgwPuPtCJhR/NNPJM=;
        b=5XfDG6AmIZp6srL0FKa/T02zXrEGD7WXlDFQ+c34xX9SygpqXJpYbydc3fQluReDVi
         KmmGOoL1rjB9+NAqGvnEvAhSzpUzZNqjwNDQTxqiiqNOdr4cg/4AzD50f4o+0pDisgS5
         f6+cOA7m8/jqEee+NV4qW+Zgwy031a5K4GNhndWYbr2hSHNAyDOOJVhmzqqmfBJT18je
         4QbH2DrJIKm37+1XgiWF/NGcsEkBrxxb2fNPEhV42EpFqNA7NYXF6L8ofyaIi2dSlNEL
         eru7mDt4YOsYb9wyg6Xtbmmo587oqaRIFdrYftJFxBXXHDbUBbzSUK/zo9CHC6p5uRTM
         jBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ18aPKzEc6NcSUJCNRGW+wabaWgwPuPtCJhR/NNPJM=;
        b=J2oBM0y3vodI5FAzGt0DQORylJr/oJb8TJ+kVzKIq5Lyfk7KY2a5cwKll67U5jyljj
         UarVSqQsfzLK5c0tnIaa24aGsHNSHTfrnHFvmrHcSWOL7W0SResdyalHiUU0Fq8LMeiz
         MLChfAofrEcjTr/jBbgKHc1veaF/3ADYy7GVPCjN7Nbmkxba7XSPDnaQZEeFZhMErTwS
         S3VxWAaopgSPneZD4A9zKlqSRbViZAUbpi+FlHqQGGxpcnDZ+mhg/6Ku2XRpYJlV5JDB
         ujBzFuk4ICFXx0Ar9iey6ht4RwVx14ZYf4Mq0/ALFw+sgq/Ey5Z2sEgTZhptcAfEEUOm
         gTJg==
X-Gm-Message-State: ACrzQf1AVE3Rw/F1MI7Uf1U5CTEMFOSHV8uq1mvbDtOqKgLQKZoUqcLe
        Dcav5sjrVFa0/i54CZv3QKWvISRJVD3tuwS4
X-Google-Smtp-Source: AMsMyM5RQeLNaMZrCGfdBQRhB822YKFBywTZ37kP9mN3ncRfdrJYwmEinsWvsX4uLgEb560PDnU6vw==
X-Received: by 2002:a05:6e02:1706:b0:300:62b7:c12e with SMTP id u6-20020a056e02170600b0030062b7c12emr9285637ill.144.1667260065457;
        Mon, 31 Oct 2022 16:47:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f16-20020a02a810000000b00363c866d646sm3385613jaj.26.2022.10.31.16.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:47:45 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:47:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 2/2] Documentation: build redo-seen.sh from jch..seen
Message-ID: <c805f06b0141f6df1543b7433c20b88028169908.1667260044.git.me@ttaylorr.com>
References: <cover.1667260044.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667260044.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous commit, the 'seen' branch gets
rebuilt by reintegrating topics between 'jch' and the (old) tip of
'seen'.

Update the instructions on how to generate Meta/redo-seen.sh for the
first time to reflect this.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/howto/maintain-git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index bac6429fbc..d07c6d44e5 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -298,7 +298,7 @@ by doing the following:
 
  - Rebuild 'seen'.
 
-     $ Meta/Reintegrate master..seen >Meta/redo-seen.sh
+     $ Meta/Reintegrate jch..seen >Meta/redo-seen.sh
 
    Edit the result by adding new topics that are not still in 'seen'
    in the script.  Then
-- 
2.38.0.16.g393fd4c6db
