Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7CEA1F406
	for <e@80x24.org>; Wed, 16 May 2018 00:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeEPAlA (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 20:41:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55197 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeEPAk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 20:40:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id f6-v6so3921039wmc.4
        for <git@vger.kernel.org>; Tue, 15 May 2018 17:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rwLdxIHhjJtIrlk2RT4m+5UXXQJ1DYmOlFqS9dZiF1Y=;
        b=cCdg0DKEx/7ZmWvcPP45pNQJvfoktaYPgjA96WC8CEmII65slVHO6CTYCkd/2PG+u2
         kZnYRvfYk/2b7ZejZy1Qu6Dvgy/oGxvp+A6Qiacq12K1EIWgBcHtSL3ov9lpdsYeDG30
         RPM/8GkUDbuoIhRSXlqH7T2aLUlIlc77oYkhswAv0bN6TbM5gflRlLAvhzHKq//ZXQSZ
         1B95yYZYIGndQe4BZnOZ5bwatH2l2y/oQd7AU/czdc4+zgE5KRCK4S40S2/YtchnkY7V
         I+dkjLHxnEwkIuvGpCyCWXQia2w0VFwpY/AaBNO/7bC1/hivlR1Yoqjp/ANeEeSgqRAn
         8gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rwLdxIHhjJtIrlk2RT4m+5UXXQJ1DYmOlFqS9dZiF1Y=;
        b=eCpYWN4fszIa1NvgwbBUQKbxBoMqYOr7wIINf4Okln1AdYrIALhcdzJTQklgkYDII0
         +npncuSBopnQQolwVZNKc5pqa5B1Cf6WK7ppkkuP4kVyEfwQM0dKjROrMQhE3/fzCWeM
         1gAeLfR8g1z7/8nNr58D+6i1WvtyPgc1nTzsGkqb/XLM6pxfwvNfDKLwXnWzYqg1Iy2P
         sJnPXi3M2esEClQ9219m8XjujbnxgJdej2mRYDmB8I/akxqhKlL7Q4PLN6P77yWx+JXb
         doM4SoidtqJwyw7I6RWO3s4YY6BvtHijO/KrblAqb9bEWOuiYZGvOAHircLL5rxXJv6v
         QvnQ==
X-Gm-Message-State: ALKqPwecgKxZYslcHSwezuI7Mu1N6kbj89sh2TKtGpxBEvVSz7ngwKk2
        hjCDWDhcqCEtvsUP32fKohs=
X-Google-Smtp-Source: AB8JxZpZwlETJ0qNpblnQ8GTQC/eJzTGfDC9tcZSQdFk1cdjkhhDawxS4/yZtx/rQwGQnlGrcVK/fQ==
X-Received: by 2002:a1c:d212:: with SMTP id j18-v6mr95185wmg.29.1526431258398;
        Tue, 15 May 2018 17:40:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g192-v6sm2023185wmd.36.2018.05.15.17.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 17:40:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/35] refspec: move refspec parsing logic into its own file
References: <20180514215626.164960-1-bmwill@google.com>
        <20180514215626.164960-2-bmwill@google.com>
        <xmqqr2md8hrz.fsf@gitster-ct.c.googlers.com>
        <20180515165106.GA72551@google.com>
Date:   Wed, 16 May 2018 09:40:55 +0900
In-Reply-To: <20180515165106.GA72551@google.com> (Brandon Williams's message
        of "Tue, 15 May 2018 09:51:06 -0700")
Message-ID: <xmqqy3gk77qg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 05/15, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>> 
>> > In preperation for performing a refactor on refspec related code, move
>> 
>> Preparation?
>
> Oops, I'll fix that.

Thanks.  And sorry for forcing you to page thru 600+ lines only to
find that I commented on only that line.  I'll try harder to make
sure I trim quotes from my responses.

