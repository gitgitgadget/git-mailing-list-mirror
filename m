Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF47D2027C
	for <e@80x24.org>; Sat,  3 Jun 2017 00:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdFCANW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 20:13:22 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34673 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFCANV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 20:13:21 -0400
Received: by mail-pg0-f44.google.com with SMTP id t185so1811813pgd.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pzeG29a5LmF1Ueh9qWGDlTAS89MCkxgRpnSffiafIy8=;
        b=kFt4HwDpqSHsEBnZpV7qNA+jKbfaDcfa2bF3aeab85EmnO+RWCgE6EHcBb8BRLdG02
         IqwpRWYLuyFMdkhre15XB+JD3FnBd4B4pLCbYylbvCMuP8o4lwn534Gcis7yVIE2sJsL
         hcPrs/pWjMer5eukRWaLLy8/1LiC0hIw3SEslQbxD/fy6tOkZ6FqpXzVz+5tD8mp0uW1
         XGAUYhZ/o5EtZ155kQS2GXoZp+NsGUMQ0AuQtbIL8tEra/BdkS7joplk7ZxmEnv7BaWj
         IPQiBf0cM9/87GtKttq/DUtTGiyaX1zkyt3B/BBBZDN2LWMWjWpTN9q+DfO90cV/htVo
         mHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pzeG29a5LmF1Ueh9qWGDlTAS89MCkxgRpnSffiafIy8=;
        b=XXLu+NfsBAp+IA/ZaAzHrI+UOtryXQpn3RmNWyvhi+HThksXVOzmH1K2dma4ipeVRe
         eXSGsEW9HeEvcu4f6soz/IWbxNOfh7LWrzvHZ7paXwHRF61lqyeu3SrWiLKBrHiVeyVA
         MUMFI+o6IU9ufjvk93s1IWYx5qTjSVivrG9SM+zWlnQJHv3nC+kf3lUCYYeWd0/hiCBU
         tCfH8OzCUx/qgz0C4HTuyQOe+/TT0EFS0aHzzwvKAsXD0zQRw4xsHhUFPjNhXFC4xByF
         BPaZC1OA4/S5W6x5AKY0loE1cF/SfB4C2j7vB50W3v+0iK4yk+2XAyfEwLAhifB0Z/4J
         L/Lw==
X-Gm-Message-State: AODbwcAtkbmP3cXZJ/d/Ga3MyYSPceGZvCIDASLljo9mfmyVTWKAXVyP
        CXgQXq2bvslzZg==
X-Received: by 10.98.209.22 with SMTP id z22mr9068369pfg.95.1496448800659;
        Fri, 02 Jun 2017 17:13:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id r68sm41523324pfd.91.2017.06.02.17.13.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 17:13:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     demerphq <demerphq@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
        <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com>
        <mvmmv9st3yv.fsf@suse.de>
        <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
        <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
        <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
        <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
        <xmqq37bj454a.fsf@gitster.mtv.corp.google.com>
        <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
        <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com>
        <CACBZZX5re5Ge1OzxYOE42nwBhhusya6=M9An08X-KzaqNH9Cog@mail.gmail.com>
        <CANgJU+UzoaN3Urj=L4unMMtNwFm6G8LGxx19g49AR5R+76F2OA@mail.gmail.com>
        <CA+55aFwL9LQfx8t7tixYgV+2w_=_dAABxk54_GLJoGod-w=mbw@mail.gmail.com>
Date:   Sat, 03 Jun 2017 09:13:19 +0900
In-Reply-To: <CA+55aFwL9LQfx8t7tixYgV+2w_=_dAABxk54_GLJoGod-w=mbw@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 2 Jun 2017 14:53:59 -0700")
Message-ID: <xmqq4lvyx71c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Dereferencing an unaligned pointer may be "undefined" in some
> technical meaning, but it sure as hell isn't undefined in reality, and
> compilers that willfully do stupid things should not be catered to
> overly. Reality is a lot more important.

Thanks for succinctly putting it this way.  I think you said the
above number of times, and I was looking for one of them to include
a reference to in the response I was preparing, but this message
made it unnecessary ;-)

> And I think gcc can be tweaked to use "movbe" on x86 with the right
> magic incantation (ie not just __builtin_bswap32(), but also the
> switch to enable the new instructions).  So having code to detect gcc
> and using __builtin_bswap32() would indeed be a good thing.
