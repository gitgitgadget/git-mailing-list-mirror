Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1077C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6075461003
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhDKTCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 15:02:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56115 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhDKTCn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 15:02:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0F09BDBC0;
        Sun, 11 Apr 2021 15:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LOeHA+qCAYBTXuuvyMOj4SZ2Fu0=; b=hgkLlt
        UiXNLrIVOTfC076qWKGZwbL1BSe2M08lH3PGli+0ZmZmtr9vrhEvz5nVkvQMC3tF
        T0XjuQUAOcSpS1N2/YO3oHyp/ReBZMLidytWXq7VluWqZ3Vfi6D76va09E3SX3KW
        hHbswVISVFuu1UpzdYXxyJgnMLtIoFK1cvAT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v2Ou6qoK9x9LqsH25h/be7EUb7AliYWE
        PH6itJHcDjcb9La7qKz+aezIITY3bB6xzmWQjcWI8cLbgpOBy42wWeir+k5nEEQr
        2Pa8KggAeZg82bDcethqf+S/JWRPioWndGNGUqayXwkvHXDaDKqj4UylI6e9u0Sy
        n3MUzMPqXcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 987C8BDBBE;
        Sun, 11 Apr 2021 15:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09196BDBB9;
        Sun, 11 Apr 2021 15:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 0/5] git log: configurable default format for merge
 diffs
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210410171657.20159-1-sorganov@gmail.com>
        <xmqqsg3whka6.fsf@gitster.g> <87wnt84s0h.fsf@osv.gnss.ru>
Date:   Sun, 11 Apr 2021 12:02:25 -0700
In-Reply-To: <87wnt84s0h.fsf@osv.gnss.ru> (Sergey Organov's message of "Sun,
        11 Apr 2021 21:04:30 +0300")
Message-ID: <xmqqo8ekhcfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 746A1766-9AF8-11EB-9572-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> 2. We have descriptive long name for every other option, and it'd be an
> exception if we'd have none for --diff-merges=m. In fact, it's
> --diff-merges=m that could have been removed, but it'd break resemblance
> with --cc and -c that both do have their --diff-merges=cc and
> --diff-merges=c counterparts.

Hmph, a devil's advocate in me suspects that it may just be arguing
why user-configurable 'default' is a bad idea, though.
