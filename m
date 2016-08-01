Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4391F955
	for <e@80x24.org>; Mon,  1 Aug 2016 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbcHATBE (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 15:01:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754790AbcHATBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 15:01:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51EA63219E;
	Mon,  1 Aug 2016 14:59:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gq4hVyiwflArRx+lvfpf51M/uvc=; b=XpMcWw
	ZMv2opcLHsgufsFj6OUS9zJNcjo64erpFHCOs6REIaGUNduTtn7VlDDnc6FsiIjn
	/1UnXSGCGrH239S3LbnyUP0DVyjX5cNw3WqLnfigfsPwn05KCvyKiobKGOP7IHww
	75Ah5lW3BaUmcCuZGJQKSN+hw4q1jQk06jyKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=io/Sb1bYkBlWMTrZYf9INe/5CCGeaWaS
	dB2pOFL06j48hjuyhaaY7ZD4WPYT0DSjUtcpvxweWadjuA9w2bkVyfyAzLEgWU5W
	gKAlChmDb+m9VoMJF65//8jf2tsx0ZcsmKYIgzjVzPlw1wdUSYFpcx6fd/SRl4YR
	SBaS+lqiAV8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47C553219D;
	Mon,  1 Aug 2016 14:59:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD13C3219C;
	Mon,  1 Aug 2016 14:59:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
In-Reply-To: <20160801174316.4boo4slop77mtry4@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 1 Aug 2016 13:43:16 -0400")
References: <20160728211149.GA371@x>
	<xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
	<20160728215603.GA22865@sigill.intra.peff.net>
	<xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
	<20160729001618.GA9646@sigill.intra.peff.net>
	<20160729020801.GA14892@x>
	<20160729225800.GA23268@sigill.intra.peff.net>
	<20160730045055.e3t6tpgi6zch4epo@x>
	<20160730054742.iwmr4pavdy5z73rw@sigill.intra.peff.net>
	<xmqqfuqol7dx.fsf@gitster.mtv.corp.google.com>
	<20160801174316.4boo4slop77mtry4@sigill.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Date:	Mon, 01 Aug 2016 11:59:50 -0700
Message-ID: <xmqqfuqojowp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22D0ACBA-581A-11E6-941D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I half-agree. Config that causes unpredictable behavior can break
> somebody else's script that you are running. If you say "oh, I guess I
> shouldn't set that config" and move on with your life, then the config
> hasn't really hurt anybody. If you complain to the script author that
> their script is broken, and insist that they pass the --no-foo option,
> then the script writer does not care much whether it was a config option
> or a change of default.

Hmph, I never considered that POV but you are right.

I am not sure if that argues that we have to be even more careful
not to add non-essential configuration variable, or that we can
afford to be much less careful when changing the default, though.
A little bit of both, I guess.

