Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991202070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbcIOTP5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:15:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53672 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753896AbcIOTPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:15:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78B0C3E75E;
        Thu, 15 Sep 2016 15:15:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NZrm/1LC9FxboN8wke85iioUjCI=; b=Duf5/Y
        lGh+qjAX3Vma3xHnlh/hvxE4o1VdIpdGIUvVHxBrvA/giRKikpFoTaBk7jCC6TzJ
        4Al0lXGCJcbr2nJoHQqciE8usl8n7KKWfeCRkw7zSn9ufcJXrYrAFojf+N7HQHP8
        Sl23MyigR5Ty/LunjHU7aj0d65xaztBuq6sUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XiK+HmqsMJ2USPnl5Rf3hT12Hjjoigk/
        2UtS8EMoRJj4C1vfGtxYcybUUcKCSE9MBTsWjcaoOHIaTI4FCzirfc6pczKznhBV
        HaeiLn5AG2fJNoigWtPu9Vv3r7cyrMBfjPxa9KZw8TnjfmRs3oJwFBUb2UxsZzxH
        zY3+7M/FQoo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FED93E75D;
        Thu, 15 Sep 2016 15:15:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA7073E75C;
        Thu, 15 Sep 2016 15:15:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 10/25] sequencer: get rid of the subcommand field
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <955727a7cf5bd64f1c1106b394095d5449a4a2dc.1473590966.git.johannes.schindelin@gmx.de>
Date:   Thu, 15 Sep 2016 12:15:50 -0700
In-Reply-To: <955727a7cf5bd64f1c1106b394095d5449a4a2dc.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:53:59 +0200
        (CEST)")
Message-ID: <xmqqk2ednfdl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1EE67E2-7B78-11E6-87DA-2D857A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The subcommands are used exactly once, at the very beginning of
> sequencer_pick_revisions(), to determine what to do. This is an
> unnecessary level of indirection: we can simply call the correct
> function to begin with. So let's do that.

Makes sense.  And the diffstat is also pleasant to the eyes.

>  builtin/revert.c | 36 ++++++++++++++++--------------------
>  sequencer.c      | 35 +++++++++++------------------------
>  sequencer.h      | 13 ++++---------
>  3 files changed, 31 insertions(+), 53 deletions(-)
