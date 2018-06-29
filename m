Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289E01F516
	for <e@80x24.org>; Fri, 29 Jun 2018 22:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934901AbeF2WFz (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 18:05:55 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54451 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753108AbeF2WFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 18:05:54 -0400
Received: by mail-wm0-f54.google.com with SMTP id i139-v6so3530990wmf.4
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T+QJLnL/88K7VG8TqQqNkI7u7zwxiGZDUTmYn2NCEyc=;
        b=Ow5wb4yhBvzEE/embQuSGxYrNCqqVJOjE/UoMrPaNN1AFNDMKbXDPKt1HFgFf1wX+O
         Bbp0EAqB2XEjpn7/8Yf0tCZeypqxF6oeopKlShlRgz0CWLUlbhgAGAW5z2Iqxu8UGsR0
         XSnfPRz+aIxFWP3IqTn99urZu1z8qgUXWz/7wNaCFrtyW2nNIKJaXjEmxuFV9Vb9nhrD
         dpfrmGu63iUmRoRWH1FglLN2Q6yczRqvPag721OS4CfrVEhlc94dKSprGosQlHCefM/8
         HPIA4VrtLB+SGcucjosBrHozKtx4XqlX9pp9tpGPG4RsaDPheJ5B5I6/r+fBOviIE9nK
         2VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T+QJLnL/88K7VG8TqQqNkI7u7zwxiGZDUTmYn2NCEyc=;
        b=HaQwM58r0mj61/WvLxH6C3d6YDKkyo7jHbKD9cBD2QtWzCOYm0Le27YV6MQgAJfVFn
         PV+d4Gia6lhwSr3mm/Hee5meUT6PfdATZVQ/iISipBD8Yvd0OMXY4pjIb1Ttj8k8/95e
         Up0OfhfChyQ2njISHRONjySqQZZhXLY4rDNPWjwzmeLj/KvTHnE353pa2+Ce6IFaJOW5
         9TrRf3MN4agZA4djFcnWanq74ZcdptsJDPbqSGE1QbpFB9FL5sDfInSRpwf8Rws2XBue
         v2fwF7+eVU2voGdK/ZNAq7FtcW5NkdXuIVL/CE5YSD31AOOBSirm1hW1AT0iP32Vdt/N
         hLng==
X-Gm-Message-State: APt69E030wiUVBSGBrXBiWhalBm1dKXnMwoJXiBtubHEcM+NjKnUtotd
        5BQow4TwWGKAyUFEjYf6AR8=
X-Google-Smtp-Source: AAOMgpdqUBKPqmdpo26bs9z7tarIIN9oErFglVoT57VdrPEmWoV4abnd2iorXCE43LCY4lesFIQEfw==
X-Received: by 2002:a1c:2fc7:: with SMTP id v190-v6mr2776027wmv.151.1530309952669;
        Fri, 29 Jun 2018 15:05:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k17-v6sm10704661wrp.19.2018.06.29.15.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 15:05:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>
Subject: Re: [RFC PATCH 04/13] upload-pack: make reachable() more generic
References: <20180629161223.229661-1-dstolee@microsoft.com>
        <20180629161223.229661-5-dstolee@microsoft.com>
Date:   Fri, 29 Jun 2018 15:05:51 -0700
In-Reply-To: <20180629161223.229661-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 29 Jun 2018 16:12:45 +0000")
Message-ID: <xmqqwouhs0xs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> In anticipation of moving the reachable() method to commit-reach.c,
> modify the prototype to be more generic to flags known outside of
> upload-pack.c. Also rename 'want' to 'from' to make the statement
> more clear outside of the context of haves/wants negotiation.

FWIW, I find the order of things done quite sensible.  Rename,
extend, etc., to prepare before moving and then move, not the other
way around.  You would want to do the same for some symbols named
overly broadly you moved in earlier steps, too.

Also, if you will be making this function a global one in a later
step, now is the time to give it a good name suitable in the new
global context before moving in this preparatory step.  If it will
be file-scope static in its new home, then reachable() may still be
a good enough name.  Let's keep reading...
