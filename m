Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F274E1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 14:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934796AbcIUOvg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 10:51:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48568 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934018AbcIUOvf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Sep 2016 10:51:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 281E5207FF;
        Wed, 21 Sep 2016 10:51:34 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 21 Sep 2016 10:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=qPn4X9CbUpgZtGo8l/ccoKidJYU=; b=Av2qDR
        QDnl5fwNh2iJOyd1tTlp9jgYcZ1i2qPodnNoXD8Dwnmu12BJRw7VdtlMUgz6wbYM
        4qznsRYySRrrVoUPRQKPUcrOz3oz9LGZ28kjfnRz+Kcf5kP9N9EZsej7jBXvS6af
        pHOHeuwRqfoj25BSwry5QJqr5fZnGLZaO/iNk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qPn4X9CbUpgZtGo
        8l/ccoKidJYU=; b=Bk1uQ0LBxHK0yzNzmt+RLSXTDDE2/YR6WAR/oALuBU6y1Gh
        rWEt7Nkt8nuEWFVLDrRw+7hjoUowy1lMKXO/NE89lfwlRDkrWe31tIXDUM3ZEqo+
        6eGfl7pDEjJMrgoMWHKG+S+IU/Xgw3NaOJq1g5BZUiUhoFuERqvtkA6Dnfjs=
X-Sasl-enc: RGq1jqV30TLgQgPPeffRNB1VjVER7mUI0fCrkRirGskX 1474469493
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D395CCE90;
        Wed, 21 Sep 2016 10:51:33 -0400 (EDT)
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
To:     Junio C Hamano <gitster@pobox.com>
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
 <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
 <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>
 <affca640-4ed8-268a-9f7d-e2c7ce6d66fc@drmicha.warpmail.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <65a10cb3-ede9-a107-9d7d-ee4b5250949e@drmicha.warpmail.net>
Date:   Wed, 21 Sep 2016 16:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <affca640-4ed8-268a-9f7d-e2c7ce6d66fc@drmicha.warpmail.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[So many typos, sorry]

Michael J Gruber venit, vidit, dixit 21.09.2016 16:46:
> Junio C Hamano venit, vidit, dixit 19.09.2016 18:12:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>>> It can be read that
>>>>
>>>> $ git cherry-pick maint next
>>>>
>>>> would pick two single commits, while
>>>>
>>>> $ git cherry-pick maint next ^master
>>>>
>>>> could implicitly be read as
>>>>
>>>> $ git cherry-pick maint next --do-walk ^master
>>
>> You can read it as "master..next maint" that does force walking.
>>
>>>> Clearly that's not what is intended, which is
>>>>
>>>> $ git cherry-pick --do-walk maint next ^master
>>
>> I do not see the distinction betwee the above two you seem to be
>> trying to make.  Care to explain?
> 
> I think you answered to e-mail (in-reply-to) and to Philip's actual text
> (quotes), but just in case:

"my e-mail"

> 
> [git]✓ git rev-list --no-walk ^HEAD~3 HEAD
> 47d74601f5c6bbef215a887be2ca877e34391c9f
> 574dece7b651fbae385add51d7aaea1cc414007a
> 3fbbf6e9e40b151215cce6c6e25cd4db0232d870
> [git]✓ git rev-list ^HEAD~3 --no-walk HEAD
> 47d74601f5c6bbef215a887be2ca877e34391c9f
> 
> The order of revision arguments and options does play role (but where I
> put my HEAD does not, uhm), i.e. walk-options vs. negative refs.

"play a role"
"negative revs"

> 
> The reason is that negative revs come with an implicit --do-walk (we
> need to walk to mark uninteresting revs), and the last

"in order to mark"

> --do-walk/--no-walk wins. That's what I meant with my comment.
> 
> But there is only one walk (or none), and one setting effective for all
> revision arguments.
> 
> Michael
> 

