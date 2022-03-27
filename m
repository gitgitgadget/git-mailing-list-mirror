Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DAFC433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 21:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiC0VMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 17:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC0VMk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 17:12:40 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A41CFD34
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 14:11:00 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C0E1432009E0;
        Sun, 27 Mar 2022 17:10:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 27 Mar 2022 17:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=xk4hGw15HL0PD6OQSXqGXGdP5B2KsnwjvqLe38
        sfhBc=; b=0BacHw+MlrVfT4UTnzUNq5wkJ/8EvdCpL+5BzW9BhqbFfLHeRUWIlu
        0TdrcMM7mKBwIy2qt118iDTUen2DgQ18j6Go1bxztT9x2Qjn1qwNejBrvH2ESFCY
        kwy0twth/C1jmFCA3ZMmuI/vnJL0yDMQUWfqHl1fH0MJru6K7/CsfxAl+YZPCwgE
        xA0nN4tMwOlu6jHAn3wAkcqPmnRH6nOLYTNzlkhgDV7w8Yf++2CggEMVrlUWYTiy
        B1BB49hZaf2uehBXiTwZTVqBn1rJhqAcithhB492btV+NEeaFTD4Qd4tV3YgV1Fy
        m5Gy4gg2cLEyLl8kPQ1mMrJOxrmrCpdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xk4hGw15HL0PD6OQS
        XqGXGdP5B2KsnwjvqLe38sfhBc=; b=LDAfMwrXKFsjGOop70FLHe+LAplg0qlYy
        i4RBiGtkS7lFuaHxID9Ofuy+7IU15QFRDkVX91j9630d6WGBWgfmMa8IyLvSgeIh
        Do1N1QbPpURBUaUaBcRoKW1x5ysZ8axppqfGnriMInPR7xf1vE9TqZHkukU8YsOJ
        amBCwRPxlNuMJj7d9aR0NOszkGFdCJ237N1FVDJufA/X1KxTPVzKuw4nOUf9z0jR
        GAn/MD+mcsinStRJcCJkbQeYeGDoyWXf4AAF24z2lihVaKQXpBdQJULXsY+YFz7U
        C5f1zx0kGixlR8CvD/CSCoSOc1sAJP80LGwbxpXtucWtcO+uwFtoQ==
X-ME-Sender: <xms:4NJAYnKNEtYLbp3Oo1NeItCwsYwLL3k1xJbM42EmtNJ-DGZz2-704Q>
    <xme:4NJAYrLBCFp-_4CgKFnruQ6T6BOR5Uy4Rk3hVRlyiwgdqtCbM5tlia9K9W3SWMnmk
    JzeEJZIudhR_TjptA>
X-ME-Received: <xmr:4NJAYvu8OBc7oxihCXTuuOxg4brM8-27tPse9latKnI38aXDC5lXvF3UFjCE9SkA_wGMQkn4dJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehhedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepvdejieeflefhteeihffhtdfhfeekhffhuedttedvgfevgfevfeehfffgkeej
    feehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:4NJAYgZlOQPm6YmY1nNunUPn_aCNJLmN3cwUz0iZdLYpeo4NKYoXSw>
    <xmx:4NJAYuYr_4Exzo6vy-mlbvn4phYoC7tK-zmMF0I53mEIDRIvuQIwJg>
    <xmx:4NJAYkDxBAiln25ELNeVLpa3qSVuolmxLczDEcmxad5C2jxMPLXnbQ>
    <xmx:4dJAYlyn-KLK9hMFv4x0luhR7aKwM2Vxx5QZwycBs8CMTx46Oy68jw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Mar 2022 17:10:55 -0400 (EDT)
Date:   Sun, 27 Mar 2022 23:10:52 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v6 3/3] vimdiff: add tool documentation
Message-ID: <YkDS3CJEPYpzRoVG@zacax395.localdomain>
References: <20220327112307.151044-1-greenfoo@u92.eu>
 <20220327112307.151044-4-greenfoo@u92.eu>
 <001d3ecd-e1bd-39f4-5123-4a8b1bd1b5a8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001d3ecd-e1bd-39f4-5123-4a8b1bd1b5a8@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +mergetool.{n,g,}vimdiff.layout::
> > +	The vimdiff backend uses this variable to control how its split
> > +	windows look like.  See BACKEND SPECIFIC HINTS section of
> > +	linkgit:git-mergetool[1] for details.
> > +
> 
> I generated the man page for 'git-mergetool' and this bit is included in the 
> Configuration section, that's great. However, it feels a little weird to read
> "see BACKEND SPECIFIC HINTS section of linkgit:git-mergetool[1]" there, since
> that's the help page I'm already reading. So maybe it would be nice to use an
> Asciidoc 'ifndef::git-mergetool[]' directive here to hide the "of linkgit:git-mergetool[1]"
> bit if the current page is git-mergetool[1] ?

Good call. I tried this:

    mergetool.{n,g,}vimdiff.layout::
    	The vimdiff backend uses this variable to control how its split
    	windows look like.  See BACKEND SPECIFIC HINTS section
    ifndef::git-mergetool[] 
    	(on linkgit:git-mergetool[1])
    endif::[]
    	for details.

...does it look good?

I'm asking because I ran "make doc" and the generated man page always contains
the extra piece. When are those asciidoc directives processed? Should two
versions of the same man page be generated?


> This whole section above needs some indentation work to format nicely in Asciidoc/
> Asciidoctor. I've fixed it and will send a 'fixup' patch as a reply.

Thanks! I will include your patch in v7


> This is OK, but adds a lot of lines to the output. Maybe we could display the help
> on the same line ? Something like:
> 
> $ ./bin-wrappers/git mergetool --tool-help
> 'git mergetool --tool=<tool>' may be set to one of the following:
> 		emerge
> 		opendiff
> 		vimdiff		Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section.
> 		vimdiff1	Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section.
> 		# etc.

Yes. It looks nicer in one line. In addition, right now it doesn't offer enough
information to figure out the difference among variants (vimdiff vs vimdiff1 vs
...) that's why I'm going to update v7 to print something like this following
your advice:

    $ ./bin-wrappers/git mergetool --tool-help
    'git mergetool --tool=<tool>' may be set to one of the following:
                    araxis
                    meld
                    vimdiff    Use Vim with a custom layout (see `git help mergetool`'s `BACKEND SPECIFIC HINTS` section).
                    vimdiff1   Use Vim with a 2 panes layout (LOCAL and REMOTE)
                    vimdiff2   Use Vim with a 3 panes layout (LOCAL, MERGED and REMOTE)
                    vimdiff3   Use Vim where only the MERGED file is shown
                    ...

