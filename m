Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A8AC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B961E20578
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHb41IRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgJEIiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgJEIiR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:38:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F6EC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:38:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so6375545pfd.5
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hWJ5cgBYmJf7czsRLY/UMHstDMDOWfuyaX5hUVwsZ1o=;
        b=AHb41IRrqmU+22ubR5gmIV6fzM9Q8ALX3Q6xpwGOeTNQ4QyIdis4gfinWHGEDvUZyO
         zdmj5arhbDWL13wPBxsfTypv+ZTihI0cLW0uSI3iOfDu6YjO1Tp2SCQNV63UVQSeYs3w
         C3BZ1dLrtnt14rSbnH/pa9bYxPxiTlISUXGkVNDwv0gV1qTaPUnjYiHwqNQ3qgQ5c8lt
         FcEyPmTHM3mIukDHwcImGaS8kZPVMpRQrlyjdvBNsgTvma8mYiTX0PyaN624Qe91t2SU
         j/kxXXQaqHEk/V78L+Xf882tvnxMJIlkSQRSptfk49vkvZj97OLRk/XAV9SY0d7wKj9/
         X9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWJ5cgBYmJf7czsRLY/UMHstDMDOWfuyaX5hUVwsZ1o=;
        b=C1dFaKJboM2GRKtT2h8oCknlEQDAbDaDSZC183NOiNkSII1wdLid+A5XTRI0DrL3L5
         5Srvcr7HQIeGLSOr2wUx4Tuj1EYJJ++5pqX3hyEos1JLq8bFcBSItPDIPznPpZV41oln
         83G075yXwv3HqbfZ6JigJtG6q6v8kTcl8L+gztpwTawZ2Vhia7H7XiF3jXnAJGx58NPs
         QGfT56t+ImRkC+IyQQ7ES13vuqQvqfP96IPlyFByPMBRQyMVIBs07D8bEcjV/68dT2uV
         WBWpiNvhR5DTiGJeeT/GxX+qH8lgMpXqpopXU4iHyOgh6QKW2pZ8Ei+W+QwwyBMzygWu
         2leQ==
X-Gm-Message-State: AOAM531oa//N6DVKfMpDE2WS4Y1L9EWHXEFplZDysMicNdrvB4X75lEW
        wZiShA+LAYFwU078tZ58WYEIreyQEA0=
X-Google-Smtp-Source: ABdhPJxD3iVGb3YBZiJo4KEf7m1n7PsOdCnhwlGPjrVjFzSW9Tk0uM7CQVBssidZKDdIq01/sBcbZQ==
X-Received: by 2002:a62:1844:0:b029:152:80d3:8647 with SMTP id 65-20020a6218440000b029015280d38647mr4408375pfy.18.1601887096549;
        Mon, 05 Oct 2020 01:38:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 138sm12012785pfu.180.2020.10.05.01.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:38:16 -0700 (PDT)
Date:   Mon, 5 Oct 2020 01:38:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/7] t7450: test verify_path() handling of gitmodules
Message-ID: <20201005083814.GM1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072015.GD2291074@coredump.intra.peff.net>
 <20201005075311.GG1166820@google.com>
 <20201005083004.GC2862927@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005083004.GC2862927@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Oct 05, 2020 at 12:53:11AM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> @@ -155,8 +155,14 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
>>>  		{
>>>  			printf "100644 blob $content\t$tricky\n" &&
>>>  			printf "120000 blob $target\t.gitmodules\n"
>>> -		} >bad-tree &&
>>> -		tree=$(git mktree <bad-tree) &&
>>> +		} >bad-tree
>>> +	) &&
>>> +	tree=$(git -C symlink mktree <symlink/bad-tree)
>>> +'
>>
>> This is super nitpicky, but: test scripts can be hard to maintain when
>> there's this kind of state carried from assertion to assertion without
>> it being made obvious.
>>
>> Can this include "setup" or "set up" in the name to do that?  E.g.
>>
>> 	test_expect_success 'set up repo with symlinked .gitmodules file' '
>> 		...
>> 	'
>
> Hmph. I specifically _tried_ to do that by breaking it into a separate
> test with the name "create" in it, which I thought was one of the
> code-words for "I'm doing stuff that will be used in another test". But
> I guess there's no official rule on that. I dug up:
>
>   https://lore.kernel.org/git/20130826173501.GS4110@google.com/
>
> but I guess I mis-remembered "create" being present there.

I can try to find some time today to introduce a test_setup helper.
Having to figure out and rely on this kind of ad hoc convention is not
something I really want to ask of patch authors and reviewers.

The reason I find "set up" clearer than "create" is that the latter is
something I can easily imagine myself genuinely wanting to test.  "Set
up for a later test" is more explicit about what the commands are
being run for.

Jonathan
