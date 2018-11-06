Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DBBB1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 01:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeKFLHK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:07:10 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33229 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeKFLHK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:07:10 -0500
Received: by mail-wr1-f46.google.com with SMTP id u9-v6so1294924wrr.0
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 17:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hEuTbeZzEq3DyD8E01+t1oYZSN/ijAB96xMBfpOT5hs=;
        b=YEZscAR4sUlX0V4/G9nUu1OcnOqO66k9IJVGJUhrf+ExLUDaBUL+G7teUHEj+k/jLv
         H0e7SKLx9z3bDIRR9OkrYj5xamaYVvkNKAjhwbcijRYVmi/kaYS3iccAjsqhvARz2e7l
         DGEn1qfMAKkQxrj22QLq8Z1LTNfGeJ2su7y9m+4r9Q3M/TaqkMzyNNUl67e3mwhcLpwb
         hQJGhkTNqdGQ+9g6DLc6un7QLZS1iiViqKJc9uuwDZECh7Sdb/yIjGh9Enui3x7WXNJH
         GzTflNuLLycwL37rDxEEQ17nqqtPoNMwjTuIqp15V/s8JdgTLigNXRV/lUdZTIBizurs
         HrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hEuTbeZzEq3DyD8E01+t1oYZSN/ijAB96xMBfpOT5hs=;
        b=E9uXxU54HIHaZ0RD58g02fx0LDUrG1iTleiqUrvZ1wiuziIQ//yWtfcnbCqyX81A0P
         emJmT7piDDG8dD45rowTB/y4JV011fazyKI7rQLJ57hY12cxswCDcl8JuZFvLocFLeuc
         i4yU7SfTGCESX3b1BybaRzhgbSK4UcwtsGpTw0312w0RfOxyw2a6AeTY+PKlznNnpEQx
         6d/W00RBlt+4n/HJfvP3PYJeADAPsqZaw2IkFR1qMDVcVZGvnjMJovFC3he2QbRRJbaJ
         GCONbP8H27KBsN3hVE8BsfUdT+L+kIRWhKnwTGxnI0A1eCpM9p4qRMibMzo+WyEoNPXX
         krdw==
X-Gm-Message-State: AGRZ1gLtxYlAjEdHTQJjx/2ApQOqHM0Vq0ENx9O4lMHd5gv3cRe3GbJK
        P52ZN18jP0kXhBu/unAvyuI=
X-Google-Smtp-Source: AJdET5focxlt/ckU6Beh00WGAvVk+T599Z39J4F94ptsvQ+qVfNNA93LMHJUZkdmbVz8DJHN3XBM8Q==
X-Received: by 2002:a05:6000:d2:: with SMTP id q18mr20749558wrx.302.1541468668299;
        Mon, 05 Nov 2018 17:44:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z3-v6sm298818wma.6.2018.11.05.17.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 17:44:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] sequencer.c: record revert/cherry-pick commit with trailer lines
References: <20181104072253.12357-1-pclouds@gmail.com>
        <xmqqtvkwl4u8.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AzriX4YYSSZN-U06HHKgL9XmkJ1WhWbLo4LwZvECa8hw@mail.gmail.com>
Date:   Tue, 06 Nov 2018 10:44:24 +0900
In-Reply-To: <CACsJy8AzriX4YYSSZN-U06HHKgL9XmkJ1WhWbLo4LwZvECa8hw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 5 Nov 2018 17:17:32 +0100")
Message-ID: <xmqqva5bgetj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I think the intent of writing "This reverts .... " to encourage
> writing "because ..." is good, but in practice many people just simply
> not do it. And by not describing anything at all (footers don't count)
> some commit hook can force people to actually write something.
>
> But for the transition period I think we need to keep both anyway,

I do not see any need to qualify the statement with "for the
transition period".  You showed *no* need to transition, but
I do agree that adding a fixed-spelled footer in addition to
what we produce in the body is a good idea.

When we know a feature with good intent is not used properly by many
people, the first thing to do is not talk about removing it, but to
think how we can educate people to make good use of it.

And if we know a feature with good intent is not used by many people
but we know that "many" is not "100%", why are we talking about
removing it at all?

> Yep. I'll code something up to print both by default with config knobs
> to disable either. Unless you have some better plan of course.

Does it make sense to put both, with exactly the same piece of
information?  I am not sure whom it would help.

The tools need to be updated to deal with both old and new format if
the pick-origin information is used, instead of getting updated to
learn new and forget old format, as existing commits in their
history do not know about the new format and their tools need to
understand them.

I'd say it would be sufficient to have a per-repository knob that
says which one to use, and between the release we add that knob and
the release we make the new format the default, when we do not see
the knob is set to either way, keep warning that in the future the
default will change and give advice that the knob can be used to
either keep the old format or update to the new format before or
after the default switch (in addition to squelch the warning and the
advice).
