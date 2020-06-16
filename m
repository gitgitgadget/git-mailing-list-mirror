Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BDFC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 21:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508A42085B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 21:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe/i+eFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgFPVH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgFPVH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 17:07:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF765C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 14:07:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id p20so23207176ejd.13
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 14:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=aA9rnMkMvF8FMhgN2wad/wMOrdvyXbzjg9AWb6xiBrE=;
        b=oe/i+eFubqdVlcug3+Xljb9KRUh6ZVHAsdPN5Znxwxl7wA5XwnJqyxZGBu+K/W1+zp
         dMW6diJ1SCQqLpiDucj8IdHYzh9fau21H6tqETd+vmgpYdzKcMcA9/krbve1anu/bwJz
         B650a4JUZ8G2W4kkVNAgBFROqkq+wfekrKiIOL9w1+uapLzI0LlH9bAIq5PBmwmVuy60
         ipu9FxC5nHG9KHTs4jNzDcdzELflKazj6KhYXnaXJGmdTZdcBUHAZviuEX2K3SR0N/tx
         aAM2yEunuDEo/q8Vtl8WMAV5KFIj+zzkO2PsMsNhiucCCTXpPWlJ/Sx0ZX2DOY1uIPRE
         PWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=aA9rnMkMvF8FMhgN2wad/wMOrdvyXbzjg9AWb6xiBrE=;
        b=QpB2uRQdbEZ/AI1d/OYWSX9OLDT6Nm9J6lXoZ3ypFgMeaRB1yD2CK5364rDWazOmFT
         OBwGaFROWXqvERcJD8ekXca7cxSTM6xzVrcBLIIFgv6w6azDP0pk22XUV1y7oLpqASYO
         gJumNlnKbTxwPVngQCYcNliwnZ6dKe1zOdVWF0m6TaeVIQFcWjQsfRVW29ENukeAZTOW
         8U4zi/O+F+4mLpg6qdL3cOs/VG1/MSqTgNrhlDYzEOswvTCI9uFwNAD4+taW5BqdIx71
         jEWT/frIPXNPUGMSj4BoRf6QuJSY3ZGNtXm78ZdPsnIhCQk89a6vuFg6DTXxMv0195Sr
         T8ug==
X-Gm-Message-State: AOAM532A++0d/Ryecv0mOYp23OI8Y8dXM8WjsgzkCUqXZ7MBpTt94XKB
        R91HKs5rTdM+7Xo/wb4r+hw=
X-Google-Smtp-Source: ABdhPJz0tuIAi0/7azCxLkAI5ihZMghaSUlSJrTdrBu/LW/DHo5Y2lQPUAPIxZLrCpmBlGM34ZIAOQ==
X-Received: by 2002:a17:906:11ca:: with SMTP id o10mr4543647eja.334.1592341645141;
        Tue, 16 Jun 2020 14:07:25 -0700 (PDT)
Received: from localhost.localdomain (ptr-uhky5c6r5vdzmzvdg6.18120a2.ip6.access.telenet.be. [2a02:1810:1c39:a800:c80a:f1a:360c:e0d6])
        by smtp.gmail.com with ESMTPSA id b4sm11852570ejp.40.2020.06.16.14.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2020 14:07:24 -0700 (PDT)
From:   ZeeVriend <zeevriend@gmail.com>
To:     johannes.schindelin@gmx.de, Johannes.Schindelin@gmx.de
Cc:     don@goodman-wilson.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, simon@bocoup.com, zeevriend@gmail.com
Subject: Re: Rename offensive terminology (master)
Date:   Tue, 16 Jun 2020 23:07:01 +0200
Message-Id: <20200616210701.22924-1-zeevriend@gmail.com>
X-Mailer: git-send-email 2.11.1.windows.1
In-Reply-To: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
References: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
In-Reply-To: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: zeevriend@gmail.com

First I want to thank you for the time. I think the change is good and discussion about inclusive really necessary.
Let me tell you I have Congolese ancestry. Today I develop in Brussels, Belgium - the irony you see, is not :-)
Second let me tell you the new master name 'main' is not so good chosen. In french 'main' LITERALLY means 'hand'. The recent
history in Congo will explain why this is bad. Not long ago slaves in Congo because of Belgian rulers. Very sad history, because
hands were cut off! Many Africans today still have family from then. My grandparents can tell me horrible stories when I visit :-(
I think you can see now why 'hand' or 'main' is very offensive to us. I can tell you, for French Africans this is MORE offensive
than 'master'! Because this reason, we do not want to be reminded of hands while using git.
Third I can suggest 2 more neutral alternatives. First one is 'default', which has almost same meaning in French. Second alternative
is 'zero' or 'branch0'. I like this one more, because it has an exact same meaning in French! Also it is very neutral and programmers
from all the world can agree on this, we all start counting at 0! ;-)

Thanks for the time and considerations! And excuse for the level of English. I hope you have good days next, healthy and stay to
fight for the good causes!
