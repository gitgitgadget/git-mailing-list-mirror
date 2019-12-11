Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_MONEY_PERCENT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0119DC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 08:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC580214AF
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 08:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv1GR1P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfLKIyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:54:24 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34803 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfLKIyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 03:54:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id d202so19028147qkb.1
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 00:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=nGIjsaBccfzgbG6AB9u8tl8iW74VAAyTBEMSpWPn7tU=;
        b=Qv1GR1P9hccnzmNvd+tlfDuU0qY+a1TNXoq2C7vcZwsDu279h/kq/WsaSkhqzRTFDh
         IHGYB+xsrE5zQ/4kF66RuhXJe25fLGXKZ2haKe3dQC4CU9YTUDMN66DPcs7uPm4ZTxX4
         m3jU0z5PkK1zPgc7AKywizZRvZDObuM8JgIsRQqLEMgv+xzbSNur7hz6MwF9anx3WeYx
         +5dDMKDeQCS5/yV3LRM9wELde2N3XA+s/a3UpQPorEtJO41KGFq7NrkCiaK2I0UoUTlp
         XJLsphwC24haHkvdT4fS9W8WLrbu+pPEco+/jjo84Yh+wvudvz62Evg0rsVb1upGOWxb
         YYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=nGIjsaBccfzgbG6AB9u8tl8iW74VAAyTBEMSpWPn7tU=;
        b=mnxEH8f4ZX4+Qoj49jzrBcyN1rUi/wQ2mYchish9fAG+oLuJmNSCVgslNItF6Pc5oa
         MDhrBLL6U5CGAhFTnJuIyVlX+kQdpiWC2HZibQDOIOv8EDrenDtzq7lEXhWf0ikmuzCI
         xd8F2P+840vFVfoHDc+hAoPWdVldrhE+kIJ48d2I3Dca1rjMIIIK0K28zoMGY8WXiBwv
         StnzFJdE1WKV+pI78lpNGK6ppn2L4tM3hJzVfjvE+6eC2qazaDIZtg5HZ3GX32xItZaZ
         g2xHnAzOl/SADnBgtNGWziug7TpJnvDNGQ9RQ3CaqnzfCQvPd9LAkZ/AIXIU2dewTntn
         G8XA==
X-Gm-Message-State: APjAAAXQNMdKFn8MKKyfS6qRxZvfg9O97kXmTDmiPOb4UxBXEcDCyyF1
        gRZG9E8cBZS2XZEvzAie4qVeT/x9cP9fOSqYnsE=
X-Google-Smtp-Source: APXvYqxiInSIWS48Tbyyxwc1txIjQAhyQCy9h17NLjtADDlNXz/M9OM/aZ1bRH5/EBMKCvoZwh3hLv5mYDyVMHbcRqU=
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr1799816qko.37.1576054462860;
 Wed, 11 Dec 2019 00:54:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:6601:0:0:0:0:0 with HTTP; Wed, 11 Dec 2019 00:54:22
 -0800 (PST)
Reply-To: sambo.salifou@post.com
From:   Sambo <samba.akasi123@gmail.com>
Date:   Wed, 11 Dec 2019 08:54:22 +0000
Message-ID: <CACy=jcm-M60YGEMs2DCWZ_RTYu-6w4bwU7+n810h-0fgEPhQQQ@mail.gmail.com>
Subject: Please lets make joint business
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please lets make joint business

I am, Dr. Salifou Sambo a bank auditor, I am in-charge of transferring
out funds or my village, which our village generates from the sales of
our local mined gold. I have some left over fund in the bank here that
I alone is aware of, and wants to transfer it out.
My village that mines gold, has mandated me for sales of our raw Gold,
and as a bank auditor I help our village to control their funds. I
want to use this opportunity to look for some one who will provide an
account to receive the sum of 4.2 million US dollars left in the bank,
this was realized from gold sold, to be transferred out to our foreign
account,now it is
unknown by our village, This fund has been laying for onward transfer
to overseas as we transfer out all funds sold from our gold, till now
this fund is lying in the bank, I have all documents concerning the
fund, and now I want to use it to establish outside my country. So if
you are interested, then you will provide an account to receive the
fund for a joint benefit and business and sharing, I will give you 30%
of the fund. if you
are interested reply me.
Sincerely,
Dr. SALIFOU Sambo
