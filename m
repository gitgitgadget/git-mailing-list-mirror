Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0356EC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiDHSVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiDHSVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 14:21:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE01A590E
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:19:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1DF718C5CC;
        Fri,  8 Apr 2022 14:19:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bazzM42nRYcz5l4LssGkod6XxDEbRxjI6f8w4P
        QxJiQ=; b=HVCYOalQ8auHja9OqmiwIkNp3nfiSkK7DSxgvYy/IPiyjwmX762svD
        /IeUNpifJs8Pl+8ug1iE2qt695/tqhQ9IENWA3IANPrNgb1jSQfegPUhJ2likW31
        3vkOAze6dpOeq3C1NdoZPrsoBsrylx76mjmJEMYsRvgOVPk08OXLU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9C8C18C5CB;
        Fri,  8 Apr 2022 14:19:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4DB3E18C5CA;
        Fri,  8 Apr 2022 14:19:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     git@vger.kernel.org
Subject: Re: git log --since to not stop after first old commit?
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu> <xmqq1qygy9nd.fsf@gitster.g>
        <Yk8Gvf/fjVca9hDB@vmiklos.hu> <xmqqv8vkpara.fsf@gitster.g>
Date:   Fri, 08 Apr 2022 11:19:03 -0700
In-Reply-To: <xmqqv8vkpara.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        07 Apr 2022 19:30:33 -0700")
Message-ID: <xmqqtub3moa0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F339BA0-B768-11EC-881B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Miklos Vajna <vmiklos@vmiklos.hu> writes:
>
>> On Fri, Apr 01, 2022 at 10:51:34AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>>> We could add a --since-as-filter= option or something, but then the
>>> user needs to be careful when to stop (and digging down to the root
>>> of the history, i.e. "never stop", may be an acceptable answer to
>>> some projects).
>>
>> I sent a patch to add such an option (which picks the "never stop"
>> behavior) on 1st, did you see that?
>>
>> If the idea is OK in principle, but the patch needs tweaking, please let
>> me know.
>
> As a single-shot change, "--since-as-filter" is certainly an easy to
> explain approach of least resistance.
>
> But when viewed from a higher level as a general design problem, I
> am unsure if it is a good direction to go in.
>
> Giving "--since" the "as-filter" variant sets a precedent, and
> closes the door for a better UI that we can extend more generally
> without having to add "--X-as-filter" for each and every conceivable
> "--X" that is a traversal stopper into a filtering kind.

If we pursue the possibility further, perhaps we may realize that
there isn't much room for us to add too many "traversal stoppers" in
the future, in which case giving "as-filter" to a very limited few
traversal stoppers may not be too bad.  I just do not think we have
explored that enough to decide that "--since-as-filter" is a good UI
(and it is not a good timing for me to spend brain cycles on the
issue).

Thanks.

