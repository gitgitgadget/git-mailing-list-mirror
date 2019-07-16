Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1331F461
	for <e@80x24.org>; Tue, 16 Jul 2019 17:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfGPRrz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 13:47:55 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:34458 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPRrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 13:47:55 -0400
Received: by mail-yb1-f169.google.com with SMTP id x32so8154550ybh.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=R1+S2+bhPKUFygFDhb2gGzGct6hQVH9dZg5hMWRSMM0=;
        b=duuJcIm0qL+hiIHuVJ4eL1jN3MHLuLhz0zaYAa1Lk4lRCP99YNa+sPFaPWE4dlhiqT
         yI6oMZEqElvs2xgMyLgRuRC9ois9RdhDRdL2Zl8uO5Qe7SAUXwi+kBpzNJ2wXo0wXEtQ
         SMzC5ryC9WHrkyNAg9iYi9pEp/w6EUqV46YqJru+aGVy6i1ygQ8F2ExeQ6pLYaxOxj1k
         8cZuTqr88tqr2XVm5gbnM/+4sNx1axysXbo7dROysil4ffGQ8KED2eihZWcg0sEf6NX1
         g4j3wK+oyu60w+SV0X0sE1S2jgNNR8JsAIfmT4xKIqtlREFtqCO163bhiOeLY1HtWjXA
         oSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R1+S2+bhPKUFygFDhb2gGzGct6hQVH9dZg5hMWRSMM0=;
        b=QlabKcJ8IG5mg5zIg32cCWs1ebeVaxnH5Q36RSZ73sWk84ND55h1LyXtxm7TvOcerL
         iwhyZob+o0PSX1nrpB+ZqupCtEH8iQTFfX/PVT3N/WLxSnJuV/45U5LvMdgv2SIMjXXC
         jy/0+txUdJ7i0nNcIzudBGoRw3ilzj+593vDMBUgs5NSG2Hh2e9FhW3dSBWWoW7WtEGC
         ZLgh4rN80+sCnEI0/z2J8nlSW6kQdUXweT7YUidqckKPTKCXdAL/G99MPS/xgXaubQhW
         +Zt4LcYyy2xC2RV3Ud8G4CnUk59FqOqfxTXTdfYPwyPKvwd0E6rSl9lze3jVtRxKRF7w
         oNlg==
X-Gm-Message-State: APjAAAWFXN9luAyIr19QoVzsoL5WYhP522nuv0iaCxVuV5OYz/U/AKCl
        lXb5HdoeNfn7We6iqWv12sHtMjId/nkhQmkDa3ujYsXv
X-Google-Smtp-Source: APXvYqyoX9eL835LnHmQUUVUcD7VAOGUJhm9XdZKBertTz7PfNOL4MoINQCP2rh1QnfnY7QQOZdTOiUR8RkkMLQtiJ8=
X-Received: by 2002:a25:fd5:: with SMTP id 204mr20551061ybp.245.1563299274377;
 Tue, 16 Jul 2019 10:47:54 -0700 (PDT)
MIME-Version: 1.0
From:   Steven Roberts <fenderq@gmail.com>
Date:   Tue, 16 Jul 2019 10:47:17 -0700
Message-ID: <CAOGP0GoYviFHhFzhqEimEw+ebd=DJx9JucG4BNvSvPuDudoWxw@mail.gmail.com>
Subject: git segfault in tag verify (patch included)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I believe I have found an off-by-one error in git.

Please see https://marc.info/?l=openbsd-ports&m=156326783610123&w=2
