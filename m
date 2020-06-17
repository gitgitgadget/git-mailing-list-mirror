Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6AAC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5352082F
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k5BSUPsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFQSQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:16:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63705 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgFQSQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 14:16:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F94CE1229;
        Wed, 17 Jun 2020 14:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LaLKuZbHwEwAyOcwC97Tmgyz9r8=; b=k5BSUP
        sfIFlicegC/XhseBaJazRz+deypSL01UdF+ZZMO/LJAG+Ih0EEgGlpee++66DKrW
        dEDPVklC7ytbp4ZjCxxvpQq6EJfwOjnqyxlc6NP6K8MiCvYB7G7s8n/ZAGGGZBil
        CXgjeZtPy2Ac/Em/QTSKZ7uAZ860cNbJtCJnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DG/s/x0rDv0IELzWz0N5iNAq5K44e/so
        lt7Ldb9eNpGgQYU6yA9nUZAUIP+M+CRl/LPbCUbB9snV6hWXme4i5gFxZ5mXJC+X
        f0NVn9CoDNlB+7vN5Zt/wRlt9XNwnDCczNyuX8vT0QcGFP4Y8nNs8E/yiPZTe5Y3
        ssSwEuRqgS8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06578E1228;
        Wed, 17 Jun 2020 14:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BAE9E1227;
        Wed, 17 Jun 2020 14:16:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/12] fast-export: do anonymize the primary branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
        <20200616125833.GE666057@coredump.intra.peff.net>
Date:   Wed, 17 Jun 2020 11:16:05 -0700
In-Reply-To: <20200616125833.GE666057@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 16 Jun 2020 08:58:33 -0400")
Message-ID: <xmqqmu51v9qy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D0F766A-B0C6-11EA-B61A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of course that only helps you for _one_ branch. A more generally useful
> mechanism would be to teach fast-export to write the ref mapping (and
> perhaps file mappings, etc) to a separate file. Then you could convert
> any reproduction recipe to use the anonymized names, and share only that
> recipe along with the anonymized dump. But that's _way_ outside the
> scope of your series. This seems like a good interim step to retain the
> status quo.

Actually, dropping this special case, and dropping the other special
case with fmt-merge-msg, we can do without the notion of the
"primary" branch.

We still need to have the default name, when user does not specify
one, given to the first branch "git init" creates and "git clone"
that cannot figure out what the HEAD at the origin points at uses,
but one less thing to worry about is always better ;-)
