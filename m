Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513AF1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 17:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHUVMj (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 17:12:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40159 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbeHUVMj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 17:12:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so6111582wrw.7
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K9NBcBP4PH+BSGtB6OEF0ch6ubhP/yCKMjCnUhAaJik=;
        b=juu8pssKwG4oDB0JxBIGWv2GsYW4k7TfSo1cfP/8LHS5dkQFybdUBjecR8Didaya3/
         O8BjdteoqIci5HEApea202s/j7iHiJjOUcyGKqAbaQQprASV8cA6EGtoGk6Xui2Ooib2
         hB06I0XudZamzFxzVXEV9nmzyKa9rQ6JcXhCEYP0nA66pDDWqpG/ZX6wbTFkr79Dtdvq
         C/PeX72uNl6pemIIt6/p+iKWB92Uym3KOaYCZ78ydohLsrZ2Mw+jGckFoxrk13YWTPOI
         dX6UgWhVWpHZsrZ7Eho9qfNA/+U2lbrlJtAJHjecguUD2tNkiY3xn8xOtz5K2oO1AJPg
         +DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K9NBcBP4PH+BSGtB6OEF0ch6ubhP/yCKMjCnUhAaJik=;
        b=aXlqYa8fhVdHDSNgcxQKgs6OCbRZksa29b8dxC8Yh7Ulq4Ks9hnI2j0iQcGFc9HGZ8
         amHhoQ/iYhSlU6mBC42KB4PJGH9yiLdp1o3ADolflyZ0TAXc5H2lxldMKVAzjbvMGvYy
         GnPmyL8+Pfiz1gCAiYvnVjFeLFHYRI08tVCMubWXsLUDWg0ZyOQmM1PV6fKBCCDKEK87
         C36q+tcLMMkJThopLY68QzdMHTMx9KwH8AHd0PFPNdjBP5QfMPXAw/CHj4NFKfxmMRlN
         +Qw4UJVXzIh9GXcbSYRys1kpzJHglGToy3Z22A7MzvO70oQ/tbunien6pRX6aTVZtlIu
         JQpg==
X-Gm-Message-State: APzg51DNWulXupyg/qTdDa7yoAEkQQ44B5nnwIWzlfSgsxlLIdJCztIw
        x20TTV4O+17P59dDymMUbbg=
X-Google-Smtp-Source: ANB0VdZqj+7ia4Mc2E29FptWuUIgwIq6iXSFgNTH5fkaP80DPj5n03R8ZgUJhy3rJC0oypE9EHehHQ==
X-Received: by 2002:adf:db51:: with SMTP id f17-v6mr4466002wrj.212.1534873889975;
        Tue, 21 Aug 2018 10:51:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z3-v6sm10004265wru.27.2018.08.21.10.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 10:51:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 0/8] Clarify commit-graph and grafts/replace/shallow incompatibilities
References: <pull.11.git.gitgitgadget@gmail.com>
        <20180820182359.165929-1-dstolee@microsoft.com>
        <CAGZ79kaAAo+=nrcipfd4kp2iHXFPdo_zNxv8mEgQkN3JbTwicg@mail.gmail.com>
Date:   Tue, 21 Aug 2018 10:51:28 -0700
In-Reply-To: <CAGZ79kaAAo+=nrcipfd4kp2iHXFPdo_zNxv8mEgQkN3JbTwicg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 20 Aug 2018 12:06:56 -0700")
Message-ID: <xmqq6003a9r3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Aug 20, 2018 at 11:24 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>> Because of the change of base, it is hard to provide a side-by-side diff
>> from v1.
>
> I thought that was the whole point of range-diff. ;-)

I thought so, too.  Was there any change that confused range-diff
machinery?
