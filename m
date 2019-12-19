Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9CDC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A8724672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYn/Ssfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLSRvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:51:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57025 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSRvK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 12:51:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A39FD96A8C;
        Thu, 19 Dec 2019 12:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w4JMCgPxrgH3wRoeoywkN25YlJE=; b=NYn/Ss
        fplsts4isQg5Wk/2rCepxOuv0Xs3DM8t2B5629WbYckBzax5gL9vR3aB9RcdM1dx
        tuodQUUa/q2ocMn5dbl+d0z6BH1Nc7wC0/FTkl66jlOkiTwL3gmahDxJGtb4IgfF
        qx5NgJB9dRpkCMaSnkJp/W1H3h6lo2Vfa2rk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OPRf8zSzLHG4oEFyGDupfxUKQJnZ+99q
        vAfHIQOU/N/XYBErwKSSJit5gYK3q0tcuZKR19OoSpN2hkYwx3KokfnI8cb7wwoi
        P7YCO/SjvQlq8otZUIbTMJcWIVY1AnlGKR916jR4hc9agfn7O8FbimaIGMwGpunK
        GJPEm3PrOTQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C15496A8B;
        Thu, 19 Dec 2019 12:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B6E1396A8A;
        Thu, 19 Dec 2019 12:51:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
        <xmqqa77pe7sx.fsf@gitster-ct.c.googlers.com>
        <20191219050545.GC89333@coredump.intra.peff.net>
Date:   Thu, 19 Dec 2019 09:51:04 -0800
In-Reply-To: <20191219050545.GC89333@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 19 Dec 2019 00:05:45 -0500")
Message-ID: <xmqqy2v8b3w7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21E318CE-2288-11EA-8470-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... So if git_config_source grows an enum to select the type, and
> all that filename-resolution gets pushed down into config_with_options(),
> the whole thing would fall out naturally, I think.

Makes sense.
