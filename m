Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9638C4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D9324842
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YnKqYWit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgJ1VeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:34:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56427 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgJ1VeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D543773271;
        Wed, 28 Oct 2020 15:14:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cJf+zM9wkXdIizDhbHTSE3QgbLk=; b=YnKqYW
        itUfqQk2d/DOAts+ZMUu4owkPjvZniKOuKJRSbb2vj1509y7jD8sSRw7+Oz/Qs2C
        52pCagXXKgt/BbJxF/u3q+V/JoK7ENCqSmLKduY/jI6Zo3YkHhkNG6lPE5DZdqKb
        ag3jFgh00Z+C8Dy0Z7LlbzIGgQeuIK+DAf8wI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qUtXbQd+RYr6GN1vpog4qwhUIzcUxNTG
        2WQTB1CX2HUiACw1dweR1oIZdkNr/3POyhNcNdeK+YXKmzgN4qlMvJG2aR/OhBaP
        QycdTJvRsobfEg8Ok9tLStZz4A3mg2KthGsqrDSIks3R3xtRIqO6YFIlecaGxkVI
        odG+46gJrxw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBFB27326F;
        Wed, 28 Oct 2020 15:14:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A7837326C;
        Wed, 28 Oct 2020 15:14:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] documentation symlink restrictions for .git* files
References: <20201005071751.GA2290770@coredump.intra.peff.net>
        <20201005121609.GA2907272@coredump.intra.peff.net>
        <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
        <20201023081711.GB4012156@coredump.intra.peff.net>
        <8bb54778-507c-2e3f-d35a-5e32edb8bee7@iee.email>
        <20201026225300.GA23128@coredump.intra.peff.net>
        <xmqqo8kod0ms.fsf@gitster.c.googlers.com>
        <20201027072648.GG3005508@coredump.intra.peff.net>
        <xmqqk0vbcxtb.fsf@gitster.c.googlers.com>
        <21e4bac1-b3ef-e28f-586d-fe17baf6b15e@iee.email>
Date:   Wed, 28 Oct 2020 12:14:16 -0700
In-Reply-To: <21e4bac1-b3ef-e28f-586d-fe17baf6b15e@iee.email> (Philip Oakley's
        message of "Tue, 27 Oct 2020 21:00:53 +0000")
Message-ID: <xmqqimau9n93.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C63CE09C-1951-11EB-ADED-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 27/10/2020 18:45, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>>>  DESCRIPTION
>>>>  -----------
>>>>  
>>>> -A `gitattributes` file is a simple text file that gives
>>>> -`attributes` to pathnames.
>>>> +A `gitattributes` file is a simple text file (it cannot be a
>>>> +symbolic link to anything) that gives `attributes` to pathnames.
>>> I worried that even a short mention like this would be distracting. Not
>>> because it's so long, but because it's right there in the very first
>>> sentence, and I really think this is a corner case that most people
>>> would not even think about.
>>>
>>> So it is helpful if you are looking for info on symlinks and these
>>> files, but probably clutter if you are looking for something else.
>>>
>>> I have to admit I don't feel all that strongly either way, though.
>> I don't, either, and as I said, I found that the placement of new
>> text was OK.
>>
>>
> I do think that the extra text above is the right thing to do.
>
> We should be informing readers early about things that are expressly
> prohibited.

It needs to be balanced, though.  If it is so common a temptation
among readers to make a symbolic link out of the tracked contents,
perhaps it is worth telling them that they shouldn't do so, but I
just do not get the feeling that it is the case.

