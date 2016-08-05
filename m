Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36AA20193
	for <e@80x24.org>; Fri,  5 Aug 2016 06:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbcHEGZc (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 02:25:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030269AbcHEGZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 02:25:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75F822CFE0;
	Fri,  5 Aug 2016 02:25:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hTHdDtOTT8mfhFQaRZpKcdjgwAo=; b=dG6XGS
	K1V+N367KiggKFrxGLC5i9kWOFZ9ndr1WLtqJeSHAOq+DgtCTjV06h9zptWTzYnp
	Zr7Ktd/Csjdp2hKtSKs04glavOTd73OdbB+4AxzjnLjyTW2rOq32LUnsoItaCJ12
	8B8cqBaogu7abR/1v08e7M6wlpWMcYImDJoDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GSvB66q/rdXI8SZvM3oLFAo8Kg/+Jyss
	JSgC2XsHdmAbqg4p6Spb2e48C3uauC9zXI9j1YyDT9dfYfjIgV14yI3RJy0Fhikk
	sPA7CWwPljG9ii5HhwY5BzmP78NiX6z5qS+LxH3CtrsW/HDf+DyD3Bzb0i4F7dMe
	tZu+bxlMGM0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E2652CFDE;
	Fri,  5 Aug 2016 02:25:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E14422CFDB;
	Fri,  5 Aug 2016 02:25:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Lukas =?utf-8?Q?S?= =?utf-8?Q?andstr=C3=B6m?= 
	<luksan@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
	<20160804233435.GA31403@dcvr>
Date:	Thu, 04 Aug 2016 23:25:27 -0700
In-Reply-To: <20160804233435.GA31403@dcvr> (Eric Wong's message of "Thu, 4 Aug
	2016 23:34:35 +0000")
Message-ID: <xmqq37mjzq94.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67EABD14-5AD5-11E6-B42E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Yay!  This finally introduces the Linux kernel linked list
> into git.  I'm not sure if it's worth the effort to introduce
> cleanup commits to start using it in places where we already
> have doubly-linked list implementations:
>
> (+Cc Nicolas and Lukas)
> * sha1_file.c delta_base_cache_lru is open codes this
> * builtin/pack-redundant.c could probably be adapted, too
>  ... any more?
>
> And there may be other places where we have performance problems
> walking singly-linked lists and would be better off on a
> doubly-linked one (or even just readability ones).

Sounds like a set of fun projects.
