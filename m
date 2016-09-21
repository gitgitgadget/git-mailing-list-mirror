Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273511F935
	for <e@80x24.org>; Wed, 21 Sep 2016 14:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933581AbcIUOqt (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 10:46:49 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57718 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933564AbcIUOqs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Sep 2016 10:46:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BDCBE207AB;
        Wed, 21 Sep 2016 10:46:46 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 21 Sep 2016 10:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=6Zl6EEb6jJ/E/wB4UE9/EAuBhjs=; b=e7TFA2
        BNdUx3Wi1pksTZW/9AkKgsxDdWibH3hXm5JqCFQyS/RFCMF+ota5FO2GckqnXrzo
        1MMScWLYvbAE2GN7QDVN2qo29Pf2hZD/clDS4JF+lYwejlco3UonLU/6fZ+FGPvn
        BG+xsoP5E2YfRRdyJyLnTkKfZa+ozwVo/daow=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=6Zl6EEb6jJ/E/wB
        4UE9/EAuBhjs=; b=tBxxi0PtE7vd9xdinSEWM+oj/Poy0Anbz+tI7pGKVOBjtYb
        ectCsM9LKsbekC6EfOZbMQJMgTpZS21K+26d/SFhB4US1XteMoVEFwR5LJEJKzyu
        RFw1tusTXJt79xhPk1DTIEWarn8SoGt7cO107GxBGqd05vr+v+Mp5wlwfy0E=
X-Sasl-enc: aoT8E9yidiM3ELkwCNgc5Tt7/ssx0vTgeoc3E1YLPRAt 1474469206
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2982EF29CF;
        Wed, 21 Sep 2016 10:46:46 -0400 (EDT)
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
To:     Junio C Hamano <gitster@pobox.com>
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
 <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
 <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <affca640-4ed8-268a-9f7d-e2c7ce6d66fc@drmicha.warpmail.net>
Date:   Wed, 21 Sep 2016 16:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 19.09.2016 18:12:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> It can be read that
>>>
>>> $ git cherry-pick maint next
>>>
>>> would pick two single commits, while
>>>
>>> $ git cherry-pick maint next ^master
>>>
>>> could implicitly be read as
>>>
>>> $ git cherry-pick maint next --do-walk ^master
> 
> You can read it as "master..next maint" that does force walking.
> 
>>> Clearly that's not what is intended, which is
>>>
>>> $ git cherry-pick --do-walk maint next ^master
> 
> I do not see the distinction betwee the above two you seem to be
> trying to make.  Care to explain?

I think you answered to e-mail (in-reply-to) and to Philip's actual text
(quotes), but just in case:

[git]✓ git rev-list --no-walk ^HEAD~3 HEAD
47d74601f5c6bbef215a887be2ca877e34391c9f
574dece7b651fbae385add51d7aaea1cc414007a
3fbbf6e9e40b151215cce6c6e25cd4db0232d870
[git]✓ git rev-list ^HEAD~3 --no-walk HEAD
47d74601f5c6bbef215a887be2ca877e34391c9f

The order of revision arguments and options does play role (but where I
put my HEAD does not, uhm), i.e. walk-options vs. negative refs.

The reason is that negative revs come with an implicit --do-walk (we
need to walk to mark uninteresting revs), and the last
--do-walk/--no-walk wins. That's what I meant with my comment.

But there is only one walk (or none), and one setting effective for all
revision arguments.

Michael
