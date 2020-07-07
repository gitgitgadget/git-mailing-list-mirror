Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2BFC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2226B206E9
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ISD53D7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgGGT1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:27:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53311 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgGGT1A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 15:27:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E20F5D40EF;
        Tue,  7 Jul 2020 15:26:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o+yYSS+ZLCpyw/3OxMaEZTIVveE=; b=ISD53D
        7IKHLgSq8c0YJ3XffSsdRXhjfiD79p/xzgEuqpVR9cMAnx6bBHsXhnqB4AwQeyp6
        3GDlyt0RvFZrUb2kMwOH0hHF/FoVMyAwWe+sIOs1xi/wtlpHFhAcDfg6bi/ZHTHU
        wJIwM2A0X4Z11eE8CZGncbuOB235H08cJogWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hqHAjgG5GghPN+VUCdO1g+rSddSmKB73
        M1PhLsgM3MdfaAuQaVjJ+CGQvcHtgwNsBbDIAyG4Ne3Y5z0eMBnNVlAi7V73L4mL
        mdXMl5VhNvb5/bMd23P6KfCoZlQEOoQEmUHZWWm40Op24N8ci/bU/WXcr9Xcnu0A
        7cUPcTAddEw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9A73D40EE;
        Tue,  7 Jul 2020 15:26:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29A32D40ED;
        Tue,  7 Jul 2020 15:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/4] Documentation: clarify %(contents:XXXX) doc
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200707174049.21714-2-chriscool@tuxfamily.org>
Date:   Tue, 07 Jul 2020 12:26:53 -0700
In-Reply-To: <20200707174049.21714-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 7 Jul 2020 19:40:46 +0200")
Message-ID: <xmqqsge33z42.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D13E31D0-C087-11EA-859B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +The complete message of a commit or tag object is `contents`. This
> +field can also be used in the following ways:
> +
> +contents:subject::
> +	The "subject" of the commit or tag message.  It's actually the
> +	concatenation of all lines of the commit message up to the
> +	first blank line.

Let's avoid confusing readers by saying "A is X. It's actually Y".

    The first paragraph of the message, which typically is a single
    line, is taken as the "subject" of the commit or the tag
    message.

> +contents:body::
> +	The "body" of the commit or tag message.  It's made of the
> +	lines after the first blank line.

    The remainder of the commit or the tag message that follows the
    "subject".

> +contents:signature::
> +	The optional GPG signature.

I _think_ this only applies to signed tag objects and not signed
commit objects, but this text does not help to decide if I am
right.

> +contents:lines=N::
> +	The first `N` lines of the message.

Good.

