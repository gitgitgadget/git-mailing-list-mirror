Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6FD81F858
	for <e@80x24.org>; Thu, 28 Jul 2016 21:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbcG1VSf (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 17:18:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751375AbcG1VSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 17:18:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 906922FF49;
	Thu, 28 Jul 2016 17:18:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hEKxpvXdTlLcrRefXxul9DKhRac=; b=T39C8W
	yGAqzQF6uwW1g+dHTJnxZWpYrtFkxqHuqtSCH8gIIBZLV+lHO3VS/HTs+ldQv7vz
	M8WhFWvcmyxUFEHSm2H2GWsmPZmLdbCKwD/UWpWDQT0cpCnhIwq9JQX+XIzdOB6Q
	6MgNxUQ1UYq/MWb7oJoyXP9I6MNslW/7bAIQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DlBKF7xXGzIhUz2AP8wEJqzZ+W2aNi23
	3ChJb+knD3VOop6+8j1+XHADAJxj97HrKsG51QRZCCCLgsLxK4PNDKWmzDJbwdl9
	yddu0N69s96EbIu2hSXMNI04rCbbsc/gQlsbnEFQeOOax3QIrCE+m+GLrKLrLOPP
	XWd8Y6hHEwM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86E282FF48;
	Thu, 28 Jul 2016 17:18:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0826B2FF47;
	Thu, 28 Jul 2016 17:18:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when generating non-stdout pack too
References: <20160725185313.GA13007@sigill.intra.peff.net>
	<20160727201506.GA15204@teco.navytux.spb.ru>
	<xmqqlh0mvmpn.fsf@gitster.mtv.corp.google.com>
	<20160728202237.GC4026@teco.navytux.spb.ru>
Date:	Thu, 28 Jul 2016 14:18:29 -0700
In-Reply-To: <20160728202237.GC4026@teco.navytux.spb.ru> (Kirill Smelkov's
	message of "Thu, 28 Jul 2016 23:22:37 +0300")
Message-ID: <xmqqh9b9qx5m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D61396F8-5508-11E6-98D5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> I'm waiting so long for main patch to be at least queued to pu, that I'm
> now a bit frustrated and ready to do something not related to main goal :)

Perhaps the first step would be to stop putting multiple patches in
a single e-mail buried after a few pages of discussion.  I will not
even find that there _are_ multiple patches in the message if I am
not involved directly in the discussion, and the discussion is still
ongoing, because it is likely that I'd skim just a few paragraphs at
the top before going on to other messages.

I won't touch the message I am responding to, as your -- 8< -- cut
mark does not even seem to be a reliable marker between patches
(i.e.  I see something like this that is clearly not a message
boundary:

than `git pack-objects file.pack`. Extracting erp5.git pack from
lab.nexedi.com backup repository:

---- 8< ----
$ time echo 0186ac99 | git pack-objects --stdout --revs >erp5pack-stdout.pack

real    0m22.309s
...
)

