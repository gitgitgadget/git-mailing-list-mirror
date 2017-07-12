Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC9520357
	for <e@80x24.org>; Wed, 12 Jul 2017 21:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdGLVdq (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:33:46 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35369 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbdGLVdn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:33:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so4414086pgc.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7EsAj8vOXbAlsf5UHyAr6yRl0jkiwo4vSz1/ye2iqMk=;
        b=ggrWLiSDyDB9k5maNfdqEwnhtXChzHGovcXdv2/W9iWO/gm7Za0iYT2/g9V6DJKMeB
         8i1wyQQSZODvKiv7aycsvBf16pXihbm1s3XkVmLcbRJmMnhqBm1hurVkGMTO+HhyFNGx
         jHgwIZ32iix7GnWCxIwfQbS41JC02BfdqmhGoj8Cq/rIDKOuZWVSXBvziTCWxzraadFo
         EE7Gy1SBB4QOUFbOspZw0vjnnkUe/XMO5zSg6k00iNKGIdXpcaYYsP5cniolCbMzdx1g
         JCfJTQKdlB4wwb3YhxuS0n765TlHe6miE7sbUmajdYikgUiZMtZP7LiIicRTeyygnZj8
         ORWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EsAj8vOXbAlsf5UHyAr6yRl0jkiwo4vSz1/ye2iqMk=;
        b=Vn1MhinOMrIOd7ScwQE4azbskCeCYiEANmVyzw87SThHbu5AqAlGb82jPq+UL1ObGD
         B3aekQJODUN1ESBWCnWF5kOszWtaNhI4E2wrYFR66tDlCtTX2tdGCUKRuox9v8u4kl4Y
         cZNpDI4PwsOt2bBIA2X9VxV6RAfyxHTCy1cd81Fig6Knfx1wonQ44dOUQVyQ0Z7kYojM
         6D0JQsnEdHnBJXVek4I9A1EAkBTASnWgY27PLzvaAcOvVHnL4oCRYhPuK10tO55/pDWm
         gvFro9om+u2bgUV14AGYWktN9zyl5gD9eAmMN8zXU6ls6rPEGjR/pimUGovKqSGpcCU4
         HZLQ==
X-Gm-Message-State: AIVw113+5DKnRH3/Ht+qG7uuKBuGs8WwphdxNOIc5H+bJEKWLNtpR/K9
        Y8umN4YCXb9mzA==
X-Received: by 10.84.131.74 with SMTP id 68mr6316662pld.8.1499895222813;
        Wed, 12 Jul 2017 14:33:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:25ad:9264:1cd0:bb62])
        by smtp.gmail.com with ESMTPSA id 10sm7822013pfj.61.2017.07.12.14.33.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:33:41 -0700 (PDT)
Date:   Wed, 12 Jul 2017 14:33:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
Message-ID: <20170712213339.GI93855@aiede.mtv.corp.google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-3-bmwill@google.com>
 <xmqqzica1pli.fsf@gitster.mtv.corp.google.com>
 <20170712180143.GD65927@google.com>
 <xmqqmv891jct.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv891jct.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:

>> Since it is a pointer then using a '#define' to replace 'the_index'
>> (which is not a pointer) would be a little more challenging.
>
> The above is merely realizing another downside that stems from the
> earlier design decision that the index field is not a real embedded
> structure, but is a pointer.  It does not explain why it is better
> to have a pointer to an allocated structure in the first place.
>
> I am not (yet) telling you to fix the design to have a pointer
> "index" by replacing it with an embedded structure.  I may actually
> do so later, but I am first trying to find out if it is a right
> design decision with some advantage.

Consider a command that doesn't need to access the index at all (e.g.,
"git grep --recurse-submodules -e foo HEAD").

In favor of using an embedding instead of a pointer, there is the
advantage that it makes initialization simpler.  (It also involves a
tiny speedup by avoiding a pointer indirection on access, but that's
more negligible.)  For that reason it was a good choice when there was
only one repository in memory: using such a small bounded portion of
.bss space in exchange for some convenience is a good trade.

When a process has multiple repositories in memory (for example one
per thread), the trade-off becomes different.  Instead of .bss, the
unused embedded index is on the stack or heap.  Using embedding would
mean that instead of an unused extra word in the per-repository
structure we get an unused ~24 words.

An argument could be made that we wouldn't want to waste either 1 word
or 24 words per in-memory repository object --- we'd want to waste 0
words and separately keep a map from repositories to index_state that
only gets populated when needed.  That complicates index access a bit
too much for my taste.  1 word instead of 0 or 24 seems like a
sensible compromise.

All that said, I don't have a strong opinion on this.  Both the 1-word
approach (a pointer) and 24-word approach (embedding) are tolerable
and there are reasons to prefer each.

Thanks,
Jonathan
