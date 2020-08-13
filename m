Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91DCC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C222620774
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g/BeBMi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMSrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:47:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51707 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSrf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:47:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A51CFDD371;
        Thu, 13 Aug 2020 14:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+zSTZRbRBIJA88aqZ7ibCQHRj6g=; b=g/BeBM
        i0XgDJSA0gTrHvLPpxCTSQLTFP0mpoY8A7+m5mnU1Pji/5xUXnAMaHR89gxCRAlm
        ubBxEoEoATQIASM3C8Z97LTCDI3OfmE8xcCIGrClA0f7yjSVVkQhkgFM1vpk0WFM
        alJ1z0ywzLehEJ/L2P0d8rG0m2tTUOgB40fq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JPU+v6TGRnaox7ycMRijewKb9PEHUtx7
        83OoDvPcTKCJyw2Rkro0GH9m+8tuPCEnH+Sz1a98+WsDgB4KZ7NEDfQnlggARS6H
        th2oaKEt+qyEVSmCSqf4wE9V+Q3qRLnquvFFpbWvN3k8WM1jiLA11EEPtuSjNTQP
        Dj5YsV4ggwM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97725DD370;
        Thu, 13 Aug 2020 14:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D953BDD36F;
        Thu, 13 Aug 2020 14:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
References: <20200813145515.GA891139@coredump.intra.peff.net>
        <20200813145936.GC891370@coredump.intra.peff.net>
        <f576fdce-9005-4653-3f91-0ddd2fff125d@gmail.com>
        <20200813173845.GA1598703@coredump.intra.peff.net>
        <xmqqa6yy2yjb.fsf@gitster.c.googlers.com>
Date:   Thu, 13 Aug 2020 11:47:29 -0700
In-Reply-To: <xmqqa6yy2yjb.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Aug 2020 11:25:44 -0700")
Message-ID: <xmqqr1sa1iym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 714E1AC6-DD95-11EA-89B0-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>     macros). That could change eventually of course, but it's not like
>>     switching back to a stand-alone at that point is a big deal.
>
> If it is not a big deal, then I am fine, but at the same time it
> becomes unclear why we can say "we can use X and Y niceties only
> available for builtins".

Actually, there is another issue that is potentially a lot worse.

"git bugreport" not being built-in would mean that the compiled-in
git-version MUST not be relied upon (it merely is a version of the
source "git bugreport" came from, it does not necessarily match the
main "git" binary when we are dealing with a confused user with
GIT_EXEC_PATH problem), but has to be asked to "git" binary on the
$PATH externally.  That needs to be done for any non-builtin
binaries (e.g. when user is having issue with git-remote--curl")
anyway, keeping "git bugreport" out of builtin would force us the
necessary discipline from early on.
