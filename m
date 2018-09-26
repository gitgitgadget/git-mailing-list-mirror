Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE781F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeI0CEW (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:04:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39114 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0CEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:04:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id q8-v6so3636326wmq.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HoBqEd2KeoQvGrVmqV96CuIDRtdH8RwxgNdN7I8XTBs=;
        b=ltuaCnxkUcQhM4FbVKwwqZpTZ/vNuFwg9GIwkApaf3w+U/1Nq3RIYpb/t3gGDnOojN
         ra51SuywwtKtYUlQQiUzw3ndXFkIfH/H9ygGv0oVHnfUe7Kk5vl8yOaBo5X1HH/FqAAR
         5541fQ5XzJ/TthY7DgydE48iwDOZwJNTXOzn3LJRD7HyfragitgSWaWsGIziDhyzQ8t7
         PqJZhxTa5+eroI6ZdF/yO/YNN05GWsSFZOAgvqUeZPV7w9OzMfY9ETqLXPqyf2zY0f8q
         FpUv7kk1EyK6DhfMf/Or7PPYqNOSa9VrGxzaB5GT1Xk0U5J2rNyI1UIAVhKqAFydwv5U
         CviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HoBqEd2KeoQvGrVmqV96CuIDRtdH8RwxgNdN7I8XTBs=;
        b=anfI5GTsQy61VOPf++otFJyRfIXmFXfkG1lqId3bd6a1YVTgAUxRMm48VMisnUxDRP
         ml62B7DExSA4mhe0x+jWVYzw9Uev0CnUa62dVTlKUsu60QMEezPArtklrPGq/dU6LpB7
         RwTU4F8e140r7vmaQkyN49weG2FmGikB9IRdOHuSDLGIyv/Q4dwSei6metF5bHxyM3BH
         SF8eDQlRuZA7EvKtRf40rN1/BxCA9QwKj6yQpsLflsrIgS4h4Av3cehlYfTOJWMuQCqt
         +agv7wiib4Yd2hihi16T9DAbT1fTto8prMoZIKTjNT2DMieL2ZpaaX3dz9N5UukNKJ/6
         AX2g==
X-Gm-Message-State: ABuFfojDUM6nNWdWfJaYlNM+2Qt586tJTrHDX+4tbSSFW4rxYz2HfozH
        jcYa6GrzUjtp7zEaZNX5G8s=
X-Google-Smtp-Source: ACcGV60D5b04qC+H0AKuWkFn8aK9PpSVkMeEfbLMWwW1JA2UpcoqmWbD0TcqKSfZUJ8HxASC0Rbw4A==
X-Received: by 2002:a1c:b49:: with SMTP id 70-v6mr5653000wml.149.1537991387500;
        Wed, 26 Sep 2018 12:49:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 132-v6sm336750wmd.13.2018.09.26.12.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 12:49:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
References: <20180921223558.65055-1-sbeller@google.com>
        <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
        <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
        <87d0t0jghm.fsf@evledraar.gmail.com>
        <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
        <87a7o4je0t.fsf@evledraar.gmail.com>
        <20180926185812.GD30680@sigill.intra.peff.net>
Date:   Wed, 26 Sep 2018 12:49:46 -0700
In-Reply-To: <20180926185812.GD30680@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 26 Sep 2018 14:58:13 -0400")
Message-ID: <xmqqtvmcjaxx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Now I'll admit it seems like make-work to me because I would not plan to
> ever look at the formatted output myself. But I guess I don't understand
> the audience for this formatted output. These are APIs internal to Git
> itself. We would not generally want to install gitapi-oid-array into
> /usr/share/man, because only people actually working on Git would be
> able to use it. So it sounds like a convenience for a handful of
> developers (who like to look at this manpage versus the source). It
> doesn't seem like the cost/benefit is there.
>
> And if we were going to generate something external, would it make more
> sense to write in a structured format like doxygen? I am not a big fan
> of it myself, but at least from there you can generate a more richly
> interconnected set of documentation.

I agree on both counts.  I just like to read these in plain text
while I am coding for Git (or reviewing patches coded for Git).  

The reason why I have mild preference to D/technical/ over in-header
doc is only because I find even these asterisks at the left-side-end
distracting; it is not that materials in D/technical could be passed
through AsciiDoc.

