Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A7BC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 15:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjDNP23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjDNP2N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 11:28:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4020B77F
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 08:27:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l21so676051pla.5
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681486047; x=1684078047;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ugyz4ej+oz1TXvYJXb0y+lc9RCJ4kr0hqqX5OyNebyU=;
        b=VfKnc1lK0qv2kD7WKZlzZk8UOOfiZrtUDHZLu4ccfwEQti3tKg7DLPKwVQFxPyQumK
         A/cjG08hX5MRbxtZklt7M++LvQ5eH+JavTcUC9bLsQmctwjYLuSDHVUPneD3t2QjtxfP
         lyRoAHj8Y8SHODCS29URe6P2mFE8VUNw5uWWH+JWSnSIZV92DyktznUVgWKO0DxxsWOe
         RZRKMzVR+LuZi5LZkpQt3g5U0LPIOcHxcL017/GU3YEzWHoXom2buJT95zxMrBxgTerg
         VarmaL7C97KsC9lX5GL11Jer2nfpk9WCfRckP5u3/CBKnuujKD/gQk+tFlkOhSoa0ng7
         kY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681486047; x=1684078047;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ugyz4ej+oz1TXvYJXb0y+lc9RCJ4kr0hqqX5OyNebyU=;
        b=OTbEkmBNphj35oaSocujkmMvvWocpy4qeoEHIQ9DZuALe9xRc/5gL0AIIXrXwRGK4j
         rOXg7w2S3u7pFDFRgLjtuNTcYaxzgz4ixy/uBaJwhcigJovZLCaBL+MSpC4VAri6GMmV
         EfkhK3EBVwk8YxSDGpYv3hTBdRDr1UxovdH5N3H/Nmyw+fvNQmoz+RqecjOvjunXp+OF
         WkmYAWdMEgQ4LVZGKBSxAwqskr7Is3UB6D7aNMdv2pVgBmq7C9jNsNWl/0hziQHO2bjR
         SlbRWCnr3TT7ahBdZsBRb19Jr5LRxdEbJKtCXr60OG7W3lB52yIJNKU9mcB2Jd2YkgPz
         a8ZA==
X-Gm-Message-State: AAQBX9fA1VEOpcmEIG1zaacuzpqF+He9CSVSClTySKViD54w/MWhDJfv
        S5rauxoRX/eoYujHcLA6Hfw=
X-Google-Smtp-Source: AKy350aEH5+606syGpiiTELg66jmmI4P3aeRJNQH3/sBJetJ5yZX3itzKTGGG94SiJhn41I8xi0fJA==
X-Received: by 2002:a05:6a20:4e22:b0:eb:f7d2:561 with SMTP id gk34-20020a056a204e2200b000ebf7d20561mr5679864pzb.61.1681486046718;
        Fri, 14 Apr 2023 08:27:26 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b0050f6530959bsm2834186pgv.64.2023.04.14.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:27:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: set actual revdate for manpages
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
        <20230414070449.GA540206@coredump.intra.peff.net>
Date:   Fri, 14 Apr 2023 08:27:26 -0700
In-Reply-To: <20230414070449.GA540206@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 14 Apr 2023 03:04:49 -0400")
Message-ID: <xmqq5y9yv601.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...  The reason is that asciidoc puts the <date> tags in the
> header, and the custom header removed by 8806120de6c suppresses
> asciidoc's default header entirely (so a workaround would be to include
> the <date> tags in our custom header, but I don't see any reason not to
> just build on top of 8806120de6c, as you did here).

I agree building on what is in-flight instead of making duplicate
effort makes sense.

>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 3133ea3182..b629176d7d 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -144,13 +144,16 @@ man5dir = $(mandir)/man5
>>  man7dir = $(mandir)/man7
>>  # DESTDIR =
>>  
>> +GIT_DATE := $(shell git show --quiet --pretty='%as')
>
> What will/should this do in a distribution tarball, where we won't have
> a Git repository at all? I think we'll just end up with a blank date in
> the xml file, though it looks like docbook turns that into today's date
> in the result.
>
> That's not _too_ bad, but feels a bit inconsistent (and it uses the
> format you're trying to get rid of!).
>
> It would be nicer to populate the date variable in that case, like we do
> for GIT_VERSION. I think that could look something like this:

I did wonder the same "what about tarball" thing while reading this
last night and then stopped, and it is good to see somebody else
brought it up ;-).  I like the "version" approach, as that is
already an established way to deal with the same "the builder
somehow wants to force the identifying string to a certain value in
the build product".


> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2ccc3a9bc9..307634a94f 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -144,8 +144,6 @@ man5dir = $(mandir)/man5
>  man7dir = $(mandir)/man7
>  # DESTDIR =
>  
> -GIT_DATE := $(shell git show --quiet --pretty='%as')
> -
>  ASCIIDOC = asciidoc
>  ASCIIDOC_EXTRA =
>  ASCIIDOC_HTML = xhtml11
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 9a1111af9b..14903bd261 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -10,7 +10,8 @@ LF='
>  # then try git-describe, then default.
>  if test -f version
>  then
> -	VN=$(cat version) || VN="$DEF_VER"
> +	VN=$(cut -d" " -f1 version) || VN="$DEF_VER"
> +	DN=$(cut -d" " -f2 version) || DN=""

Are we sure historical GIT_VERSION strings never had a SP in it?
I would be very surprised if we did, but the correctness of the
approach depends on that assumption.

Thanks.
