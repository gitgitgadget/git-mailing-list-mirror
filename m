Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FB7202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933931AbdJQHMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:12:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51072 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932564AbdJQHMW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:12:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 718C7BA199;
        Tue, 17 Oct 2017 03:12:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PvT72GQYnyrQ+DJOLr78K5FlpoE=; b=OPrH6v
        nl1AmbLpLR7xSgbpdNfdjhUaTzsi64YrFtJXN4UYEmaV1IffNZmCO//E+1TfcfQi
        vrzo4W1Z2zuExhJR3+cGvm2wc/cLr3ub33DGYPv7bs+vyTqyuY9l5SLVQwqO0YHS
        K3pPcLOaiDYMmcFbWnnR+pFHN2MEXeLlTSyVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=srPEOaZgZjyi7dbupW5Cpxrm1qe+LcgR
        3YGukupxyunlxBnF7PvXUDrc+mptRxC4VjWhQfyTrj/hI4WCsxrIOd/7Zwx8+uH1
        GaiqzWAZHSW/SqQ2kToXtOAFjB9wMOo+6inJHyCKiH6WfPr48IcCeAQwdlbg9zSk
        ZA/hzCWa50Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 694A6BA198;
        Tue, 17 Oct 2017 03:12:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2732BA197;
        Tue, 17 Oct 2017 03:12:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] Re: [PATCH] check-ref-format: require a repository for --branch
References: <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
        <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
        <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
        <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
        <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
        <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
        <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
        <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
Date:   Tue, 17 Oct 2017 16:12:19 +0900
In-Reply-To: <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Tue, 17 Oct 2017 00:06:19 -0700")
Message-ID: <xmqqefq2nt7w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 844CCFC2-B30A-11E7-8858-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Handles the nongit case in strbuf_check_branch_ref instead of
> introducing a new check_branch_ref_format helper.

I view that as a regression, actually.  Don't we want a function
that does not require a strbuf when asking a simple question: "I
have a string, and I want to see if that is a valid name"?
