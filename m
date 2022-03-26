Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D94C433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiCZW5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 18:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiCZW47 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 18:56:59 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59882F3B6
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 15:55:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 153F1320070D;
        Sat, 26 Mar 2022 18:55:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 26 Mar 2022 18:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=8MUWqQcZj6v+7PMSLq1UBB6ZnkR4ubW4mPhwD6
        f9N0I=; b=XCVi2hoOIc/gG0vOeVu1VKj29a3U7BYFTFIjON9AjmRS1kQhPnlhAL
        HY18kvo3Tp4XSxA9gwkTg/H5R7YWuV3Bgu2+moD3qXXJ5UIzOzGpDbIa6+HxbWY3
        YQjwXuQ1sLjVAvbD/z6xrFJ9z7Apxv4YpE5AUNh3pKtZSBjdW8uIPGdjwLbsqNa0
        MU3mRzAEKUXOAAPtL3wL6dRn41Yod1v61PGHFUebwyme3QMKeXLnkPaIixBXZEsh
        dd9McXb4FcrWBOh+9sYrFGJ/fihm1AaT0/LS5Bv9u2C7hPlHVng7FdzXIEsC8qiv
        8WmHGL7XaVsaexv4W1uRAYP4vecOaGFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8MUWqQcZj6v+7PMSL
        q1UBB6ZnkR4ubW4mPhwD6f9N0I=; b=jXPJNUxq5Per5//bBfK89aHc4h2M/LxB/
        Un47CBMhsXtg3DCQg4nIURYQNle21m/R8qW196BCfq2gsNU1qoO/9NSK027sVUO6
        v53SroT+OKiljN91rhCtD51cvpDs9RLmWB3ziDGZI6iZlIMFZNZSwjlYYwJQbu/b
        t5HqmPiE9JpZfInzOecdUUIuvCrkiMGvkC/yk7i3V1OqlH6wMTnUZ8823siV8Ynz
        Jd2XRO3y9hjBKBbU8/5jk8TH7CuIfhi9HbVvOb4n19MvlcDCZlZRgf0y/UJyc+Fy
        yj+8AQNdJnzoucUglE/ZB05c0bUjwz+f0RiFAvvoNddyO/dA9lWKg==
X-ME-Sender: <xms:1Zk_Ytwqnp5sZbz6IeylOv8ue1FFo3-2u_PyHAo6I85ryY0CKo_oCw>
    <xme:1Zk_YtQDoDYa-6UUZGjJDksidcunF1T4VX1zNN9J0P9ylvdtCBT2HEB8gLtGngdjq
    KQlgzQGa3v-pXwyTA>
X-ME-Received: <xmr:1Zk_YnVxYly0qxFgnwW7fWQDjLHQrN1K2DL_9f2G9CYH1mBm7UjzDq7M2-BlQftAf37d1EzAMfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehfedgudeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttdejnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhho
    ohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpedvjeeifeelhfetiefhhfdthfefke
    fhhfeutdetvdfgvefgveefheffgfekjeefheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:1Zk_YvjYmBq4eoKJFSfQG74NpTFP3KgrdNpSK0MSZDvwo5PHhxlEPQ>
    <xmx:1Zk_YvD15vagk4EDqoW7drffdXlnNURIVLpjZcrH-FKo1HzCTqvAmQ>
    <xmx:1Zk_YoLzcvtZiHMCgLsWWV7at_hoMM4roskK5Avj16ZNoYdBARs8nA>
    <xmx:1Zk_Yk4LpdvilTliHglKdq2wBECP9HYF0X1Y5-Z3OkD0EFlP7rsScQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Mar 2022 18:55:16 -0400 (EDT)
Date:   Sat, 26 Mar 2022 23:55:13 +0100
From:   Fernando Ramos <greenfoo@u92.eu>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: fr/vimdiff-layout (was: What's cooking in git.git (Mar 2022,
 #05; Wed, 23))
Message-ID: <Yj+Z0T2TShqH99a/@zacax395.localdomain>
References: <xmqqwngkm4am.fsf@gitster.g>
 <220326.86k0cgk83t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <220326.86k0cgk83t.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It looks like it's emitting a new warning from the "Makefile" in
> check-docs:
> 	
> 	$ (make clean && make check-docs) >/dev/null 2>&1; make check-docs
> 	make -C Documentation lint-docs
> 	make[1]: Entering directory '/home/avar/g/git/Documentation'
> 	make[1]: Nothing to be done for 'lint-docs'.
> 	make[1]: Leaving directory '/home/avar/g/git/Documentation'
> 	removed but documented: git-difftool--vimdiff
> 	removed but documented: git-mergetool--vimdiff
> 	removed but documented: git-version

Looking at how the Makefile works it looks like this error is triggered
because...

  1. I have created these two new files:
     - Documentation/git-difftool--vimdiff.txt
     - Documentation/git-mergetool--vimdiff.txt

  2. None of them are real programs (such as "git-clone") or scripts (such as
     "git-mergetool--lib.sh")

All the other "Documentation/*.txt" files are associated to "something" that
can be executed, but not these two (they are only meant to be accessed from "git
help" / "man").

Options I can think of:

  A) Ignore the warning message

  B) Remove these two files and add all this documentation to an already
     existing one (maybe "Documentation/git-mergetool--lib.txt")

  C) Create a new variable in the Makefile to contain a list of "documentation
     aliases" that do not correspond to a "real" command, so that they can be
     filtered out when testing for documentation problems.

In other to implement (C) we could do something like this:

> diff --git a/Makefile b/Makefile
> index 70f0a004e7..db8a1c8025 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -597,6 +597,7 @@ TEST_BUILTINS_OBJS =
>  TEST_OBJS =
>  TEST_PROGRAMS_NEED_X =
>  THIRD_PARTY_SOURCES =
> +DOC_ALIASES =
> 
>  # Having this variable in your environment would break pipelines because
>  # you cause "cd" to echo its destination to stdout.  It can also take
> @@ -1228,6 +1229,11 @@ THIRD_PARTY_SOURCES += compat/regex/%
>  THIRD_PARTY_SOURCES += sha1collisiondetection/%
>  THIRD_PARTY_SOURCES += sha1dc/%
> 
> +# DOC ALIASES is a list of topics you can call "git help" on but they are no
> +# real commands or scripts you can execute
> +DOC_ALIASES += git-difftool--vimdiff
> +DOC_ALIASES += git-mergetool--vimdiff
> +
>  # xdiff and reftable libs may in turn depend on what is in libgit.a
>  GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
>  EXTLIBS =
> @@ -3355,7 +3361,7 @@ check-docs::
>                     -e 's/\.txt//'; \
>         ) | while read how cmd; \
>         do \
> -               case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS)) " in \
> +               case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS) $(DOC_ALIASES)) " in \
>                 *" $$cmd "*)    ;; \
>                 *) echo "removed but $$how: $$cmd" ;; \
>                 esac; \

Let me know what you think. Thanks!


