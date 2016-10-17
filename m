Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988F71F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933168AbcJQRS4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:18:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54032 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754835AbcJQRSn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:18:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8145D44881;
        Mon, 17 Oct 2016 13:18:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=06ltdvcGcUxDdzMpp58d+JkforM=; b=MJIBNf
        dxM/ifxpshcdsWI38kZbNe31DW6aA06zlo4sft6thzm16MIOxA796zxVWBMieDNB
        kT3gnTGigEYz28WkZBU/qhR7ow4+/fg/v94Ai/+df7n9/vqrH5ZC7nObpB3CTiXw
        Stfz5NK+nEAnYvPsv/BoulCRlrS0ASXEiwyjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rDx+eyx5+gJaV1j6M8K6EjVgetSbNC++
        pIoueD4njXljMzQta8PenWo2zr+/k7SMo2Gp9LS9JeMChRtu/XPizqDgAv7knfqL
        hGQL2Qjz9N+FrYWCsxZ1qPN6dxqKwpSzoAwp8PUcl7UkrLVVJbH4Fdwc14gks+VD
        NBOk/3QaJ/w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79B9244880;
        Mon, 17 Oct 2016 13:18:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DFA14487E;
        Mon, 17 Oct 2016 13:18:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 15/25] sequencer: allow editing the commit message on a case-by-case basis
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <0577f66a108dced07775e10b87292c0eabfcc514.1476120229.git.johannes.schindelin@gmx.de>
Date:   Mon, 17 Oct 2016 10:18:37 -0700
In-Reply-To: <0577f66a108dced07775e10b87292c0eabfcc514.1476120229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 10 Oct 2016 19:25:50 +0200
        (CEST)")
Message-ID: <xmqqmvi2x5aq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF412C5A-948D-11E6-B866-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In the upcoming commits, we will implement more and more of rebase -i's
> functionality inside the sequencer. One particular feature of the
> commands to come is that some of them allow editing the commit message
> while others don't, i.e. we cannot define in the replay_opts whether the
> commit message should be edited or not.
>
> Let's add a new parameter to the run_git_commit() function. Previously,
> it was the duty of the caller to ensure that the opts->edit setting
> indicates whether to let the user edit the commit message or not,
> indicating that it is an "all or nothing" setting, i.e. that the
> sequencer wants to let the user edit *all* commit message, or none at
> all. In the upcoming rebase -i mode, it will depend on the particular
> command that is currently executed, though.

Makes tons of sense.
