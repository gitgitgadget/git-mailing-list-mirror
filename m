Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBFE720135
	for <e@80x24.org>; Wed,  8 Mar 2017 23:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdCHXgd (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 18:36:33 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36235 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdCHXgc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 18:36:32 -0500
Received: by mail-pf0-f178.google.com with SMTP id o126so20805859pfb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 15:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FigIdr1MChHpngsXlnbeQOb4D8N0kgy7QJTTfFJaMbo=;
        b=OCunTVNRuCoc/YqwQkal9/GLr/pfxRyS6MnEIaPUqJFUIL0xvnMBY7qZcIcG43FeU8
         CS4FE++IK3WN2ZKGYlEKqYmf7pxv9jeTQTC5k/OGVB9RddN8i6REB7qT+w4oHfRG3jKB
         xR4WcMX0vA142ojSDndJKBOT4c0WAUjPj25WzhYzFogkWzPTAuUygzCWdZSKYH3waU+y
         QLLaudsvHonIUufiJmT24NUsQFwX3cmyjwt7BK1w+yK4lZ36RSxMjLHuhle6Q41PKGLy
         AJRkB1tL26jZBtJniw5tj2IjE3IwQKqcvgqLngAzut7YXnXYrEhEOBHG2JtZ0iwMJCaC
         vtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FigIdr1MChHpngsXlnbeQOb4D8N0kgy7QJTTfFJaMbo=;
        b=OXT5l/kzpmWvC62j+xrh+kDHp4sZ0A3EYZayXixwLHn3a4DAGhACHfwNlSY82VR/ki
         h6Sd/jM2tlK0I/yJ7p00ypJrVhtyN6DoYk2xPQePX88Koz6tSSFOH3DTRKuEZ24QS9M6
         sjnWnr2+bOFQFdrRApSs4HFunQMF+8ivlOLhq8DgfmKXFqJlm0NJxK2cuf6Yk6fpuZYG
         ZrwG+qRiCcrNKDMuqWYR8BM8Xq/P7dUMPfogxoypMUfIYWyqUZYoydYoFyBJ6fT+uQxZ
         mUinNgKWZQbJzvgUJ7g/TS2obK+wxQ1Jgd9ow363fKeb9pEI3k80JXZGrGD8bjY5LkUt
         3OIA==
X-Gm-Message-State: AMke39nynY1ym5nGGz74d7JV1+vdfkt77ldxZE/qtv38mjF3qlMvPxHup/JN2eHsdwcYf3+iP1ZmZBTAWENNiRsU
X-Received: by 10.99.247.83 with SMTP id f19mr9880356pgk.158.1489012762185;
 Wed, 08 Mar 2017 14:39:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 14:39:21 -0800 (PST)
In-Reply-To: <xmqqlgsg4lj4.fsf@gitster.mtv.corp.google.com>
References: <20170302004759.27852-1-sbeller@google.com> <20170306205919.9713-1-sbeller@google.com>
 <20170306205919.9713-16-sbeller@google.com> <xmqqfuio674n.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbdJa54YyKPHR9ycuJBVtyNY_2yaD7_5RPPu++Awiz5cA@mail.gmail.com> <xmqqlgsg4lj4.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 14:39:21 -0800
Message-ID: <CAGZ79kYF63E17SNa9wt3X_28kbvjNujUBPoMct=RvDcyOeJm-w@mail.gmail.com>
Subject: Re: [PATCH 15/18] read-cache, remove_marked_cache_entries: wipe
 selected submodules.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> submodule_from_ce returns always NULL, when such flag is not given.
>> From 10/18:
>>
>> +const struct submodule *submodule_from_ce(const struct cache_entry *ce)
>> +{
>> +       if (!S_ISGITLINK(ce->ce_mode))
>> +               return NULL;
>> +
>> +       if (!should_update_submodules())
>> +               return NULL;
>> +
>> +       return submodule_from_path(null_sha1, ce->name);
>> +}
>>
>> should_update_submodules is always false if such a flag is not set,
>> such that we end up in the else case which is literally the same as
>> the removed lines (they are just indented).
>
> I see.
>
> I didn't think a function this deep in the callchain that does not
> take any parameter could possibly change the behaviour based on the
> end-user input.  I was expecting that such a state (i.e. are we
> recursive?  are we allowed to forcibly update the working tree
> files?) would be kept part of something like "struct checkout" and
> passed around the callchain.
>
> That was why I didn't look at how that function answers "should
> update?" question, and got puzzled.  Because it would imply there is
> some hidden state that is accessible by everybody--a global variable
> or something--which would point at a deeper design issue.

Well it is just as deep as e.g. reacting on some bits of
struct unpack_trees_options in unpack-trees.c ?

But I can see how this is an issue with design.
I also think my previous answer was a straw man.

We only need to differentiate between 'ce' being a submodule
or not, because it should not be marked CE_REMOVE in
the non-recursive state.

Side-question:
Is there some doc (commit message), that explains the difference
between CE_REMOVE and CE_WT_REMOVE ?

Thanks,
Stefan
