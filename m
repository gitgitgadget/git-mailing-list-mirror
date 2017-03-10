Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E501C1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 17:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbdCJR62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 12:58:28 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32881 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755050AbdCJR61 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 12:58:27 -0500
Received: by mail-pg0-f47.google.com with SMTP id 25so41434853pgy.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJSMALiwtl46KuJ3a2FEn1Ka5qLA6elIhG/vMbZZ+RE=;
        b=A7ZsolBCsFHiHdBdmgE75GSUjua8kpaWSlUd0rkdFboAYGNkPA08wPTkFO4oOZzaNR
         RmJGH6diSyU8B3OVaJmExZTvKnw6jNgRkVMei5UMeWR/iKsEEzcOT5GoSTNMbh3n49Rc
         UX1j3w3NfsTObY87vRzPQYG3/iwoWaHo34sSd7xQoZUkQnzljNUST9qtdyF3JAW+L6Gv
         GystKSgJyMECXtlWsYCAnP5Rtz/s4uMlHNG1CzyvbiHE4shXbhRTuog5ri4v1vWlaUaD
         dcqQptPjY4yqkLFTnRdDRtt3SSBwGf3cotcqGybcEzZUOuZirTid9ytMcHWsBwQrOhsQ
         L70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJSMALiwtl46KuJ3a2FEn1Ka5qLA6elIhG/vMbZZ+RE=;
        b=A6vbIrZjKMqBpW8vDL2ITcfLIhQuo+JmX3pZYxNs4dbICfjHTfn+JxPHufeE7syd4n
         v87gbilpeDx1RZFe7hdN32QsdkOeYj60RtWnuJlO4nqi0n+bZKE3Dbig7kX7LzAq4vAb
         Dzq+zNyESTk5DZb4bWrBwgMNlCeM4nrnu+N5B0zK2H0xaBxeyuQB1SgXFfetDYMMKwD7
         omzBDWQaNkfyYYMQGj7+vxLKXycijGyIRQ25q0EEvo0rb+FJosHqZG1IhCaaKOlQhwWn
         jEjJPD38NibZFeGmBro9mrMui0jvGddRQakqZYgWPqt6orrSmIp13/R+/ciVvv1UoY3G
         XXBA==
X-Gm-Message-State: AMke39mO7vVy/scHJH5apEzDayJm2slX2EYp42i+6POz5WZzFz5tMCKkV1K30/wuo83j+5o9
X-Received: by 10.84.229.77 with SMTP id d13mr27319427pln.177.1489168705842;
        Fri, 10 Mar 2017 09:58:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:c69:ce9:a41e:fd0])
        by smtp.gmail.com with ESMTPSA id c11sm19900955pfe.68.2017.03.10.09.58.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 09:58:24 -0800 (PST)
Date:   Fri, 10 Mar 2017 09:58:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        markbt@efaref.net, benpeart@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH 02/10] pack-objects: add --partial-by-size=n
 --partial-special
Message-ID: <20170310175823.GA53198@google.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
 <xmqqh93338s2.fsf@gitster.mtv.corp.google.com>
 <1c38ffbc-e4a2-32e5-d324-506c2111043e@jeffhostetler.com>
 <20170309070438.r5g2h5vlmgzds4kp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309070438.r5g2h5vlmgzds4kp@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Jeff King wrote:
> On Wed, Mar 08, 2017 at 03:21:11PM -0500, Jeff Hostetler wrote:
> 
> > > And not ."gitmodules"?
> > > 
> > > What happens when we later add ".gitsomethingelse"?
> > > 
> > > Do we have to worry about the case where the set of git "special
> > > files" (can we have a better name for them please, by the way?)
> > > understood by the sending side and the receiving end is different?
> > > 
> > > I have a feeling that a mode that makes anything whose name begins
> > > with ".git" excempt from the size based cutoff may generally be
> > > easier to handle.
> > 
> > I forgot about ".gitmodules".  The more I think about it, maybe
> > we should always include them (or anything starting with ".git*")
> > and ignore the size, since they are important for correct behavior.
> 
> I'm also in favor of staking out ".git*" as "this is special and belongs
> to Git".

I agree, .git* files should probably be the bare minimum of files
included.  Especially since things like .gitattributes can effect things
like checkout.

> 
> A while back when we discussed whether to allow symlinks for
> .gitattributes, etc, I think the consensus was to treat the whole
> ".git*" namespace consistently. I haven't followed up with patches yet,
> but my plan was to go that route.

Well if I remember correctly you sent out some patches for
.gitattributes but I got in the way with the refactoring work! :)

-- 
Brandon Williams
