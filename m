Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F40C6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 20:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBXUbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 15:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 15:31:31 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C265063A36
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 12:31:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ec43so1992456edb.8
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtg0TmwhTKGejOGs2GzAY7EqhgPG+rvnZv3g75ZnOuA=;
        b=Cc0jYuJ86OFp/zdHghs/FYhsLDevzYVFj/r5+uJvkUaoVZkm5w9j4Boe18LV4rAyUY
         qSgIyHf4M14dPT1Zu/Xo+Y6pW948k9PF79nEh9fIW4jGzm4cEU69r9jBu7ysmqc+yoPK
         G9iwDzrJBfkaR/6RPCQLWMDmVH5EJYaGfajfiGvq3XHxXyXP5lyupZh1JdWMSS3DAc4d
         buUeOEmk26+vC0I5cuwUR6GAyFUS8+nCnFbOIGJIiCMtmzZqy7F/TXL7awOG7XwBRpku
         qn6u+m94BNuMwpiozdUCEbAWYgfdLjJes1OXb3wYk0Sk09zUAiBrDEvkPRvU8OuwzK1w
         2ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtg0TmwhTKGejOGs2GzAY7EqhgPG+rvnZv3g75ZnOuA=;
        b=ZiAtG61jQhd+v7yqdBl1KYSloHdW4xYWxDnO8l0lj0q1pe6Z000ccrwE12vEbZuqPo
         iD3Z5gN1XeHhuexBQcS7MAthkV7kzxl6d/2iZk9ErAPzxB97/Sabdi9ae9vVS0BG2xzb
         +enQbyA+kffFnFhOTdI+EKvKCaIjTRM2kjaI/rJ+gh7wQlRLgKI86bEMKIPYhm5/jYGy
         WT5BGD5D0PnSiNDlQaz0vVknFx4K743cczMp1BZM6r828c4hjsXTv2nwZI++xlbjEZhU
         zO/fKGfbBA4CuC2p3UUdTacxRhkxfLIbu9LB8aAH4M/0u1ZStRWX9+Vod+J629KtGv+N
         TcdQ==
X-Gm-Message-State: AO0yUKXP1SR7SzHvltVMYcpdcXxZsfUHtUPjBR3p3YLjwQLvWCLxRSXg
        hmMBXchhhdkfFx/MXP9Z7d/JlDyBrRFjegANmjXNFyhJeE+3Jiqu
X-Google-Smtp-Source: AK7set9E8cZGXF+mWCcjSyY7UXHmxzW3LkTEbrq23Ahy/Pk4MWLj5bwlni3lUZ5Rwnw8xYskM0VEo/wBD78J7f9FKq4=
X-Received: by 2002:a17:906:ce59:b0:8b1:7e1b:5ec1 with SMTP id
 se25-20020a170906ce5900b008b17e1b5ec1mr12434830ejb.6.1677270688056; Fri, 24
 Feb 2023 12:31:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net> <CAJoAoZmMQ-ROdCp0=4oaFa836-PqxwYntnRSBSzzJc5chp16eQ@mail.gmail.com>
 <Y/ACqlhtLMjfgJFQ@tapette.crustytoothpaste.net> <CAJoAoZkMR9Acy7thVs-_e=Fz8wwjoDGDKb46wmwn8yxk0ODGow@mail.gmail.com>
 <Y/ZuR9zs3peUfO0g@coredump.intra.peff.net>
In-Reply-To: <Y/ZuR9zs3peUfO0g@coredump.intra.peff.net>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Fri, 24 Feb 2023 12:31:16 -0800
Message-ID: <CAJoAoZknYizS4peYgR4Zy5KUMEpFUbj5eREZoC_K5vUDXnAhng@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2023 at 11:34 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 17, 2023 at 02:49:51PM -0800, Emily Shaffer wrote:
>
> > > Personally, I'd like to see some sort of standard error type (whether
> > > integral or not) that would let us do more bubbling up of errors and
> > > less die().  I don't know if that's in the cards, but I thought I'd
> > > suggest it in case other folks are interested.
> >
> > Yes!!! We have talked about this a lot internally - but this is one
> > thing that will be difficult to introduce into Git without making
> > parts of the codebase a little uglier. Since obviously C doesn't have
> > an intrinsic to do this, we'll have to roll our own, which means that
> > manipulating it consistently at function exits might end up pretty
> > ugly. So hearing that there's interest outside of my team to come up
> > with such a type makes me optimistic that we can figure out a
> > neat-enough solution.
>
> Here are some past discussions on what I thought would be a good
> approach to error handling. The basic idea is to replace the "pass a
> strbuf that people shove error messages into" approach with an error
> context struct that has a callback. And that callback can then stuff
> them into a strbuf, or report them directly, or even die.

Thanks! I'll give these a read in detail soon, I appreciate you digging them up.

>
> This thread sketches out the idea, though sadly I no longer have the
> more fleshed-out patches I mentioned there:
>
>   https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net/
>
> And then the sub-thread starting here discusses a similar approach:
>
>   https://lore.kernel.org/git/20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net/
>
> It does mean passing a "struct error_context" just about everywhere.
> Though since the context doesn't change very much and most calls are
> just forwarding it along, it would probably also be reasonable to have a
> thread-local global context, and push/pop from it (sort of a poor man's
> dynamic scoping).
>
> One thing that strategy doesn't help with, though, that your
> libification might want: it's not very machine-readable. The error
> reporters would still fundamentally be working with strings. So a
> libified process can know "OK, writing this ref failed, and I have some
> error messages in a buffer". But the calling code can't know specifics
> like "it failed because we tried to open file 'foo' and it got EPERM".
> We _could_ design an error context that stores individual errno values
> or codes in a list, but having each caller report those specific errors
> is a much bigger job (and ongoing maintenance burden as we catalogue and
> give an identifier to each error).

Is there a reason not to use this kind of struct and provide
library-specific error code enums, though, I wonder? You're right that
parsing the error string is really bad for the caller, for anything
besides just logging it. But it seems somewhat reasonable to expect
that any call from config library returning an integer error code is
referring to enum config_errors...

>
> -Peff
