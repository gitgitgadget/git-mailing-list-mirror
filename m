Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8DC202FC
	for <e@80x24.org>; Mon, 23 Oct 2017 06:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdJWG0O (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 02:26:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51064 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751083AbdJWG0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 02:26:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57C4DAE585;
        Mon, 23 Oct 2017 02:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VcZOXQNa2HI+UY+aM2KzdiQU0SE=; b=au3+sm
        Uaz02bWf5pMUcP3sTQYzNom8dL9Jw5FT2ljMSsrt2eLawpVHfzkdEtuoin805qgO
        C6kiLseuxDJgWPj4LfYYoPU40i2Yz2L9uHRtmtN8nbvS6iGT892OS+cPE0XCeFh9
        knDBwzsYwI4a5NyMDUBdDTaEvgD62yFSZfKkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jqfU8+9KQ9wT0MTXKf2sx86Js1SRHKNA
        R1BCaJJh7SOQakN+Lp1d32aJjHev4/dkgEVDSm7Qywl+hQnQDPq9Vqak9JWo+4B0
        3aUQhNNTO5OxHzYnRs059QeadJga7x/XLJKgBKXbcPoPvhCxfarGuRIdjPNmcNsK
        YOd+r8GG4Ic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FD6DAE583;
        Mon, 23 Oct 2017 02:26:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B129AE582;
        Mon, 23 Oct 2017 02:26:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v3 0/3] deprecate git stash save
References: <20171019183304.26748-2-t.gummerer@gmail.com>
        <20171022170409.8565-1-t.gummerer@gmail.com>
        <xmqqwp3md5jp.fsf@gitster.mtv.corp.google.com>
        <20171023051850.vil3p5pmu3jb2a5y@sigill.intra.peff.net>
Date:   Mon, 23 Oct 2017 15:26:11 +0900
In-Reply-To: <20171023051850.vil3p5pmu3jb2a5y@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Oct 2017 01:18:51 -0400")
Message-ID: <xmqqh8uqbcsc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10CA0258-B7BB-11E7-BBDD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 23, 2017 at 10:19:38AM +0900, Junio C Hamano wrote:
>
>> > -	This option is deprecated in favour of 'git stash push'.
>> > +	This option is deprecated in favour of 'git stash push'.  It
>> > +	differs from "stash push" in that it cannot take pathspecs,
>> > +	and any non-option arguments form the message.
>> 
>> Every time I saw this line, I misread s/form/from/ and got
>> confused.
>
> We could reverse the order:
>
>    ...and the message is taken from any non-option arguments.

Yeah, that makes it slightly less confusing.  Or "any non-option
arguments become the message", perhaps?  I dunno.

Let's queue the version as posted; perhaps somebody new comes and
says it is confusing in three months, at which time we may be able
to come up with a better phrasing with a fresh mind ;-)

