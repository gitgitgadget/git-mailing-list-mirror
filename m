Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA9D20954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdLDVkQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:40:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57679 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752538AbdLDVkN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:40:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07DBCAF2ED;
        Mon,  4 Dec 2017 16:40:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q/Al9peHScYdEi+ebkhDSnuyeJo=; b=RWbsEL
        IXWxLT5MrGlEnrfmodBKlf15FocRB0KOBhUbs2gXU+qdMEet233O3dL5+HlNSqg4
        qNFtJJihVkQGvwveNWOE/oJMFi22+VN7TCkuDKiA3dLaQMt5DoeXZR1NkSf/19vd
        qkT2NrTWgZLEquCb1Wggq/Yq9HeAb+TRsezYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lDoLbG/wgiHOhuVnMpE/6ZTR4I8PIKux
        lRYcBu4yLWLWAvAaYN31JJZP46/6/CUGzXFPunZmiqOFZDbxZfvXvlce1g8Vz2T/
        lQS+bQQh6cXDuzZx7Mr/52cbQ9s3JWmeaF7jqaiREl2pmxsquP03qAAp0uCKwRSS
        94O0wUhzWUg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F245EAF2EC;
        Mon,  4 Dec 2017 16:40:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FF8DAF2EB;
        Mon,  4 Dec 2017 16:40:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
        <20171129143752.60553-3-lars.schneider@autodesk.com>
        <20171130205137.GC3313@sigill.intra.peff.net>
        <xmqqvahojssu.fsf@gitster.mtv.corp.google.com>
        <D3A5C7E6-A63C-431C-97B5-070632EE3540@gmail.com>
        <20171204173223.GF13332@sigill.intra.peff.net>
Date:   Mon, 04 Dec 2017 13:40:11 -0800
In-Reply-To: <20171204173223.GF13332@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Dec 2017 12:32:23 -0500")
Message-ID: <xmqqr2sakw90.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B538565E-D93B-11E7-BE9A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Dec 03, 2017 at 01:47:04PM +0100, Lars Schneider wrote:
>
>> I am on the fence here. I like consistency but I don't want to
>> bother Git users.
>> 
>> @Peff: Do you lean into either direction? Could you imagine that
>> novice/regular users are bothered? (I don't expect experts to be
>> bothered too much as they would likely be able to find and set 
>> the advice config).
>
> I also am on the fence, and am OK with any of the options discussed.
>
> But now I've said my reservations on the list, so I can say "I told you
> so" if people complain (and naturally refuse to admit my objections if
> people love it). :)

Heh.  I am even OK with not doing anything for that matter ;-)

