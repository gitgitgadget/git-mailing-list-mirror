Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D0720756
	for <e@80x24.org>; Fri, 20 Jan 2017 18:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbdATSb7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 13:31:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50035 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753180AbdATSb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 13:31:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6D565F762;
        Fri, 20 Jan 2017 13:28:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vumt4uQePD++38x7pEvfSRDH70Q=; b=b/w/fp
        RFYGtxoloS/A6zR45f5pkcPNDSkdCE2HXtvX6eT/oAxVjfipD/gMgMc+1n0XrZVY
        yLwVrlcQIQQfWtkfc+bopYp5RpHJEmp9+u1lowfN5X/GClqH0FWf51SMltUhJAN7
        yyhr++Hg93v+hXOwpxY/uB7O95w99dslbZWzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yNZzzANcDvljkc5hLxeHsKwVJbhKzFQx
        gbFjvjzFRV7CgdDSH61qV7SKXb9uHkkptLsPdMezVHUWt18NN8yYp60ywb9+7e8t
        jOxvVUuV12W0G3vSb/S5w971J+ZVIJDyLhg3Y/QfqepWnar7J9r8K2Pl8fV9MMHs
        QLbzwEwKVD8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F4195F761;
        Fri, 20 Jan 2017 13:28:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F26CC5F760;
        Fri, 20 Jan 2017 13:27:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with keyboard
References: <20170120102249.15572-1-pclouds@gmail.com>
        <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
Date:   Fri, 20 Jan 2017 10:27:58 -0800
In-Reply-To: <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 20 Jan 2017 11:09:43 -0500")
Message-ID: <xmqqh94ty4b5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BF93D42-DF3E-11E6-B539-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Not really a comment on your patch itself, but I think a lot of people
> solve this at a higher level, either in their terminal or via a tool
> like tmux.
>
> I recently taught urxvt to recognize sha1s and grab them via keyboard
> hints, and I'm finding it quite useful. Here's what it looks like if
> you're interested:
>
>   http://peff.net/git-hints.gif

Nice.  I would have called the "give me the string that is already
on the screen" solution solving at a lower level, not higher, but I
think I agree with the general direction.  I always work in "screen"
and grab a string I see displayed by going into its "copy" mode,
which lets me jump to where the string appears by searching, and I
think that is a solution in the same class.

>   2. It doesn't take any screen space until you're ready to select.

Yup, personally I find this quite important (as I am often on a box
with a smaller screen).

I dream an integration with the command line completion we have.  I
do not offhand see what the mecanism to tell what object names were
shown on the display recently to the completion mechanism should be,
but if we can solve that small detail, the result would be wonderful
;-)

