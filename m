Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D858AC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiBYS7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBYS7H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:59:07 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E9D1FE541
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:58:34 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B7971020B7;
        Fri, 25 Feb 2022 13:58:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M0RKWnw3bT8BswuvnExSA96wuWlYGJHyYRq5e/
        M4X4I=; b=YfDu1r/gK8oFh3eeCV9zHVH0IkRRT91B60oz6O0VZvog8bx3Hkw/Tm
        KHbsx5vv8aD8M5JZSZ25aBMvQPbn09uxq9TPU11Ub5X2xHqeVAO4lILwimZF6uFf
        GNVOZNB9u8DekMIBEHECuEu6WZY8OpOPMBHbzzwXvJMdit7hK700c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73B1F1020B6;
        Fri, 25 Feb 2022 13:58:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D99C21020B5;
        Fri, 25 Feb 2022 13:58:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] xdiff: provide indirection to git functions
References: <20220217225218.GA7@edef91d97c94>
        <20220217225408.GB7@edef91d97c94>
        <e73c6746-9f8d-7e23-3764-18d01307278b@gmail.com>
        <nycvar.QRO.7.76.6.2202251639590.11118@tvgsbejvaqbjf.bet>
        <xmqqo82udctt.fsf@gitster.g> <20220225183854.GA9@811aa366e12e>
Date:   Fri, 25 Feb 2022 10:58:32 -0800
In-Reply-To: <20220225183854.GA9@811aa366e12e> (Edward Thomson's message of
        "Fri, 25 Feb 2022 18:38:54 +0000")
Message-ID: <xmqqbkyudb8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE3A421C-966C-11EC-9C62-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edward Thomson <ethomson@edwardthomson.com> writes:

> No, the thinking is that they would provide their own `git-xdiff.h` that
> defines the mappings to their project-specific APIs.

Is that spelled out somewhere?  That would help future readers of
the file to learn what they need to do when reusing the part,
perhaps in a comment near the top of that file itself.

If git-xdiff.h is meant to be modified to match the need for non-git
codebase, it probably should be named to a more descriptive name,
like xdiff-compat.h or something, I would think.  git-xdiff.h that
has libgit2 specific names in it would look quite strange.

