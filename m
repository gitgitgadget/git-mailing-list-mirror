Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A762201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 00:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755484AbdKJAWR (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 19:22:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54732 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755161AbdKJAWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 19:22:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C9EDB6F4A;
        Thu,  9 Nov 2017 19:22:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=axLG+smX+Y9C
        H/rB2VaVRYBVBO4=; b=EWzadQWWSpuoiMUZU2Gr651Z5mMt4PEKSE3NNZsrFZKZ
        /tV26RjXhwdzyCkRp/Vp3OPfHyKWkiqBZ1N2otSazjcQiCqnAxYO6au0MhmxKqrl
        coD+gzF//n5+59VNRe1lTjMtYDN2hXBVTtICy9fWYL4rndo37oQxL6jArfMFKMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jJwpXw
        O/xoev+PCDNK439IzZiVuAQQWTyLIOIw1yPyeHcBjZ89OzJh229XSzcThNygynvQ
        oFd7hokXJgIoYv9PZ5YOA+flVkGv0n9HgHeEdV68bmtgD13uq/BJ7ldTQj5bTQ2Y
        VN9XKCg/JZnKzOVoQ+B50ngjvjlfa/3FQY3XU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62808B6F49;
        Thu,  9 Nov 2017 19:22:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D14B6B6F48;
        Thu,  9 Nov 2017 19:22:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Introduce git add --renormalize .
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
        <20171030162913.23164-1-tboegi@web.de>
        <xmqqvaimeixm.fsf@gitster.mtv.corp.google.com>
        <20171107172659.GA11119@tor.lan>
        <xmqqlgjhobb4.fsf@gitster.mtv.corp.google.com>
        <20171109184700.GA27635@tor.lan>
Date:   Fri, 10 Nov 2017 09:22:10 +0900
In-Reply-To: <20171109184700.GA27635@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Thu, 9 Nov 2017 19:47:01 +0100")
Message-ID: <xmqq1sl7j83x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 321ADDB0-C5AD-11E7-9BB4-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Here is a somwhat shorter description:
>
> Apply the "clean" process freshly to all tracked files.
> This is useful after changing `core.autocrlf` or the `text`
> attributes in the `.gitattributes` file because
> Git may not consider these files as changed.

I think it is OK to omit .git/config for brevity (I am assuming that
your justification is because you thought it was obvious it is a
configuration variable); but then it is equally obvious (if not
more) that `text` attribute comes from .gitattributes (notice we do
not mention core.autocrlf is a configuration variable in the above,
but we do say `text` is an attribute) so it can also be omitted for
brevity.

> Correct the files that had been commited with CRLF,
> they will from now on have LF instead.

Reading this as a single sentence immediately after the above
paragraph leaves me feel confused.  First of all, this would not
happen unless the user corrects core.autocrlf/text like described
above.  In fact, updating these settings is done as in order to do
that correction.  So I'd say it should not be split.

> Re-run what the `clean` filter does.

This again looks out of place just like the previous sentence.  In
fact, provided if "the clean process" is understood by the end user,
this is redundant.

> This option implies `-u`.

Taking these altogether, perhaps

    Apply the "clean" process freshly to all tracked files to
    forcibly add them again to the index.  This is useful after
    changing `core.autocrlf` configuration or the `text` attribute
    in order to correct files added with wrong CRLF/LF line endings.
    This option implies `-u`.

Thanks.
