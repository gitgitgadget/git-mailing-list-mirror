Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5C31F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964906AbeFYSVr (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:21:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38321 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934772AbeFYSVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:21:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so14638099wrs.5
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F7iNeoqYg07AMfNSyedSFstaoJ6p/dnmVrqSgMUFr1A=;
        b=a3sQtxaukyefaQJq5rIHk1TfDUHhSEf7oBfMuDXv8FFzoLTUb55/dX2Q9R/iHlbBSx
         XklkSXd8CUwqsrUxbUosz6DH4DcXEgqSVw9b59JREg3fBhJhVGjb1BlLq+IQL6Ei+CeY
         jM2QDkU8Ouu6BoEkA1ORe/y+V8Uq1UlHIlVaLCVWgLyg0nPToSSBfo4VbfemJECdu5/L
         wCx0unvhNxAwLasuXLk7gll5sQ3i7l3fsOfpu/HX+ilYrJzX5CgJWJVJAngYxOQLI1ZI
         FWiG5vXlH/lb6AhXZlqMCkPKNvhJV9zMTdRjOndesRrLXTKSg/DQpTmAfAWUP2K2CB/T
         lQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F7iNeoqYg07AMfNSyedSFstaoJ6p/dnmVrqSgMUFr1A=;
        b=bCbO1ufYe7RpMmt2QMq8bH7V7wtWy7t1ExKGbz+/rc6E99ikHHZeIh15W7tCux4w1i
         Vf+mJBixsH5UnCkuDB2jtbUDtn5PEEyaiIPv8ivGbbL8gK8SeJrShNgrI6fLWIUgmNab
         G2k8Rzlctb2wazXXsInY8ghV4ZNFmbWFdWWzmuGpoSnKBO7gJiP2Fhu055IKakGucRWW
         8mVQj9RDw8uvoHIVxrbbDMCzUNvv8UfEEGTZSOE8PWaP4t9ixaHuZkP+5rosVpxZF16m
         330VECyWdJLi08CuDgFxJKKEeW4SRy/uNiXzAajBVOL9X4A6RX79FV2vytVjQqEYE0Yl
         ZJXQ==
X-Gm-Message-State: APt69E2gEXM1stNI4YjuNat2pGNOeSZQ1S28usI7ev5G8/bKHPwO0E+U
        yR7aUaiUsxxP238BLyqykZ8=
X-Google-Smtp-Source: AAOMgpcdWT0929Atqbccwxbn1ClTUu01ZrEXolkMa2IC/wBel7IyrkRUxtYc0fmcDxfWV0LUEzNI6A==
X-Received: by 2002:adf:edc6:: with SMTP id v6-v6mr10645578wro.264.1529950903660;
        Mon, 25 Jun 2018 11:21:43 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.gmail.com with ESMTPSA id h71-v6sm9326268wme.47.2018.06.25.11.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 11:21:42 -0700 (PDT)
Subject: Re: [GSoC][PATCH v3 2/3] rebase -i: rewrite setup_reflog_action() in
 C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
References: <20180619154421.14999-1-alban.gruin@gmail.com>
 <20180621141732.19952-3-alban.gruin@gmail.com>
 <xmqq4lhurdl7.fsf@gitster-ct.c.googlers.com> <7094810.i0lmrLi0k7@andromeda>
 <xmqqr2kuq3qg.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <4dfaa8d4-09d0-1156-43a4-687c3389e039@gmail.com>
Date:   Mon, 25 Jun 2018 20:21:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2kuq3qg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 25/06/2018 à 17:34, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> Hi Junio,
>>
>> Le 22/06/2018 à 18:27, Junio C Hamano a écrit :
>>> Alban Gruin <alban.gruin@gmail.com> writes:
>>>> This rewrites (the misnamed) setup_reflog_action() from shell to C. The
>>>> new version is called checkout_base_commit().
>>>
>>> ;-) on the "misnamed" part.  Indeed, setting up the comment for the
>>> reflog entry is secondary to what this function wants to do, which
>>> is to check out the branch to be rebased.
>>>
>>> I do not think "base_commit" is a good name, either, though.  When I
>>> hear 'base' in the context of 'rebase', I would imagine that the
>>> speaker is talking about the bottom of the range of the commits to
>>> be rebased (i.e. "rebase --onto ONTO BASE BRANCH", which replays
>>> commits BASE..BRANCH on top of ONTO and then points BRANCH at the
>>> result), not the top of the range or the branch these commits are
>>> taken from.
>>>
>>
>> Perhaps should I name this function checkout_onto(), and rename 
>> checkout_onto() to "detach_onto()"?  And I would reorder those two commits in 
>> the series, as this would be very confusing.
> 
> I may be misunderstanding what is happening in the function, but I
> think it is checking out neither the onto or the base commit.  The
> function instead is about checking out the branch to be rebased
> before anything else happens when the optional <branch> argument is
> given (and when the optional argument is not given, then we rebase
> the current branch so there is no need to check it out upfront), no?
> 
> 

Yes, you’re right.

Now I really don’t know how to call this function.
checkout_top_of_range(), perhaps?

Cheers,
Alban

