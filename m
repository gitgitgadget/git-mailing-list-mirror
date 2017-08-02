Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6234920899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdHBWNj (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:13:39 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35333 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdHBWNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:13:38 -0400
Received: by mail-pg0-f66.google.com with SMTP id l64so7686950pge.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgLEtirztWgcls64iyoaUHcZpBBwZnHp/iy8S9hA+T8=;
        b=ZUORh8PBz/OIBqFGup+kEWYlyEWcxuZRYQrS9f8cS+g4dyma8YFfMYTowXB0nrAYnF
         htAlfaXRsmE+jeG5JYxt+l0zzBPkyGd/Pze4pRgn0yQ9dU1GM6VJ8jr/NtwZ/TK1kuYh
         i2wAzEIxqmBXkbOpKiNWwlWZQj71SmGD9GeOUeU7BwV1If4m2Np0AlWADbpP7pTcrkTn
         F/QA/nGnHP4ux6RB5duDHIiQbamM7c5JrA/mytG875PSXYwPz9Tlbvyz0/YkchUUMKXs
         F0EcgKFU+0/PtMOpE1UyzJFNWuRlPqywE5edb79ZtRY/C4bfAeAdJJD+I+HNLYn94owM
         7HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgLEtirztWgcls64iyoaUHcZpBBwZnHp/iy8S9hA+T8=;
        b=gZbTt08+2LI/RJ/l366yvsEOz3Ab9490zzwmbHOpOuSv4RoMqW6Q7QHcLZBrBeNUBF
         FvjOdzJOP7jZ1T5mNrwhN4AFXWW0QOG1/JIK2cCRFKLFjUuKMRkDqylGmq7BXHam6FCI
         qaSkDM6WGHWEGel1L0yw6vLBzbKmR8Pn/OBOPeSpxoRXNwPmNjYRJdTxFxMDJqtaRcQS
         ZEACQj1/IVUzZUtd62UuZmnTwZQJ9Ax2MxDCNYTuaB8eT6jaZijwS6+zQ76TkFS9VUK3
         oD+elQUAWDURBUx1z2zAP5Q8kj2zeq2xl9Odyfi7VaUPc4DB8iRXV7Xd5Hk3jNPcF3hV
         fRnA==
X-Gm-Message-State: AIVw112Gknql8LljN8uBHkXt80LfISXkPZJV0KMJPx8IiEannlipqdYS
        DNyxNZwYjnTIjg==
X-Received: by 10.84.211.111 with SMTP id b102mr26850432pli.439.1501712017409;
        Wed, 02 Aug 2017 15:13:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:edc3:2705:cd6c:d8b2])
        by smtp.gmail.com with ESMTPSA id n16sm53612225pgc.84.2017.08.02.15.13.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 15:13:36 -0700 (PDT)
Date:   Wed, 2 Aug 2017 15:13:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual
 invocation of loader
Message-ID: <20170802221334.GV13924@aiede.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
 <cover.1501532294.git.jonathantanmy@google.com>
 <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
 <20170731160533.0a446244@twelve2.svl.corp.google.com>
 <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
 <20170801171944.7690a63f@twelve2.svl.corp.google.com>
 <xmqqefsudjqk.fsf@gitster.mtv.corp.google.com>
 <20170802173857.GU13924@aiede.mtv.corp.google.com>
 <xmqq8tj1snfq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tj1snfq.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Can you spell this out more?  To be clear, are you speaking as a
>> reviewer or as the project maintainer?  In other words, if other
>> reviewers are able to settle on a design that involves a relaxed
>> guarantee for fsck in this mode that they can agree on, does this
>> represent a veto meaning the patch can still not go through?
>
> Consider it a veto over punting without making sure that we can
> later come up with a solution to give such a guarantee.  I am not
> getting a feeling that "other reviewers" are even seeking a "relaxed
> guarantee"---all I've seen in the thread is to give up any guarantee
> and to hope for the best.

Thank you.  That makes sense.

In my defense, one reason I had for being okay with dropping the
connectivity check in the "lazy object" setup (at a higher level than
this patch currently does it, to avoid wasted work) is that this patch
series does not include the required components to do it more properly
and previous discussions on list had pointed to some of those
components that will arrive later (the "object size cache", which
doubles as an incomplete list of promises).  But that doesn't put the
project in a good position because it isn't an explicitly spelled out
plan.

The set of other reviewers that I was hoping will weigh in at some
point is the GVFS team at Microsoft.

I'll write up a summary of the ideas discussed so far to try to get
this unblocked.

Sincerely,
Jonathan
