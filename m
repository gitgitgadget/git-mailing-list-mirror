Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71AEE1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbcLGWFA (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:05:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61856 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752156AbcLGWE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:04:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF2A55556B;
        Wed,  7 Dec 2016 17:04:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1udMlNMsRvAM9jg9lYqi8XZsSqU=; b=n1s7Jw
        bIQkKh0WDXqWvZhKvkquKH7TS/sB1JsY4Jr9BAEZhvPb+hUmW7M2v82NW7idO/Hf
        /oqR7i0rfXQYAOrmPrdEc5HzC7S8Rgz2y4pDZymYi67yht2y19EI2C9kT5le2KxU
        OC8xyfp4jblETIjt5cIUtulEXrUVYtVOPd4bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oXHeGVshcEMhprn3lSryGcTKqt1XnhD6
        Hq+w5HYem9Sa65MaHboQ/anf6kEpqImoRe+b3juZonmtklcDxLwzLTesSw6oC/OP
        UEaq97eugKTiHIPyOEzeEwMqzRElaEvNoxZH/EcNyAsxdfS2xH8DjggGTP0323z+
        aI3L4OJuQEg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C79A95556A;
        Wed,  7 Dec 2016 17:04:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 472C455569;
        Wed,  7 Dec 2016 17:04:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 00/17] pathspec cleanup
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Date:   Wed, 07 Dec 2016 14:04:56 -0800
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Tue, 6 Dec 2016 13:51:29 -0800")
Message-ID: <xmqqeg1jwg3b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30B624AE-BCC9-11E6-A787-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> The intent of this series is to cleanup some of the pathspec initialization
> code as well as finally migrating the remaining users of the _raw field or
> get_pathspec() to the pathspec struct interface.  This way both the _raw field
> and get_pathspec() can be removed from the codebase.  This also removes the
> functionality where parse_pathspec() modified the const char * argv array that
> was passed in (which felt kind of odd to me as I wouldn't have expected the
> passed in array to be modified).
>
> I also noticed that there are memory leaks associated with the 'original' and
> 'match' strings.  To fix this the pathspec struct needed to take ownership of
> the memory for these fields so that they can be cleaned up when clearing the
> pathspec struct.

Both good goals.  Thanks for working on this.
