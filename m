Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0B8C43470
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 08:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4193561179
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 08:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348780AbhDNIEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:04:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64730 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349865AbhDNID0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 04:03:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 132A2B28D2;
        Wed, 14 Apr 2021 04:03:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=52aRdvtAJj/JrGPzXtq+UX4UvPQ=; b=t1b/xP
        qq8MNPvB8SWEWDqQ/FA/8gNfADVPzyOkavUb9RspWwhug0sSjEfbWUoN4j8vRLmg
        gvFMSxm/bSbRu8uXKXm6qDKeSmwJ23npUQp4LCz5lFCr323mLXjzxRKYaD1CiXdm
        w4ry/iZ/Ed1C79q6DihCkTzHdb2IC7RpQZ+ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H8Fmc0XAUdre+PO2YQMVJijmFza3kjsV
        SWHSCRYJ1MN5ksHturI/k3zuUBcsiB0NnoqrkAhc0rmlSIId+hoE693Goa2k9Dvh
        W9aUcdK+dlLsN6bM6oGKWgVqR8SevjFQq7pOo/u1e9ehgTZ3eobbnusqOLenYyjA
        D1YqrMv1Omc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 090E4B28D1;
        Wed, 14 Apr 2021 04:03:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86CFFB28CE;
        Wed, 14 Apr 2021 04:02:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Pain points in Git's patch flow
References: <YHaIBvl6Mf7ztJB3@google.com>
        <b562e614-add7-575f-3013-1dbc667bc5bf@gmail.com>
Date:   Wed, 14 Apr 2021 01:02:58 -0700
In-Reply-To: <b562e614-add7-575f-3013-1dbc667bc5bf@gmail.com> (Bagas Sanjaya's
        message of "Wed, 14 Apr 2021 14:22:51 +0700")
Message-ID: <xmqq7dl5z425.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4306F14-9CF7-11EB-AEAC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> There is no lists of "beginner-friendly" issues that can be worked on by
> new contributors. They had to search this ML archive for bug report
> issues and determine themselves which are beginner-friendly.

Yeah, looking for "#leftoverbits" or "low-hanging" on the list
archive is often cited as a way, and it does seem easy enough to
do.  You go to https://lore.kernel.org/git/, type "leftoverbits"
or "low-hanging" in the text input and press SEARCH.

But that is only half of the story.

Anybody can throw random ideas and label them "#leftoverbits" or
"low-hanging fruit", but some of these ideas might turn out to be
ill-conceived or outright nonsense.  Limiting search to the
utterances by those with known good taste does help, but as a
newbie, you do not know who these people with good taste are.

It might help to have a curated list of starter tasks, but I suspect
that they tend to get depleted rather quickly---by definition the
ones on the list are easy to do and there is nothing to stop an
eager newbie from eating all of them in one sitting X-(.

So, I dunno.  We seem to suffer from the same lack of good starter
tasks before each GSoC begins.
