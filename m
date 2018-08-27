Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D6A1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeH0XYV (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:24:21 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37086 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0XYV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:24:21 -0400
Received: by mail-wm0-f45.google.com with SMTP id n11-v6so96703wmc.2
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=8c2vyizN3of2ikuyr5N0+SD3qYS3yB/77ZTFtuDcVnc=;
        b=Qd625aQ060+hXRseiqGoM+/YgNXe+zHGWm3iys5uoP7BM0JOkcPCaYfr9mj4SrOEXj
         9UZ7mMnh8pLQ+lfelXdO6cC8v+QCWggyPZ1mIBx6bJu71l8d44dcGdSLxjRbtbOwnPfu
         j2u7gkQiqQ+lH6RxrpSznjelACeeknHfOQV6/RUoR15NGkbvGHeI03p4C2jnXQ0pslo5
         ibUdrBDGUbXxhx2fromu/luOe3Y4jyaZffchccVfuTI2xVq7N6sR9AGAF5suiOZWW7oj
         5evVDhF91regiNwWPNQxTUcjoFg0Y/7t4uijjnuV8djkognnn9RLY79j1p3vbxSOb+hI
         cqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=8c2vyizN3of2ikuyr5N0+SD3qYS3yB/77ZTFtuDcVnc=;
        b=CBptj0MuE/ljSrlxtPXEAiDE9IuEWgdL/cwuYx0YEyeiJQr+ei/gEpbJONatFsRSSy
         5zEqAmXIOBH541kk2YyYm78MUcZm8flmnqaufjSq+xgr6DyNxZFtZrCXh4hgHjv01agj
         d2T6vPrF/DsmaX4l3ZNa/MBkNHmXVzd+sRkqm49ktCEF2Y05mKLmAcsDSq71BJK8s3LC
         VdpF//6tyb3gM5he9yeOWYRAsj2IIZdeXu2i2wQTa2cIJUfVN82eVfbh8PgTG6ZSYvCB
         nBC/jzUAHMk/3mkWzI3CUzw9lV4f6Rk3Md4zy8S9pPM+IT1d6XtikANrlDSt40gYI9vu
         HMmw==
X-Gm-Message-State: APzg51By0ubr4MCIdAwntWC8H7Uw1pZaxlFz+n3vqkMemXNwihc+J23p
        VNV+dFmXyPgHB10lA8/NXek=
X-Google-Smtp-Source: ANB0VdZENdhF6kgYoutiM8mhFNHaX8u1UpaCvoOjRUGTnFCddrLShDTw0z+AGgQARKqHcauTkH3rzw==
X-Received: by 2002:a1c:9945:: with SMTP id b66-v6mr6296757wme.159.1535398581514;
        Mon, 27 Aug 2018 12:36:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d12-v6sm144029wru.36.2018.08.27.12.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 12:36:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
References: <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180805172037.12530-1-t.gummerer@gmail.com>
        <20180805172037.12530-11-t.gummerer@gmail.com>
        <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
        <xmqqsh365qt0.fsf@gitster-ct.c.googlers.com>
        <20180822203451.GG13316@hank.intra.tgummerer.com>
        <xmqq4lfmm7pb.fsf@gitster-ct.c.googlers.com>
        <20180824215619.GH13316@hank.intra.tgummerer.com>
Date:   Mon, 27 Aug 2018 12:36:20 -0700
Message-ID: <xmqq4lffk3ez.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Fair enough.  I thought of the technical documentation as something
> that doesn't promise users anything, but rather describes how the
> internals work right now, which is what this bit of documentation
> attempted to write down.

That's fine.  I'd rather keep it but perhaps add a reminder to tell
readers that it works only when the merging of contents that already
records with nested conflict markers happen to "cleanly nest".

Thanks.
