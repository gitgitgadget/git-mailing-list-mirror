Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D39C2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 14:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbcGFOv0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 10:51:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754507AbcGFOvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 10:51:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A025629425;
	Wed,  6 Jul 2016 10:51:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nHoarUAfgppdpVSYTXAkZG0cmsA=; b=RY5me/
	fVhICJGydAenPUxBPUc+Ea18NJTcQAfGbBICnVpuq7mlWdfV122Q/M/C/hdAh8Br
	9xE1RKY1nwwhPQhLhYODm846U2AGSFbG+S4odkwNUtl28e3kqYl3EbXmSLypH3JE
	vlUNmj/gCw6sHMHuarhAKPUvAT6Xy8Jbdj/jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dxh8WxL+mOvA60EhXNOrAVTf12jzO+3U
	s2LJ6jfvuho8or0bynwwV5m5LgO5ZYVXiO6K6Dh9BDnY9SoPgNMQ6U3YB49O/p6Z
	Ccqv9dDeeRideIbJajDFTrfDc4WN7jFV7Djo/ohZQGzGcFNj+1HxAZZ2OkeYcFKn
	WVv4FjanQDk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99F9E29424;
	Wed,  6 Jul 2016 10:51:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25DD629423;
	Wed,  6 Jul 2016 10:51:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3404: add a test for the --gpg-sign option
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
	<0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de>
	<xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606301019040.12947@virtualbox>
	<xmqqpoqxz6kp.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607020933080.12947@virtualbox>
Date:	Wed, 06 Jul 2016 07:51:20 -0700
In-Reply-To: <alpine.DEB.2.20.1607020933080.12947@virtualbox> (Johannes
	Schindelin's message of "Sat, 2 Jul 2016 09:38:46 +0200 (CEST)")
Message-ID: <xmqqeg76vmzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B760D70-4389-11E6-97C3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course I agree that it would be very nice to have a test at a later
> stage that does exercise GPG if it is available. But would it really be so
> terrible to have a (simpler, not as complete) test that is exercised
> *also* when GPG is *not* available?

What I would expect is "In the ideal world, we may want both, and in
an imperfect world in which we can have only one, we'd rather have
the 'even though we can run it only when GPG is available, we make
sure that we drive GPG correctly' one, dropping the other.", simply
because the end result matters more, not how the instruction to the
end user is phrased.

Sure, in even less perfect world, having a superficial test might be
better than nothing, but reminding ourselves to aim high (and make
sure we document the decision when we punt) is an important part of
the purpose of the review process, so...



