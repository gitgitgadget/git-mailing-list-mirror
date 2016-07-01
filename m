Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841922018A
	for <e@80x24.org>; Fri,  1 Jul 2016 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbcGATZn (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 15:25:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751996AbcGATZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 15:25:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6F51275A7;
	Fri,  1 Jul 2016 15:25:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tDmp2jAaQ47/0Rsi0YAz7qfLn84=; b=E+vOFF
	yPCipRPtGTGhoqYenDbnQRrAtCt4Te5bQOyzXFJH9IRk2+aHu7ISjnWcx0QRUsu3
	gULIjkdxR/mXOvK1/iK6bXzlYVVTSVHuiMnuRI0zJ7pcSAvsGKiBBkOeufMIW6aY
	HtNvfVLILQMT9FJv4U0yRrludbKmTCQuGIU1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SIcImPaT7gCfys3s5JVyCNmlc8rlOo/T
	8f43h/Pn/0ggDIvCqsq47mQbBCTRhB/+zHwI0OtFocbWC1EzNbSRxLu4ehFT1WHr
	J3+5YYzPgHQE+t3r5GUGJWeJ0+bJsfBwsSyplPwXpW9VcFAPA61v9Bfp9gG4JOcE
	x5gp8wRDU1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BED00275A6;
	Fri,  1 Jul 2016 15:25:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 489A0275A5;
	Fri,  1 Jul 2016 15:25:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about push options
References: <20160630005951.7408-1-sbeller@google.com>
	<20160630005951.7408-2-sbeller@google.com>
	<20160701071410.GG5358@sigill.intra.peff.net>
	<CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
	<20160701175950.GB16235@sigill.intra.peff.net>
	<CAPc5daWjSW5KM4uUyEBbb+765t50+dUsewF52uPrCiT1HW=NAQ@mail.gmail.com>
	<20160701181102.GA16695@sigill.intra.peff.net>
Date:	Fri, 01 Jul 2016 12:25:39 -0700
In-Reply-To: <20160701181102.GA16695@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 1 Jul 2016 14:11:02 -0400")
Message-ID: <xmqqr3bdxirw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99361EEC-3FC1-11E6-858E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Compare to:
>
>   if test "$GIT_PUSH_VAR_force" = true
>      ...

OK.  As this is a new feature, I guess it is not too bad if we tell
users that they cannot have duplicate keys in their <key,val> data
they ask Git to transport.  They can do the key1=val1 key2=val2
numbering themselves if that is really needed.

