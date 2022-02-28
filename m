Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951EAC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 17:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiB1RIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiB1RIU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 12:08:20 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E6F17056
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:07:38 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF4F1192A61;
        Mon, 28 Feb 2022 12:07:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+YWPpc3WzvzK
        g5DNug2pzpVLJBBc84XUIDnLEilHlNA=; b=ohJWNmnt1tbq/ywQe9axapy4SG/0
        mxBnnFIboWcwhE2cKVt9NmuHCY7Ccos9HnknUB13cXKdDsziKLT4RIbdXQlEuP46
        /UUvASWFmfLSbro/ILGzZdt7v1bYv9OO6VEwOPOPnxgkkWgPY62tdTtRj8E1CH2T
        7+7D4cgea02RshE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7146192A60;
        Mon, 28 Feb 2022 12:07:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65C44192A5F;
        Mon, 28 Feb 2022 12:07:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Coup <robert@coup.net.nz>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 6/8] maintenance: add ability to pass config options
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <cfa6dca8ef4a64b6233e3b7b6021571447fc5ba9.1645719218.git.gitgitgadget@gmail.com>
        <xmqqsfs7fn6v.fsf@gitster.g>
        <CACf-nVeh9p1ba+tPSFQvqDBq3SaNtnhCQMibd__EED0w0Btozg@mail.gmail.com>
Date:   Mon, 28 Feb 2022 09:07:34 -0800
In-Reply-To: <CACf-nVeh9p1ba+tPSFQvqDBq3SaNtnhCQMibd__EED0w0Btozg@mail.gmail.com>
        (Robert Coup's message of "Mon, 28 Feb 2022 12:02:31 +0000")
Message-ID: <xmqq1qzm538p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ECB51C8E-98B8-11EC-B39B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Coup <robert@coup.net.nz> writes:

> =C3=86var pointed out GIT_CONFIG_PARAMETERS has an API to wrap it's use=
, so
> I can adapt the implementation to use that.

Depending on how that "API to wrap" looks like, it may not be a wise
idea, though.  You'd need to consider how it interacts with those
who run "git -c var=3Dval" to enter this codepath.
