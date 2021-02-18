Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63001C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A24B64EB4
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBRTtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:49:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63100 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhBRTho (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:37:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C73A12B002;
        Thu, 18 Feb 2021 14:37:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YLPXCr7F8VhmvkPPX6ogPutpk7I=; b=Ag9Qsg
        MPa8Jqeqn1sbMNl7m6MiEWXGjH0QST+oib+RYzf4H/ixttKe+wONntYi88hYR8G9
        xMVDmiozsh8rtAdKLsQer4VW8sbPmPuDqSQ8K8bD5dc9sbfyanGIjWWv848U6WP/
        AlQ4HdGbqqmEq9L/UHO20oezVSDWKFAl0WGcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eSvLQ+NYNuU9EacH705cuOofeV8cAiq4
        0FwMFLujOMo4zehH6mcg8SvjhLU1jznyj1LM4BdGnKqdlpprUWS+VNiPt6azrY+g
        xT0KjvSPalu0xdBEkIILMGW4PCW7w/IcBKT91LA8KMab0xM2tPhg+VXNEo1UHZHT
        XjeFoyjCmX4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55CCC12B001;
        Thu, 18 Feb 2021 14:37:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11EF112AFFD;
        Thu, 18 Feb 2021 14:36:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2021, #03; Wed, 17)
References: <xmqqr1legm5v.fsf@gitster.g>
        <CAPSFM5efu6MF2RzfDkw8XJ9kF79akEesdA0WFAG3n9fo9N26vQ@mail.gmail.com>
Date:   Thu, 18 Feb 2021 11:36:57 -0800
In-Reply-To: <CAPSFM5efu6MF2RzfDkw8XJ9kF79akEesdA0WFAG3n9fo9N26vQ@mail.gmail.com>
        (Charvi Mendiratta's message of "Thu, 18 Feb 2021 16:14:23 +0530")
Message-ID: <xmqq8s7lf9ra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA8E5EC0-7220-11EB-A375-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> On Thu, 18 Feb 2021 at 07:44, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * cm/rebase-i-fixup-amend-reword (2021-02-17) 6 commits
>>  - doc/git-commit: add documentation for fixup[amend|reword] options
>>  - t3437: use --fixup with options to create amend! commit
>>  - t7500: add tests for --fixup[amend|reword] options
>>  - commit: add a reword suboption to --fixup
>>  - commit: add amend suboption to --fixup to create amend! commit
>>  - sequencer: export subject_length()
>>  (this branch uses cm/rebase-i and cm/rebase-i-updates.)
>>
>>  "git commit --fixup" learns to optionally create "amend!" and
>>  "reword!"  commits, that use the log message in "fixup" commit
>>  as the message of the resulting commit.
>>
>
> I would like to put light on the description of the patches. I might have
> misinterpreted the meaning of  _"reword!" commit_ as written above.
> But I thought to explain that here both additional suboptions i.e
> `amend` and `reword`
> of `--fixup` introduced in the patch series creates "amend!" commit only.

Thanks for clarifying.  I did mix up in the description.

As the parameter given to the command line option is much more
end-user facing than which insn it results in the todo list, how
about explaining the topic like so:

    "git commit --fixup=<commit>", which was to tweak the changes
    made to the contents while keeping the original log message
    intact, learned "--fixup=(amend|reword):<commit>", that can be
    used to tweak both the message and the contents, and only the
    message, respectively.

