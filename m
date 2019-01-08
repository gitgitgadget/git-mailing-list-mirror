Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6701F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfAHSiG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:38:06 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:46988 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHSiG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:38:06 -0500
Received: by mail-wr1-f50.google.com with SMTP id l9so5054283wrt.13
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=09SBTJBmb9RoaxD4nH2W8QUfJ237B/byS/USxj4qaVg=;
        b=LHZ6ZB0O9gw4Q6xbezXP4HQlk+YpFNM1LSdDAEXEcUJvC2xd31uO3QRQfazpqVbSoH
         Or9/M+M7xah8N0G7J1pQHKKSUH/8yujkMwr64E6jIdh5ysemX6AHS6qmSssPTdO06fI8
         pqpuntq7q2K3Hpf6lTd9rAidVVG8Uq4rGcoArTMk5bW3MHIEXUsGM+UnyzWUQe37tUXf
         A6/Z1kVDoSHhTjfRILag+ZGpIZQvdkIyC42qlZVP2xyXIR51Atxat5T7wWt7BGeYy5Kr
         FN4nOrHSWNl605mZO/gbVQRNkiY3r6vg9uhEopQ35I28mkzuDHAIJxStA3GrvWx2SB2r
         fS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=09SBTJBmb9RoaxD4nH2W8QUfJ237B/byS/USxj4qaVg=;
        b=UFanhixWABkIZufMAmQLrqV2wFXoGBAvfsbR3LKAEdesARVkqUAjNSDf5TI+WWO1dF
         +f8b5trsqOhZ8/eQsDjjNxRA7+kRjNRR0OCpFK1Y+LFTkhXQsJDEIzDKHgVs9qEboy7G
         rWUQtsr3pdntGGJbxCTU56dB6TBwf+AFZH224DBPGc+AYlU8Ue1RwtZ0KujAg/sBASn+
         utxhNiuZfiiXrHsSlTnIfC8qgTiLXW4Z523OVmyVuhfeTxJ5o7AenO3cE15+HxKmb5Ss
         tDweRytZu5w4WP8fKbZhJkmYI+OVSJTDJ4TPhDc7R4Mb0RgnkvHsbPn4BfNKvCuHeQo3
         QXog==
X-Gm-Message-State: AJcUukdBx65l1ajsuJyGF+rt17WF149w3ZDENigucGIVY/1cIgJ30v85
        UZvZOJd5GeihMgYcJLpsFtrfQyNS
X-Google-Smtp-Source: ALg8bN7152p5ZrsRdD5ymf8ZGoWPuwV0CmaLEECMAeZlOKyq2mQGkjdvOVp7qgMnsPv8NH6MaiQxBA==
X-Received: by 2002:adf:9422:: with SMTP id 31mr2476488wrq.106.1546972683411;
        Tue, 08 Jan 2019 10:38:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w125sm10639027wmb.45.2019.01.08.10.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:38:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Hennings <andreas@dqxtech.net>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: --preserve-merges to add "exec git merge ..." instead of "pick ..."
References: <CAH0Uv3Eu7bGSVaJKu6kDjp0BPRe0yROucDfJ8QHV3X_ZjNJT7g@mail.gmail.com>
        <xmqq36q4berk.fsf@gitster-ct.c.googlers.com>
        <CAH0Uv3FRq0JiXWx9Ow1EhKrYB4OTM-9Fpox7FvZ3tC6J6toEsw@mail.gmail.com>
        <CAH0Uv3F4q0oPG2O58eTV5n+5eZcxHK9acGMX+4F4LTm1JATfhg@mail.gmail.com>
Date:   Tue, 08 Jan 2019 10:38:01 -0800
In-Reply-To: <CAH0Uv3F4q0oPG2O58eTV5n+5eZcxHK9acGMX+4F4LTm1JATfhg@mail.gmail.com>
        (Andreas Hennings's message of "Tue, 8 Jan 2019 19:13:31 +0100")
Message-ID: <xmqqd0p7571y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Hennings <andreas@dqxtech.net> writes:

> I tried this option after upgrading my git.
> Unfortunately, no matter which variation I use, it still attempts to
> rebase most or all of the feature branches before merging them.
> Possibly depending on their ancestry.

Yes, I know that.  But what I am hoping is that it won't actually
touch the commits on the side branches UNLESS you tell in the insn
sequence to modify them with "edit", "reword", etc. and instead
fast-forward them.

Of course, it will allow you to muck with these commits on the side
branches, which is a potential source of mistakes.
