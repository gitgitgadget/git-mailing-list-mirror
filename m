Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B017620954
	for <e@80x24.org>; Tue, 28 Nov 2017 23:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbdK1XrE (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 18:47:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59470 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752054AbdK1XrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 18:47:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3E9EADE97;
        Tue, 28 Nov 2017 18:47:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n0c/tf8a0RZBVDruGZKosBbMu38=; b=m0rQYO
        bVuuMgSOnZy7VyUrsXw3hoOeotCvBMMM34nysrbslbhV6RuuyOCRImVhYw7MuDcr
        HjOJz7M2TIiho7sx7u4nxz4mazvOrMbpjAMvA0e0tQLHHX7VBX2GWClfsXFFetSl
        hQzn8V0QEm2yhwYlOhPT18i9Gul4GSFtjgUAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GBy849aUqwsjgpqOfK/l/CCAKT1/bMv2
        6kokv1/c2HaiuQLz5UevXzf1rp20J/CYIc6VtCE0JuU9eh9u3aJs+oi1/Wqk8w1U
        7c0OFxN7i6WohWLgRU3g4rKrqlFMpd3pddjT7r5zzf7BpFoyhgQEyUBuczqZr2OX
        V+UOu7aSaEw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA7DCADE95;
        Tue, 28 Nov 2017 18:47:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28690ADE94;
        Tue, 28 Nov 2017 18:47:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] travis-ci: avoid new tcl/tk build requirement
References: <xmqqlgir6mwk.fsf@gitster.mtv.corp.google.com>
        <20171128143718.3748-1-tmz@pobox.com>
        <CAP8UFD1Y_7FcARFoqNKTpDLRxKW1+jCBGAy5+TxL33ui0Hyb8w@mail.gmail.com>
        <20171128160222.GO3693@zaya.teonanacatl.net>
Date:   Wed, 29 Nov 2017 08:47:00 +0900
In-Reply-To: <20171128160222.GO3693@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Tue, 28 Nov 2017 11:02:22 -0500")
Message-ID: <xmqq4lpe6k5n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E8494B0-D496-11E7-804A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> I pulled the travis docker image used in clang/gcc builds[1] and can
> see it has both tcl and tk packages installed.  The linux32 builds use
> a docker image[2] which does not contain tcl or tk.
>
> [1] travisci/ci-garnet:packer-1503972846
> [2] daald/ubuntu32:xenial
>
> If we wanted, we could set BYPASS_TCLTK_CHECK only for the linux32
> builds.  I think it's probably better to do it globally rather than
> rely on the travis containers implicitly having tcl/tk installed.
>
>> The patch looks good to me. Thanks!
>>
>> I wonder if it would be better to squash it into my patch or to keep
>> it separate. I am ok with both ways.
>
> I fine either way too.  This is still just on pu, so squashing it in
> seems like the way to go.  I only made it separate to cause travis to
> run the tests. :)

I am OK either way but this may be giving an early warning that a
typical mix of packages installed on a box will lead many people to
encounter this glitch in the real world, and we may need a more
seamless solution than a workaround.

Keeping this "fix" separate from the original commit that introduced
the issue would allow us more easily to refer real users who will be
hit by this glitch to it, telling them to do something similar to
their build environment.


