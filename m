Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D017B1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeGPWcb (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:32:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40921 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbeGPWcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:32:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id e13-v6so13575311pff.7
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qk2z8TKWOKuTkio9egNrHyr0OF2qQA2WSMHq5AyhBwI=;
        b=lbQUGa0pdQh7m3PWv74YZSdMFelPrnuqEdeD5xg0/Z1F6ZfVoY2RBRQWU4TI5nkkGE
         yQ3YPjkCwP9GS+0Nd1olQGNfvhBP1xXKZg5Ch7sQq01iVfFU3U03ML14a3XMCG7BW2Uf
         QyAYh9fmhka9eS8IuLyog6kqGwfrADaIaJkhPLHQZboi6h8OLdktCt1NF4YlA4odI1x2
         Rqn41A0e94jKNj0uKIaBQAzBriXxStGWh/2BG3Tivom5CfjSwNy1uw5NLypma0FTqNd+
         4c6uCnw078X0tjrPRepzMmG/azTDcZsq7xKzH2CIgd5cqGjRdfBj20ngXmeZyJhpbS76
         EBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qk2z8TKWOKuTkio9egNrHyr0OF2qQA2WSMHq5AyhBwI=;
        b=R2Gri1SrX+b+TRhmjmdPgXomysrAu/fqvHRvrJi01uVouUlA+LkOkSbhu4wD0uaX0s
         hTSVDmfX975MhkiPcwGUQ/j5cAJWWH2hDdWnZmBnSjEO8IjMmgPt0YP3GDUIFskXe0NW
         qndu4OeJX2IbLno81slMrZyjpAHQ+6fpy70XRzKJZV+IrhEHc9w4alPJGZikv7Y2s9mD
         06sSlFX8WYZ77h2RcK6cgByC+YaGMHGxFuuGN4ihbTkOKW82wWk75n7AbKRWVRn6G47U
         +MfXZ50RbDGjh1ykE9wS45AGyJDgkJzg+S0xYnGt7J5iR7iNxkyk+bDZl3/jO2y4TVZl
         dB7w==
X-Gm-Message-State: AOUpUlFeNqhVHNKdbwhIXd6lc4RXcId+6VWguAG0XPNaxpTm4xnUBJti
        alzxqoEoHebQRQIYJe/oRUA=
X-Google-Smtp-Source: AAOMgpeOQ2/cKb7uq2SUS0yNsJiWd7Td852fAmN+sHk1PLX0Pz3RZY+rXLNZwNSdAEylD8yagfuKtw==
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr19803701pff.199.1531778588486;
        Mon, 16 Jul 2018 15:03:08 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v6-v6sm95583789pfa.28.2018.07.16.15.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:03:07 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:03:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716220306.GI11513@aiede.svl.corp.google.com>
References: <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
 <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
 <20180716214003.GH11513@aiede.svl.corp.google.com>
 <20180716214539.GL25189@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716214539.GL25189@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I don't think any command should report failure of its _own_ operation
> if "gc --auto" failed. And grepping around the source code shows that we
> typically ignore it.

Oh, good point.  In non-daemon mode, we don't let "gc --auto" failure
cause the invoking command to fail, but in daemon mode we do.  That
should be a straightforward fix; patch coming in a moment.

> On Mon, Jul 16, 2018 at 02:40:03PM -0700, Jonathan Nieder wrote:

>> For comparison, in non-daemon mode, there is nothing enforcing the
>> kind of ratelimiting you are talking about.  It is an accident of
>> history.  If we want this kind of ratelimiting, I'd rather we build it
>> deliberately instead of relying on this accident.
>
> What I was trying to say earlier is that we _did_ build this
> rate-limiting, and I think it is a bug that the non-daemon case does not
> rate-limit (but nobody noticed, because the default is daemonizing).
>
> So the fix is not "rip out the rate-limiting in daemon mode", but rather
> "extend it to the non-daemon case".

Can you point me to some discussion about building that rate-limiting?
The commit message for v2.12.2~17^2 (gc: ignore old gc.log files,
2017-02-10) definitely doesn't describe that as its intent.

This is the kind of review that Dscho often complains about, where
someone tries to fix something small but significant to users and gets
told to build something larger that was not their itch instead.

The comments about the "Why is 'git commit' so slow?" experience and
how having the warning helps with that are well taken.  I think we
should be able to find a way to keep the warning in a v2 of this
patch.  But the rest about rate-limiting and putting unreachable
objects in packs etc as a blocker for this are demoralizing, since
they gives the feeling that even if I handle the cases that are
handled today well, it will never be enough for the project unless I
solve the larger problems that were already there.

Jonathan
