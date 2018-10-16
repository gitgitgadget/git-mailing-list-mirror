Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9921F453
	for <e@80x24.org>; Tue, 16 Oct 2018 07:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeJPPfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:35:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45995 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPPfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:35:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so24239013wrw.12
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NwwFCToG/nFIhcrjxKzDPeWp8vB2MoC+/Jg5b+FyAEs=;
        b=XafuolmbY+BlVG+5yEw2YW8/17ArTkPXdRWEdjpLhSHaD8Co/kurPxyA6AdKXohK1q
         gOsMrCKJmw/VxiIaVSApYjZIzx5NRXwwRgfuwHrtQdDDIv2gaT4d2ox87imVZu1fPcmE
         ayvT01gDZZ2VO5rsOdIiEP/KniwG7lkCc4TrEXDqX4rtO8IqWpkpNmpFL/hUwlx5NXdF
         nQBkWILrovxUKJmycNNvjvEKTXbFF+5oqLvG73S16rAtjkPWb7Wf8gyMl1iZhSiFJKdZ
         hPaCxpqAX8s0k1vIqRYRmsb6ZASQObDeT6DWcBAMROuoF6amj5Mx6QzjeDw2dV2DReKz
         MQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NwwFCToG/nFIhcrjxKzDPeWp8vB2MoC+/Jg5b+FyAEs=;
        b=irDjZgJAl0schTtsc/akjrJNMBVsa96jZzQuX/IOi+k+BVFunMv77VLRw0iAbUM2CH
         j811jdJmA8ODFEeNYjU0Wfe7hM4TQm5JucaZS5c65D9enY3OkUKLidUAgZmiVHddJW7u
         1TmiEcziOKEgRI55QXScyqO1KE/jLquK3ndLbrXQt49suw1aHj6Re3B4IWmFQrueea/q
         YYKlOqNI5S8qMV7Lt7FdD+gYBwd1nP8IHDCtMR5Wiz9Bq9665MszdWi6Ke3+o80b/ILf
         nZGS/ENdIV3XdJHtd6vtU/GDlb03W2OkPdxVfEfwe7PqmqZK/JH1WxQiF0DQc6/saw5r
         O8Hw==
X-Gm-Message-State: ABuFfojf89F191v9kHg47BN1EhWS4TlSwnCBN1zXDOmlE3Y457K0Qtn3
        hbuL9eBJPjTgPID2Qrnx3W2u8ztEc2I=
X-Google-Smtp-Source: ACcGV602rlBSBypQ3NAIfRnuwsYBWLCac40L+TLZZa5VY/lRqyWgp0A9xaczKPv+XdLPXe0YkwjqEQ==
X-Received: by 2002:adf:eac5:: with SMTP id o5-v6mr16751538wrn.284.1539675972635;
        Tue, 16 Oct 2018 00:46:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm9810474wra.83.2018.10.16.00.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 00:46:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/3] send-email: also pick up cc addresses from -by trailers
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
        <20181010111351.5045-4-rv@rasmusvillemoes.dk>
        <xmqqd0shgg66.fsf@gitster-ct.c.googlers.com>
        <5651069a-4879-096d-082d-58d8f0158958@rasmusvillemoes.dk>
        <xmqqo9buzb67.fsf@gitster-ct.c.googlers.com>
        <ef80210d-f440-06c5-a1eb-7b3737f73adb@rasmusvillemoes.dk>
Date:   Tue, 16 Oct 2018 16:46:10 +0900
In-Reply-To: <ef80210d-f440-06c5-a1eb-7b3737f73adb@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Tue, 16 Oct 2018 09:17:46 +0200")
Message-ID: <xmqq7eiiz64d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

>> It may be surprising to existing users that
>> the command now suddenly adds more addresses the user did not think
>> would be added, but it would probably be easy enough for them to
>> work around. 
>
> Yeah, I thought about that, but unfortunately the whole auto-cc business
> is not built around some config options where we can add a new and
> default false. Also note that there are also cases currently where the
> user sends off a patch series and is surprised that lots of intended
> recipients were not cc'ed (that's how I picked this subject up again; I

That "also note ... people who are not familiar are surprised" is,
quite honestly, irrelevant.  The behaviour is documented, and the
users are supposed to be used to it.  Changing the behaviour in
quite a different way from what existing users are used to is a very
different matter.  No matter how you cut it, change of behaviour
like this is a regression for some existing users, while helping
others, and it does not matter if it helps many more users than it
hurts---a regression is a regression to those who are affected
negatively.  

At least this is a deliberate one we are making, and I think it is
OK as long as both the change in behaviour and the way to get back
the old behaviour are advertised properly.

Thanks.

