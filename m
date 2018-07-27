Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941E01F597
	for <e@80x24.org>; Fri, 27 Jul 2018 22:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbeG0X4O (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:56:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46874 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG0X4N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:56:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so6462621wrw.13
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZiNxdLq/LVBggnjrFnKHJggS5FEc013nC7f5jibxAEs=;
        b=iGNs9VxaY5SGLCDxGXpS59nEHuFDXMBFS8JIoL13gF/M9lal539agkTiI8+YGLTeJ6
         rRU6hVcmdUrpstpTrlzBEFCDuMI8QXU81wrVgLnVZUd8wG8ZRV3MLcQo3XE+toJAfoOv
         n/3dyjUSQPTFuoa7k2vxUc7CBfmAB3jUU2WOZyZCsfeJZGqW25+9cQgJ7MtrqVcaBb+A
         yfLlLFJ1TVcSubh78Z0wW7kIexFRHvvNCXa6+Nl0OA+CZDwM6o8XA02ZEoyQ+GHVQIQN
         BMaTFqW4VP4lxHjInFzMZaKcsuZ3PnLWqwg6sLsXtFuj59Gg+3ZMBTLvD0fcYS7n4lwr
         zwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZiNxdLq/LVBggnjrFnKHJggS5FEc013nC7f5jibxAEs=;
        b=RqLzjqmSfrHVxIXItn3g5uDdC1uzBqR+BGpoxucAHhCpV7HqLRUZIYDiH0HyUC3Pbv
         3vn4jIsEDNt8wVgbTPAiq4H+a7Z0Sm5YNWEsVhXQ9moVJBxqFWsZjjsOQ81RI10wt5V8
         DPjIu4mco0j0Arfs+nfcRyawol5DkSgNbh5NoEMJD0lNEn+14ezynPBEog4PrjsG3bmc
         HtNAynZ9fS4r1L8kD+cPwsEECJD8qH3NA980oWNjUCnMSeSfbAvwI8qqCnIu3QBVdoOe
         vbJ2folB7AOB8vjhwstARU7QoODHWJonqEGPiOWIx/jtkcbImsugJXlSGVNIjFKBihje
         b2TA==
X-Gm-Message-State: AOUpUlFtNlzr0NIiTFXsEMXrJXGod5qVsYJwPuxvKa9x2XY/5nh0OqQo
        ckqrHmX8ZVYaPlAnvAFAX0HDiWDh
X-Google-Smtp-Source: AAOMgpc4YqNB9v/1C7ylgZvYrhNYxppRFRV7b1auVLU0qNW113lMtSOQvNjCCNSneFR+ix0TUrTD3Q==
X-Received: by 2002:a5d:494c:: with SMTP id r12-v6mr6632288wrs.66.1532730735007;
        Fri, 27 Jul 2018 15:32:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x14-v6sm4755134wrv.21.2018.07.27.15.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:32:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Proposed approaches to supporting HTTP remotes in "git archive"
References: <CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com>
Date:   Fri, 27 Jul 2018 15:32:13 -0700
In-Reply-To: <CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com>
        (Josh Steadmon's message of "Fri, 27 Jul 2018 14:47:00 -0700")
Message-ID: <xmqqtvokjonm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> # Supporting HTTP remotes in "git archive"
>
> We would like to allow remote archiving from HTTP servers. There are a
> few possible implementations to be discussed:
>
> ## Shallow clone to temporary repo
>
> This approach builds on existing endpoints. Clients will connect to the
> remote server's git-upload-pack service and fetch a shallow clone of the
> requested commit into a temporary local repo. The write_archive()
> function is then called on the local clone to write out the requested
> archive.
>
> ...
>
> ## Summary
>
> Personally, I lean towards the first approach. It could give us an
> opportunity to remove server-side complexity; there is no reason that
> the shallow-clone approach must be restricted to the HTTP transport, and
> we could re-implement other transports using this method.  Additionally,
> it would allow clients to pull archives from remotes that would not
> otherwise support it.

I consider the first one (i.e. make a shallow clone and tar it up
locally) a hack that does *not* belong to "git archive --remote"
command, especially when it is only done to "http remotes".  The
only reason HTTP remotes are special is because there is no ready
"http-backend" equivalent that passes the "git archive" traffic over
smart-http transport, unlike the one that exists for "git
upload-pack".

It however still _is_ attractive to drive such a hack from "git
archive" at the UI level, as the end users do not care how ugly the
hack is ;-)  As you mentioned, the approach would work for any
transport that allows one-commit shallow clone, so it might become
more palatable if it is designed as a different _mode_ of operation
of "git archive" that is orthogonal to the underlying transport,
i.e.

  $ git archive --remote=<repo> --shallow-clone-then-local-archive-hack master

or

  $ git config archive.<repo>.useShallowCloneThenLocalArchiveHack true
  $ git archive --remote=<repo> master

It might turn out that it may work better than the native "git
archive" access against servers that offer both shallow clone
and native archive access.  I doubt a single-commit shallow clone
would benefit from reusing of premade deltas and compressed bases
streamed straight out of packfiles from the server side that much,
but you'd never know until you measure ;-)


