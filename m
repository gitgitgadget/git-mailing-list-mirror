Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E348B1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 20:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeIYCg1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 22:36:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36920 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIYCg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 22:36:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so21002538wrr.4
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=11eIYjPLDFC6S55RFutkv2IOq3M+Cm8iGVd+pWh1NS0=;
        b=RaJhSVgc1FuKMSFN6p6lhxcEzxjpsKSOuRH7x+aGNc3lEBGFgwIQ0eXnh+UHufJSoC
         vWDEZT+Ua5ZbJKgCcvYHDyBrnHPqsrlOdR/xeynQ00/SxyPPNrssZ+JMrNaHY1L+m6jo
         wKhqgklGUWggl6RNgc6zaPqlkmDvFrJgHzgcF2x7TAb/u/bqpEkSR5kiVVhc8i09stmw
         Fdk4jheGa1g4m/nY9fML6D505FEgHkDcoXilRxREo0RVagN07NaPh4J+IOmHyieo7Cem
         gQP8ebNK6vWQTrBJ5Rz/MGlr7oxE4f5wf7BSHdmE9ftO7FoS54aH+WHbs9azet5sxWR9
         YR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=11eIYjPLDFC6S55RFutkv2IOq3M+Cm8iGVd+pWh1NS0=;
        b=eCXR5thMOPA3jyqeurd4dYTGpxPGxA6Ykl02FEtU11nKRGzzXvuPyQBFmlORatZC0I
         KDGVdNvhFKnqjMAVCGfUWOVpXjsyoiX5CoJ15xUXEegdbpAi2bh41pfvtHybcq76XMLZ
         kgKjzZcPSBJ0sdVRe5dcmYUDReKHeu2uw8XfL69qEDZ+070SfINjTK2UfoMEfSoPru7K
         zyLudU/f+++tOjtjwQ9MhMYPpzFs7fyeIal+/dxaeiLppVT+CGS12g943ieHNfk/Iop7
         aSCkE31TeGKrkzaMWpQ0AzM4In83bUYsuHVKwiiwG8nIH8fbsHcss9bSOih7JyS4duqy
         Ja0A==
X-Gm-Message-State: ABuFfogeIGv8mVRoPgT/ZnCLrPkYjTQGvbtEE2+pHbwM/FcXj+NgjjU4
        GUlxTr55j3B2OOk13kaMmc+1zaZD
X-Google-Smtp-Source: ACcGV61hqJ5bVZ6mNxI3tbTtykAJJv6mpAgL2/ZszX7bAtIwbyyVEkd8VfkWbyXY/KLTluiocjDRIg==
X-Received: by 2002:adf:8141:: with SMTP id 59-v6mr358759wrm.127.1537821147594;
        Mon, 24 Sep 2018 13:32:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v16-v6sm565350wrw.12.2018.09.24.13.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 13:32:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <cover.1537466087.git.me@ttaylorr.com>
        <cover.1537555544.git.me@ttaylorr.com>
        <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
        <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
        <20180921213753.GA11177@sigill.intra.peff.net>
        <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
        <20180921221832.GC11177@sigill.intra.peff.net>
        <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
        <20180924181011.GA24781@sigill.intra.peff.net>
Date:   Mon, 24 Sep 2018 13:32:26 -0700
In-Reply-To: <20180924181011.GA24781@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 24 Sep 2018 14:10:12 -0400")
Message-ID: <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think it's conceptually consistent to always show a subset.

OK.  Then I agree with you that it is a good approach to first adopt
core.* knobs that universally apply, and add specialized ones as
they are needed later.

Thanks.
