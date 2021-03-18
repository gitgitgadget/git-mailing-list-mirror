Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D977C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57A564F30
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhCRVuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:50:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57148 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhCRVuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 17:50:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7532123EDA;
        Thu, 18 Mar 2021 17:50:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/01+ug0bHP6a
        cJqkulXdof6uoEM=; b=kL+50Fn/7Kx8uQIUoP7aFB7+Z/0bt+jcVrEr9Gnz0oFi
        OQsAgLY4OnfuwvdEDJcSR2NeZrYKbRrAZ1WV9FU87V7KjW9e4P+GBS7ca+vwkBhy
        lybG1CcLyTTfPtoFvq+9fXjI8tUypfhQfn8JweKWkjXTIrmjHe6xUFWtN/PV9/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WuG1Aq
        CieBa3hGJSZy2/CdBh2uWaPcGNKTBs/mHUmTaEoRRKJjn2E8LJVKxkkJBxi2KM2V
        4VDw12api4R/osz0wHmybpiEBZzYx/lozBoYe/fz+Xd5VGB2G4TNst3TepW982ul
        gpFGpvwsLjilOJNXoemh2hfhE3XL2btFnEsTM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEDCA123ED6;
        Thu, 18 Mar 2021 17:50:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A0F1F123ED5;
        Thu, 18 Mar 2021 17:50:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 00/20] Sparse Index: Design, Format, Tests
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 14:50:06 -0700
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 16 Mar 2021 16:42:43
        +0000")
Message-ID: <xmqqzgz0qghd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E84927EE-8833-11EB-AC71-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For this version, I took =C3=86var's latest patches and applied them to=
 v2.31.0
> and rebased this series on top. It uses his new "read_tree_at()" helper=
 and
> the associated changes to the function pointer type.
>
>  * Fixed more typos. Thanks Martin and Elijah!
>  * Updated the test_sparse_match() macro to use "$@" instead of $*
>  * Added a test that git sparse-checkout init --no-sparse-index rewrite=
s the
>    index to be full.

Thanks.  I expect ab/read-tree would be rerolled at least one more
time, if only to straighten out the "oops #5 was screwy, let's patch
it up on top with three more steps", but I do not expect the end
state would be all that different, so tentatively I'll queue these
patches on top of the latest iteration of the topic for now and
hope that the other topic will be updated soonish.


