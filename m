Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18B3C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 12:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A434822AAB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 12:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbhAEMtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbhAEMtv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 07:49:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3CC061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 04:49:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r7so36038784wrc.5
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 04:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bloggeroutreachfirm.com; s=google;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=IjCBoxp6DboNA3sSbOnr1ORCCK/0uKF9hWVz2xK7WdI=;
        b=aYoesvU5RwcLBIrDzcYAUzkP1AEkKZcDz55xwL2KKPPaTPzt2neqy/na8T4uRgx07m
         oUX+BkR+l0AINF7v65c0lhcBRPs/GOgu3JsVKGVvHn31Of8bbaZ210wI/aJgcIyzFiqR
         1IvKoxtbJsj5KDzIJfQVmj5eaxpQ8RamKdzwI2vMLuEJikjG/X+ICUEXiBqSXvi0ig/j
         LHkakUAKlEezE3BvDYU7sIiluyPyITHJJUT2Fck1G8QDd1BOlvgKXZLEvOZ9yKLB3xcN
         5wV/CYGNcKjcVemzhCPk+NnPIzQXj8Pb2OAPfJHtANQpWRpDd+LcEZ/hoTP2agEo3o8E
         u4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=IjCBoxp6DboNA3sSbOnr1ORCCK/0uKF9hWVz2xK7WdI=;
        b=A1lvQIn/7LRmIuMY1gcDM5pz4eggRmNvp4qCscnuLSMM26DnFjQ2AVAwpk158awT7x
         LGdRzyJv/NZJnDN5aMQS1MfnI8ikjdz6pGK7NfkEATUJ/bju89tYuLisjPC3v33YGRDI
         0UWh6P94MQOFNfEiA0goFhdLoR5Do84jJ98FsZXJ5zjt9UX6OAxtiUIpOW/4jp0dMbiQ
         M2LEGT6vSVL9YG9w/Cvfig+BrTIdsgLy4vImvnBjz9CCp2or5/VHVGlk78l6J9MDN2hh
         O1yjaCqCIySnMa8Ol+TsdtfxCSZo3VxIhhyeOkaqioVXaOqjKb/KGgI82WZhBtdaWYAm
         O9VQ==
X-Gm-Message-State: AOAM533b7ms86MWUk7rkJVtBAHqeGmd6xeOeXDljSRiIDUnU0GQPdLhs
        Jb3tAhhhs23k/a0NKXsnBihxP916yz8aDFgv
X-Google-Smtp-Source: ABdhPJxzlzVUSZKERN9CKzTun7hgl0qKzdISCgipU3U7R/5Z8i7P5I/YeUS/yGMcbrTdBp9Gpumq8Q==
X-Received: by 2002:adf:ec92:: with SMTP id z18mr85628490wrn.166.1609850949200;
        Tue, 05 Jan 2021 04:49:09 -0800 (PST)
Received: from DESKTOPK818O97 ([72.255.36.144])
        by smtp.gmail.com with ESMTPSA id u66sm4112454wmg.2.2021.01.05.04.49.07
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Jan 2021 04:49:08 -0800 (PST)
MIME-Version: 1.0
From:   "Adam eve" <adam@bloggeroutreachfirm.com>
Reply-To: adam@bloggeroutreachfirm.com
To:     git@vger.kernel.org
Subject: Paid Guest Post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Tue, 5 Jan 2021 17:49:04 +0500
Message-ID: <38323820162242014017527@DESKTOP-K818O97>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I am looking for a guest post on your site with a do-follow.
I would like to offer you a reasonable amount to publish my articles on you=
r site as this engagement will lead to a long-term opportunity to collabora=
te on further publishing tasks as well.

Let me know about your rates per post with a do-follow link on your site.
we pay through Paypal or Payoneer.


Thanks,
