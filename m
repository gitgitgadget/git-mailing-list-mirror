Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 768832018E
	for <e@80x24.org>; Fri,  5 Aug 2016 16:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbcHEQSa (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 12:18:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759896AbcHEQS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 12:18:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 89E5E2F0FE;
	Fri,  5 Aug 2016 12:18:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V0LRAHXzEMAo/rkN4zX5GkcnnFQ=; b=x3RPW0
	MajQtVD1eZPMIj3iKQrBxeZB/0aG+mOPTykf0a6KuPFx6l6qnpzWUyS2NL5sSgnO
	cN6sZlw/O8ZA4D+esAUIKCXXGiAS9cFGMAjnb69wo7T1beX4YyCVwLVq/o3GNJ2P
	qdWBDI3rfIWOvOxorOK1sPRPfMwqKz5OZen+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0arVPRpQu8Cdzutizmu+YspMR8cIVhQ
	nBlXc3lg+dlmupQaC5AD2Sb/aglJ071FghabHXnzGKKakBhUT9dyOwzs1HPmxKtq
	s6uhFsI2wJF1YvvYKd6vuP01iqw1USBVuGDQcTWnNxQvBMVhMJp+9mqxhOfxj7wR
	uLmnpJMjH8Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8383F2F0FD;
	Fri,  5 Aug 2016 12:18:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08DDF2F0FC;
	Fri,  5 Aug 2016 12:18:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git mv: do not keep slash in `git mv dir non-existing-dir/`
References: <e0415c55e9bc651e7fa9f5f7717b4f6e44eb9ce1.1470407827.git.johannes.schindelin@gmx.de>
	<xmqqtwezxlf2.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608051754080.5786@virtualbox>
Date:	Fri, 05 Aug 2016 09:18:26 -0700
In-Reply-To: <alpine.DEB.2.20.1608051754080.5786@virtualbox> (Johannes
	Schindelin's message of "Fri, 5 Aug 2016 17:58:25 +0200 (CEST)")
Message-ID: <xmqqlh0bxk8d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E1FE718-5B28-11E6-A12F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Please note that t7001 *specifically* tests for the opposite of what you
> want, then ;-)

Yes, I know.  I am torn.

It seems "mv A B/" (not "git mv") when B does not exist does the
same "wrong" thing, so the existing behaviour is at least consistent
with the command line tools on Linux, and more importantly, existing
users of "git mv A B/" have expected it to ignore the trailing
slash for a long time, so let's not change the expected behaviour.

Thanks.







