Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EBC21FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbcHJUyk (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:54:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932761AbcHJSJv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:09:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A950F35409;
	Wed, 10 Aug 2016 12:33:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HjVHPi96GkbN
	SQYxmQEabEx9VtI=; b=YSbZdMRayw5mw2rCmriClG5GDUydv9SQwAWCIS5sYf3Y
	328qitiGXYuc5qo0y1b6rrZgmBDNLJJ4WfKhVpepXK0Crln5A8767u6IU6Wd6+za
	81+t0fPr31A5HF2+Qm7ZB09xN2+WC/pTraEZUVWRfoy01KcHiMxsCaUWdwk4/XA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d18r0t
	ZjtSeAw6VAmxlHub++HGp3fCGE7g8ca14jmNgeO6IeESFIa97Np04n2UA6TmG6jm
	hAWjCCw39ymFzlKn3+CBOzLlDjqGcwz+YFU2Qby4nUxVZiDkUVv0LMU3lph6A29m
	a9FldcFE+L1oHaCPFsgO/YYn9H0APqXko07+E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A04FE35408;
	Wed, 10 Aug 2016 12:33:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3384C35407;
	Wed, 10 Aug 2016 12:33:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge: use string_list_split() in add_strategies()
References: <57A4FEAF.3040208@web.de>
	<alpine.DEB.2.20.1608081034250.5786@virtualbox>
	<xmqqeg5zf8mh.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608101431300.4924@virtualbox>
Date:	Wed, 10 Aug 2016 09:33:26 -0700
In-Reply-To: <alpine.DEB.2.20.1608101431300.4924@virtualbox> (Johannes
	Schindelin's message of "Wed, 10 Aug 2016 14:31:34 +0200 (CEST)")
Message-ID: <xmqqfuqc7fe1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2ABC3A8E-5F18-11E6-B356-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> All true, but I guess this type of complexity would really complexify
> René's patch too much, so I am comfortable with the patch as-is.

Yeah, good that we reached the same conclusion, as my point was that
for_each_word() would not be all that useful.
