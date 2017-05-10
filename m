Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81EF2018D
	for <e@80x24.org>; Wed, 10 May 2017 06:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdEJGEE (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 02:04:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33393 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdEJGED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 02:04:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id a23so2629278pfe.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rwgB0WHzOCy9uryMDbud/rHzxH/NASiRBzTZ/NI3tSA=;
        b=Po92uklF0dlnkXnt3qm9n/ZeyWCl+5LVJwVhlFlv9NQ+uDWudFMkvWxtmihwrkQhqd
         dCBJruj6yLt3uRxLz+NFxmU3QAMqfaCMyS0UccZF3WAer5l1QowCMGp9R4mggNVEb6W2
         24rc1uUvDdaHDi1Xk18VfG+LBdHJ2lwhkkaen7K/lBpKHUQY9iBXymj1uK6fQsd3cPWH
         IAyi2j/DtXnHj3XqnpNdX1QLCm5gEJ2Y1YTuVojX/W0txeebcFntqCnTeMUgB5Tg/Upd
         +KMHfLVP3UK07Fl1ltnb3jJPlSZU17ucN51fX5FLc7gt43y3WaLEEWEtjAyGhrEpLqA8
         bWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rwgB0WHzOCy9uryMDbud/rHzxH/NASiRBzTZ/NI3tSA=;
        b=EXxujZyLpZu0YsatHUDbN83OJieKOSokjI8HijN7i7mQYyhWytHir+Bc5Q/FaysChM
         RfWD3CJ8JwvKUFgBhYL1AX+7h7uUpCxNSi7sJWF2OSJFS0xKMbWmxwcv28siDn89kIB5
         +9GMBiSpVytXPGzzFaJL9kh9CwSIrg+iAuG0EVDJb1YLYPneEma9QBYpgZFWvA0oxtu0
         QMb14GZYcUQZ/VBdk3BAmGF32hRIT5vVpguct6vlh8DYSqDM3rXOOybTrj+LCLVITbU4
         Irc2Eo+peEAo7/+G5VDNUX7uHgaxd+V9PhcbBWral1xJMuocmbky+UdlTz4cSvESArtQ
         UE+Q==
X-Gm-Message-State: AODbwcBW8+qTDWAHlurYG0Rftiuu5ZM56mSxAyLW+F+JBQ0a5TXkTRao
        FyqlkAM1CmLPlA==
X-Received: by 10.84.218.205 with SMTP id g13mr5828517plm.38.1494396243235;
        Tue, 09 May 2017 23:04:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id e185sm3023238pfa.115.2017.05.09.23.04.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 23:04:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] pathspec: convert parse_pathspec to take an index
References: <20170509191805.176266-1-bmwill@google.com>
        <20170509191805.176266-9-bmwill@google.com>
Date:   Wed, 10 May 2017 15:04:01 +0900
In-Reply-To: <20170509191805.176266-9-bmwill@google.com> (Brandon Williams's
        message of "Tue, 9 May 2017 12:18:05 -0700")
Message-ID: <xmqq1srxxn72.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Convert 'parse_pathspec()' to take an index parameter.
>
> Since the index is only needed when the PATHSPEC_SUBMODULE_LEADING_PATH
> and PATHSPEC_STRIP_SUBMODULE_SLASH flags are given, add a check
> requiring a non-NULL index when either of these flags are given.
> Convert callers which use these two flags to pass in an index while
> having other callers pass in NULL.
>
> Now that pathspec.c does not use any cache macros and has no references
> to 'the_index', mark it by defining NO_THE_INDEX_COMPATIBILITY_MACROS.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

The same comment as 5/8 applies to this change, but it is a bit
easier to judge, because it has so many callers, and for some
builtins, especially manipulator commands like add, checkout, and
commit, there may be a good reason why they want to keep the primary
index while playing with an additional in-core index in a distant
future.

Does a pathspec parsed using one instance of index_state expected to
work when matching against a path in another instance of index_state?
Otherwise, passing a non-NULL istate to parse_pathspec() would tie
the resulting pathspec to a particular index_state in some way and
there may need a mechanism to catch an attempt to match paths in
another index_state with such a pathspec as an error.  Just
speculating out loud...

