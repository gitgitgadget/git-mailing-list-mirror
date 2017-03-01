Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E09D2027B
	for <e@80x24.org>; Wed,  1 Mar 2017 17:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdCARfO (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 12:35:14 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36791 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdCARfD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 12:35:03 -0500
Received: by mail-pg0-f68.google.com with SMTP id 25so6514678pgy.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 09:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YVDfH/7H6mqu/3jh0SEbCJLa2zNxB9dRF//54eE3/FI=;
        b=CTrGQZ13TSIyCPgtRlE75oH4PsTyrtEwzwXoUbVWh6L4OjDeJq2Prx6MPEXnYRH5d3
         3dPJ8Hz8IwygNochFHX6md7RkBS1x3k9TpvSZbJvJ8CVH90FGemdQ7+4mxfo0X3A2Q4H
         hX4RZyNlJEUpDfMk2Uwa/p0jRJb696nhYSymZcnfPAQUFrwPVUvRWx4RH9znLzz2eOD1
         jwvKoWLjmH4HXVrLZaLMY3je8jnKtC+eh9haWsC6KHBThgTYSRrSKLC/QumCqNhE9xGt
         alpyic/GhccA/zxGXH3SHwyEA30RX+iS/kVbq3aZKkOQRZ2bHg0YPJxCd2wW9gm19ANG
         jJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YVDfH/7H6mqu/3jh0SEbCJLa2zNxB9dRF//54eE3/FI=;
        b=fJYSUEOBGnEOTjp/dcEKjfxypRl+BfYXe0ybFp772ESo2AkBHYw7f/2PfVTwhas84H
         yplebpSGaAm6g4/X0uREIHGA45w2Sw2dFGTTraM5yshyeZ2SrAHyqSc+tkZYn0wlXoeN
         zr7Px6rn5/641usu1RHAmZ7w4lgHutb8qAOBAb3y/WtrTZQkyxD+Kty2uZ2Jj+jJsE+T
         nX8Pt2qKYN8mWiOpmF2w7BqeJpYKm9/V49Sa622csdZGv+QKJisnox9xVsfkBkl5v0+/
         X/YNQbBayn3sQ2C9MaoaPGm6qekB5rj4H6hI09Ed4klhzvpn+gFf25iNpy3jGnZtJN2r
         y28w==
X-Gm-Message-State: AMke39ldGcVNAee7FB/SkGJn89Og9IBd20DhLaFEsglLcLrDVbIH9NnAivUDpoJ8J6C6ow==
X-Received: by 10.99.211.21 with SMTP id b21mr10017380pgg.166.1488389702039;
        Wed, 01 Mar 2017 09:35:02 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd87:32f4:da52:1d3d])
        by smtp.gmail.com with ESMTPSA id l188sm11806764pfl.28.2017.03.01.09.35.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 09:35:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
        <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
        <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
        <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
        <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
        <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
        <xmqqzih7kvbz.fsf@gitster.mtv.corp.google.com>
        <20170228005302.k6fyfinaxyl3ti76@sigill.intra.peff.net>
        <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
        <CA+P7+xpfRjr4BKkLLcbCS-yXXYoiHeWr9Y9ubHA-Xxqa9c7q8w@mail.gmail.com>
Date:   Wed, 01 Mar 2017 09:35:00 -0800
In-Reply-To: <CA+P7+xpfRjr4BKkLLcbCS-yXXYoiHeWr9Y9ubHA-Xxqa9c7q8w@mail.gmail.com>
        (Jacob Keller's message of "Tue, 28 Feb 2017 14:48:09 -0800")
Message-ID: <xmqqwpc8hpdn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I didn't find any problems besides what you had already outlined
> before I started reading the series. It looks pretty much like I
> thought it would. I like the idea of saying "I want X" rather than the
> command returning "This was a Y"

Yeah, thanks for reading it through.  Except for one disambiguation
glitch Peff noticed himself, I found the entire series a pleasant
read.
