Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596331F404
	for <e@80x24.org>; Thu,  1 Mar 2018 23:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163273AbeCAXnn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 18:43:43 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:43902 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163088AbeCAXnl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 18:43:41 -0500
Received: by mail-wr0-f181.google.com with SMTP id u49so8322428wrc.10
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 15:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IR/9XKGmciRSmrt09Tly0P7CCiKQoRYizo4TUFoQgo0=;
        b=g35UvFVzeCQ92sloOlr47TJwufCKfr6k0ivpJDgyu7z04qBQNDe1Z5c3KkfwvHs4aH
         I+N8PWqm15MDfkoGTFhJWtk3WbU5a6oC7tIUr+a8NIrh6/0ipx/OAwZP3h9gRxFQQDo+
         Iw+i/2QTD0dIebqFaCjz8roqvLj1/wYSEB53CAIm9pE+QEtNCLfO6vbIaUAdnpONImy0
         TPZADNYw33zDDZhidz3pFpe0zp3onOv2Foy2EG9KElOXRoXMVP52sf4RkGOo2yGfg7E9
         BrRXOS6K71T8C51UN5nFo13rMxRQC+6aVSrm7mQaiOo+Vr1EchPhEna8o/qO6gW9FFgS
         Zdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IR/9XKGmciRSmrt09Tly0P7CCiKQoRYizo4TUFoQgo0=;
        b=l3eFPQ5aaV7dFydro2yG32+oJ6y/p2idoFt6Z8WeF9isGgtAu8NuFFYb58l/sWLVcr
         NvZSRJhl6yjK8FGz6K4qHxh4tNOn/nIfeNiU4q35xYVy3JT8y+mRAguo8T6dviLQ2Izy
         owYtk/uxYWqKFQDL7D8ijYcWN5UUjd2EVuvy3IUNpksVy7uwqly6GYiog9Ko1zElK7NB
         3i1VXxCerXjZax9elbRa/u5vyTaVE2DI+uUX5mFmlqKvCkzzoU1p4p2VE1hzryhxRDAk
         MsE0SDdhEdDBWD4bWS56j31iynxcBVMXpSDlWiTMO9hpS1/Ml/pt4jo6PnF02/A5yLec
         8zaw==
X-Gm-Message-State: APf1xPDzoMiQ3xC898FLGgxHCYJVnsfAg9znrecbX85sK7tgLo7KU5+W
        QCMvIWUVqGt8mcN3jWQRdPNsHJFS3zY=
X-Google-Smtp-Source: AG47ELsMYQPsASyBXuLL1DHvMhun09u4o1k7tWxQ29bEdCLG9f9kO+JLcSP2RM8bZrgDU9plgJcL5w==
X-Received: by 10.223.177.194 with SMTP id r2mr3446399wra.89.1519947819999;
        Thu, 01 Mar 2018 15:43:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 69sm23645wmw.32.2018.03.01.15.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 15:43:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 03/35] pkt-line: add delim packet support
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-4-bmwill@google.com>
        <xmqqfu5jfrlb.fsf@gitster-ct.c.googlers.com>
        <xmqq7eqvfqx1.fsf@gitster-ct.c.googlers.com>
        <20180301224916.GB241240@google.com>
Date:   Thu, 01 Mar 2018 15:43:38 -0800
In-Reply-To: <20180301224916.GB241240@google.com> (Brandon Williams's message
        of "Thu, 1 Mar 2018 14:49:16 -0800")
Message-ID: <xmqqefl3e505.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 03/01, Junio C Hamano wrote:
> ...
>> Hmph, strictly speaking, the "delim" does not have to be a part of
>> how packetized stream is defined.  As long as we stop abusing flush
>> as "This is merely an end of one segment of what I say." and make it
>> always mean "I am done speaking, it is your turn.", the application
>> payload can define its own syntax to separate groups of packets.
>
> Thanks actually a good point.  We could just as easily have the delim
> packet to be an empty packet-line "0004" or something like that.

Yes.  As long as there is an easy and obvious "cannot be a value"
constant, you can use it as a delimiter defined at the application
level.  For example, your command-request uses delim, like so:

+    request = empty-request | command-request
+    empty-request = flush-pkt
+    command-request = command
+		      capability-list
+		      (command-args)
+		      flush-pkt
+    command = PKT-LINE("command=" key LF)
+    command-args = delim-pkt
+		   *PKT-Line(arg LF)

to mark the end of cap list, but if an empty packet does not make
sense as a member of a cap list and a commmand args list, then an
empty packet between cap list and command arg can be used instead.
A protocol-ignorant proxy can still work just fine.

Having a defined delim at the protocol level is often convenient, of
course, but once the application starts calling for multi-level
delimiters (i.e. maybe there are chapters and sections inside each
chapter in a single request message), it would not be sufficient to
define a single delim packet type.  The application layer needs to
define its own convention (e.g. if no "empty" section is allowed,
then "two consecutive delim is a chapter break; one delim is a
section break" can become a viable way to emulate multi-level
delimiters).
