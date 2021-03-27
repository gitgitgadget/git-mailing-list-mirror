Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA86C433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 19:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31523619B1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhC0S7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 14:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhC0S6z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 14:58:55 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2258C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 11:58:54 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c4so8682288qkg.3
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o2InHQ/9KSgXiCCdUWTgQteyrkFJp/0AE2BziBcJMEI=;
        b=pQHTxwnVficEQVDVXvto2nV8GHdo/QM1pYyDFSw3kqqMJ5K8b4lFWfivNcRDOzaYCC
         Gzfg0cz3gJFElLDdzjTA7T16OjgsNChKaW4oC0ID41KYXftT+5U1glFZ36dhYPqvC8L4
         VkW5Vc4OQKjcxUFA5WaG8e3+f4XStZqEB82csEoKxdAGUx6y5hovAQrRhIqTaEd4htNI
         zCMT/8bP9b7kXdXnkPAdsqOb3VjQvor2ExMm6oEBmPvVlsZlkdwSI1ueaG2VfXjTiruc
         /89kleRU1urbqBlskr91aLGHobnIgYyGB2tV2mtZH51jJAM3MZ7+Ee6gbttn5962wPgs
         fLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o2InHQ/9KSgXiCCdUWTgQteyrkFJp/0AE2BziBcJMEI=;
        b=TP+ozs/vUTH7O/OCkGAXU0mBJhOoaMBLpscxbxk/qAr22T7ZypPHmavN7W5/9O3cYW
         QfyWqWN42htW9JPbY3I48nSURz54UaNUIhhxqxiddITf1Y/vCdtQ4DLgs4a8CRD+riAq
         wuWKd7ey+dwoJ7lCotDfdZlFcccmq/tp4N2y93q7Oc/5Ck9g8gyK/2H/FVnGQiFgtjXy
         XljlmpGAtfzuxpte/rjCTTc8IdP4rQQVXLK32odEcPez+GFp1stRSxNbwHOHZqqXnGfl
         gMaEw/oDgjv8ty+pXe69vyBeQamMc3NWX84jZjw/gsjIgcr+NmKBSd4mFLrj3bY0R+3S
         O49w==
X-Gm-Message-State: AOAM530wbN5uX8Yw0N7ZSulOwyrIQpqGVpoS9O9ZFi/4/rCELj+cyJNt
        fcaW/owAsKd7otutquukKq+o6sAZkZ02JQ==
X-Google-Smtp-Source: ABdhPJxa45mgqtPrbnyl/gIDHr1HRlDH4HPc3wjWaeSWKL/V/IXRkYs3utfGakVkGt8nW27fvtmc6Q==
X-Received: by 2002:a37:946:: with SMTP id 67mr17780872qkj.194.1616871534021;
        Sat, 27 Mar 2021 11:58:54 -0700 (PDT)
Received: from [192.168.103.12] (cpe00fc8d50b7d3-cm00fc8d50b7d0.cpe.net.fido.ca. [72.141.221.184])
        by smtp.gmail.com with ESMTPSA id 84sm9578376qkg.8.2021.03.27.11.58.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 11:58:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [BUG] Git is not using the configured SSH key when there is
 another SSH key added to the SSH agent
From:   Utku <ugultopu@gmail.com>
In-Reply-To: <YF9/gCIWaFBicdpo@camp.crustytoothpaste.net>
Date:   Sat, 27 Mar 2021 14:58:52 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CF3B8F00-BEEB-418B-8500-450141650779@gmail.com>
References: <967BFF88-A8E1-4EEC-B298-668012E42C03@gmail.com>
 <YF9/gCIWaFBicdpo@camp.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding `IdentitiesOnly yes` solves it. Thank you so much Brian!
