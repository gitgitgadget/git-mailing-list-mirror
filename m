Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1E91F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeGIUfw (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:35:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40628 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGIUfu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:35:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so12305630wrn.7
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BB3ThR29HCf0V8FwMtmiUTjsqeS8WyFI7gQIhC4FWkE=;
        b=tTYLtArW7NkSwLOyNBNZqXpmKO39PKchEr2wVDf/IELSH27+G2g7ePNQZl1jd0JbDr
         FUbJA9c2puIRmvlq+ZhzPIPOqVMsYMa7K5puH71vSoqleq+6NvU8/Vr9P5LTgGSrw5sC
         RU9fvu7UDKdDywjRagMh94ezGItBtXa1cAQI7HF51VTRyWn3jwm7l3dGZejRJAkY+vj5
         3nbg1SRSDn/VvaRFoiN5BQiZfSRMnrRzxIsnKuoVgp0SQ/XzbJSy8sna7cOOgY9SjIIp
         Bkcidhbx2od55zPpC/bAYKWM9QKKwCGMtIRgOhf2PfbGh3bPvF7eUno45PMtms2VjIv6
         LcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BB3ThR29HCf0V8FwMtmiUTjsqeS8WyFI7gQIhC4FWkE=;
        b=jiRyPJJ5q0Zjr/QLAYmH0J/YHJI1iBhWLkMzDLFmg1HSyLiXVxVuaaOR+tNuu0IzIL
         SpRxhbGHeuYNrVmJkWWSq4ykXBdoZTR6W+wfuQeTmcl0bov3u+wCUCaUhXhICp1aOtq4
         JQBsgM8iOKbkj6Ma9+4fa3bY29E6n0qctKrfpGq8pvjYXS/iQE6El0Yd4getmOTLVic6
         B5wiNbV0vIH4PN2uWTiizc1tLiyXPSEXDrcWWQGPtzvOihzxEUaGeI/9VVR7Jic9Q6kg
         1u5OuECWnYyDsgQjIPGVK85kZRPYKq1AyuU+SdIvJcHBtCkCbTNUIb8ILo2hxgKQ44cB
         Pfvg==
X-Gm-Message-State: APt69E1MJ0H5Rr82uMAs8/5rgoglk+y+LuAWHQgEAws/Ie5WUVafpKMe
        OxsPbLjiHeyK5T5PkRum8mg=
X-Google-Smtp-Source: AAOMgpd0EIHW/SqfpOfiZA+UlJ+48vvcFQrZDGsR6rgYMGMyonkLndy0zLAQx+0eNhNAeHpBHhe35Q==
X-Received: by 2002:adf:ac2d:: with SMTP id v42-v6mr15470517wrc.142.1531168549271;
        Mon, 09 Jul 2018 13:35:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m10-v6sm16761715wrj.35.2018.07.09.13.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 13:35:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
References: <cover.1528233146.git.jonathantanmy@google.com>
        <cover.1528234587.git.jonathantanmy@google.com>
        <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
        <20180709173813.GA14196@aiede.svl.corp.google.com>
        <20180709175939.GC81741@google.com>
        <xmqq8t6ke07x.fsf@gitster-ct.c.googlers.com>
        <20180709183328.GD81741@google.com>
Date:   Mon, 09 Jul 2018 13:35:48 -0700
In-Reply-To: <20180709183328.GD81741@google.com> (Brandon Williams's message
        of "Mon, 9 Jul 2018 11:33:28 -0700")
Message-ID: <xmqqd0vwcfkr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 07/09, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>> 
>> > I agree with this observation, though I'm a bit sad about it.  I think
>> > that having tag auto-following the default is a little confusing (and
>> > hurts perf[1] when using proto v2) but since thats the way its always been
>> > we'll have to live with it for now.  I think exploring changing the
>> > defaults might be a good thing to do in the future.  But for now we've
>> > had enough people comment on this lacking functionality that we should
>> > fix it.
>> >
>> > [1] Thankfully it doesn't completely undo what protocol v2 did, as we
>> > still are able to eliminate refs/changes or refs/pull or other various
>> > refs which significantly add to the number of refs advertised during
>> > fetch.
>> 
>> I thought JTan's <20180618231642.174650-1-jonathantanmy@google.com>
>> showed us a way forward to reduce the overhead even further without
>> having to be sad ;-).  Am I mistaken?
>
> That's true, what Jonathan mentioned there would avoid having to send
> "refs/tags/*" when requesting the refs.  The question is do we wait on
> implementing that functionality (as another feature to fetch) or do we
> fix this now?

It's not like the earlier v2 protocol used to be super efficient and
correct, whose performance benefit is destroyed with this "fix"
irreversibly.  It was a fast but sometimes incorrect implementation,
and we'd protect users of the still-under-development feature with
these two patches while updating the protocol further in order to
become truly efficient and correct, so I do not see it a wrong move
to take a hit like this patch does in the meantime.

What I would see a wrong move would be to leave it very long as-is
after we apply this fix, and declare to flip the default not to
follow tags, using the performance hit as an excuse.

So I do not care too deeply either way, whether we wait to regain
efficiency or taking this safe fix as the first step, as long as it
is fixed in the longer term.  I had an impression that the sentiment
in the thread was that it was OK to accept the inefficiency for now
and fix it later, and I am personally fine with that approach.
