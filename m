Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9DFC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE3861CAC
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhGGBXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 21:23:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62899 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGBXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 21:23:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6D5E137FC9;
        Tue,  6 Jul 2021 21:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L/vMV3yRv917axT3iQm/jjhsZCZYAk1Ptmqxno
        y9d48=; b=NL/VcKmxWHz+HEMoe3E6wXBp7U/eIvaP7ZG2IfrsF/jV9DlKeSSkZL
        oiJGmsulAF7BZ/OebhR8xApssBTOXsczIEtpfKF33LdvuXfXVbLoEbPusE9k6E14
        vl74MTwKrd1L0IpwGVXECFlO9fZZNyz3Ywn+vkIkBl6ijka/jy7fg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9065E137FC7;
        Tue,  6 Jul 2021 21:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CAE79137FC6;
        Tue,  6 Jul 2021 21:20:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrew Berry" <andrew@furrypaws.ca>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH] docs: .gitignore parsing is to the top of the repo
References: <20210706205439.75015-1-andrew@furrypaws.ca>
        <20210706205712.75270-1-andrew@furrypaws.ca>
        <xmqqk0m3gl6a.fsf@gitster.g> <xmqqr1gbf02i.fsf@gitster.g>
        <CA0F1460-CB39-45DC-8DED-13F7ABA674D1@furrypaws.ca>
Date:   Tue, 06 Jul 2021 18:20:27 -0700
In-Reply-To: <CA0F1460-CB39-45DC-8DED-13F7ABA674D1@furrypaws.ca> (Andrew
        Berry's message of "Tue, 06 Jul 2021 20:32:52 -0400")
Message-ID: <xmqqh7h6gbs4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83EEAF82-DEC1-11EB-A9A9-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrew Berry" <andrew@furrypaws.ca> writes:

>>> Line rewrapping makes it hard to see what actually got changed,
>
> To check, that's asked for, correct? Or is it better to do one commit
> with the word changes, another to clean up the wrapping?

We do not encourage one-word-per-line or other silliness, but as
long as the source is readable enough, there is no need for line
re-wrapping, and I suspect that principle would apply.

>> Another tangent.  The discovery process used for the .gitattributes
>> files is identical to what is done to the .gitignore files; we may
>> want to make sure that the explanation we give in our documentation
>> won't cause the same confusion you are trying to avoid with this
>> change.  Such a fix does not have to be (and probably should not be)
>> a part of this change, though.
>
> I'm out of the office for the next week, but otherwise I'm glad to
> take that on when I'm back if no one else picks it up.

Here is how we describe the .gitattributes side:

    When deciding what attributes are assigned to a path, Git
    consults `$GIT_DIR/info/attributes` file (which has the highest
    precedence), `.gitattributes` file in the same directory as the
    path in question, and its parent directories up to the toplevel of the
    work tree (the further the directory that contains `.gitattributes`
    is from the path in question, the lower its precedence). Finally
    global and system-wide files are considered (they have the lowest
    precedence).

I think we are already good on this side.

Thanks.
