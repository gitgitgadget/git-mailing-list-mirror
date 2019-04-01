Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E2820248
	for <e@80x24.org>; Mon,  1 Apr 2019 08:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfDAIez (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 04:34:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44353 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbfDAIez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 04:34:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so10754096wrn.11
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uUrHbvHCP3OylxryFce/e6jSqQG6SpcHc13VR8BDBpY=;
        b=o8m5Knpn35zId1YoKonLcxDNn8seYkqjH2eBndB+j1uSuj5CSbMyTUxxGq87yoEny7
         jC0lRzNttQjw01IPLzETP4ZF21OGgqiTsPY8aasSBiJTAiXAMyddi8nD2o6SWg4Eze9Y
         slkforkqiijHjtwitIVgI9XWt5rNNBywhPNLHCSsUwsKvN72ThzrcNsmzNub04ZtnZyC
         Ub4L+p8gqsokPo0fX2kKVpUAgHqRvJDlm1XLd7sqFCwM/JWZxL45nRXOMZma4GlqVPGe
         YJ0iIEP0qmOLEh83tOPxpbuIECvULHJlCMWqq0rLdvMedc68MYNOfdnNPpb/CtHqY6n8
         7/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uUrHbvHCP3OylxryFce/e6jSqQG6SpcHc13VR8BDBpY=;
        b=luMFyUa10tC/L7yNXD/VbdIQwt53+/NbVpfpdPY2JbSHlGFj64F5X/DmeOMsCsfuod
         PsIF88bEMfHB+rQ8wnGmWICbUdBZxBzsjnQGeTzp4/QCng0cwQBMwaKTbhhQiuhzG7a1
         unU3yBEl8iQPsDV5ikg6ynwml0rdwTgbRPOy96jU4uAt4ATrAOo9WUBWN9zFn2WhuJpc
         vd0308ZYhKwHMrvXEtjgtJdeE1DLTFJ26T0mkZiN3kxeFtUILGUksm9KzBocuQ+nJqzK
         u4abAjBwTNOSc+szVWGMIYqFmnG10THePwf6HPmoGvuYlpOIhNyZ2M2kyp75+IUpv+nY
         5VLA==
X-Gm-Message-State: APjAAAXLyX/n2EhKrBhs3wICLlVPr42wKV7UdJT4CCm8X3CiknIV/fFu
        REVNVqNdhiK0GXqaKhbGxycNSfKeQfY=
X-Google-Smtp-Source: APXvYqxotQ4bxJ3OfekXWl4Hwpq1EQLMB3bBj5nBSsy9aQjh9Pu9pfgUgw3pv2mL7gYEIAn1dKZivw==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr29964389wrw.103.1554107692887;
        Mon, 01 Apr 2019 01:34:52 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h131sm21234110wmh.1.2019.04.01.01.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 01:34:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] fix cherry-pick/revert status after commit
References: <20190329163009.493-1-phillip.wood123@gmail.com>
        <20190329163009.493-3-phillip.wood123@gmail.com>
Date:   Mon, 01 Apr 2019 17:34:51 +0900
In-Reply-To: <20190329163009.493-3-phillip.wood123@gmail.com> (Phillip Wood's
        message of "Fri, 29 Mar 2019 16:30:09 +0000")
Message-ID: <xmqqv9zyxgwk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the user commits a conflict resolution using 'git commit' during a
> sequence of picks then 'git status' missed the fact that a
> cherry-pick/revert is still in progress.

How well would this play with the previous step?  Didn't the change
to builtin/commit.c made in [1/2] mean that after 'git commit' that
concludes the last step, there is nothing 'git status' to notice?


