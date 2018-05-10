Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D27D1F424
	for <e@80x24.org>; Thu, 10 May 2018 04:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753534AbeEJEVX (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 00:21:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33358 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbeEJEVV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 00:21:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id o4-v6so609546wrm.0
        for <git@vger.kernel.org>; Wed, 09 May 2018 21:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=yYyVtvWgU6kP5iMyqWy4Sop7ucE08X2sWxBddBHJqNc=;
        b=vd7RrzQw2WAny8tMEt+/OkBOKWXz0cTruqU3FIVrl97v/eGFo4Hiu/jNdnF6gJdRAk
         uN0vK6mHOGWJWYU/QW+lBfla6g46iN9W3Q/iYtQ+E05O6ztLyr/+y+kCt3F13DOPeZMi
         TMCy/Gl0M3E1f5kNHcT2QW/NGnOmcEM1QaefpNiUJ2T/42xav3TFohNAUHIQXSJpAJps
         fUSLOzgXs+0JaKoQFJ2tJRbOyIfK4zbIoftcqmUraYqHWYmlos+3abBkPoJjwVVgTaAB
         cwIi5WbM+lu7Y1iLD/KTGKDKE472T1sLhC4ZNWgowGML87+If1BZnFxszompd85XILM+
         M/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=yYyVtvWgU6kP5iMyqWy4Sop7ucE08X2sWxBddBHJqNc=;
        b=MciNKfvrhF6z19Rl4jouDrauIC3I5xfS+7qHMq0KA7U0Fi+hVH5TkLaGLjfp/PO1xq
         qiOEp4U0TaAEh2ZO22/eCE0M7YHW27vIzA938o52JOqGeW6L+ohjPYABirJZ8m+fMEZj
         WnivLToSeJnDZDfT3s6wcRVnw1grM3i/9USEuOWPvn1D0EtsfGqBqibTPh+vZ9hJgycY
         xbIlpXQBtKeFiAhrZQFEsDn0r/smsc51WzWhfH3ec5nvyVSHS/gURzlTiB0qTDfhLr3b
         zPm64lnLh2VhjvklOsEooIP2g2s7vz6Yilp2FkHSfwFOeEPQcH7/Mf8CMdn9IEWFb3eb
         xyuA==
X-Gm-Message-State: ALQs6tD9wVZJVgaHUlEhWnG5qz+LoihS3HKQq9qNO0rsrw4OdpDMo1v9
        GgAXHCJKujXIEWiVJGNiPk0=
X-Google-Smtp-Source: AB8JxZrbqXWs6bh6g1IppiadFIlbXx5DRGM48IfTUMptS5e2ZtKWfD3xRaktZRCZW+kTmOYAzpAG9w==
X-Received: by 2002:adf:8827:: with SMTP id d36-v6mr36927212wrd.41.1525926080347;
        Wed, 09 May 2018 21:21:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 123-v6sm132071wmt.19.2018.05.09.21.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 21:21:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be tree, not treeish
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-10-avarab@gmail.com>
        <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
        <87wowlxko8.fsf@evledraar.gmail.com>
        <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
        <87lgczyfq6.fsf@evledraar.gmail.com>
        <xmqq6040qf8x.fsf@gitster-ct.c.googlers.com>
        <20180508143408.GA30183@sigill.intra.peff.net>
        <87a7tax9m1.fsf@evledraar.gmail.com>
        <20180509075632.GA3327@sigill.intra.peff.net>
        <878t8txfyf.fsf@evledraar.gmail.com>
Date:   Thu, 10 May 2018 13:21:19 +0900
In-Reply-To: <878t8txfyf.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 09 May 2018 12:48:24 +0200")
Message-ID: <xmqqa7t8kuo0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Before we had any disambiguation code, resolving X^{tree} really was two
>> independent steps: resolve X, and then peel it to a tree. When we added
>> the disambiguation code, the goal was to provide a hint to the first
>> step in such a way that we could never eliminate any resolutions that
>> the user _might_ have meant. But it's OK to take a situation where every
>> case but one would result in an error, and assume the user meant that
>> case. Sort of a "do no harm" rule.
>>
>> By disambiguating with just a tree and not a tree-ish, that hint is now
>> eliminating possibilities that would have worked in the second step,
>> which violates the rule.
>>
>> Does thinking about it that way make more sense?
>
> Okey, so to rephrase that to make sure I understand it. It would be
> documented as something like this:
>
>     When the short SHA-1 X is ambiguous X^{<type>} doesn't mean do the
>     peel itself in X any way, rather it means list all those objects
>     matching X where a subsequent X^{<type>} wouldn't be an error.

With the understanding that this paragraph is written primarily for
your own enlightenment, I wouldn't complain too much, but if you
meant this to become part of end-user documentation, I have a strong
issue with the verb "list" used here.

X^{<type>} never means to "list" anything (FWIW just X does not mean
to "list" anything, either).  It just means that the user wants to
specify a single object whose object name is X^{<type>}, i.e. the
user expects that X names a single object, that can be peeled to
<type>.

Now, it is an error when (1) X does not specify a single object in
the first place, or (2) the single object cannot be peeled to <type>.

When diagnosing such an error, we would give hints.  The hint would
show possible objects that the user could have meant with X.  The
^{<type>} suffix given to it may be used to limit the hints to
subset of the objects that the user could have meant with X;
e.g. when there is an object of each of type blob, tree, commit, and
tag, whose name begins with 7777, the short and ambiguous prefix
7777 could mean any of these four objects, but when given with
suffix, e.g. 7777^{tree}, it makes useless for the hint to include
the blob object, as it can never peel down to a tree object.

If the tag whose name begins with 7777 in this example points
directly to a blob, excluding that tag from the hint would make the
hint more useful.  I do not offhand know what the code does right
now.  I wouldn't call it a bug if such a tag is included in the
hint, but if a change stops such a tag from getting included, I
would call such a change an improvement.

>     I.e. X^{commit} will list tags and commits, since both can be peeled
>     to reveal a commit, X^{tree} will similarly list tags, commits and
>     trees, and X^{blob} will list tags and blobs[1], and X^{tag} will
>     only list tags.

Modulo the use of "list", which I have trouble is as it makes it
sound as if listing something is the purpose of the notation, I
think we are on the same page up to this point

I think the best way to explain core.disambiguate to readers is to
make them rethink what I meant with "the user expects that X names a
single object" in the early part of the above response.

Without constraint, Git understood that the user used 7777 to name
any one of the objects of all four types.  With core.disambiguate,
the user can tell Git "when I give potentially ambiguous object name
with a short prefix, assume that only a commit or a tag whose name
begins with the prefix is what I expected the short prefix to name
uniquely", so Git understood that the user wanted to name either a
commit or a tag.  It would still trigger an error as it does not
uniquely name an object (for which an attempt to apply the ^{tree}
peeling would further be made).

