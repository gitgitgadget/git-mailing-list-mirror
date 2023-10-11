Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C57ECDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjJKWvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJKWvw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:51:52 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51AA4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:51:50 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697064708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaqkSeCk2zZLvs7MzwaiBRyIx5wzfNSnt92j7qFnHfU=;
        b=fFu8pOS3/Kuoccs2AeTchA56nNC8BVemWaDe9LHxM79e92yJQEPzfkdKRj+nQir1q6OVXv
        uQCcnF17iMgfRPYBF2l8sjTO2smdioksZ6uMTid7d7Ic+bhKI4IJZDMkgVTcOYu2MhbOHB
        DshXQviIe4KYRUH9s3Iv928rOR/1y2Q/4yhhWP2Ft7psngM1nI4QtlMxw0ycDe58yQJZKS
        oKPsjeNOlBSQrBi8J6zOJJDnb2BIPf6aFVxgIZDpL/d+wvoKqXRtLROENuOLtD2jlzeeDa
        P0wUFAZ5LgJHO/Op0q0fH9gYJT297c9CUKisJxmFJAMHMJ4vrKB0fWwwy2UUjw==
Date:   Thu, 12 Oct 2023 00:51:48 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
Message-ID: <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-12 00:26, Christoph Anton Mitterer wrote:
> On Wed, 2023-10-11 at 15:23 -0700, Junio C Hamano wrote:
>> I think that was the reason we added it back in 2005.  In any case,
>> asking "why" is not a useful use of anybody's time, because it is
>> very unlikely to change in the official version we ship, and because
>> it is so easy for any individual who does not like it to drop by
>> exporting the $LESS environment variable.
> 
> Well the other commit I've mentioned kinda read as if it was thought
> that either X or both F and X were needed for the effect to exit less
> immediately if the output is too short ("F and X because
> sometimes the output Git pipes to less is short").

In general, not clearing the screen (i.e. "-X") is there so the 
displayed contents is still visible in the terminal after exiting the 
pager.  That wouldn't be the case if the screen was cleared, making it 
less usable for most users.

Exiting if less contents than one full screen was displayed (i.e. "-F") 
is there to save people from the frustration of quitting a pager that 
actually wasn't needed to be executed.

When it comes to "-R", it has to be there, otherwise no coloring of the 
paginated output could be possible.

> So I thought maybe that was intended, and the no-clear was just a side-
> effect no one ever really thought about.
> 
> 
> Anyway, thanks,
> Chris.
