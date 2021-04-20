Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBE6C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2D261403
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDTWpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:45:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59021 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTWpE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:45:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E4EB12DB39;
        Tue, 20 Apr 2021 18:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7WWWdFfDWDEJRl96InqSMEYHZ6w=; b=WALuhl
        KEEXmO0nqcT0Pq5H5TYJUAN5l+uJu4f8KXHnwQD/Bsehj6uS8Se4/P70JwUq/P+d
        jqfzeqb5Sm2iGgtuMXHbRSJLuYi5Llb6Tm+dR4Tt/e1BQFYyQHyXwcB8npuAtNr5
        L0pMi8GoKxd6D3AHXSEZARNpid4Gukh/oUfXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KMEKSa/HeYR7TOBJzq9nMwOirDUg1iL8
        lAC7Dv/EbyonMRuX/WLJqXu5P8UudbWvUaSJ8hSILgq2upJyVDTjqKbwXcgF0tYb
        Am2ApVfOt+Q8nL4jsqLOuDQLB9HuS7a4De01uZKGdmc1EnLIMYsuMnXVKnZs+aNv
        Mh4KPdKio80=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94E8912DB38;
        Tue, 20 Apr 2021 18:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A02412DB37;
        Tue, 20 Apr 2021 18:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 23/28] Reftable support for git-core
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
        <2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 15:44:27 -0700
In-Reply-To: <2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Apr 2021
        11:37:51 +0000")
Message-ID: <xmqqk0ow37as.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F773EE38-A229-11EB-85CB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +if test -n "$GIT_TEST_REFTABLE"
> +then
> +  test_set_prereq REFTABLE
> +fi

How would this interact with what the test prep series did which was
to unconditionally add

test_seq_prereq REFFILES

around the same place?  Should $GIT_TEST_REFTABLE disable REFFILES?
IOW, do you want the above to read

	if test -n "$GIT_TEST_REFTABLE"
	then
		test_set_prereq REFTABLE
	else
		test_set_prereq REFFILES
	fi

when both series are in effect?

Thanks.
