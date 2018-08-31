Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B89D1F428
	for <e@80x24.org>; Fri, 31 Aug 2018 06:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeHaKjs (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 06:39:48 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40212 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHaKjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 06:39:47 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so9606138iob.7
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvUJcqp1HxqPeyBt/jngl/9n/05744k139Xd6QSckHw=;
        b=r0lu5XUfjIqJhujdTlDx168Fvoe6ESV89o/fjCvBWc+gjwlmh4H1S6FkUps95VCDKZ
         qGBXbY7tFoboZGONn2gI6Sv74KKgOSiKGKL6vW9RwgXvDBhjQqOyI1okKWSidGyMj82P
         KTJDtrad6qf1tkkGtN+8eHQMwjsyqMUkHI8tOmyq+TTRrYjnn7v4EbsnOsv4q5JmLa3D
         DDZFruOMArie6rBjloj5BTsD70s33QzEpzLRZ1hBWYBtOkwqcY1+THsPEgVTUAonSGV0
         WuCXUoeCeUBPjl15ViWhSXC3G21xiPQK8XcLHUezBEqFCyUQsikF7DbE02+CnEeUqOjR
         VnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nvUJcqp1HxqPeyBt/jngl/9n/05744k139Xd6QSckHw=;
        b=NN0PXSNp0O+0tMDTC/a8CdhLeeav6B/lhVFTGK2Vl8SxXJMd20AIqVD5q2cWKUtlxI
         7q9U07IAdsRHwCwtU10f6x+BhgXQ+BT6rbGWlKK9dXpBC0MuoSXj8d3iLHaTbYIYapne
         bpgISJw4tq9VuFcW7WnuqiGvz65wv9inKF+/23w/G1oTbwO3tARtyT2mDrc7Dkx2xBYG
         KFn8Q/Yq6vddkO7Jg4WnavNbOEAPNY3yiNYfohKqu1MCBfgjiuGmKTy2srkS9zupwqrT
         +TBlqZsmGPgOauLK+BqdCxaLl//zGpTSXzwqOsabjoSg2OIt2PfuoD9lHt0IrwukBYsH
         baeA==
X-Gm-Message-State: APzg51DTfhl+ThfHLB0Z6xh6EiQGT4D7EV9urt44V8AdvNNfIq8nwdRF
        acr5rU926oFLCVU6a2wZ9Wc7DF8R
X-Google-Smtp-Source: ANB0Vdb5uLAfmNPpZ9m8odgcwC3QKu6WvdfoIAYCGfcRUW2tKvvTA58b3ztciF5RomsNMwsZb4n7xw==
X-Received: by 2002:a6b:d506:: with SMTP id m6-v6mr11254639iog.20.1535697232587;
        Thu, 30 Aug 2018 23:33:52 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id k18-v6sm3734531iom.73.2018.08.30.23.33.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 23:33:52 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary files on "make clean"
Date:   Fri, 31 Aug 2018 02:33:18 -0400
Message-Id: <20180831063318.33373-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.352.gb1634b371d
In-Reply-To: <20180831063318.33373-1-sunshine@sunshineco.com>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

doc-diff creates a temporary working tree (git-worktree) and generates a
bunch of temporary files which it does not remove since they act as a
cache to speed up subsequent runs. Although doc-diff's working tree and
generated files are not strictly build products of the Makefile (which,
itself, never runs doc-diff), as a convenience, update "make clean" to
clean up doc-diff's working tree and generated files along with other
development detritus normally removed by "make clean".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a42dcfc745..26e268ae8d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -332,6 +332,7 @@ clean:
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
+	'$(SHELL_PATH_SQ)' ./doc-diff --clean
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-- 
2.19.0.rc1.352.gb1634b371d

