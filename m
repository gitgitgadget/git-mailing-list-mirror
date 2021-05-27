Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE32EC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 02:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F40C613B9
	for <git@archiver.kernel.org>; Thu, 27 May 2021 02:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhE0CHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 22:07:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61394 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhE0CHs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 22:07:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6944CCC73;
        Wed, 26 May 2021 22:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vjqj5PY4sivV9JBsigNBRovfoyHbqTNWkURl8k
        69QCo=; b=GszUr3rXp6HcksWaVYcQ0JhPl9SCCiLV98LqPBlxNUZkvf00i7k3ha
        vlAYiD9n6FNiQk3BqkWRPqKOAiZrv6jyACElz/I5JPKgZ8BAPGBsceNDtNzHq/1E
        S0ak9VhPNZDklFcMQEUXdIADIPoTNwbM6i/Lckh3eM8JyHCZughwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1F0ECCC72;
        Wed, 26 May 2021 22:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FD64CCC71;
        Wed, 26 May 2021 22:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/28] Builtin FSMonitor Feature
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 11:06:14 +0900
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Sat, 22 May 2021 13:56:39
        +0000")
Message-ID: <xmqqmtsh9bhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DF57C20-BE90-11EB-9D76-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These new global symbols are introduced by the series, but never
used outside the file they are added to:

fsmonitor-ipc.o        - fsmonitor_ipc__get_path
fsmonitor-ipc.o        - fsmonitor_ipc__get_state
fsmonitor-ipc.o        - fsmonitor_ipc__send_command

Perhaps make them file-scope static?

Thanks.
