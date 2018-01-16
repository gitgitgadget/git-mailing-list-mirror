Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221EA1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 18:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbeAPSXd (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 13:23:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61431 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAPSXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 13:23:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A4DDCC597;
        Tue, 16 Jan 2018 13:23:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rLLSdAekxWsN/QkEgryAUDn4J3Q=; b=sIEaxR
        wQbfC25krpopWk9KoHMWXS8MRnNDq46cxOR4etXDq7icTmvdLHEJP+3+B7F1RErI
        oNYt3PsIjat6zBEWNLeq0KzDu6tGRJw/jihIEJJLOl9O9UkZc2px7R8ntAhT4qX3
        jE7OgvFN/PRcEwoJ6FlcKWK70tCz2larHFxKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oXXuyFHUt5rcapMKAptmbrr9zpiifXX7
        viDQvObhBXq496YLN6x1KblW5VUWETSVA1lId/3BNY0OE32z7mJ0fSad1uhgypCm
        3Bq25aL0IFrvgFR0lIGjb9Kw9Aj83d3Wpxc/3QQ0fJlS4pZ49l6JVaELH/duMLa9
        JgEjK7Fe/5E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50C6ECC596;
        Tue, 16 Jan 2018 13:23:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2FCBCC591;
        Tue, 16 Jan 2018 13:23:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Andrzej =?utf-8?B?T8WbbWlhxYJvd3NraQ==?= <me@osmialowski.net>,
        git@vger.kernel.org
Subject: Re: Git uses wrong subkey for signing commits with GPG key
References: <CAHLNBdVp0VTqtxHQ_cQ2XPMMDhqnQG5boj0M2JrT-iECaFUFZA@mail.gmail.com>
        <20180113002221.GQ29313@zaya.teonanacatl.net>
        <CAHLNBdUTWTbvkLdqbvB-1vs=oPJOHP5S3CWMZbtCgBnJNh4hRQ@mail.gmail.com>
        <20180113172555.GS29313@zaya.teonanacatl.net>
Date:   Tue, 16 Jan 2018 10:23:27 -0800
In-Reply-To: <20180113172555.GS29313@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Sat, 13 Jan 2018 12:25:55 -0500")
Message-ID: <xmqqlggxvf1c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B33EB52-FAEA-11E7-A26A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Glad it helped.  The git-tag documentation points to
> git-config and the user.signingKey variable in the
> CONFIGURATION section.  The git-config documentation for
> that variable currently says:
> ...
>     so you may specify a key using any method that gpg supports.
>
> Whether that can be improved without being too verbose (or
> duplicating too much of the gpg documentation), I don't
> know.

Yeah, I personally do not want to see Git's documentation sound more
autoritative than it actually is wrt how to use software from other
people, especially given that we do not have volunteers who will
closely be keeping track of their changes in order to update our
documentation.  So "any method that gpg supports" is a good place to
stop from that point of view.  "See documentation for the version of
PGP software you use for details." is not a bad thing to add without
risking to go stale, though.

