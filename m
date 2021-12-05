Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF5C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 07:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhLEHfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 02:35:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60316 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhLEHfL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 02:35:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCB8117385D;
        Sun,  5 Dec 2021 02:31:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jx7/2gXCAkKAy2rjPN1ty4DdUsS8mi/TxUG6W/
        CpppM=; b=OuagdEMhILyv4jiqPon2YUI5S9SYVK+DkvU7G1aFd3/9cyM3P1KLWS
        ylYf1Gqbb7q2ymMUXRU2R2Uq/LHQHlCgwBWFD9l6lZ0s0hhY0fXjZiRxoZ0EB3bj
        x85OtfNF9l9ladepWtX0A2P4mvENVD8Jc26Y1sRFwPwNciJHBiw1Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 921C517385C;
        Sun,  5 Dec 2021 02:31:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82CBC17385B;
        Sun,  5 Dec 2021 02:31:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 00/10] Factorization of messages with similar meaning
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <YaqSXvp6ZxOFqeuk@coredump.intra.peff.net>
        <d687f69b-efdc-6b1c-c63c-8544ff37d1c2@kdbg.org>
Date:   Sat, 04 Dec 2021 23:31:38 -0800
In-Reply-To: <d687f69b-efdc-6b1c-c63c-8544ff37d1c2@kdbg.org> (Johannes Sixt's
        message of "Sat, 4 Dec 2021 00:39:42 +0100")
Message-ID: <xmqqfsr7mrs5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6347E034-559D-11EC-A523-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Another aspect is that translators lose context. For example, "%s and %s
> are mutally exclusive" may have to be translated differently depending
> on what kind of text is substituted for %s. In this example it's
> probably always command line options (I haven't checked), so not an
> immediate problem. But something to keep in mind.

Yup.  I do not think we are quite ready to have two identical msgid
strings to be translated into two different msgstr strings.  We've
briefly talked about pgettext() a few months ago, but nothing
concrete came out of it, as far as I can recall.

