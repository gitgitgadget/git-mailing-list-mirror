Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A82F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPWJY (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:09:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36701 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeGPWJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:09:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id d14-v6so3166621pfo.3
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q6XT4ZzEL9KoZ42xe4qhpo1iTZUfvbuJWbQ2mTDBq7M=;
        b=d19BA9yAx2WlrQWkxMRQ1Am70X7hgsIkIY5wwzEmUdfeneh4v+4dUxzrcR7LqxJHVl
         dBQQBxyIJvpNvhajVEMEQMPEWf9czo2gLPmMs2c5y9Pa8nqif7OS3znB+3brpehKbTNq
         tVCgVornPp1Qh+0GjQqc0iAhixUZ9One0JlwwUlIYHtsrIX5HxEYVu1xpyuV8fnf9oGM
         9jYG/CTLKQ6Xbv5qBX3IBt6SN25mKtIY7/TfQ3fQ4JoMOt6mTO/Twn/QjoXA3Cjli+6p
         I1bg9yENREJ+Rsli2TQWhJP7UdSSY0mcXcBptpxmJABjY/CQqdkP9ZJNqkNdsHc0bA3W
         Bq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q6XT4ZzEL9KoZ42xe4qhpo1iTZUfvbuJWbQ2mTDBq7M=;
        b=Ub1ZR4XilnDqTCrovpIoMSnrtdeNaTdV4px9D0WPQ3U7w1/6XsMR77mzmNnim3ojA1
         8SZunvYtF94tspkVFwR7JEF/NPiCLeJg+KZ86YEV54GBu2PBbuTs4AsAwm2wt9icn308
         9+hGcTPdxVEJQW0nDaFqMbTlfxyVk7zHRXWDZl43JrVUEINZk+sEM+VnTCAZcXMsIePW
         RK8Pfaic+rYXKPaEv/Z+0joWjKvhJZoCkl38I4nlvCNwGPWpeJ2saV6aLLwyLcdQOXaW
         vC8PwPcxzY0sXzimQJtdP1ZbDLlgeL7PZgSRgl1uA8CormSoMn7IEqnlXA+rVhc2Fxis
         Z4Vg==
X-Gm-Message-State: AOUpUlGUpI9sOFh14GPvzHA3QSfXutI9vz2dR9hrKXoRXGNVGPeFqz8v
        pAre8nhBKQkn7hmB2/BdEpQ=
X-Google-Smtp-Source: AAOMgpdAVtlnyI1JUYV2obk3Yzq/q2/tYdpQbT5MTclSzco2wu4dSvddVY3WwFUTlAGlTiBR3dtPvA==
X-Received: by 2002:a63:b605:: with SMTP id j5-v6mr17246822pgf.437.1531777205814;
        Mon, 16 Jul 2018 14:40:05 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b192-v6sm5300433pga.2.2018.07.16.14.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:40:05 -0700 (PDT)
Date:   Mon, 16 Jul 2018 14:40:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716214003.GH11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
 <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716210938.GF25189@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jul 16, 2018 at 01:37:53PM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> With the current code, that produces a bunch of annoying warnings for
>>> every commit ("I couldn't gc because the last gc reported a warning").
>>> But after Jonathan's patch, every single commit will do a full gc of the
>>> repository. In this tiny repository that's relatively quick, but in a
>>> real repo it's a ton of CPU and I/O, all for nothing.
>>
>> I see.  Do I understand correctly that if we find a way to print the
>> warning but not error out, that would be good enough for you?
>
> Yes. I thought that's what I proposed originally. ;)
>
> The key thing is that the presence of the warning/log still suppress
> the actual gc for the gc.logExpiry period.

Ah, now I think I see the source of the misunderstanding.

When I initially read the docs, I also assumed that

	If the file gc.log exists, then git gc --auto won’t run unless
	that file is more than gc.logExpiry old.

meant "git gc --auto" would be skipped (and thus silently succeed) when
the file is less than gc.logExpiry old.  But that assumption was wrong:
it errors out!

This makes scripting difficult, since arbitrary commands that
incidentally run "git gc --auto" will fail in this state, until gc.log
expires (but at that point they'll fail again anyway).

For comparison, in non-daemon mode, there is nothing enforcing the
kind of ratelimiting you are talking about.  It is an accident of
history.  If we want this kind of ratelimiting, I'd rather we build it
deliberately instead of relying on this accident.

Jonathan
