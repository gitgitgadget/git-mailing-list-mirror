Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CEF420282
	for <e@80x24.org>; Mon, 12 Jun 2017 05:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbdFLFaz (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 01:30:55 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35789 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdFLFaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 01:30:55 -0400
Received: by mail-pf0-f182.google.com with SMTP id l89so47536357pfi.2
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 22:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NnzBxzBs24QjK372pgQFu6foXnerTP4Z10mW8k5y4d8=;
        b=bHc0Ie+AzBjlDZg32pHAFwbnEQeo7Tgl+n2tEXd0MzRTpOv2/bSMDRUaikLmST9NEH
         6Vizt9g0YNNd4aa1xcGvYOvPkVRROjPkcP5Fqa/tczO3BBkCVAp9ep54cTO7iPWmzIop
         D1C2cqNkasLLZ46PIcqiq50AKLXEx3uemDL2/CBJafbknwVjdFmBbrpbtCMTAV7OY1UP
         t48LPLmRuQ/6tEXf8N3JWxALzL3oHV0WW6pn7yghphOxc9qr8rusHYdbbC7H7MkUDt3s
         17poQtblNVJnHmnR9A843tZDlX1NeuZ9z2pGaH2jZi5zZ6hLlOIAINRNpBATJNR5MVE8
         Q1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NnzBxzBs24QjK372pgQFu6foXnerTP4Z10mW8k5y4d8=;
        b=iKJr/pX3HAJ8a79gE5ZOGfib0+7LriWCf85x9MLRqAoqkTEE521UTIMAg6jNdGLPlc
         JpQ/fVel4TRhED9Lezg/wXEN7TQuc+IgzmZfYYhSSHrRfhQC6vPvVkzYsZAZ5OAlCvQ2
         PPR986KMk6MVYxPFtVSxwvHg75jPca400Ta2ipoHWcknzAe7f6kdjsg4G0bAJ4dV09yr
         QsANxj+IGs4E080/zmDfEcAM12dFf6uhmwRxmhEc3MdmTcG/qE8fvmcOcCvzUSHA8LPO
         X/lj3OqOYnbbv31vjfVPd/seOUMq2+3RryBLAy9WkSPjGsWQG4Tl1a9Q5hY6FZL9c2Hk
         Xuvg==
X-Gm-Message-State: AODbwcDGzg2skol7uxH1B691tz0LuyIlgPfrUMcpkIButOjjdn9FBHSA
        NQja1sNwfPz+3OPS4+b57pK/2ZvQLocL
X-Received: by 10.99.9.131 with SMTP id 125mr46378036pgj.178.1497245454255;
 Sun, 11 Jun 2017 22:30:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Sun, 11 Jun 2017 22:30:53 -0700 (PDT)
In-Reply-To: <xmqqbmpw4mpo.fsf@gitster.mtv.corp.google.com>
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
 <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
 <20170606181024.GA189073@google.com> <20170606183914.6iowfhimo5yrvmtf@sigill.intra.peff.net>
 <20170609231935.ysolxkiuhhpa3xrd@sigill.intra.peff.net> <xmqqbmpw4mpo.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 11 Jun 2017 22:30:53 -0700
Message-ID: <CAGZ79kZuwjQ1qYm5wLXXdMurwyAieWuLETV-Cx61ipO=QcsG+Q@mail.gmail.com>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive clone
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 9, 2017 at 7:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> In an ideal world the user do:
>>
>>   git submodule add git://host/repo.git path
>>
>> which adds the gitlink and the .gitmodules entry. But it doesn't seem
>> unreasonable for somebody unfamiliar with submodules to do:
>>
>>   git clone git://host/repo.git path
>>   git add path
>>
>> This does add the entry as a gitlink, but doesn't write any sort of
>> .gitmodules entry.
>
> I actually would think that is a perfectly valid state.

me too.

But on the other hand I do not want to offend non-submodule-gitlink-users
too much. So maybe:

  $ git add <gitlink>
  # Adding a raw gitlink to the index,
  # in case you want to use a submodule,
  # use add a .gitmodules file or use 'git submodule add'

> In that
> original repository pair (i.e. the superproject with a submodule
> without an entry in .gitmodules), as long as the configuration in
> the submodule repository "path/.git/config" has necessary remote
> definitions, "git push/fetch --recursive" etc., should also be able
> to work without having to consult .gitmodules at the top-level
> superproject, I would think.

but these are the 2nd step, clone fails first.

>
>> With the old code, cloning the repository (either by
>> another user, or in our case during a Pages build), a recursive clone or
>> submodule init would complain loudly. But now it's just quietly ignored.
>> Which seems unfortunate.
>
> Of course, if such an original superproject gets pushed to a
> publishing location and then the result is cloned, without an entry
> in .gitmodules, no information "git submodule" can use to work on
> that "path" exists in that clone.  I would say it is OK to leave it
> as-is when going "--recursive" (what you called "inactive because
> it does not even have a .gitmodules entry).
>
> But even in such a clone, once the user who cloned learns where the
> submodule commit that is recorded in the superproject's tree can be
> obtained out-of-band and makes a clone at "path" manually (which
> replicates the state the original repository pair), things that only
> need to look at "path/.git/config" should be able to work (e.g. "git
> fetch --recursive"), I'd say.

But the user would never learn, because

  $ git clone --recurse-submodules ...

does not complain, but put an empty dir instead.


>
>
