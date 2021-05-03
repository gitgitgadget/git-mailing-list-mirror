Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A370C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60982611EE
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhECVRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 17:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECVRW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 17:17:22 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D87C061573
        for <git@vger.kernel.org>; Mon,  3 May 2021 14:16:27 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j12so4726073ils.4
        for <git@vger.kernel.org>; Mon, 03 May 2021 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vrC7C30O5JdpSuBY9CzOn+BaMrqTjydpl6HP2tipRg8=;
        b=G38bq3RGYjsWwdtqPgfTftffrci/AR9fYpNPWrR5/ZCn/W995pUW9YgJAmPAZMdSAi
         WaZQTQu78L7dn4zmP7Sef34UINvKd6Jf7r+he375r5ceG2lpSNkaRt6X/TpxSGt8qJJl
         c1VTy+YiMzHo5OpbBLXtHXGgS+FATZDAjZQtAD1ahGIonFUjl3eCcVMSL5ORrj9NDllJ
         aYs0sEhZ+Cel4L3AlJs/QJKrJeXC6V8iRFSNEtfpoKmYi0ACzOpBeZIESMDxy0S37Sk/
         HSJy0tEMAIsfDUiOX41yB3/NLw5jV2FGuPB5edY8rZf731+HNUaZxyGNXiT9EZOBawmx
         eDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vrC7C30O5JdpSuBY9CzOn+BaMrqTjydpl6HP2tipRg8=;
        b=gkWItSMn4HOpIpMDFcy73O1V+mWD3clLv/r/kRzRIGwzttFuHPkTyzGjVaZgueqNl3
         Ms3iY67JZSLO7hs4C/CAf1EUWgj42vlu3mTkbpx0eA2O5kTDD0qbeMFdCza91/ipI9QY
         cNEaKxn2m3rqARIxddvYd1ZrM6qnIeCrjmrNDFjG2riOkOaWtbIzGbhRbpG0kuPZkpgp
         WOLG02rLzSgUM0Jd+7igPqjkIIAK21eTyZEZXy95Fe2lBc/coXlR1w0Aiu42ekCB/bAR
         og7sFQ6LylPmpo6XO7IMU2NJhHHV+yEhXzePoYzYPVuZ1nHI9U4IrYhG+NJvxn9wu+bm
         Z6NA==
X-Gm-Message-State: AOAM5324VCiprxfPVpjx/y4olzUvYjpQpaq9Xd3T63oxJegrjr3giaOV
        itsZ4AChZoyY4zUCNtdAcDMmFQiMi1mUYcWg7YQQr/nC3+WKCw==
X-Google-Smtp-Source: ABdhPJxEh9Ohcw9jTBZ6Es80DEbtwd0J7ACpwoM5n22WQn2B+50YvAIRrMjFEMAIg0tnmwA0er+qOtA4OahZxgy3Xtc=
X-Received: by 2002:a05:6e02:e43:: with SMTP id l3mr18255490ilk.130.1620076587093;
 Mon, 03 May 2021 14:16:27 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Packham <judge.packham@gmail.com>
Date:   Tue, 4 May 2021 09:16:16 +1200
Message-ID: <CAFOYHZBAg7pkise8bir7Z3qApw9mJB8Z99p6z71-_T6=7rFV7w@mail.gmail.com>
Subject: [BUG] gitk error - can't read "arcnos()": no such element in array
To:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm hitting an error with gitk (gitk 1:2.31.1-0ppa1~ubuntu18.04.1) on
a specific git repository.

The repository is slightly odd in that it has some replace refs
configured and multiple root commits. Although another similarly
configured repo doesn't hit the error.

The text from the application error pop-up is:

can't read "arcnos()": no such element in array
can't read "arcnos()": no such element in array
    while executing
"lsearch -exact $arcnos($l) $a"
    (procedure "splitarc" line 21)
    invoked from within
"splitarc $olds"
    (procedure "getallclines" line 33)
     invoked from within
"getallclines file11"
     ("eval" body line 1)
     invoked from within
"eval $script"
    (procedure "dorunq" line 11)
    invoked from within
"dorunq"
    ("after" script)

I've not been able to narrow down a specific reproduction method yet.

Thanks,
Chris
