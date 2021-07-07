Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2041C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 00:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EF360249
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 00:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGGAV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 20:21:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58379 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGAV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 20:21:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB15413747E;
        Tue,  6 Jul 2021 20:18:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hj0DZuHPZq2SSG/GEQeb+vnOuCiQ99i81CH1ue
        ItAxA=; b=b4dUV+ok1YtpBf76wSP3dnK7wlVnOECNymFi+gUfrtjvS5PSK5ss5l
        2o+UCNp23479XMrwgqa5qEVSWrCvNl4EBIOGm9Z9TlhLfOROwrf78dMse8okUoXT
        sQRHrItdjyHYUC/IA8RXlFvPtuidnL3XVjfpcyldXE9Xn6tQcljt4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3DED13747C;
        Tue,  6 Jul 2021 20:18:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2310D13747A;
        Tue,  6 Jul 2021 20:18:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Berry <andrew@furrypaws.ca>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH] docs: .gitignore parsing is to the top of the repo
References: <20210706205439.75015-1-andrew@furrypaws.ca>
        <20210706205712.75270-1-andrew@furrypaws.ca>
        <xmqqk0m3gl6a.fsf@gitster.g>
Date:   Tue, 06 Jul 2021 17:18:45 -0700
In-Reply-To: <xmqqk0m3gl6a.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        06 Jul 2021 14:57:33 -0700")
Message-ID: <xmqqr1gbf02i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E58E9148-DEB8-11EB-BD39-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Andrew Berry <andrew@furrypaws.ca> writes:
>
>>   * Patterns read from a `.gitignore` file in the same directory
>> -   as the path, or in any parent directory, with patterns in the
>> -   higher level files (up to the toplevel of the work tree) being overridden
>> -   by those in lower level files down to the directory containing the file.
>> -   These patterns match relative to the location of the
>> -   `.gitignore` file.  A project normally includes such
>> -   `.gitignore` files in its repository, containing patterns for
>> +   as the path, or in any parent directory (up to the top-level of the work
>> +   tree), with patterns in the higher level files being overridden by those in
>> +   lower level files down to the directory containing the file. These patterns
>> +   match relative to the location of the `.gitignore` file.  A project normally
>> +   includes such `.gitignore` files in its repository, containing patterns for
>>     files generated as part of the project build.
>
> Line rewrapping makes it hard to see what actually got changed, but
> does this only move "(up to the top-level of the work tree)" around
> without anything else, as discussed?
>
> If you do "toplevel" -> "top-level" while at it, perhaps we would
> want to correct "work tree" -> "working tree".
>
> Looking better.

Another tangent.  The discovery process used for the .gitattributes
files is identical to what is done to the .gitignore files; we may
want to make sure that the explanation we give in our documentation
won't cause the same confusion you are trying to avoid with this
change.  Such a fix does not have to be (and probably should not be)
a part of this change, though.

Thanks.
