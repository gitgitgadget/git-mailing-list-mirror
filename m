Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF85F1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 04:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeJZNQ7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 09:16:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZNQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 09:16:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so11447447wrs.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rTAdHzi/mSBlRUv39m3vGzcdHH87uQ/a/Hb7y/unMq0=;
        b=Qb7+xIbJyLHIHzlkgFiBMEETC1pgiIQeHAR1NFniQy5/f0NHjieiMMgJRdb76jvtxN
         4wlBCLp1EMnHd7l8EBOBm7AfQsrUiesQtZi+trUxkslRsdxk3HeTqcFFsJcVZVwZ8xWs
         Nv1Js8zlsL00BkZcOKi6YzX8WESNZtUp+QIneU0VZ8dSqczfoSCkVKzTiIk9PVlTXIWe
         x1ghvIKq8fheQYo57hkW1mrjtEC4QTZYWVvpgh0zE++JTlG6r8RKFu5Z8zPWDyR5D+5a
         /+BfMGKsDV8DBOb/N/4Y0SHCpfqT3zlR4gCFEgbfFXVtCBhev2LuJOXapkHT86jlEjR3
         03uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rTAdHzi/mSBlRUv39m3vGzcdHH87uQ/a/Hb7y/unMq0=;
        b=EnYvp/JD/tZWWxcXRn5FXX85rblEvFWNL+soSRZSYEXgo7giWD4tPlDgaj3MGV1S0g
         SDdJ45sZZXpoaDFZFZhF7/Knvdabx6/uIkjHs3iilfauMFYTgE7judT58fzkvlNdXaJg
         9QYOb/SP9k+uCVwh5KObp7my5CTbqLJeMtyFzYKh33xFaEfgS1wPefa9IlluiwYkU3R+
         /bYFLwOE4DKHQ9t9N0ujDjiYI+LfcEV3JyGCu50bPHPXVKL4zcSIWXayODtJTvlqIP6o
         eTsk41TdArWMxr5Hdz5jA06qGyTMjcUFsQWn2xOA3iweQgFzZaNxj2+5Ft6XSVipG3WY
         d8XQ==
X-Gm-Message-State: AGRZ1gJCJuP5OtH974b+4RjTcy8/Yfnb/gldcCpdTJasJJyiHeoOZimE
        ZGTZFNB89WH6x5Cd0dO+6s4=
X-Google-Smtp-Source: AJdET5cxxqfS+feWmaJibkQv3+0xpnfIKoiK94TAlZW8UGW93qMMEExpphPLVACynQkXgMZ4plqZDQ==
X-Received: by 2002:adf:9069:: with SMTP id h96-v6mr4093188wrh.65.1540528893368;
        Thu, 25 Oct 2018 21:41:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 74-v6sm3941572wmi.23.2018.10.25.21.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 21:41:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brendan Forster via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Brendan Forster <github@brendanforster.com>
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks in cURL
References: <pull.46.git.gitgitgadget@gmail.com>
        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
        <xmqq1s8q34g2.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810161225310.4546@tvgsbejvaqbjf.bet>
        <xmqq1s8oxbpc.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810252049210.4546@tvgsbejvaqbjf.bet>
Date:   Fri, 26 Oct 2018 13:41:31 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810252049210.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 25 Oct 2018 20:52:16 +0200
        (DST)")
Message-ID: <xmqqsh0tcoas.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I did not and I do not think it would.  I was wondering if the
>> ability to be able to specify these per destination is something
>> very useful and deserves to be called out in the doc, together with
>> ...
>
> I do not think that it needs to be called out specifically in the docs. It
> is just yet another http.* setting that can be overridden per-URL. It
> would be different if it had not worked.

OK, thanks for sanity checking.
