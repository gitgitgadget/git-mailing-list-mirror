Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180A21F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755647AbdKHAlW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:41:22 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:52525 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754940AbdKHAlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:41:21 -0500
Received: by mail-it0-f49.google.com with SMTP id j140so4537554itj.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 16:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbGvrMo0HKUdTQocB2Asjq+Y5fylryuALla874UPxF4=;
        b=Prc+0sd9iMUe3Tr7JrvQ1EZgUoSiTl8K/n1iyi9LIPxsFIzArnes6J7BWzsnt/Z4Xq
         7tBFFca400nOdVg2JVvQrno3K9xeN4TkJGsm9e3NwB9DfxP6408CPHCAAFN7x5VikP+w
         Mmb8p2fLFtH3WxxjBzvvzIRvHe1Sb1jWqNwLfkdLHHPKTjRwufJcWsYmetWnno5ljki6
         9vi9ExlI0R1vSzPqBu2CgcZIN1RIrgvhwKZ6/pE9Ep+khH22E2U4SFWGRtQF919wPmMM
         dMdRRcJ13W0ZT6ruCsk5eFiddYpo6FHVN9FbDiAydiN/oA1vZ+G2l48jgwQnWfAO5faS
         mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbGvrMo0HKUdTQocB2Asjq+Y5fylryuALla874UPxF4=;
        b=XWwo+y2k54HZckaUjcHOvmDKBatmz+PaO7BWijkEGcIYkZ37mvtqi94kEYFp4NHv7O
         U0A2y6bkIFsOl5JXU9tAwBIkuIA29U/fuTeMq7P2cZC701U5NdRj4Ps+9gR9axb0Ro3K
         08n/xEH1L+Ymz2SETeIF1xYDxQbunIEUl3mQW/TIB0mF0COoXKrcJSy7n8278aP0QGrI
         nDOIk8N0xo+Z+ff+8Kdsjt1xgN5esN8FCSQJkviUyFy7fqFPtJ1YMBW8WNiSlwSD3ZwE
         2Sn22x9ExkO65WX+NMD2L34GIJhNK64cuxKEqALczuAag9F5UPUU2pVmvJM5WlEYSR0v
         7lSw==
X-Gm-Message-State: AJaThX5XQZQTI9Sp9BcaPNouc4dZ2VY2/gvx+pAK+ZDajJ9OVBp8U7k0
        /x2SjgPJj80RBuNIa9WZkrRzOA==
X-Google-Smtp-Source: ABhQp+QqkFL/nnbsuBxK659o+p/NLBFkn8jjCu4d+h/0MtHHrNv4jFG3uWe3xa6Ap1vL8Gm6nYC7wQ==
X-Received: by 10.36.105.65 with SMTP id e62mr1455376itc.16.1510101680379;
        Tue, 07 Nov 2017 16:41:20 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:8df4:1665:e9bb:1ae7])
        by smtp.gmail.com with ESMTPSA id e203sm102362itb.32.2017.11.07.16.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Nov 2017 16:41:19 -0800 (PST)
Date:   Tue, 7 Nov 2017 16:41:18 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/6] Partial clone part 1: object filtering
Message-Id: <20171107164118.97cc65c4030de0922b19ddd6@google.com>
In-Reply-To: <97585434-6d57-dad4-d7aa-e48dacec1b3f@jeffhostetler.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
        <20171102124445.fbffd43521cd35f6a71e1851@google.com>
        <bd41699f-19c7-02a0-0af1-8f22b3277a1b@jeffhostetler.com>
        <xmqq7ev7pfln.fsf@gitster.mtv.corp.google.com>
        <97585434-6d57-dad4-d7aa-e48dacec1b3f@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Nov 2017 14:34:39 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> > Assuming we eventually get promisor support working, would there be
> > any use case where "any missing is OK" mode would be useful in a
> > sense more reasonable than "because we could have such a mode" and
> > "it is not our business to prevent users from playing with fire"?
> > 
> 
> For now, I'd like to keep my "any missing is OK" option.
> I do think it has value all by itself.
> 
> We are essentially using something like that now with our GVFS
> users on the gigantic Windows repo and haven't had any issues.
> 
> But yes, when we get promisor support working, we could revisit
> the need for this parameter.

Well, it's probably not a good idea to include this parameter, and then
subsequently remove it.

> However, I do have some scaling concerns here.  If for example,
> I have 100M missing blobs (because we did an only commits-and-trees
> clone), the cost to compute "promisor missing" vs "just missing"
> might be prohibitively expensive.  It could be something we want
> fsck/gc to be aware of, but other commands may want to just assume
> any missing objects are expected and continue.
> 
> Hopefully, we won't have a scale problem, but we just don't know
> yet.

I can see some use for this parameter - for example, when doing a report
for statistical purposes (percentage of objects missing, for example) or
for a background task that downloads missing objects into a cache. Also,
power users who know what they're doing (or normal users in an
emergency) can use this option when they have no network connection if
they really need to find something out from the local repo.

In these cases, the promisor check (after detecting that the object is
missing) is indeed not so useful, I think. (Or we can do the
--exclude=missing and --exclude=promisor idea that Jeff mentioned -
--exclude=missing now, and --exclude=promisor after we add promisor
support.)

This is conceptually different from gc's use of
--exclude-promisor-objects (in my patch set), which does not intend to
touch promisor objects (objects that are known to be in the promisor
remote), whether they are present or not.

Having said that, I would be OK if we didn't have tolerance (and/or
reporting) of missing objects right now. As far as I know, for the
initial implementation of partial clone, only the server performs any
filtering, and we assume that the server possesses all objects (so it
does not need to filter out any missing objects).
