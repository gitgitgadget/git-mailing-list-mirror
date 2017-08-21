Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EFD208D0
	for <e@80x24.org>; Mon, 21 Aug 2017 22:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754293AbdHUWlq (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 18:41:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55572 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754019AbdHUWlp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 18:41:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CD4592DAB;
        Mon, 21 Aug 2017 18:41:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=36EetE7pg3tZS3rfKsjbAV4mImM=; b=e6WOrR
        5HI3+sYdLcNz6PxwJ/PjTQ0cjv3FGKHQ/IpTfRhPaZP+ql0JRoVuASWIpFKnjuj0
        Q1C8CisVDKphpmzrBaNmEnwdr7Cfp+eTzQbJmxqmGs/q3319pNk/a74QTJPSH+Ge
        QqxLMOWGU0jViZpssSleXrqPbrgh3jfpqdqsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NAFuFwaXt0D22X6e9Sp2Lrw9TdFlhuUP
        MEk+4YPR3B1yYmdvy/2V9OajAZfc6pEKzKvLxNy7ylCIqemIlkFNUFaTilZycMEp
        9yW4AA+YqzQ0l9Df1rOZcc6urMQIMPUSXPnnAuQIrbdVPrT4lj+4fUfzkM1xcOq1
        XzZIKccMa/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3348592DAA;
        Mon, 21 Aug 2017 18:41:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9380192DA8;
        Mon, 21 Aug 2017 18:41:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a rebase
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
        <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
        <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
        <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
        <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
        <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
        <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
        <a3b7af29-8b3a-5253-21da-957920212a6e@talktalk.net>
Date:   Mon, 21 Aug 2017 15:41:36 -0700
In-Reply-To: <a3b7af29-8b3a-5253-21da-957920212a6e@talktalk.net> (Phillip
        Wood's message of "Mon, 21 Aug 2017 11:32:48 +0100")
Message-ID: <xmqqinhg5ysf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E45D07EE-86C1-11E7-987B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> ... I prefer
> having to pass --autostage with --continue so that it is a concious
> decision by the user to stage unstaged changes when they continue rather
> than rebase just doing it each time it continues.

In other words, instead of

	git add -u && git rebase --continue

you would want a quicker way to say

	git rebase --continue $something_here 

If that is the case, that is understandable to me.  Is the "-u" (I
think "git add -u" is short for "--update" but I didn't check) taken
as a valid option to "git rebase"?  If not, that $something_here could
be "-u".

Thanks for pinging the thread; otherwise I would have forgotten,
especially because not many other people were involved in the
discussion to begin with.

