Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CCD1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeIACFV (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 22:05:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38275 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeIACFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 22:05:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so12431717wrc.5
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HBQzDKOWV9c9k0qoTzGVpUpunZX2UwtkPaVH6dYaiak=;
        b=UUvHigVVGAi3EdQZX4TvnW0LnYwpw2QpPcjbX5gycg2WIgtxPGvkrOmjuQ2o9V8EB1
         YE70I0Mo1QC5eKo/284qUtUehHGR6SUB3CNrL8F0f4o8xZl49pTwfeT4cn2zaBAY3CIW
         ke3jX70xJUQNkKiPvqxWwZOIwCUk/eCloEw9fERo0hVDFy268Is3Ko75PJacP/EPHzqB
         0P8Cn0QlopIvlKL3ZFcc8gHqfmJmI/bkt/UJLSaE6s4MDR18S9bzZlv1kh8pPozO/5JC
         1BVPCp/sgOoZBCqIDfSPqMtenWK5sIR8KKkP+e5LdMCJf/NaFFOZKYNxQcXl4e1rfQXV
         6A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HBQzDKOWV9c9k0qoTzGVpUpunZX2UwtkPaVH6dYaiak=;
        b=KETodiR8u8Ka6LhgF+VnW6KHu9a7hCXao8NyZZDcuu+JWJTRkxvBZubtPHP/iE6MUY
         QY/bGy1wuNmvuZi9So8GpqQI8V3skg3JgSchdLq0o7a5QFL/kL8NnaoFBYGhVQo+2M51
         uCjPC4tA466GCsQrsW69Eb0u1+9o1DoIdQqvXOUFne2fYmgAQkGDLLViBto6RIkImggp
         5tAW8XgUnYq35Ab0bXsVHx9G0Kfq19EIwVVLEoeX8jCQ30g+VYwOwWzQqWaoawkNjRUy
         6m5Wz5oBTiDGiGGC0xszBwEiD5p0cIxIUdjguF9iwqShR6oid1zT9rCkEHZK1a4CfrrO
         3yjg==
X-Gm-Message-State: APzg51DRr9jbVW2rLs7tjs8jhSNuwlNYgszcbZwYkZBEtbJD8qVnJljO
        qQpCBvjlHIpj1xWWIJ16DQpkQcmw
X-Google-Smtp-Source: ANB0VdZXOM8a504uiwbd0MzYcnunb8w2atLa+wzyLh5PLgdXLez41UErQ82n7FfhOdbRCCrdl0yd/Q==
X-Received: by 2002:adf:bb41:: with SMTP id x1-v6mr11728231wrg.24.1535752553940;
        Fri, 31 Aug 2018 14:55:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v192-v6sm5992944wmf.40.2018.08.31.14.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 14:55:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jann Horn <jannh@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
References: <20180830070548.GA15081@sigill.intra.peff.net>
        <20180830070932.GB15420@sigill.intra.peff.net>
        <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808311155410.71@tvgsbejvaqbjf.bet>
        <xmqqh8ja360p.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808312313210.71@tvgsbejvaqbjf.bet>
        <20180831214116.GA16999@sigill.intra.peff.net>
Date:   Fri, 31 Aug 2018 14:55:53 -0700
In-Reply-To: <20180831214116.GA16999@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 31 Aug 2018 17:41:16 -0400")
Message-ID: <xmqq7ek619qu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   - make it clear to other observers that there's at least one person
>     who hopes this is not the norm for this list

Make it at least two by counting me ;-)

>   - make a general reminder that collaborating on the Internet is hard,
>     but it's worth spending the extra effort to consider how comments
>     will be taken by the intended receiver, as well as others on the
>     list

Well, in this particular case both of us know exactly how the sender
wants the message to be taken by the other side.  At least I do.
