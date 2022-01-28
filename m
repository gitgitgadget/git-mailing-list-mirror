Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B7C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 19:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350966AbiA1Tcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbiA1Tce (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 14:32:34 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDCAC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:32:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e2so12833029wra.2
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=P5cFTnprNnOKzdrpwf0x9NSiEHs8zxS8bNMdxo3FxAA=;
        b=QsiqfdmYkwGrFk3SK22vnYfCU4BD/jBgTzwTJCIOGHdnPkG6VYH9Bu4n1ahWdIbW4Z
         P64KUuMLyefa1jH/cXD4egYhK0hbDfwir2JWKfmIITe4Q6ui545LpHJZAGkqbgvZEjqq
         Ff4OS03hm2+FrK6ss+/BUvjS4KOslj5w0ImZVkYWQlamFLhgfwihO6Xb2585bFB0FnhF
         mzyUpOhrHxV3D2OLjWEIbyw2gWyicLZ8C7sW0m8IPUrm9PhiqbpXxbUekbODXf5OgVt6
         OdvQxSexpHLqKqry8SxjjvbwOah9En0HrmdLr1k951JudSnarfw+DuAn3KD3loKNkatD
         KDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=P5cFTnprNnOKzdrpwf0x9NSiEHs8zxS8bNMdxo3FxAA=;
        b=FdX5lV1tQ4eQANh6T1oSNeJIHG9dRqB3KNQt7MMyfWIwfgH51s68QPbWvYMaQ2DJSJ
         Q7/hUUTn6YI5R+J8L4T2ozuuPQlfILQwTwuB7+ZezWTjNacZEypGgmc7BYEnmgBA3TrZ
         OTh/zjERbRT0aOmlC45rMYrMQZwC7/D8a6/qvFqRx3P3GD+5JctKHWUnQkJCAlseZKth
         FXcV4L1e7ZbJLU50E59WbY4YE81kl98Xih/HVatlVhfJwdJIDwv4auyyx2EdShFfL0SF
         I2BKA3ElyHQyFoOxTPNgjfYLGJev+yPuW4P9y88rnOPv3hszIXkZe4Fwxyl/oFSqsWLz
         At7w==
X-Gm-Message-State: AOAM5333lSmwwi8IA0W8XHXi8eAZJAvc8MfD2u167/iZryPLDmyVRLR3
        43NfOorXdB2xjyCeY6fmRgsm5K2oDin2xA==
X-Google-Smtp-Source: ABdhPJyK62kZzmDSbQzYPKE2u55Gvt1mX6NwInXEk3B/XbkoVDtpbbXXZ34fZ05Eho6slkGpqHj9oQ==
X-Received: by 2002:a05:6000:2a5:: with SMTP id l5mr2697528wry.394.1643398352904;
        Fri, 28 Jan 2022 11:32:32 -0800 (PST)
Received: from localhost (2a01cb000f483e004bf57bbe4fddc0d6.ipv6.abo.wanadoo.fr. [2a01:cb00:f48:3e00:4bf5:7bbe:4fdd:c0d6])
        by smtp.gmail.com with ESMTPSA id n10sm6975989wrf.96.2022.01.28.11.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 11:32:32 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jan 2022 20:32:31 +0100
Message-Id: <CHHK3G8H9D1X.23YTAHXI55311@diabtop>
From:   "Robin Jarry" <robin.jarry@6wind.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Patryk Obara" <patryk.obara@gmail.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3] receive-pack: check if client is alive before
 completing the push
X-Mailer: aerc/0.7.1-32-g429b2b168003
References: <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop>
 <20220127215553.1386024-1-robin.jarry@6wind.com>
 <xmqq4k5nychf.fsf@gitster.g>
In-Reply-To: <xmqq4k5nychf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Jan 28, 2022 at 18:52:
> If they have already exited but the fact hasn't reached us over the
> network, the write() will succeed to deposit the packet in the send
> buffer.  So I am not sure how much this would actually help, but it
> should be safe to send an unsolicited keepalive as long as the other
> side is expecting to hear from us.  When either report_status or
> report_status_v2 capabilities is in effect, we will make a report()
> or report_v2() call later, so we should be safe.

This is not perfect but I think this is the best we can do without
adding a new capability so that the client sends a reply to the
keepalive packet.

> I suspect that any keepalive, unless it expects an active "yes, I am
> still alive" response from the other side, is too weak to "ensure".
>
> I guess "to notice a client that has disconnected (e.g. killed with
> ^C)" is more appropriate.

OK, I will change that.

> > +	if (use_sideband) {
> > +		static const char buf[] =3D "0005\2";
> > +		write_or_die(1, buf, sizeof(buf) - 1);
> > +	}
>
> Observing how execute_commands() and helper functions report an
> error to the callers higher in the call chain, and ask them to abort
> the remainder of the operation, I am not sure if write_or_die() is
> appropriate.
>
>     Side note: inside copy_to_sideband(), which runs in async, it is
>     a different matter (i.e. the main process on our side is not
>     what gets killed by that _or_die() part of the call), but this
>     one kills the main process.
>
> The convention around this code path seems to be to fill explanation
> of error in cmd->error_string and return to the caller.  In this
> case, the error_strings may not reach the pusher via report() or
> report_v2() as they may have disconnected, but calling the report()
> functions is not the only thing the caller will want to do after
> calling us, so giving it a chance to clean up may be a better
> design, e.g.
>
> 	if (write_in_full(...) < 0) {
> 		for (cmd =3D commands; cmd; cmd =3D cmd->next)
> 	        	cmd->error_string =3D "pusher went away";
> 		return;
> 	}
>
> Yes, the current code will not actually use the error string in any
> useful way in this particular case, since report() or report_v2()
> will have nobody listening to them.  But being consistent will help
> maintaining the caller, as it can later be extended to use it
> locally (e.g. log the request and its outcome, check which cmd has
> succeeded and failed using the NULL-ness of cmd->error_string, etc.)

The main receive-pack process will be killed by SIGPIPE anyway but I can
fill the error_string fields and return for code consistency.

I'll send a v4, thanks for the review.
