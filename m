Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A68D20248
	for <e@80x24.org>; Thu, 14 Mar 2019 05:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCNFCD (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 01:02:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39887 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfCNFCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 01:02:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id p8so4349914wrq.6
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 22:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9DTWy9urW1FpsZcgph9vxyPiAlPqlMUD3YTvbP4iITY=;
        b=PyIhIMlTbv8fg3/3I6z/htKD+o5nO2hjlRjUwgpC8UxFndFfjpozbVP5HVkVBNmsFQ
         BMfQvRjdVgBpb4q9sE4JozbfpAmuqHNVlWi4JZrgEtI4TMe62iDXD20UXf1k1qoSpBak
         bggY3+rA5Jqd0qFKpWrzMSTcJw1aXpYVsOsj67QR2oh4gAfiuN1u4jbMwHSfjldA10sY
         pNjP5jZvYc8IE+mh+XB945wiyzMzjCSkwdzxigD/l0sPkXaDO3qqwpqK2fJtnQ32uHWX
         ABq/MrtuJZEFG1ee1vbb8GAHLqisnw4+axf/SAyfBbYENQs+8bJwQyESCej3OMQlGBIL
         swqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9DTWy9urW1FpsZcgph9vxyPiAlPqlMUD3YTvbP4iITY=;
        b=na4NgCnyyhfgrl/BSQS1EC41yhnO053kyEhP6f0z5rBBIsX9VsO0E6br/VJrTI0/+1
         4gKr7HjBh6bNY9Slw6n9jr5Gri4WLG4VH0qoFI3zxthwwRPViIb2RLpMD34xHaJ1yXrO
         HTjoEdTrdeUXl1asvrRzbMjIq5879SvvN3z06T7q7Kn0nMOT9NbLHxNyGJy5LS2aXQEY
         E8L+Oh6eM0Prw5qXBZxj7cm8kTrABEaqmEqgwyub++pvEtFCjFl2BjRrZu5w2XlkRlAe
         4TQ+F10nYUjS3tVbpsMI98Yj4Zm1NlVXBz2Mxnj4ewsBwmGz3tftoFrj+kXrEZCma76W
         xraw==
X-Gm-Message-State: APjAAAVSr5Qvtba6xU4KtnsatSKORDYCh9BEKf8qrw3kG9hSFO+v44GR
        P9xhFRfs45RewY65ZuATvmQ=
X-Google-Smtp-Source: APXvYqw7JZYaQOXiX3vjGzAj/5lPgw8GvfoJoFENjpF9bPnO7VlzeTv7I4tYCBID9nNgzJ+34CLcmA==
X-Received: by 2002:adf:9d89:: with SMTP id p9mr15220060wre.81.1552539720716;
        Wed, 13 Mar 2019 22:02:00 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id p17sm1028734wmi.35.2019.03.13.22.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 22:01:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] cherry-pick --continue: remember options
References: <20190313182615.7351-1-phillip.wood123@gmail.com>
        <20190313182615.7351-3-phillip.wood123@gmail.com>
        <nycvar.QRO.7.76.6.1903132344350.41@tvgsbejvaqbjf.bet>
Date:   Thu, 14 Mar 2019 14:01:58 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903132344350.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 13 Mar 2019 23:45:41 +0100 (STD)")
Message-ID: <xmqqimwm9hh5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Remember --allow-empty, --allow-empty-message and
>> --keep-redundant-commits when cherry-pick stops for a conflict
>> resolution.
>> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This whole patch series makes sense to me.

Yes, the changes look sensible (provided if it is the sensible goal
to make --continue use the same set of options, that is).

> And it is especially nice that you make it easy to verify that there is a
> bug in the first place, by separating the concern of demonstrating it from
> the concern to fix it.

For a multi-patch series, breaking out the verification test out of
the fixing patch is OK.  It is a different story for a simple change
that could be made in a single step to artificially separate the
test into a separate step.  An early "test_expect_failure" would not
stop the test when applied to a different codebase as a standalone
"does the breakage exist in this unrelated version?" even if the
"test only" patch might appear easier to apply (as opposed to
applying only the t/ part of the patch that expects success and
seeing it actually fail).

