Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C853D1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbcHOPhw (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 11:37:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752590AbcHOPhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 11:37:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE8A33448A;
	Mon, 15 Aug 2016 11:37:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DIvh2wBetfTVatxb7UX+HoXdAiM=; b=bsDDrU
	Bju+Y609ebbdDfIDhvRRKO2e/DnxGpODKP9W5EeC0OKN5A4eQ6+4LXiCyC6CEMB4
	x/BhnNHvur7CbuhBiyWHVAaXXuGbmkbM7VGBJ2q9v06kOHAvzBqtBKTHubom5HWG
	GYCAmIS+Bb8anNTkP3ekEQ411bjEVlL+rUe1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b80BMNuZAR7jVYleQzarcodj8SlX8r+A
	OLdOvUrRq49+tN7sGarpzdkcPqCB/srNkJvyq1eRsoG/9+1VcO9gE9HPCpuUmoPH
	f9e9QUE6tEuF+JmG9BRQiDlHXy56ZbiP+VZMvpRzGUjQZIc0M7+93wmBRHNqj0Nl
	gn85CTYwJRE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4E8434489;
	Mon, 15 Aug 2016 11:37:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A48534488;
	Mon, 15 Aug 2016 11:37:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] diff: add --diff-line-prefix option for passing in a prefix
References: <20160811225946.18381-1-jacob.e.keller@intel.com>
	<20160811225946.18381-2-jacob.e.keller@intel.com>
	<xmqqvaz5vgc7.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xoX6AT7tGb5AJr1CSjzAQ67o8QXJFF1LxsV_7E_pF-moA@mail.gmail.com>
	<CA+P7+xq+GTbvzOtVvpu4_rdYYy-hhGZHhpk_ka=KkeU7UmQRew@mail.gmail.com>
	<CAPc5daVmyx+EX8H0yETfO6Vv+A7DqBM5bsqrnJdYzbEhVnA1wQ@mail.gmail.com>
	<CA+P7+xp_sPk6P1qyyDfOgpkXU1GxWPivfSzvveS4PAvGb-=ggQ@mail.gmail.com>
	<xmqqa8gfkpw1.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xr9RcKQ0uO_F7CtK6nsz83KH0OqpFaBVnzL1jqyP9YfSQ@mail.gmail.com>
Date:	Mon, 15 Aug 2016 08:37:48 -0700
In-Reply-To: <CA+P7+xr9RcKQ0uO_F7CtK6nsz83KH0OqpFaBVnzL1jqyP9YfSQ@mail.gmail.com>
	(Jacob Keller's message of "Sun, 14 Aug 2016 22:32:49 -0700")
Message-ID: <xmqqwpjihwkz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39413552-62FE-11E6-9004-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I will look more into how to do the log version tomorrow, if I am
> still stuck I will re-work the patches as you suggest here.
>
> I am hoping I can find a good solution for how to handle it though.

Thanks, I am hoping the same, too ;-)
