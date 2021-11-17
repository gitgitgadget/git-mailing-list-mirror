Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A863C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 12:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2878760D42
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 12:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhKQMwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 07:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbhKQMw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 07:52:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07381C061766
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 04:49:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so10723356edv.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 04:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=My45tbno8ftUo2osqnhK0hlXHYLXDILsDhnL/no+JS4=;
        b=OTuejF0bOEe+QhQ5gbmkBd/3B2I5PdxpeRr5d/J+yBKDb3pgq4QQZoy/95ydYZk6pn
         Xdfh8JmITKlv/x+Y83rGctIaa+zVpJjFy7pyuaWGrEqMRqh3I0EsQOdqvD9Gbaf8YNDr
         DB1qSed/GZtKNBuWf0inptGerIDh51y4zqZSV7QRPmFK7umvzKUa1iDyw/vZqZR+Gnx2
         gMCP6ixW/vASLU5UchYFhZ58vEH5erU3JosgHzOsrdU/iNWfrIvJ+MQ713UvR5gmJTob
         vGHjUW6DfcYG4hJZS6uHFu5lVEdalPu34ttNofDCH3b2UFDdWEvV5/PY1rGDkilZQx7g
         N53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=My45tbno8ftUo2osqnhK0hlXHYLXDILsDhnL/no+JS4=;
        b=IH4kePNX4Jd8TlVQGzaYaGXwEG1Wcd6O2e7HrjSce+93vh02IvTtjUBI7Q0TBaQdv8
         9wSa16FFTDjiYDOB0dN1IU9ETmIzKbTzh2jHCuAm1LNs0caNaiHo3g+9Bpt3uhxksCA1
         0roTNDGJ8CVefIysVE8BD/2bYenSLVv3rDMdKUS3tW8+1xpJHiORBlhsxlSGYNhnhhD+
         DtF6gaA9r+3MAPQ90zWiwmmHopaAqeFg1ZJEI3LYaMyjnxwCtmMz/iQdLHgOhuZXNl0h
         1ubyPE1NEaQ6qnU+BgDREdJvy4fLGJClIxd7YVG4DYr4dsDlRn0sGmpc8Z3p/YbIAtqn
         Omnw==
X-Gm-Message-State: AOAM531kOR0ys52UC6vWHguwNMaB7KfP2eXIjZeoK9RFno3OOFrg1qkt
        O4m7/ImA/Es8IXCYQ/Y+cAglXFz4JwdkbA==
X-Google-Smtp-Source: ABdhPJxvypB4TFD9CpBJQo9yy0yfajgrlSB+H1YJKd3Vonqci0IJAYoPMEQGHCFxUdlqkOT3IF/HKw==
X-Received: by 2002:a17:906:8051:: with SMTP id x17mr21808266ejw.473.1637153367557;
        Wed, 17 Nov 2021 04:49:27 -0800 (PST)
Received: from gmgdl ([109.38.148.220])
        by smtp.gmail.com with ESMTPSA id ar4sm832350ejc.52.2021.11.17.04.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 04:49:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnKNQ-00090K-L5;
        Wed, 17 Nov 2021 13:49:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
Date:   Wed, 17 Nov 2021 13:39:33 +0100
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g> <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g> <xmqqpmr2j5lq.fsf_-_@gitster.g>
 <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
Message-ID: <211117.86bl2j6j6z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Phillip Wood wrote:

> Hi Junio
>
> On 15/11/2021 06:27, Junio C Hamano wrote:
>> There are certain C99 features that might be nice to use in our code
>> base, but we've hesitated to do so in order to avoid breaking
>> compatibility with older compilers. But we don't actually know if
>> people are even using pre-C99 compilers these days.
>> One way to figure that out is to introduce a very small use of a
>> feature, and see if anybody complains, and we've done so to probe
>> the portability for a few features like "trailing comma in enum
>> declaration", "designated initializer for struct", and "designated
>> initializer for array".  A few years ago, we tried to use a handy
>>      for (int i = 0; i < n; i++)
>> 	use(i);
>> to introduce a new variable valid only in the loop, but found that
>> some compilers we cared about didn't like it back then.  Two years
>> is a long-enough time, so let's try it agin.
>> If this patch can survive a few releases without complaint, then we
>> can feel more confident that variable declaration in for() loop is
>> supported by the compilers our user base use.  And if we do get
>> complaints, then we'll have gained some data and we can easily
>> revert this patch.
>
> I like the idea of using a specific test balloon for the features that
> we want to use but wont this one break the build for anyone doing
> 'make DEVELOPER=1' because -Wdeclaration-after-statement will error
> out. I think we could wrap the loop in gcc's warning pragmas to avoid
> that.

Good point.

Overall something that brings us to the end-state 765dc168882
(git-compat-util: always enable variadic macros, 2021-01-28) brought us
to is probably better, i.e. something you can work around by defining or
undefining a macro via a Makefile parameter, instead of needing to patch
git's sources.


