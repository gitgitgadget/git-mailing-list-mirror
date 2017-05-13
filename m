Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F42E20188
	for <e@80x24.org>; Sat, 13 May 2017 14:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdEMOGh (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 10:06:37 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34792 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdEMOGh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 10:06:37 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so2705376pfj.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lZDN+YnFDEAUHxBiOChkfe0Bx7T+SztgtvrKZ1NNYcQ=;
        b=otUuEplthunlIdIbd3hIIVMwbTLhpyE2MWgVGjNtHyH1TCUnQJrdzPjn1KouC/BhHi
         5V2wTVfCGmWwGJgaha0w0msOO+LeBYEdLSi2DVk13qDo6iXPNrV71MkvvRhzyDSgtL7M
         SILa10ifMqU+XaIiv1FdFwFiilYybMFtk8UU+8Fp4kcoyTcXPLjXW6FBAjE9ZA9Mc8a3
         TMdaILoL+vz38FwdNFYMslTJ02/mx5kjMorY6kus7t4XFeh0L2rJ+O1Mx+0lgOf3X5nx
         TbTct/1OMB/7SQPrC35l8wUsJ2syGiwPs26cx5MTXjKUATxW5/cWi6pdblU0yyVIb97r
         z1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lZDN+YnFDEAUHxBiOChkfe0Bx7T+SztgtvrKZ1NNYcQ=;
        b=Mdo0LYkm0JH5U8JcfVWqhnbw4Zs2iJhTmCvCCvPxl6+6Em2GfjoNj8vyg9PowcL/5n
         5f6/SziHX+yPAQEzyvjk7HgR+5WisKTwIcFQzJ/lhphFjCxnH6DtpjnhyhjCX7S7swM3
         u4c4h0cdkB2XVZDqhnoawzSj1yGSPLnFA9JBLB2tb1GsdSjUPqbW356cKQLJJvrQBAF5
         sr9oPaXPgF4D8WS/3O00ItEW0V0DRFpgDGOdPc09PjQvIwL0ifwg2caphVSVWvyBHUhY
         KUCJgxEYmezyj978e6tUBQ/n+iVmU11qoESsddneBALNFwyh83fdoIGgPHnWWYUo3MEu
         6IrA==
X-Gm-Message-State: AODbwcAP/fMWGqVynkGeq1at5u8jqrAKwnnp9uOl0rucVgAh9NL2KmcZ
        BudDcloGVolXZ9Xe435ciYRM2Yen4XHT
X-Received: by 10.84.228.207 with SMTP id y15mr12758639pli.172.1494684396109;
 Sat, 13 May 2017 07:06:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Sat, 13 May 2017 07:06:35 -0700 (PDT)
In-Reply-To: <20170513085050.plmau5ffvzn6ibfp@sigill.intra.peff.net>
References: <20170512200244.25245-1-sbeller@google.com> <20170513085050.plmau5ffvzn6ibfp@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 13 May 2017 07:06:35 -0700
Message-ID: <CAGZ79kZxN5-K19R+gd-pZ1Uc30_JRKugjMTJZ4er2dF71pStPg@mail.gmail.com>
Subject: Re: [PATCH] hashmap: hashmap_get_next passes through keydata as well
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 1:50 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 12, 2017 at 01:02:44PM -0700, Stefan Beller wrote:
>
>> The 'keydata' may be of value in the underlying compare function to decide
>> if the given two entries are the same.
>
> I had to scratch my head over this for a minute, because there isn't
> really any motivating example of what you're trying to do.
>
> I think I figured it out, but I have a feeling it is violating the
> intent of the "keydata" parameter.  That parameter is typically used not
> as a pointer to arbitrary auxiliary data, but as a trick for finding a
> hash entry without having to allocate a struct for it.

Yes, I was violating the intent exactly as you describe. I'll adapt my patches
accordingly.

I do not really buy into the trick though, because when the overhead of
allocating a 'key' struct filling in the key parts only leaving out the value
is so much more expensive than giving the key via this keydata argument,
then there are serious issues with your data structure IMHO.
Example:

  struct {
    struct hashmap_entry ent;
    int actual key;
    char value[4096*1024]
  } key_plus_value;

Now when you want to look up a specific key, you don't want to allocate
such a struct on the stack, as we'd be wasting 4M memory of the stack
trashing the caches. However the neat part about this struct is that the
key part is (a) totally separate from the values, and (b) comes before
any value part, such that

  struct {
    struct hashmap_entry ent;
    int actual key;
  } key_only;

  struct key_only = {{NULL, 0}, 42};
  struct key_plus_value *match = hashmap_get(&map, &key, NULL);

works, I would think?

>
> So generally, I'd think two entries in the table should be able to be
> compared on their own merits, even if no keydata is available. Without
> that property, any internal operations in the hashmap can't actually do
> an entry comparison (e.g., a table resize that needs to rehash the
> entries).
>
> It works out in the current code because the chaining is purely linear,
> and doesn't care about order. So we can rehash and just stick the
> elements into a new list. But if it were switched out for a different
> data structure (e.g., a tree), then the hashmap code would need to be
> able to compare elements.

Note that most compare functions do not return an order, but only
a boolean [no]match, so putting it into an ordered tree could only
rely on the hash that we already know without aid from the compare function.
Of course we could fix our compare functions before doing such a
refactoring, but I want to point out how involved that would be.

>
> I don't think we have any particular plans for such a change, but I
> wonder if we should avoid encouraging callers to rely on the current
> implementation.

After a night of sleep it is easy to fix my code to behave as the API
intended. Yesterday I could not see how to fix it.

Thanks,
Stefan

>
> -Peff
