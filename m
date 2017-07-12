Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1476C1F661
	for <e@80x24.org>; Wed, 12 Jul 2017 20:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbdGLUia (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 16:38:30 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34362 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbdGLUi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 16:38:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so4256858pge.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lEm0OIn6jdPHmVOBoUp9HoeXK5trw6SflTyx8TkNpK4=;
        b=DK2Q2Vh/XY8gDb6M4y79/7VE0VMlDOWG7d/g9lO2WNl6ro7TiwZ8NkuuIJfIkCXisK
         nG31iF/z235qHsYiueLflx7CtWv28BVVQyMZ5kyVt4hpzA5jtSjmBQU+8vPShwJRRMrP
         4uY26VbSZoVciewi41qOrlmIgV6i3ZER7GoeLcyoJQ3sZ36VpFWng/0e6VHuhiCivhAp
         PqV4L3P6TyE/p7Vj4MC/q6By+5/bfjchW4SXfkIfBmgTWqpZioZ7WjYUVLWWQOImER8F
         CN8Nqn46Yr7EDuvsUOTDKZu/8QMhWExQaqQLqIxz4RpW4xv0KfHhn9UfzGL+5ldoSH/c
         40Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lEm0OIn6jdPHmVOBoUp9HoeXK5trw6SflTyx8TkNpK4=;
        b=mN8UzyGGmVK9OrqajVlA81uYBYPSk4S1TETdM61Y73hdLFVlJDNyy9vWNasyAiDQfM
         HniijD3/+wA2MUBRyjdN72go/n8z36N/wyeC+kh7TeTbUBj0p111fA1extbYXjvvjnGJ
         Ebx2BpZReNjxHkb3ZcWOqflCrPqAktinRKnKpJ3Cm/eMyDPft4W/e6MtJhn2X2MvdcJy
         mK7bp5B5I3dLnsuqjQpsvlAsfinijFVPv+mv25N0AYTmebF0BKXd153lrLiwGRV1AFkp
         ysO15hMJKVBtSbzwwFxcW/YZEp1cXbp/+e6ecM57gOiI6HULAmKJGiBe5OYGbqXBMM04
         MQhA==
X-Gm-Message-State: AIVw111FusTy+y05eK0MAl8RFjTAGYlKvq2gZSPfgS8CAfLVkgM71zsx
        e2C1uEkPzyhbPA==
X-Received: by 10.101.83.138 with SMTP id x10mr5547007pgq.201.1499891908138;
        Wed, 12 Jul 2017 13:38:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id o8sm5993784pgn.52.2017.07.12.13.38.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 13:38:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
References: <20170711220408.173269-1-bmwill@google.com>
        <20170711220408.173269-3-bmwill@google.com>
        <xmqqzica1pli.fsf@gitster.mtv.corp.google.com>
        <20170712180143.GD65927@google.com>
Date:   Wed, 12 Jul 2017 13:38:26 -0700
In-Reply-To: <20170712180143.GD65927@google.com> (Brandon Williams's message
        of "Wed, 12 Jul 2017 11:01:43 -0700")
Message-ID: <xmqqmv891jct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> For all intents and purposes the index struct that is stored in 'struct
> repository' is an embedded instance, its just stored as a pointer
> instead of being a direct part of the struct itself.

The question really is this.  In order to realize the intents and
purposes to have an embeded instance, the most natural way to
implement it is to actually embed an instance.  There must be some
advantage of substituting that most natural implementation with a
pointer that needs to point at a separately allocated memory;
otherwise the implementation chosen is a poor imitation of the real
thing.  One downside of not actually embedding an instance is that
the code needs to do something different from what it has always
done to answer "is the index already populated?".  In the normal
codepath, it would look at istate.initialized but for the index
state that is emulatedly-embedded in the repository, it would also
have to see if the pointer is NULL.

And I do not see why a pointer to an allocated struct was chosen,
and what advantage we wanted to extract from that design decision.

> As far as
> submodules are concerned, thats why 'repo_read_index' exists since it
> will allocate the index struct if needed and then populate it with the
> index file associated with that repository.  So the 'struct repository'
> owns that instance of 'struct index_state'.

All of the above merely makes an excuse why you can work around the
fact that the index field is a pointer.  It does not say why it is
better not to embed the real thing at all.

> Since it is a pointer then using a '#define' to replace 'the_index'
> (which is not a pointer) would be a little more challenging.

The above is merely realizing another downside that stems from the
earlier design decision that the index field is not a real embedded
structure, but is a pointer.  It does not explain why it is better
to have a pointer to an allocated structure in the first place.

I am not (yet) telling you to fix the design to have a pointer
"index" by replacing it with an embedded structure.  I may actually
do so later, but I am first trying to find out if it is a right
design decision with some advantage.  If there is some advantage to
have it as a pointer to an allocated structure, then perhaps we may
even want to do the conversion the other way by declaring the_index
is always a pointer to an allocated structure that _could_ be NULL.
We can even lose the istate.initialized bit if we did so, as the way
to answer "is the index already populated?" in the new world order
would be to see if it is NULL.

But if there isn't any advantage, then I _would_ tell you that the
design to have it as a pointer in the repository structure _is_ a
mistake.  But I do not think I was given sufficient information to
decide it yet.

Thanks.
