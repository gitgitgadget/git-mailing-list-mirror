Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6651FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdBMUYm (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:24:42 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:38833 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdBMUYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:24:41 -0500
Received: by mail-it0-f45.google.com with SMTP id c7so1908501itd.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 12:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+l0ZQfI2tgHT0R3zvW7z20TGNaokVmiJ3We5tvKrLmw=;
        b=OGu1HJ1z98Vprg3KhE16+zqrsdie1QK9DRnwzfYOpO8sd6nsy24zzhCtaVB1oTGpaT
         5sgtNe3/6klPrUmIbhAuJS3j5Hlaj9u5rcC8sgqZGp076yP1C3qUnRd5pX9dZsvGjEnx
         rVnEdPPYv48un6A9QIxaqldzndBccajeGhzTI56/Ht2zQ0YodHpDEWa38na0j+gCNXJt
         20oZETmuG82SENnkgFQEqWRB8JU8lYur27fMs6MP4CqE5uXk5k3y2APPK2KD7cd1h+1W
         8fzPdHs6Hq6MKUS2B4PCKgZnh4naoBD4nLDO5Jr/atk+FwN6IVNlMRwQhTGLgTRDVnkB
         eJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+l0ZQfI2tgHT0R3zvW7z20TGNaokVmiJ3We5tvKrLmw=;
        b=rw+sX5V9jf8bGTDRvtDU4MwNExvgtaiGwVIaQl529b0DZknvWvWOCFCb618giG3mJB
         DIMOv63Z0PrH2LDevlfa0zFqYuazywUL3V4/ki+DoMl9a5scTpPdAe/gEiWHXBmRdiGG
         6fa1UMOQB4AN+e36+855rn58DHrYwD39LmiN20s/mt5SitKPhVtaR23eE7Qwy0lZwKKK
         +sAnS75bvNf2pJPgOIsHaB08s+6SU0oZw1HtrRMl80+l7O1TRiQmMLZVJ0nj9E6p3kQn
         m8qxBZnkGhLlZsaN84+wGKHJkRfqM8KjBANObLYZPuxBQiHeHE4Hgw4joUJfdRAqgeGu
         nmtQ==
X-Gm-Message-State: AMke39nf+DIUJXR08eobdlQ+uIev8dIFJjARjRrumM5WvSEJzwQtxLiLt09N3Q1mEpl/hA==
X-Received: by 10.99.67.130 with SMTP id q124mr29086407pga.221.1487017478902;
        Mon, 13 Feb 2017 12:24:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id z70sm22564880pff.26.2017.02.13.12.24.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 12:24:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] squash! completion: fill COMPREPLY directly when completing refs
References: <20170203025405.8242-13-szeder.dev@gmail.com>
        <20170206181545.12869-1-szeder.dev@gmail.com>
        <xmqq7f4xk9es.fsf@gitster.mtv.corp.google.com>
        <CAM0VKj=Pai0fL7KtMdv1sg3N2KA1aBafGQ_XzXWKUsBmo62ZoA@mail.gmail.com>
Date:   Mon, 13 Feb 2017 12:24:37 -0800
In-Reply-To: <CAM0VKj=Pai0fL7KtMdv1sg3N2KA1aBafGQ_XzXWKUsBmo62ZoA@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 13 Feb 2017 20:32:52
 +0100")
Message-ID: <xmqqshnhdeka.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Feb 10, 2017 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Should I expect a reroll to come, or is this the only fix-up to the
>> series that begins at <20170203025405.8242-1-szeder.dev@gmail.com>?
>>
>> No hurries.
>
> Yes, definitely.
>
> I found a minor bug in the middle of the series, and haven't quite
> made up my mind about it and its fix yet.  Perhaps in a day or three.
>
> Regarding the 'strip' -> 'lstrip' 'for-each-ref' format modifier
> rename that broke pu: I should keep using 'strip', right?

Right.  I view the removal of 'strip' as an accident when 'lstrip'
was introduced, not an intended change.
