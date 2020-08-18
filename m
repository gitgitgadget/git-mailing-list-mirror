Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB40AC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE74A206B5
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pz5q/Aek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHRUSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:18:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62434 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgHRUSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 16:18:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2C20E5E49;
        Tue, 18 Aug 2020 16:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KNLdEvM/9P7VKZ58ERXt+/ZTeU0=; b=pz5q/A
        ekKfwj0LLOW7v4WW9zrVJfXKf4byOs/he0HgKyMcA94ZfAV3rT1CZ41ugRC2Tm/W
        OF2U0aJlehwqQjD+sWiO0ahlGi3ctgpSa6sryrydpDCHz2lueidSPt+679Jm/NL/
        n2KbGsVMpRTcfCeLtEwzHfFSLd2yWCnk5+hvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cEhIwJOjyzpHn9iOoo8fTpdA18AvEohH
        pswXIYPgi9A3GxToDETCtBfEjpxXJjjnD0Pet9PyqOOJV3MXYu6zhv8UhXF6W0xx
        uQ9deAitw6RlQI8pUm+DvQNmuFdgEzv1nVsY/l+tJaJAoiNR+k133RbJgczOQlWY
        s5EsdU1vYc4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA054E5E47;
        Tue, 18 Aug 2020 16:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40EE0E5E46;
        Tue, 18 Aug 2020 16:18:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/11] Maintenance I: Command, gc and commit-graph tasks
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 13:18:39 -0700
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 18 Aug 2020 14:22:57
        +0000")
Message-ID: <xmqqa6yryag0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01F8F5B6-E190-11EA-9940-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series is based on jk/strvec.

As jc/no-update-fetch-head topic seems to be getting popular for
some reason, let's do this:

 - recreate jc/no-update-fetch-head topic with patch [1/9] of the
   maintenance-2 series directly on top of 'master';

 - fork ds/maintenance-part-1 topic off of jc/no-update-fetch-head
   and queue these 11 patches;

 - fork ds/maintenance-part-2 topic off of ds/maintenance-part-1 and
   queue its 8 patches [2/9 - 9/9].

Thanks.
