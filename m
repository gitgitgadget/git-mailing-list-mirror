Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A79AC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001F9206D9
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n9O1lJSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgD2X5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:57:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57574 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgD2X5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 19:57:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11A8448B3B;
        Wed, 29 Apr 2020 19:57:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H8AHKiZNHpKBuuxZJ/SHg8YFTG4=; b=n9O1lJ
        SEtg353xp3d09HUUwIw8QTyQywRDaJyJagjUZ01yn0pwf+IM3ETBWmeNVKgOSqvm
        vj6AyD5YxmI/ZKkRwNcz0UBc/l2PrB7n090MidreoB9oOuMqoQ8QlWk1NQp0Ka0V
        naxopmIgbMcTN5c+BPmLkv6sjBaas+vz45Y6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FnSL6hhyc1tIZVEL2berpBaODa+kQa+e
        mgzblnbwBQb0A6g7w6qXWfW3+psZpvCDWBbA/Pt9x73EfcqELiPrjzlCJI4OJRI3
        91OzjtG7FQIBH0NAICZjO/yX0IFruC1skN+DDcd4uBDmer0risBD/1sarJ31KH7C
        q0cSFaips1k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0843848B3A;
        Wed, 29 Apr 2020 19:57:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8964848B39;
        Wed, 29 Apr 2020 19:57:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH v6] credential-store: warn instead of fatal for bogus lines from store
References: <20200429203546.56753-1-carenas@gmail.com>
        <20200429232322.68038-1-carenas@gmail.com>
        <xmqqlfmdua5o.fsf@gitster.c.googlers.com>
Date:   Wed, 29 Apr 2020 16:57:32 -0700
In-Reply-To: <xmqqlfmdua5o.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 29 Apr 2020 16:47:31 -0700")
Message-ID: <xmqqh7x1u9oz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3193EDE8-8A75-11EA-BC7E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +Do not view or edit the file with editors as it could compromise the
>> +validity of your credentials by sometimes subtle formatting issues,
>> +like spaces, line wrapping or text encoding.
>
> I do not think dropping "view or" is justifiable....

Sorry, this comment is now stale.

>> +An unparseable or otherwise invalid line is ignored, and a warning
>> +message points out the problematic line number and file it appears in.
>
> OK.  You didn't want to tell them they can remove the problematic
> line as a whole with their editor?

This one I do not care too deeply either way.  Probably it is
obvious to the readers that they can remove the lines (otherwise
there is no good reason to give warnings in the first place).

