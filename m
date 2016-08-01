Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64DE1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbcHATOw (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 15:14:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754747AbcHATOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 15:14:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 417EA32E27;
	Mon,  1 Aug 2016 14:40:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p08kEGlPAplHf93yDrgC6X9NBOo=; b=J0N+jf
	oYftzbE3z1wZKryi7MlcB8ezayWEjE9AYWuSh+KPc3WcP3aEw354GKe2V2z6UohU
	LXKzBtDRV5cGCBYO3hEC+iEajmli4Kzx+lhg7Doe1kGsDJg01B7t0BoLaF0jNVfV
	2VmK+k6DUV2xRXGzxDzEUFlt6qQOA1ySDncEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9VWPodImTPxyrwTYbkZYBOX+LUGpneI
	hZmdcJjenuz4T2mymrAhiCOxIANYl1Q6HtJ56dQN4DD5G480bl73mRB1MQ39XjDP
	7A37weGJqwXwCMLF2gALoFprqrN3SbEUJGJ5n47WjjBg2PdwTaft9jIzM3hGHK1J
	zy0i6uQfRQQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 388A732E26;
	Mon,  1 Aug 2016 14:40:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE40F32E25;
	Mon,  1 Aug 2016 14:40:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 05/16] Prepare the builtins for a libified merge_recursive()
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<d3c5678faf46391ce684aa79927a54cf15beea3f.1470051326.git.johannes.schindelin@gmx.de>
Date:	Mon, 01 Aug 2016 11:40:39 -0700
In-Reply-To: <d3c5678faf46391ce684aa79927a54cf15beea3f.1470051326.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 1 Aug 2016 13:44:08 +0200
	(CEST)")
Message-ID: <xmqqpopsjpso.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7393510A-5817-11E6-99E5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Previously, callers of merge_trees() or merge_recursive() expected that
> code to die() with an error message. This used to be okay because we
> called those commands from scripts, and had a chance to print out a
> message in case the command failed fatally (read: with exit code 128).
>
> As scripting incurs its own set of problems (portability, speed,
> idiosynchracies of different shells, limited data structures leading to

I think I typofixed this when I queued the previous one on 'pu'
already, but s/synch/sync/; 

