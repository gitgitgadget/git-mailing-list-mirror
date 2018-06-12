Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B019B1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 02:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935159AbeFLCnA (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 22:43:00 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34538 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935004AbeFLCm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 22:42:59 -0400
Received: by mail-pg0-f48.google.com with SMTP id q4-v6so9647724pgr.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tL+YYPM/bNclKafJxTJDHgCG/Tf7TThF10b3dNaHDns=;
        b=cYH9gL4t1Y+hG59OQR201ck9iLLh417bceZgbZki3K3dtTF7tkm7IEGNzT9kzEjaoP
         uay5n3TPp2j5+6l9UX6k/F8CCCBwRbDheBYNHULWwILnsg/gcRp4dFxc2TIBQ9vWLgLD
         U+WFi3dEj9OTTyBZzec1p2zWa4rkWibUPoB1YcPd7nkfwpPzIiq45nPb160AWgWVsvFL
         erQRZ1sGNsS6wKBQWR7VRqXGCtU1w+SVKCqt4G908092vjkQRbQNklDa+ixGt6sknB6i
         s89PJDbb87hNLTlDX/kLjn0/MSUXSqnpue0vrsA15wg52UUhIWJ4IPC+g0scypJL5hxP
         dc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tL+YYPM/bNclKafJxTJDHgCG/Tf7TThF10b3dNaHDns=;
        b=eddoiPJasphx8WurJ0pWTSg5oKKs+IgkkGq/asA+Z1JpFDKWmkUenMQMmHAfpypA8v
         B9sSVTTLWhN9HcMoyNM5Is5Gl8LnTCHKmkAxewJN7g/x1BkxJ2BUnq7D6eJZP8gE+Eba
         jaa0QNji6dKfTsem1g6ae5Tg50LN2qG/+x3d8J83Y7XII9bPXX7QrPWeV+hy02kd/0dK
         KCBQEumaVm/MEL4SNc8KE66YK0wEKeFB6j48kqtXRDRGOY5HmIcuY0SZ8ltiXai8+VQe
         /QpXHtw61dKnb/zo5pB+IJ+cIA+ZiWj7a0tLH8OjKe/HaDorVJUGq3N1KcUBOxM9G3Aq
         9t1Q==
X-Gm-Message-State: APt69E2KaIQokFvwn5Oflt5I1PCkjEuNQ34/2/Dhf12pgnW6+wzN8VzQ
        8TVhPetZRPIevxFgs1Bs1G0=
X-Google-Smtp-Source: ADUXVKI97Yiu3b9sR6WBCjq6UWtyDtMWsr+LLZ9ZW0yhjMlfoeWTGZM0edi7t+TbR2EZ3Qg4osZcug==
X-Received: by 2002:a62:dc98:: with SMTP id c24-v6mr1754578pfl.183.1528771378908;
        Mon, 11 Jun 2018 19:42:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d65-v6sm30587489pfj.20.2018.06.11.19.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 19:42:58 -0700 (PDT)
Date:   Mon, 11 Jun 2018 19:42:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: State of NewHash work, future directions, and discussion
Message-ID: <20180612024252.GA141166@aiede.svl.corp.google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180611190103.GB20665@aiede.svl.corp.google.com>
 <20180612022815.GL38834@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612022815.GL38834@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On Mon, Jun 11, 2018 at 12:01:03PM -0700, Jonathan Nieder wrote:

>>  1. Hash to be used for command output to the terminal
>>  2. Hash used in pack files
>>  3. Additional hashes (beyond (2)) that we can look up using the
>>     translation table
>>  4. Additional hashes (beyond (1)) accepted in input from the command
>>     line and stdin
>>
>> In principle, (1) and (4) would be globals, and (2) and (3) would be
>> tied to the repository.  I think this is always what Duy was hinting

Here, by 'always' I meant 'also'.  Sorry for the confusion.

>> at.
>>
>> All that said, as long as there is some notion of (1) and (4), I'm
>> excited. :)  Details of how they are laid out in memory are less
>> important.
>
> I'm happy to hear suggestions on how this should or shouldn't work.  I'm
> seeing these things in my head, but it can be helpful to have feedback
> about what people expect out of the code before I spend a bunch of time
> writing it.

So far you're doing pretty well. :)

I just noticed that I have some copy-edits for the
hash-function-transition doc from last year that I hadn't sent out yet
(oops).  I'll send them tonight or tomorrow morning.

[...]
>> brian m. carlson wrote:

>>> The transition plan anticipates a stage 1 where accept only SHA-1 on
>>> input and produce only SHA-1 on output, but store in NewHash.  As I've
>>> worked with our tests, I've realized such an implementation is not
>>> entirely possible.  We have various tools that expect to accept invalid
>>> object IDs, and obviously there's no way to have those continue to work.
>>
>> Can you give an example?  Do you mean commands like "git mktree"?
>
> I mean situations like git update-index.  We allow the user to insert
> any old invalid value (and in fact check that the user can do this).
> t0000 does this, for example.

I think we can forbid this in the new mode (using a test prereq to
ensure the relevant tests don't get run).  Likewise for the similar
functionality in "git mktree" and "git hash-object -w".

>> You can always use something like e.g. "doubled SHA-1" as a proof of
>> concept, but I agree that it's nice to be able to avoid some churn by
>> using an actual hash function that we're likely to switch to.
>
> I have a hash that I've been using, but redoing the work would be less
> enjoyable.  I'd rather write the tests only once if I can help it.

Thanks for the test fixes so far that make most of the test suite
hash-agnostic!

For t0000, yeah, there's no way around having to hard-code the new
hash there.

Thanks,
Jonathan
