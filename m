Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C780220A27
	for <e@80x24.org>; Sun, 17 Sep 2017 05:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750749AbdIQF2J (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 01:28:09 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34868 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbdIQF2I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 01:28:08 -0400
Received: by mail-pg0-f67.google.com with SMTP id j16so3425310pga.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 22:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=YdOl331LttvJsK2H1BPho8nYnHrKdszn372l8Xn/w0c=;
        b=ccUXNSj2WL1Bvwzm9Az13rVrhUhIe1oe/41KS+awmvLByYBDtzf/fHJY41qXROELrO
         NYE1LN3Zp/vKAydQRaVRXM3JtQTvcbaIlw6Sucf1NLesd8+zKkRl2EDO7u5gzI3rL71x
         NEsts69Bayg1ALaTc3MigSPzA64Z3XO/NxtI6SdsKQrq/k9JRgrP+gCSi7Os8tLIXQuC
         0fwGM7YpDT+5xgZD7lq0X2uQD/px5M2uB1/XZjAPpPVIKMm9FMgy15Rr44DCGKokXsEB
         HEyO7+BfIWq8cX0vQKmsyz5KtI2YCb1GdmpN0j9bKAB8IIixXovFIpI8cDw9ls/YqXvM
         LY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=YdOl331LttvJsK2H1BPho8nYnHrKdszn372l8Xn/w0c=;
        b=LPd/o7o6giOO8mPOAy7E6HVpHI/JXnaaJdqLT42GsQom2YhQwaZex78h96NxYkwHyk
         QdTHclOWTv0z90ygqyGuEuRmXY6F83pFZtVvV0oS+ZJVKn5licXAcWwQ7KEMiqORfqJD
         f4MPLMSULeDF4kL7f7UlEN0ecFRC/K4a3sc020SegbIIXa6rocrctWbje92LG8hPug+5
         V5U10vEEpqar13EffsB3mqIaPxJAJe0JBwnDTVhpGwXhKDMgaVG7tXAChPGCfS9bVo3q
         RPCg4RwCfLp35kdeTGNJC56TDImusHVShd1jaz1PMyCHm1+EWL7p7j/CMqHKAuWKi/6F
         513w==
X-Gm-Message-State: AHPjjUimj5MgT07kcJedUBLVHWqExGiYEXod86syoBaYG06LTvOIbq0I
        FpaINwS8LgGgL7VUn0c=
X-Google-Smtp-Source: AOwi7QDtow4UjxaJIOkcr9ywz5KT7qwErDQj9VUs7chZZQZmWgGKeAV3hRiGEWrODJS3UMcmfFvOtg==
X-Received: by 10.159.198.2 with SMTP id f2mr17868493plo.288.1505626088143;
        Sat, 16 Sep 2017 22:28:08 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id q13sm8816271pfd.100.2017.09.16.22.28.02
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 22:28:07 -0700 (PDT)
Message-ID: <1505624855.9625.4.camel@gmail.com>
Subject: Behaviour of 'git stash show' when a stash has untracked files
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 17 Sep 2017 10:37:35 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some time ago, I stashed a few changes along with untracked files. I
almost forgot it until recently. Then I wanted to see what I change I
had in the stash. So I did a 'git stash show <num>'. It worked fine but
didn't say anything about the untracked files in that stash. That made
me wonder where the untracked files I added went. I then applied the
stash to see that they were still there but weren't listed in show.

I understand that they aren't listed because 'git stash show' is
typically a "diff between the stashed state and its original parent" as
the documentation says but shouldn't there be at least a message that
the stash contains untracked files. Those untracked files are "part of
the stash" and I see no way to get information about their presence
currently.

-- 
Kaartic
