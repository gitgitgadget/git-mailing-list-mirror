Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D4EC04FF3
	for <git@archiver.kernel.org>; Sat, 22 May 2021 01:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FAA60C3E
	for <git@archiver.kernel.org>; Sat, 22 May 2021 01:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEVB76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 21:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhEVB75 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 21:59:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69CBC0613ED
        for <git@vger.kernel.org>; Fri, 21 May 2021 18:58:31 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h21so16722721qtu.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 18:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=D7zuenixr+CN0Yj9dTxFl94XPXR3+7ctdLS50bP26so=;
        b=vhOQk7HTCNJtZBkidFWWqU2Wn1kLliNnisCssXzhekq/JmMOO6tSrVTPiXClk9+SIk
         R22XlGVvgQKrCYsttQQOsnbto1KVx1YVG5CbY1Nd9ctBoHbafSDHfEKnF7MJiTaNw1SH
         xdq/Oi1LZCMGFSdZVLMbwSwtXohUQx9p0yCKy5jD/sxqHH6T9UcXHp0h2vhIFHaTTCs0
         /qFzjtRdz9UG0UrolWzQ9Obh/QhX80AdrkHm+uqj/G3N4HDFgS0+N/fQM4Mx4j1ARXOX
         YqS2SRPx6o2+4xFYPm9tCPZ9TmdAA/NqymhF7QZDVUF6O+6yMLtgY7MEXOH5sMStAsZI
         TZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=D7zuenixr+CN0Yj9dTxFl94XPXR3+7ctdLS50bP26so=;
        b=cWV6C035I3xjrn7++vi3+9SoRoML6hIpvrr8QaxO5vOG2o/x8B+7k//ZkOGOJJwfut
         TjmOobmZjEgt0lQ7FlDBsvOCYeaxs+YoJGPX6k0OBJj6VUMXDtdzVwGD8ql/hHdyxmpN
         COfFL5nJBaJdaEWAo9nNLDZkVX7PsxAcJGfld2v1zYYtN4FJCOGUrGJZ4ZB0GL88vf2Z
         jwIXmHbZ9lbTIEnK52uc5paC8pg0OhMq/Klcr1+FZovIqe+pgFzobw+uxLemMyiOGA7g
         30JGaAP0RjWDDZoEGr6fzH54O1J8vROAN60OV1Eq2b+cube5Jifz2cpKJ0wvP+3u4Hfl
         MCdw==
X-Gm-Message-State: AOAM533+jg1jbe0SH2iCFxJcQMctumsGrsHBsrR2FLeSUomKsA95CvG4
        04SgTlqvZPnmLHLhmG8DynPmeEGFXYc=
X-Google-Smtp-Source: ABdhPJxVzQSvxPUmXkiVXDTy4AL8NSj6pzgf8sqNArR0A1jz9Iq9HFJG0qcuo/MesgoLlRcaM8Zw2A==
X-Received: by 2002:ac8:5812:: with SMTP id g18mr14025310qtg.216.1621648711051;
        Fri, 21 May 2021 18:58:31 -0700 (PDT)
Received: from [192.168.1.102] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id b17sm5397917qtb.78.2021.05.21.18.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 May 2021 18:58:30 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 21 May 2021 21:58:29 -0400
Subject: Re: Formatting options are ignored when tracking functions
Message-Id: <EE7D39E6-D826-49E2-AD0E-090A83DFDEC1@gmail.com>
Cc:     git@vger.kernel.org
To:     aidgal2@gmail.com
X-Mailer: iPhone Mail (16B92)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aidan,

I believe this is working as advertised: only the first line of the commit m=
essage is shown.=20
However as mentioned in the doc, the -L option also triggers patch output (-=
p),=20
which you can omit if you explicitely add --no-patch (or shorter, -s).=20

Cheers,
Philippe.=20=
