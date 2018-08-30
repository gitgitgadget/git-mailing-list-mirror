Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705581F404
	for <e@80x24.org>; Thu, 30 Aug 2018 18:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeH3Wyb (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 18:54:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35824 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3Wyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 18:54:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so3058051wmc.0
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XVaGzPVA3W7AS65qGK1+jCA1JFtBC+naZY1Z3SvuePA=;
        b=KpbvdxR4Z9zfSBMWPjKM5Unh07TniFn47fsOWPoCNRB/tMUhmTB1ZKrg2jgHV8VLZA
         hYfAuvqHtsTiKt1bRxtFyATblvk7o+kweth68bsAV9U8ZFYgJ0Mxs6ua+XHEBd/LCYZj
         VoNlYNDWCt8qAGMUhWehnZVrhe31ZD7RMfuyw4tU0lsVYxGnQTL3aamL1S3eRqSF7k8M
         vBxWsw8atngDLX9yTkwyT6vZ3Zv4JpyLkFGlOkkbvG4VEQv2S9o5yh4jlsQIV6TA2bji
         XDDt1VYNPtIfBSsShVvhP8jgkKC8iHPz4awI4kQp9Q6v7YkstxAVhSNoumaclYp2GZAH
         5X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XVaGzPVA3W7AS65qGK1+jCA1JFtBC+naZY1Z3SvuePA=;
        b=iFUgSCrdz7c65JPqg3nXB8OtgMlDcEZLtyz7p9eMgqTiB/TgBaKkdtVxzXSIIpDdZZ
         XbpRlrMTslsIZ2FB5aXRs491CYVa2VXOBivl4XCyw0/fURYwVLXV9ZQOynQS//m+eHYt
         8+BX1Q/fGGQKLT0zXQ3PiiNmuicq+IgRU6WAswJvhHb8YVywGo6t9h5X+45tv7dKJ0qp
         DTONzjq6B8cB8Wi5KbR7wPdsy0WZeSzaqa8BcrIoaT/7L0gfl8DevAevkiVWI1OUKW+o
         IV7NFFy3IWGTV1mSqqmd0zkVw7GJwHuTds8E1YYTJUP2f/rZJN4h9ErgPdGuuVYz4wQe
         ukZw==
X-Gm-Message-State: APzg51CEmG4QdcuPKnxsYZlzKEDX3zUVXlEd0qdQuWOkmWwb3liA55Cn
        aBVB4IrLtELtHsktUweZYYm5Wivx
X-Google-Smtp-Source: ANB0VdbFu3PYjArcW7XzaAYE9ctx9wzCkKBSIAZcudDxZOVdyRWVDhiACMRWlbqAiQsVD7awiQ3Wfg==
X-Received: by 2002:a1c:ee97:: with SMTP id j23-v6mr2625623wmi.66.1535655057331;
        Thu, 30 Aug 2018 11:50:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h184-v6sm1773492wmf.28.2018.08.30.11.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 11:50:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jann Horn <jannh@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
References: <20180830070548.GA15081@sigill.intra.peff.net>
        <20180830070932.GB15420@sigill.intra.peff.net>
        <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
        <20180830184201.GB14273@sigill.intra.peff.net>
        <20180830184459.GC14273@sigill.intra.peff.net>
Date:   Thu, 30 Aug 2018 11:50:56 -0700
In-Reply-To: <20180830184459.GC14273@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 30 Aug 2018 14:44:59 -0400")
Message-ID: <xmqqzhx34rjj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I can re-roll, or even prepare a patch on top (it's sufficiently subtle
> that it may merit calling out explicitly in a commit).

Yeah, I tend to agree with your reasoning to do it on top as a
separate patch.
