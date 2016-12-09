Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B2E1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 22:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbcLIWX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 17:23:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60660 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752434AbcLIWXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 17:23:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 514CA56C57;
        Fri,  9 Dec 2016 17:23:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AxcGyZ4UauON
        eLIaZkgJNcajfsE=; b=Yt78aG0mTeVr34PtaZ4HqRkdD87R1IOFaMWemI5JJKQ/
        n+UPJlEihm+d+J/7yWxVRr2EktlnUGQAmuHn30Fm6iQ5xCaj4xNOygciPFPN4PJF
        xSLJEnQ2skQYNzAbt3xGKTx11e1V1cz/Yg2wDf3Jnrvo954Ei4Uiq4hu95jLMMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Gp7jnH
        u4QKsh6pIG5Fkc/YT8HofQgxK/E7Cc2MEf2NXXyc5qU58G9gAzH0NPuU1ghklrSN
        ds0XsLh29uzAsVEgmNTxp2u9RirGvyLb+/f/WrnnaScUxecT5AIr4i7HPDb5d8Y8
        lkkhQrQJwnLlOMSYL3HHd4At378ar4oGBYmPA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 331B856C56;
        Fri,  9 Dec 2016 17:23:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 844AB56C55;
        Fri,  9 Dec 2016 17:23:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 01/16] Git.pm: add subroutines for commenting lines
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>
        <20161111124541.8216-2-vascomalmeida@sapo.pt>
        <1479823833.1956.7.camel@sapo.pt>
        <xmqqoa17quls.fsf@gitster.mtv.corp.google.com>
        <1481303956.4934.8.camel@sapo.pt>
        <alpine.DEB.2.20.1612091832310.23160@virtualbox>
Date:   Fri, 09 Dec 2016 14:23:52 -0800
In-Reply-To: <alpine.DEB.2.20.1612091832310.23160@virtualbox> (Johannes
        Schindelin's message of "Fri, 9 Dec 2016 18:32:53 +0100 (CET)")
Message-ID: <xmqqk2b8rbbb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2AD5DF84-BE5E-11E6-95CC-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Vasco,
>
> On Fri, 9 Dec 2016, Vasco Almeida wrote:
>
>> A Ter, 22-11-2016 =C3=A0s 09:42 -0800, Junio C Hamano escreveu:
>> > The incremental update below looks sensible. We'd also want to
>> > protect this codepath from a misconfigured two-or-more byte sequence
>> > in core.commentchar, I would suspect, to be consistent.
>>=20
>> Are the below changes alright for what you propose? It just checks if
>> the length of core.commentchar's value is 1, otherwise use '#' as the
>> comment_line_char.
>> As a note, when I set core.commentchar with "git config
>> core.commentChar 'batata'", I get the following error message when I
>> issue "git add -i":
>>=20
>> error: core.commentChar should only be one character
>> fatal: bad config variable 'core.commentchar' in file '.git/config' at=
 line 6
>
> This is exactly the same issue I fixed for rebase -i recently.

Yes, but the patch we see here punts "core.commentChar is not a
single-byte single-letter--panic!" case differently.  I think you
did "just take the first one" in "rebase -i", which I think is more
in line with the rest of the system, and this addition to Git.pm
should do the same, I think.
