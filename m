Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E946B2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 23:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbcKIXQv (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:16:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56770 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753402AbcKIXQv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:16:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D8534E7CB;
        Wed,  9 Nov 2016 18:16:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3IBdwxgnWcXS
        Kg7Oz3sSu4V3IjY=; b=ZhpIADCtJSN0OH9CmW5RV8co4mlaXOSJwi8w7ZW6ZSlp
        7N+yva0g6evTXUCWttljJ6YEa3J0m7jncri1zV5UdqWqdqs5kfB1P9YtfTWCTEcN
        1kBEs1KE3+bpwRPtdEG6Xsqjf9nqMMdwDpIMkXrZAl3emUl4neRMxNIR1qjS9gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=U0VOLE
        TkB7afdYcQCDSgN1ksx2BGUQyIJNgX4Q9DMCAvpLeMT+4ggFYH60HTHn6L+v/sLG
        qt7he6QBUxE9QCKbnNWISAVTPzJ4N5S/WIw23KZlQqQ88a3+yka38TkPNcqQ1NkK
        p1xTaSOoVFPy7BsrGHhP3a3n9WyzIr8tZd1ms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04EA04E7CA;
        Wed,  9 Nov 2016 18:16:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 738794E7C7;
        Wed,  9 Nov 2016 18:16:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5 01/16] Git.pm: add subroutines for commenting lines
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
        <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161108120823.11204-2-vascomalmeida@sapo.pt>
        <xmqqshr19oxp.fsf@gitster.mtv.corp.google.com>
        <1478710943.28771.4.camel@sapo.pt>
        <b01d0d90-f87c-f708-5d2a-79f6268b4f44@gmail.com>
Date:   Wed, 09 Nov 2016 15:16:48 -0800
In-Reply-To: <b01d0d90-f87c-f708-5d2a-79f6268b4f44@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 9 Nov 2016 23:25:23 +0100")
Message-ID: <xmqqa8d88crj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97685602-A6D2-11E6-81D2-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> I prefer to have like this instead
>>=20
>> sub prefix_lines {
>>         my $prefix =3D shift;
>>         my $string =3D join("\n", @_);
>>         $string =3D~ s/^/$prefix/mg;
>>         return $string;
>> }
>>=20
>> So both subroutines can take several strings as arguments.
>
> I like the interface, but the implementation looks a bit inefficient.
> Why not simply:
> ...
> If those strings can contain embedded newlines (so that they can be
> called as in Junio example), then your solution is a must-be
>
>   sub prefix_lines {
>           my $prefix =3D shift;
>           my $string =3D join("\n", @_);
>           $string =3D~ s/^/$prefix/mg;
>           return $string;
>   }
>
> Well, nevermind then

OK, so in short, is that a "Reviewed-by:" from you ;-)?

I agree with the conclusion.  Thanks for a review.

