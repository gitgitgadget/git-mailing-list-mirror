Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3068820D0A
	for <e@80x24.org>; Tue, 30 May 2017 00:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750925AbdE3A3y (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 20:29:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35448 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdE3A3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 20:29:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so14058558pfd.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 17:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DovtMYo/19ZLZveeZgyLcoaDNG8VRI5n8NvVTlxWa7g=;
        b=FOGTcHAuBj/DOqDC5E7COL/xjqY1fFjVe/xz9vO39Ior9RU0SJ/qsgn7gNUYG5sl8E
         ENeyRqh9yBqmH3wZ6/AxOAixRyDLhYzYUww2L1Zpb7pBkQgSW/Gw8+HFj4uG3DNtiVW9
         oOA++ZBJP6mQH737T7JUfHK1StJalLlegmLKueG+fRJCBLjAjd3id5VabJp0cwAEDqlJ
         kG/oDHtSdICzm3bUne4olow0R9jKLinhJF+kzGLuiumk7tGX7RRPjWljyYD3wb9GUA1M
         svJUfs8jsmHZom+lu3bJuql8Pl9Fd5OBdpoKUv6xpbUof2GJEJXRGDQyrTHQSxiUGfxD
         kQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DovtMYo/19ZLZveeZgyLcoaDNG8VRI5n8NvVTlxWa7g=;
        b=kRiPE8u/l/AEqNsqkRVjT/vMua4rbD6ttj/z1hE4PSR0QZSmukgxs9Sze2SoyJGwot
         MM8MS/xKVQJbtVtR03sQ8jIAxW0DQEoIRSvVTSy6X2Qp9tDg0kccDnGteo7dEimoSD71
         a0512idEYCF3I+SH1YHOCUE3fggS9ZvLibSR71ZtmGiSy9/VMMhwmwNzIA8vkn08PgfG
         k/+Yvt0fpAsgznQeQGhD9BOpjoGpjHQbmQAiXLBEI6oVS0nTv5uKgmOJus96s9mpXN79
         ceDh4rrLX4cL0h6wpGx7yxlXb03HekLEuUVTibKkyS7bIVc3Rj0WLJ5e+fXiQvxCpYdy
         HUUA==
X-Gm-Message-State: AODbwcAyUw+OFJcse3c+dxvwD4nK0U/7Gi6w2lqcnptZp+igzOvWaLqd
        RboBg9eI3CVZ/XdC814=
X-Received: by 10.98.139.206 with SMTP id e75mr20231995pfl.64.1496104193428;
        Mon, 29 May 2017 17:29:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id v9sm18142167pfa.43.2017.05.29.17.29.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 17:29:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote nicknames
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        <20170526033510.1793-1-gitster@pobox.com>
        <20170526033510.1793-14-gitster@pobox.com>
        <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
Date:   Tue, 30 May 2017 09:29:52 +0900
In-Reply-To: <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org> (Johannes Sixt's
        message of "Mon, 29 May 2017 22:25:25 +0200")
Message-ID: <xmqqk24zfapr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> I would prefer to catch the case in the compatibility layer. Here is
> a two patch series that would replace your 12/13 and 13/13.

Thanks.  It is good that I can drop that last one.  Will replace
(with a SQUASH??? for 1/2).
