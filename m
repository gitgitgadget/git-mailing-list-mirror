Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C874720188
	for <e@80x24.org>; Mon,  8 May 2017 01:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdEHBDB (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 21:03:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35310 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdEHBDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 21:03:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so8255149pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 18:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mhyLI7ViKsJxbi+sLlbrt++jPxlheGUxBQv3+FHjV90=;
        b=lB2GQjfS7nEJQzTESbFEKFD9+wR3cbtB2ZLzt2aTUTQtTji2yW1GBqf+7kYn3Gr+9Z
         2CydBIVeq1TetWyIn94Qf6nPio2CyucvypYhueNW6+sXzO90Xmzq5C0QpQANM8zv1H7K
         o6FWlySGI4e8USLv+TpWBMACmL4KPcdifi6OtzB3lh6VbIIjqWhT8Cl3mKFUNlmC0K9q
         1uTQinJlfxI3Djc+4pVEr2Cs9EEr9Gq1qnSL649nmgCwfKgzlKuKxBjT8wr25TKGf3M5
         IAZhyjklkisvQBRvS4E25TqfrQ8seOaTRI1mMLxwriCfE/qcpijrF1mCXPvQ2wvGlSOq
         2i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mhyLI7ViKsJxbi+sLlbrt++jPxlheGUxBQv3+FHjV90=;
        b=tk4/Valut4uTToX3iJOkOBnpGCmSstWUpz2eXABLRCOuaxmqcPrxvqKJqu3aMHM0BN
         vr6WGA/1mZiA3brwcgWeJmtxxUkPjBkbPMcAksPYJZUe/JZ/524ifB0FLAAwAlj/h118
         nW6XA2ElujIGzHOTAfVD3O+wr7mYgPuhZ16sGgBXJZiyyKSCcZbopRVPi+HMBOvyrG9c
         ICidk4niUEvX0349epJ9UOJ6WqALUr0VY2PSFYxUsyvuhTjdbYZejuHNFm41+kbitqvm
         OI263FQxhXLOFzmv2W88U1HwSpp5l4FwTTyIswz4amEfFwSw7mb91BluBjgeLK45Rs5v
         g8bQ==
X-Gm-Message-State: AODbwcDT2hJj2NhzEmAUP1tkOO5fyc5qwU2V0/NKncUxj4IHGwlOPB1a
        NzRSs0t73W1L3tu+gr8=
X-Received: by 10.98.9.27 with SMTP id e27mr4334483pfd.177.1494205380066;
        Sun, 07 May 2017 18:03:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id b72sm8250160pfd.118.2017.05.07.18.02.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 18:02:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Smith <whydoubt@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 02/10] Move textconv_object to be with other textconv methods
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170505052729.7576-3-whydoubt@gmail.com>
        <xmqqwp9v6vw2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ4k7qVKE7OpSEELorwSx5hUgJksLAeNgVGs0w1JC_Ffg@mail.gmail.com>
Date:   Mon, 08 May 2017 10:02:58 +0900
In-Reply-To: <CAGZ79kZ4k7qVKE7OpSEELorwSx5hUgJksLAeNgVGs0w1JC_Ffg@mail.gmail.com>
        (Stefan Beller's message of "Fri, 5 May 2017 10:50:55 -0700")
Message-ID: <xmqq1ss0cg8t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I guess it is ok for now and in this series, but we may want
> to split up diff.[ch] in the future into multiple finer grained files.

For what end?  Such a split would require more symbols internal to
diff.[ch] to become external, which is a big downside, so we need to
have a large reward to compensate it if we were to go there.
