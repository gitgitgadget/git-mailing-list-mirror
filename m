Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A766820958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdCWTa7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:30:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50213 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdCWTa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:30:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC22E6710D;
        Thu, 23 Mar 2017 15:30:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6QZxoTWao8baqoRAYQZd77juzOc=; b=RzXMNR
        /Coq/teqMuVeVZppH0OrAiyV5BSzI9mu/08HqH9VmrYbn5Nc+xLNyi0+JO11+pYE
        ptTGbGFCcRV7XIt/k+kzWu5U6gO6E3JaylbjzsSeFQ2Zg7SpYAoQOll0DjTjVCqL
        x0C2kg+z0BDaprE63WOd74SigxClZ0zidXOyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p93sQW9Q/l6VTbl4NtU16kHe/y80NolP
        0PX6WypGz2Pkqg0FjE2qP3IHRnau0w3D83v6UyxH9FwnCl8tzvX3sqXmhJtdYv+w
        y3ws/aVRriJQSJlbCxzcYYecG9sQTbRdgVEqxidNEqXwb6kEXatFRivYRRkDtnsa
        yVulU8rsVcM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D52C76710A;
        Thu, 23 Mar 2017 15:30:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45F6467105;
        Thu, 23 Mar 2017 15:30:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
References: <20170322065612.18797-1-larsxschneider@gmail.com>
        <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703231716320.3767@virtualbox>
        <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
        <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
        <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
        <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
Date:   Thu, 23 Mar 2017 12:30:49 -0700
In-Reply-To: <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com> (Lars
        Schneider's message of "Thu, 23 Mar 2017 20:26:15 +0100")
Message-ID: <xmqqzigbbxjq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3972E6B6-0FFF-11E7-B08D-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> "[...] we do not provide these values to untrusted builds, 
> triggered by pull requests from another repository."
>
> See: https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-in-Repository-Settings

OK, it is a releaf to see an indication that somebody over there is
thinking.  Thanks.

So we do _not_ have to turn it off; as soon as we define sekrit
variables, they will turn it off for us ;-).

>> Hrm, it does mean that people have no way to test on Windows until the
>> branch hits pu. Which is not ideal.
>
> I agree it's not ideal. But I think it is an improvement to check
> pu/next/master/maint continuously :-)

I am not sure what you mean.  We are building each and every branch
updates already, and I do not see any improvement over what we are
doing now.  Care to elaborate?
