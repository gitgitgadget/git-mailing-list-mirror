Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8AAF1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbeGLQgw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:36:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34396 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeGLQgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:36:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id s13-v6so2475435wmc.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wBqF50WW6qwZwAUd8gBM8R4+qJh8TYjQlG+BwqR4VXM=;
        b=keLXESMgt1+77hXE7zRfs6eoLb3FgQydFMatMzwFAvQeKxzF3govZGaxcFu0RxQsLQ
         uWAaoctBPiSaq1q05OClzvQJ53QiEW+DNJr/X34bNUHcIgWVgHya2M9GLhN9Ryg8g+4G
         ycgoQmvxq4wDe2TQOxRDbjXR1n16u64HAPnvv5Sd38vJ0oMwRsAmRi5LirorCpEe2Mdg
         r2kmzR67et+wLWgGkIwJQ85htTxZciz0Wz2L54z30Yq6rRbcmz8buubQn4OITtJephVd
         jQEZZk/j+xWQvdLc2rJm+FWrhIvk4LMOarwPk/PmkIphf5cnLsumRPT4adJlfSW2IIU0
         1EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wBqF50WW6qwZwAUd8gBM8R4+qJh8TYjQlG+BwqR4VXM=;
        b=bt3ZAPaOYix4St+Sar0ojgtKXTlfFryjIWSA+M9IsLurvfTCx4t24GeEsckeJqyO+d
         6FJnAsY4/erk5CGCMr8FiGQEoTGm/aVbwQQ7csotWY71Ny0OX/FXvUg0T4gZrNekF5n1
         8+BezsTj4KZphYny9Xs/LFSTMxCh8M6PoNJmUYIDV++V40GunkIEjbpB+9CnYq4ix9+H
         MQhHps+PtRdRD7eQZLqBqZ+b/MuJsSCmQ6TpZegutzPxUBVL1Ayu36QDJsyEZJlXIxAi
         H6L1qe12Fsfak3ek7sWmS2Iwehw9c6k0enL1NHSHJ3l0GBO/Imr8TIrCNsvvbVskquJZ
         2XCw==
X-Gm-Message-State: AOUpUlHSsH28q97eaPjOwUEmRMiRNpzTArITNf6I3T59XBO9IhzZeDnY
        YZlQfTCrjsph4wJdC4nydKE=
X-Google-Smtp-Source: AAOMgpdRn9evzw52Ph0B7AeNBEcH1xbSnY/Oe9D7jamJ5YwqnXdqtO9Z9ng8mBS6CkWaOCKnGj1k/w==
X-Received: by 2002:a1c:70b:: with SMTP id 11-v6mr1758282wmh.151.1531412795376;
        Thu, 12 Jul 2018 09:26:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h5-v6sm13218933wrr.19.2018.07.12.09.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 09:26:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase -r: support octopus merges
References: <pull.8.git.gitgitgadget@gmail.com>
        <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kaYpw9t3kCvPnDiLc5z7cLFsVQv4XJDAff_T-bShEjPoQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1807121450100.75@tvgsbejvaqbjf.bet>
Date:   Thu, 12 Jul 2018 09:26:34 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807121450100.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 12 Jul 2018 14:54:38 +0200 (DST)")
Message-ID: <xmqqlgagzah1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Git is used in *so many* different scenarios, and both in terms of
> commits/day as well as overall repository size *and* development speed,

That misses another important factor, though.  How well the project
uses the tool, iow, how canonical should its way of using the tool
be considered and encouraged to be imitated by others.

> A much more meaningful measure would be: how many octopus merge commits
> have been pushed to GitHub in the past two weeks. I don't think I have the
> technical means to answer that question, though.

It does not mean that misusing a feature is a good thing and should
be encouraged if many misguided people do so.
