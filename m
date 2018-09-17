Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36C61F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeIRAIt (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:08:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42315 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeIRAIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:08:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id g23-v6so7820871plq.9
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7s2wsBKDBbb+vcwxUrFcDrlBBXp8dZkOM3Iv/qkNbY=;
        b=G7xfgxmwDR9O3DbzuiTvPI9ia2a3x7pw2j81Gv+mtCqUrL3M4V5nRW2bqn0gUp/XYO
         DCNyTRddL4Z6TS6see2eYWfsqvV44X+an/qA8w4K+xS2DKm4jWkS0PPC44cwsIGsUbRv
         xU18uFhhpxGm35+4DM3P3GNG/YQjmnPZjnQmX0aE0E3yP4wde7YWjBL81VK6hTv5AzYp
         ZlBjUApV21jpIf6hA0V+OsxRNEiM/uFJEz6SMFI/YkR024UIlAJZXrHbAhDDHKYwB2Nh
         hQF07RuntNvpfVG3VKP7YivB4E663d105/NDe4ofIXllJGQzVCNkb+tjSe72gFt4PFnP
         aUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7s2wsBKDBbb+vcwxUrFcDrlBBXp8dZkOM3Iv/qkNbY=;
        b=PZYLtMSEVlpKgiVCMGGz5bXxVSjGNoabzIRHnczIUSYEQtAG2gITQw3vUOakoBlIeO
         dpzE3Vh130r4zuKSXuTRl5Sw6/XF8Z2vujMmve//t5LJ8HtvJvcxg+d1q9/NaUTLzYHE
         ydwUL+/DubC4RGXJ9JEi6Uoo4j5fltws1oZS988QR14Mdw+Wtv/WrVMweN97HQHRYPgn
         d9bY8eeK7zrLer2Naozy2TUHemaGblWLcOtR+cmQ9T5XUJlqLKnYZyFqGQRvPL7nI3Of
         sif6o96eIhc7YY9/qPac72MoF2EPrM33n7iUf3O66WaxUK5DBmdxBLvQ2MQLt+38l1jS
         XQIQ==
X-Gm-Message-State: APzg51CZAceAOXcdd5bi5EyPZhuCyV0PpzEkP+hYJG8aL4PURhMvjj8S
        m3IisnBIsnlaZTJcrLN4QwE=
X-Google-Smtp-Source: ANB0VdZE/pyFvQwgp8G1tS7+rMXxZYHcFFEkofpWxU8hI7v257+D5N5XU5RuoKrXTXnxp7nlgdsBvQ==
X-Received: by 2002:a17:902:7c96:: with SMTP id y22-v6mr26286912pll.332.1537209614376;
        Mon, 17 Sep 2018 11:40:14 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d10-v6sm17406292pgo.2.2018.09.17.11.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:40:13 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:40:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] gc: exit with status 128 on failure
Message-ID: <20180917184012.GD140909@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
 <20180717065416.GC177907@aiede.svl.corp.google.com>
 <20180717195946.GC26218@sigill.intra.peff.net>
 <20180917183336.GA4630@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917183336.GA4630@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Tue, Jul 17, 2018 at 03:59:47PM -0400, Jeff King wrote:
>> On Mon, Jul 16, 2018 at 11:54:16PM -0700, Jonathan Nieder wrote:

>>> A value of -1 returned from cmd_gc gets propagated to exit(),
>>> resulting in an exit status of 255.  Use die instead for a clearer
>>> error message and a controlled exit.
>>
>> This feels a little funny because we know we're going to turn some of
>> these back in the next patch. That said, I'm OK with it, since this
>> version is already written.
>
> There's discussion elsewhere[1] of applying just up to patch 2.
>
> Do we still want to convert these cases to die() as their end-state?

IMHO yes, we do.  die() is the function that you can use to exit with
a fatal error.

If we want to get rid of die(), that would be a tree-wide effort, not
something that should hold up this patch.

[...]
> It also makes the code more flexible and lib-ifiable (since the caller
> can decide how to handle the errors). That probably doesn't matter much
> since this is all static-local to builtin/gc.c,

Exactly.  I'm a strong believer in http://wiki.c2.com/?YouArentGonnaNeedIt.

Thanks,
Jonathan
