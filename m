Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB11BC433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B648208E4
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C4SF8YjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGUAk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:40:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53787 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGUAk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 20:40:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A8AF7BFEB;
        Mon, 20 Jul 2020 20:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HYp/Em4CgPqRarT50UwK341R3aE=; b=C4SF8Y
        jGiNCpI5evTgwyY06UUy8FrScGRtF9beP9dgRPhFNCsp6Yvff6qj7HBefSVrRAar
        9X9a3/QaErKto2u9vM/h0CZlEZHKjbxYlR8iCPdF0vHJSnQCV08MxIjrNPlF9uuk
        2KsHMtNz6eebuibDPB+93PBFhTBF4QkNFRZS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tAZHtJGT3S6/7XT6ITeNMYlaIEVwgQ+8
        tdGuZGophFngrvgLf/jdcyvyXo2/kQ4Q49NWHLXZE399wlk6oD3ivleCdUrBnqqK
        okkCWA6oPcjIrmO1TGtF+wtwClSfvEgzAbXFoDRzct83RU5EojuLjQxmL1KC+Fqr
        0+BwfXP9Cx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 632457BFEA;
        Mon, 20 Jul 2020 20:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7B877BFE9;
        Mon, 20 Jul 2020 20:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        "David J. Malan" <malan@harvard.edu>
Subject: Re: [PATCH] git-prompt: changes == to = for zsh's sake
References: <pull.679.git.1595287052428.gitgitgadget@gmail.com>
        <20200721002309.GA178512@pug.qqx.org>
Date:   Mon, 20 Jul 2020 17:40:54 -0700
In-Reply-To: <20200721002309.GA178512@pug.qqx.org> (Aaron Schrab's message of
        "Mon, 20 Jul 2020 20:23:09 -0400")
Message-ID: <xmqqh7u18zu1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5FF1D66-CAEA-11EA-943B-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Schrab <aaron@schrab.com> writes:

> An alternate fix would be to switch to using double square brackets
> instead of single square brackets for the test. Since contents of
> double brackets have their own parsing rules the `equals` option
> doesn't apply there, and so `==` is available for checking equality
> same as in bash.  IMHO, this provides saner behavior in general;
> although it's definitely not POSIX compliant.

It won't be but it does not have to be POSIX compliant anyway; after
all this is prompt support for bash with support for zsh added on
the side, neither is limited to strict POSIX.

I'd say that the patch posted is good as-is.

Thanks.
