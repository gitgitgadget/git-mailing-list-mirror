Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9133BC49361
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A0F61400
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFOD2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:28:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59825 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhFOD2n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:28:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1481813BF44;
        Mon, 14 Jun 2021 23:26:40 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=1NKwxPJo/0y7CGxwCn2xC9jybm+5efc6jYP67i
        YdK4I=; b=mdGvkFGcQkt99oFqr44/Wy6FwgNpOWTPAc5HrxW9I3lmWoFSH6+fcF
        /ep2ZbQnOIm434gu11ENpJ2w5e1C/OjHXBQ670H/16OkUBd78lJRm3NsWbi1B0zx
        dsfUuNMxCkZiD6QATc5Rk32NN+3poHgJVljNAilTAp/PYTRoQ9fyA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F184013BF42;
        Mon, 14 Jun 2021 23:26:39 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=1NKwxPJo/0y7CGxwCn2xC9jybm+5efc6jYP67iYdK4I=; b=mUpbQWXYkWhsI8G+Zu0/o4rm2cmJxS7Dl3gqQFvWRJrUXiAo6xkQ9Xv1sTz4Re72Dlu4SFN5G/sMtgMWa7XbKqp5syy7SuLiNLk/jJQgq7JRQeyhj3aSQkXwCu0THtDVYLFZ407GM30zWVCEgzVa6dkL7dEOAYp/9q3isInGF9A=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E0CB913BF41;
        Mon, 14 Jun 2021 23:26:36 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 3EF8E2DA0044;
        Mon, 14 Jun 2021 23:26:35 -0400 (EDT)
Date:   Mon, 14 Jun 2021 23:26:35 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
In-Reply-To: <CANYiYbFsqj9j_UT9-mF+BSOAHU4=On+BUxCU4w6rXhhMaeo=zg@mail.gmail.com>
Message-ID: <r8ss67nn-31s4-o429-828p-s787sr2481@syhkavp.arg>
References: <87im2s5jjm.fsf@evledraar.gmail.com> <20210612050711.4057-4-worldhello.net@gmail.com> <xmqqim2hyuj1.fsf@gitster.g> <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com> <xmqqk0mwylhc.fsf@gitster.g>
 <CANYiYbG6bKwheThWz2ecHUTh7JFmTsi-F9FtYkcoS0az=f=m6Q@mail.gmail.com> <0pqq6s9-n238-95ss-nsqr-42o75sr933r@syhkavp.arg> <CANYiYbFsqj9j_UT9-mF+BSOAHU4=On+BUxCU4w6rXhhMaeo=zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 7DC733DE-CD89-11EB-87D8-FA9E2DDBB1FC-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 15 Jun 2021, Jiang Xin wrote:

> The issue this patch try to fix is like the following example:
> 
>     PKTLINE(\2 "<progress-1>" CR "<progress-2>")
>     PKTLINE(\2 CR "<message-3>" LF)
> 
> The message "<progress-2>" is displayed without a proper clear-to-eol
> suffix, because it's eol (CR) is in another pktline.

I'd fix this issue with the following logic:

bool pending_clear_to_eol;

my_putchar(c) {
	switch (c) {
	case '\r':
	case '\n':
		pending_clear_to_eol = true;
		break;
	default:
		if (pending_clear_to_eol) {
			clear_to_eol();
			pending_clear_to_eol = false;
		}
		break;
	}
	putchar(c);
}

In other words, you clear the line after printing "remote:" but only if 
there is a non \n or \r coming next.


Nicolas
