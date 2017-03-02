Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9FA2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 04:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbdCBEy4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 23:54:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56890 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752238AbdCBEy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 23:54:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07EA37A4EB;
        Wed,  1 Mar 2017 23:38:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SjhX4vCmDZBtXVL13EJSNcQqTQk=; b=i9ujuo
        RyFbhKEYd+aDU3pcZLC8YY6TT7tcA8rreSQs7gyESBtkpY/dZF4UADAswooOZT3n
        N0OOnDltyCxWrEYpvXNRas/pECuDqZOTjWpb6Iz8TV1bpvOhjJ30d56bRBu06CCi
        OCvgSvGse1RD04wqNZ0g4iqblph7fH7XhMkeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BIAt0l0JRlhITn2VKfFIuuY8+65/Rws4
        nSQbMqPPpPcFnSfcZPSSyPsq5OMiEAuo1Tiws5q8E6BvsVfk6TNA1GvOzItygTH9
        z969M35o08TXUfuLaVwnTS61x5PzMiQ8+D0qjAi0930fydpB6toO11+/Mwa74toE
        GXhJRRM+tsI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F40027A4EA;
        Wed,  1 Mar 2017 23:38:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A5B77A4E9;
        Wed,  1 Mar 2017 23:38:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Shumow <danshu@microsoft.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc.stevens@cwi.nl>
Subject: Re: [PATCH] Put sha1dc on a diet
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
        <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
        <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
        <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
        <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
        <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
        <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
        <CY1PR0301MB21073D82F4A6AB0DAD8BF1FCC4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
Date:   Wed, 01 Mar 2017 20:38:04 -0800
In-Reply-To: <CY1PR0301MB21073D82F4A6AB0DAD8BF1FCC4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
        (Dan Shumow's message of "Thu, 2 Mar 2017 01:31:17 +0000")
Message-ID: <xmqq1suge1jn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 070A4A06-FF02-11E6-B012-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Shumow <danshu@microsoft.com> writes:

> At this point, I would suggest that I take the C optimizations,
> clean them up and fold them in with the diet changes Linus has
> suggested.  The slowdown is still 2x over block-sha1 and more over
> OpenSSL.  But it is better than nothing.  And then if there is
> interest Marc and I can investigate other processor specific
> optimizations like ASM or SIMD and circle back with those
> performance optimizations at a later date.
>
> Also, to Johannes Schindelin's point:
>> My concern is about that unexpected turn "oh, let's just switch
>> to C99 because, well, because my compiler canehandle it, and
>> everybody else should just switch tn a modern compiler". That
>> really sounded careless.
>
> While it will probably be a pain, if it is a requirement, we can
> modify the code to move away from any c99 specific stuff we have
> in here, if it makes adopting the code more palatable for Git.

I was assuming that we would treat your code just like how we treat
any other "borrowed code from elsewhere".  The usual way for us to
do so is to take code that was released by the "upstream" (under a
license that allows us to use it---yours is MIT, which does) in the
style and language of upstream's choice, and then we in the Git
development community takes responsiblity for massaging the code to
match our style, for trimming what we won't use and for doing any
other customization to fit our needs.

As you and Marc seemed to be still working on speeding up, such a
customization work to fully adjust your code to our codebase was
premature, so I tentatively queued what we saw on the list as-is on
our 'pu' branch so that people can have a reference point.  Which
unfortunately solicited a premature reaction by Johannes.  Please do
not worry too much about the comment.

But if you are willing to help us by getting involved in the
"customization" part, too, that would be a very welcome news to us.
In that case, "welcome to the Git development community" ;-)

So,... from my point of view, we are OK either way.  It is OK if you
are a third-party upstream that is not particularly interested in
Git project's specific requirement.  We surely would be happier if
you and Marc, the upstream authors of the code in question, also act
as participants in the Git development community.

Either way, thanks for your great help.
