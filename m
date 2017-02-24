Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A1B201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdBXUcm (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:32:42 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35606 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbdBXUcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:32:39 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so4261265pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AGFJVviqT0LZU4SnQFqZV4+ZtYlZHRFsRV65/Mhl0ek=;
        b=puQPJAYS/oSgoqeYP7dbCayuG1ktJGJCPGTmREEIOeq0eI9Zg0f2COX78g1UIGl2LG
         fXrxsIz2BxRSTds5EArhr/h2hwRxpiiCHjBnxxrJ2R1cWIoP6bKfWKD2IxYB7DiLo+tq
         D7V8R5RZL7TAsN+KDg6cMxjCe54o0tSODq3uOy91K9e9G5CME0Y4B8tUT96Na+ZrFmRa
         LsOeP+HuxQ9hKArAUbePnMdAprZxFkZspZUMcH4jypdxcRGPxUfqrgttY7cdBqiroc90
         Y5NaGJA2sXG8XJD/Z9jnYqLsf6AxgVDKzStHnIS0z8YvZgliWm9KWuvV++kxhW5KmdA8
         6RuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AGFJVviqT0LZU4SnQFqZV4+ZtYlZHRFsRV65/Mhl0ek=;
        b=KZIPrmzK4rz/6NsJdRZEqA4qgnVX6JZZU3Sx2W1XBQgCTNUPchBxge8+ll492YnTQP
         bgfVHhXqNdB3MNm+N5GhW2W5WaOtMtnfcYPdil7d+ubQkMSBUNBvLwxKbfs+DN1Tz22p
         H/spjZN1uUte4BmIfj/aqs16WMFxWidmmH7w+le3Wrlhd5+bdRNK4TEJ9ZSaw1W7hRAd
         MfShDvwReTAkRZZJaqbhVDBmoy8L7gZpbJ1MRq0i+cKm01osOvTL1hM9yVIocWFB+sRW
         9AFsi2KrnSv01u5c3hMYtJIWpP+1Ocum+FEifdnTRgnLZ3FsstMCqWwP2zxJURxOr2cj
         5n5Q==
X-Gm-Message-State: AMke39k+bIh4qrA9xFBI70VBCfLJvV5i2xEIqOVFhhzcAih+hMMEiDwhEMbOiK/8goxzZw==
X-Received: by 10.99.24.88 with SMTP id 24mr6024481pgy.54.1487968358204;
        Fri, 24 Feb 2017 12:32:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id l71sm16751995pga.32.2017.02.24.12.32.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:32:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     ankostis <ankostis@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
        <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
        <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
        <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
Date:   Fri, 24 Feb 2017 12:32:36 -0800
In-Reply-To: <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
        (ankostis@gmail.com's message of "Fri, 24 Feb 2017 21:05:40 +0100")
Message-ID: <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ankostis <ankostis@gmail.com> writes:

> Let's assume that git is retroffited to always support the "default"
> SHA-3, but support additionally more hash-funcs.
> If in the future SHA-3 also gets defeated, it would be highly unlikely
> that the same math would also break e.g. Blake.
> So certain high-profile repos might choose for extra security 2 or more hashes.

I think you are conflating two unrelated things.

 * How are these "2 or more hashes" actually used?  Are you going to
   add three "parent " line to a commit with just one parent, each
   line storing the different hashes?  How will such a commit object
   be named---does it have three names and do you plan to have three
   copies of .git/refs/heads/master somehow, each of which have
   SHA-1, SHA-3 and Blake, and let any one hash to identify the
   object?

   I suspect you are not going to do so; instead, you would use a
   very long string that is a concatenation of these three hashes as
   if it is an output from a single hash function that produces a
   long result.

   So I think the most natural way to do the "2 or more for extra
   security" is to allow us to use a very long hash.  It does not
   help to allow an object to be referred to with any of these 2 or
   more hashes at the same time.

 * If employing 2 or more hashes by combining into one may enhance
   the security, that is wonderful.  But we want to discourage
   people from inventing their own combinations left and right and
   end up fragmenting the world.  If a project that begins with
   SHA-1 only naming is forked to two (or more) and each fork uses
   different hashes, merging them back will become harder than
   necessary unless you support all these hashes forks used.

Having said all that, the way to figure out the hash used in the way
we spell the object name may not be the best place to discourage
people from using random hashes of their choice.  But I think we
want to avoid doing something that would actively encourage
fragmentation.

