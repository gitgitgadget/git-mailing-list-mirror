Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD0C2BA2B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F7320857
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qi7PCJxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389946AbgDODpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388437AbgDODpy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 23:45:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEE6C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:45:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g2so764509plo.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j+fKs9SpT1RBVFqFA8mXIEzdYzOZUCS2TEFDRp9nq1k=;
        b=qi7PCJxnscw7odGCyy2056CafV9r2RIzTMFtBBbRrz9Nyq0HqEFK8avw2dwnGsoLbQ
         F+wuIaF5t7iq/VJ9E7CKaCw7zn9FbqDt5SEQ4FwuV++GGIbwb+wIcwKsrkd1FAlzIGv/
         gTfq8z80ay6OdVKi/h/VPP0PDtQMj/+G1e7CgS6OKL3HdOoy0wEKCwD5TSI6iDlmhCI8
         hHZZSMY8Ix4/KECu0VfzDzPBLO+qVL0KmFbST+ZWPN9lTaJeU12yqTnb5N6i3eHqXw6u
         CY90Y+uqTHop1Qxi4WYII/Clr/4mIfGsN27YGZDT3KzbhmWm2F75I3IvbZ+bQebs03u7
         HPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j+fKs9SpT1RBVFqFA8mXIEzdYzOZUCS2TEFDRp9nq1k=;
        b=s/uJaP8ks+pCWSLVneSK22/Z+9tc54S0+cQtYfHpUdsK4YkIdUCwUtY2NCjszgO7aS
         cGUFBM76uaq/emBf0PrLMFW21bpYnewaFoUuzoYOo/kepSott9MDMaXf2XH/J6HTIa3n
         ATe7CSAKR3sJU+1wHKPEppYKneBVSI3II1EQmLSmuCiOcTxCgV1ukDbx2rGC2Bzc32KG
         Lq0dfjzy5pXkORal5K03Bsh/HPV8tE+0xXgKMBkiA4wjJgiq8TuSD2/KqlN2t7pRM3Va
         UHgziq9QJe64DmCxyjqHG2GftoEUzCqHU7GBr5hoeZS3odRQzVVKXQ1llnDbK+TYnxwE
         +zZA==
X-Gm-Message-State: AGi0PuZx7ow48jwOaTun8woQKk8kxDNXoNC8H1q9+BLjV30M1ft97VKR
        gkQSYMCdLaftMg9pi9vuB3X7vj4k
X-Google-Smtp-Source: APiQypK0ekZtUwZTUfTjysPYu678GMpxRPh5fX6DHJg0PYnkvpquWpq9Gys9GK6K9OBT5sVJUgPGOg==
X-Received: by 2002:a17:902:ec01:: with SMTP id l1mr3012983pld.151.1586922353332;
        Tue, 14 Apr 2020 20:45:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id x26sm4041543pfo.218.2020.04.14.20.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 20:45:52 -0700 (PDT)
Date:   Tue, 14 Apr 2020 20:45:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200415034550.GB36683@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
 <20200410213146.GA2075494@coredump.intra.peff.net>
 <20200413191515.GA5478@google.com>
 <20200413215256.GA18990@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413215256.GA18990@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Mon, Apr 13, 2020 at 12:15:15PM -0700, Emily Shaffer wrote:
>> Jeff King wrote:

>>> Yeah, giving each block a unique name lets you give them each an order.
>>> It seems kind of weird to me that you'd define multiple hook types for a
>>> given name.
>>
>> Not so odd - git-secrets configures itself for pre-commit,
>> prepare-commit-msg, and commit-msg-hook.
[...]
> Yeah, I do see how that use case makes sense. I wonder how common it is
> versus having separate one-off hooks.

I think separately from the frequency question, we should look at the
"what model do we want to present to the user" question.

It's not too unusual for a project with their source code in a Git
repository to have conventions they want to nudge users toward.  I'd
expect them to use a combination of hooks for this:

	prepare-commit-msg
	commit-msg
	pre-push

Git LFS installs multiple hooks:

	pre-push
	post-checkout
	post-commit
	post-merge

git-secrets installs multiple hooks, as already mentioned.

We've also had some instances over time of one hook replacing another,
to improve the interface.  A program wanting to install hooks would
then be likely to migrate from the older interface to the better one.

What I mean to get at is that I think thinking of them in terms of
individual hooks, the user model assumed by these programs is to think
of them as plugins hooking into Git.  The individual hooks are events
that the plugin listens on.  If I am trying to disable a plugin, I
don't want to have to learn which events it cared about.

>                                       And whether setting the order
> priority for all hooks at once is that useful (e.g., I can easily
> imagine a case where the pre-commit hook for program A must go before B,
> but it's the other way around for another hook).

This I agree about.  Actually I'm skeptical about ordering
dependencies being something that is meaningful for users to work with
in general, except in the case of closely cooperating hook authors.

That doesn't mean we shouldn't try to futureproof for that, but I
don't think we need to overfit on it.

[...]
>>> And it doesn't leave a lot of room for defining
>>> per-hook-type options; you have to make new keys like pre-push-order
>>> (though that does work because the hook names are a finite set that
>>> conforms to our config key names).

Exactly: field names like prePushOrder should work okay, even if
they're a bit noisy.

[...]
>>>   [hook "pre-receive"]
>>>   # put any pre-receive related options here; e.g., a rule for what to
>>>   # do with hook exit codes (e.g., stop running, run all but return exit
>>>   # code, ignore failures, etc)
>>>   fail = stop
>>
>> Interesting - so this is a default for all pre-receive hooks, that I can
>> set at whichever scope I wish.

If I have the mental model of "these are plugins, and particular hooks
are events they listen to", then it seems hard to make use of this
broader setting.

But scoped to a particular (plugin, event) pair it sounds very handy.

My two cents,
Jonathan
