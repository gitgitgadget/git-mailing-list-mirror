Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0D82047F
	for <e@80x24.org>; Tue,  1 Aug 2017 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbdHARpH (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 13:45:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38825 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdHARpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 13:45:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id 123so1836856pga.5
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WNVogokDcmnuSE0WjT6KZv5WIKKpylO4XiknUMuC35Y=;
        b=uo5ElHLRCSVhJSZE/3zLvOOojmjWIeyibQwRmNWK4EbMgYvjznwhCkEtfaV+QEejci
         R/u2w2P2HkxA3Lj4rGnqoehLF2elFnDQRPtYIigQ9msIBAxJcUNw6txbY8aAMLwyPbJi
         xfSVjcImjmdk91Uz0I5AFKgMA6tW8t8KpSJrxr9OXL8VO54Q8jfwmiZ9dumeRgHgxJ23
         xsjPTyoGUXS4cXxbOVmW9ZGkcmeYSQ4jlw/be91/OKFJZCi8WCl2Ba+tkDI6lIHZZwo3
         1M+NBOOrd/W0LaKlp1vguhk0/zpB6CpfNnj5icysxIuy/1kqWxQmfy3RAZFtyfuXHM8H
         cdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNVogokDcmnuSE0WjT6KZv5WIKKpylO4XiknUMuC35Y=;
        b=roQbrxVxk36N+I6kXnYXByVR7Eq/kfHrAqjb4MLcghDWUg1DmrIWtB9sXIx23myXrq
         jd/4Y05XvsAgVIpED7plzOsyTYDqdp5kOskV4FVVVG7eHSHy8HgIx4z/wBMHldZM2dLR
         eYH4RlIm2MZpiMls7cXt1jGgTp5Xu3/GFcyD3eylby1l0h2Dkb2MY2SjpsgbArv0CDBc
         u3KM8dXQri30lGet8JoNuSXM96Tjz8LUUX+oCpfRh8+t6QaTZt1Lp9XPfYDCN0yZ/gDt
         DCXG3leAgEXnHRL2EZOOlhyBcJbx3Q/A4CY7ReAOXj1kdvlU4z0rODNDXC1DVo4gixW7
         6NXw==
X-Gm-Message-State: AIVw111yd/uYnGln3l4XRF310KjKzl5P1Oi9bpqXadh1QvLV5h2hZm3e
        nCV02Sp9fkGLCOtujBs=
X-Received: by 10.84.229.130 with SMTP id c2mr21691841plk.215.1501609505817;
        Tue, 01 Aug 2017 10:45:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:ec35:1dee:1562:dd55])
        by smtp.gmail.com with ESMTPSA id y12sm53133001pgs.91.2017.08.01.10.45.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Aug 2017 10:45:04 -0700 (PDT)
Date:   Tue, 1 Aug 2017 10:45:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual
 invocation of loader
Message-ID: <20170801174502.GR13924@aiede.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
 <cover.1501532294.git.jonathantanmy@google.com>
 <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
 <20170731160533.0a446244@twelve2.svl.corp.google.com>
 <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> Can we do something similar, i.e. maintain minimum set of cut-off
> points and adjust that set incrementally, just sufficient to ensure
> the integrity of objects locally created and not yet safely stored
> away by pushing them the "other side"?

This sounds like a variant on the "promises" idea (maintaining a list
of objects at the frontier) described before.  Instead of listing
blobs that the server promised, you are proposing listing trees that
the server has promised to handle all references from.

> I haven't thought things through (and I know you, Ben and others
> have thought much longer and harder), but I would imagine if we have
> a commit object [*1*], some of whose parent commits, trees and blobs
> are locally missing, and know that the commit exists on the "other
> side", we know that all of these "missing" objects that are
> referenced by the commit are also available from the "other side".
> IOW, I suspect that the same principle "shallow" uses to give us the
> integrity guarantee can be naturally extended to allow us to see if
> a broken connectivity is OK.

If we are deeply worried about this kind of broken connectivity, there
is another case to care about: the server can "promise" to serve
requests for some object (e.g., the tree pointed to by the server's
"master") and then decide it does not want to fulfill that promise
(e.g., that tree pointed to private key material and "master" was
rewound to avoid it).  In the promises model, how we do we get a fresh
understanding of what the server wants to promise now?

Earlier in this discussion of fsck, I thought you were proposing a
slightly different idea.  The idea I heard is that you want to check
connectivity for whatever you have built locally, while accepting a
relaxed guarantee for objects from upstream.  If an object is missing,
the idea would be that at least this way you know whose fault it is.
:)  (Not that there's much to do with that knowledge.)  Implementing
that by treating everything reachable from a remote-tracking branch as
"from upstream" seems natural.  But that implementation suffers from
the same problems: not all objects from upstream need be reachable
from a remote-tracking branch (e.g. after a fetch-by-object-id, or
because a remote branch can be rewound).

Both variants proposed of the promises idea also hold some promise,
but my understanding was that the cost of maintaining the promises
file (getting data to fill it, locking on update, merging in new
objects into it on update), for little benefit wasn't palatable to
Microsoft, who has been coping fine without such a file.

Jonathan
