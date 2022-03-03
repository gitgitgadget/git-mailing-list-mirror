Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D142DC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiCCQ7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiCCQ7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:59:09 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C5CE02FC
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:58:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id dr20so11981031ejc.6
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z9L6NUQa1Y1rPhCYq2koDlRP+2jRh9zcikIFpgHyLh8=;
        b=SPyYS6z+q+hTde4WySUPCngnc+aaDTy8hQcd9CO8C5KfWe7CJ+CTrcUFecUKV/V0g1
         QWC5Z9bqa0avMQE2oqN36TpqiI5Nk43ffDuvVgE/YYi77zz591BnoO1ENjO+nUHWIrRP
         9jlSYs3/X/XJsMcLsQL/d6bNMawk9aRhwMohuvCPugLYU5Ff+jDvfprrDUyU106iXt1I
         w86uYUEuUoudHIffEyzaQ5r0YbExi6LYBCq43sltMAscfVdFHYxpkvharCwXbnsR2afi
         TAZ0tBdzydmxJua76tY+X7n+n2/RdEBgY0ystGjfRthaKLwVGDONP51/0PQ0FBQhQAtg
         SjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z9L6NUQa1Y1rPhCYq2koDlRP+2jRh9zcikIFpgHyLh8=;
        b=mCMwagNUjRY+uagCYnYUUqG2tnPcYUGuOqzUnXX9pYAfvugpmHV3xUfLHRVWQvjj3y
         PKNNDEQz4VoHw8hpN7hJd0r2FnCP9VySoVzu9t9sD4WwcDAnbq2VbX/MI7RZQW+uV2D5
         Fpl9tHstmFS61Yc8uX4DDQ8tYvf2K0vTwdevQwsp2LNQsh6Ye+Bgr0mDKyyTLDusfhNR
         fQuPlnEm7aRrgUczrcekAsI5hC/wrRbqi69hgQqd5GKN1Dd9VMRoB0jgDJucDdpOnDhz
         ifESqpA4NMfP7Y6dl9W9n58JKkS+aQaaHatcWsp0oNGCiGKvYdG2p7kBD7NSPkBH+gdE
         vWbQ==
X-Gm-Message-State: AOAM5325UNWmPtqOLah20BLy3tr9sgWttHGsC9pbw71xtqwrhZ5uHe4D
        Qjz07CKWtxLZkf9Hm/PeVipEaoOMuwIkDg==
X-Google-Smtp-Source: ABdhPJzM/c8uRHLhDOiiUXjMKkvGDwE0H7rwbL0OD+pncYa7MsZvj4NIooFLNfixbia+HMW1KDSEkA==
X-Received: by 2002:a17:907:3da4:b0:6da:9ec2:c3ff with SMTP id he36-20020a1709073da400b006da9ec2c3ffmr1710634ejc.90.1646326701855;
        Thu, 03 Mar 2022 08:58:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm1052537edw.72.2022.03.03.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:58:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPomS-000exz-T0;
        Thu, 03 Mar 2022 17:58:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
Date:   Thu, 03 Mar 2022 17:54:26 +0100
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
 <fe93dfb2-7c0d-11cb-09a0-9ccc7fcc2507@kdbg.org>
 <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com>
Message-ID: <220303.865yov2csz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Jaydeep Das wrote:

> How about modifying the number match regex to:
>
> `[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]` ?
>
> The `[^a-zA-Z]` in the end would make sure to not match
> the `.F` in `X.Find`.
>
> Additionally, we can add another regex for matching just
> the method calls:
>
> `[.][a-zA-Z()0-9]+`
>
> Both of these changes would make word_regex match 2 tokens in
> X.Find() : X and .Find() (Here X can be any valid identifier name)
>
>
>> How many tokens will the word-regex find in the expression X.e+200UL?
>> .e+200UL is a single token. > It's most easily fixed by requiring a digit before the fullstop. But if
>> floatingpoint numbers can begin with a fullstop, then we need a second
>> expression that requires a digit after a leading fullstop.
>
> But that syntax would be wrong. I tried making a condition like you said,
> but it always ended up breaking something else(like breaking 2.e+200UL into 2, .e, + and 200UL)
>
> Also, I realized I did a bit of mistake in the identifier regex.
> Both _abc and __abc are valid identifiers. _3432, __3232 are valid identifiers too.(not numbers)
>
> The previous regex matched only one `_`, so in the next patch,
> I plan to implement the following regex:
>
> Identifier: `([_]*[a-zA-Z]|[_]+[0-9]+)[a-zA-Z0-9_]*`
>
> Numbers: `[0-9_.]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]`
> (It makes sure that in X.Find, .F is not matched )
>
> Additionally, An extra regex for method calls:
>
> `[.][a-zA-Z()0-9]+`
>
> What do you think?

Just a small note on rx syntax> [.] can be handy to escape "." (but you
can also use "\\.", but that's arguably not as easy to read.

But there's no reason to use [_]* over just _*..

(Also, I have an in-flight change to userdiff.c that would conflict, but
I wonder if it wouldn't be handy to make the word_regex a "struct
userdiff_funcname". Then we could specify icase flags, which in this
case would make it a lot easier to read).

