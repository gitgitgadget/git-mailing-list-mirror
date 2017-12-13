Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D161F407
	for <e@80x24.org>; Wed, 13 Dec 2017 19:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbdLMTFc (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 14:05:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59057 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753817AbdLMTFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 14:05:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93792B7194;
        Wed, 13 Dec 2017 14:05:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4W1+Pn/HcXBTV/IFIDp7WL4ExS8=; b=K09Cx3
        ZBOWbIajuWcDL8Co4K0fhRBFCIKkcfMyVjhP3wNw19y8nNiLJdD6bzcr+jiErJJr
        tmuRJ/qkfXZKrAh4Sb21Pi1Y9DoCd/RMTinURihQNbA4adI0lEy0JM9TKspaw54f
        3Z8inh9oz9CFBuqPjUT1ZqojiDtLH+gRh+BXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ez7vaMeGNFDqRQmt7TrwLzDFuv+x106M
        nQpP0PVRB9dl8rtpVPaj83O2B7J5aMXonuasojhbSWOd1D1+TgDyPgxHxQYWmS4R
        YrDfVjxO4YUml7nLLGGrZAgm+/7I62W+DcMq5vU1By/bz8+mKpqxw8xdxLAZvrZu
        dzWcwH963EI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BE99B7192;
        Wed, 13 Dec 2017 14:05:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12E47B7191;
        Wed, 13 Dec 2017 14:05:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH v4 00/34] Add directory rename detection to git
References: <20171129014237.32570-1-newren@gmail.com>
        <xmqqh8svxwpm.fsf@gitster.mtv.corp.google.com>
        <14bf2760-2787-5dd3-e5cc-a2ec0e0d8950@ramsayjones.plus.com>
Date:   Wed, 13 Dec 2017 11:05:28 -0800
In-Reply-To: <14bf2760-2787-5dd3-e5cc-a2ec0e0d8950@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 13 Dec 2017 18:15:49 +0000")
Message-ID: <xmqqvahawirr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96349DA4-E038-11E7-9A3F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 13/12/17 01:06, Junio C Hamano wrote:
>
>> We may probably want to redirect the output of underlying grep to
>> /dev/null in test_i18ngrep to make this kind of misuse easier to
>> spot.
>
> I have test-suite failures on the 'pu' branch for t4151-am-abort.sh
> (#3 and #6) and t5536-fetch-conflicts.sh (#3 and #6-7), which on a
> very quick inspection seem to be due to this (ie your SQUASH commit
> e5c5e24ad9).

Yup, sorry for leaving it broken this morning.  I re-pushed after
dropping the /dev/null experiment to fix it.  In the longer term, I
think we should make sure that output from test_i18ngrep is never
used (i.e. t4151 etc. must be fixed), though.

