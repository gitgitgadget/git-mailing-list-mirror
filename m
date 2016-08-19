Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D1D1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 21:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbcHSVOM (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 17:14:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58695 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753990AbcHSVOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 17:14:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 126FB35F44;
        Fri, 19 Aug 2016 17:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HpH5hDQ8yElbB53IlLYE7m3WIuw=; b=F/AC4v
        46a7pRDrhIsxx9ZrD5CAkPmx8sSnmlDlesh/6+jc2gAcWxJMjPWhUw6bgAnVECNe
        ceFkZ3UH9LuJBiN6mD4tEQlLmuTch0HwdnoLLgq2ZalItK6RWIGI0hhkz1TtL7h7
        B62FWgYxNdLcPbwgINoX5frkL5G0SJSbvZsuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iw5Hfc6dnfZ3qatpFWkIx2HIerpodvbU
        R2NruVrJi4VVyZf1AI8CLb11k4PjBQ6A20V5UEY5EhNZA0sq5o8kJagJnHt8+ilj
        jNmGVHphOHelm1PlZJeo7rQLkSSJVTt3M7sJ6XsB7YnawIkWkmW/H3KsJTZmURYW
        3QDNgz1ASmc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09DEC35F43;
        Fri, 19 Aug 2016 17:14:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7154E35F40;
        Fri, 19 Aug 2016 17:14:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v8 7/8] cache: add empty_tree_oid object
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-8-jacob.e.keller@intel.com>
        <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xp6VDdMnh-srDzToSwh3mZrQei+B8DjpB2N6OkqAuARkw@mail.gmail.com>
        <xmqq7fbc1o1f.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 19 Aug 2016 14:14:08 -0700
In-Reply-To: <xmqq7fbc1o1f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 19 Aug 2016 13:50:20 -0700")
Message-ID: <xmqqtwegzckf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF42403A-6651-11E6-B269-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Is there a reason for that? I've found that .field = value is safer
>> because it ensures that you don't end up initializing the wrong
>> values? Or is it a compatibility thing?
>
> Yes.

That was a bit too terse.  The answers to all three questions are
"Yes", "Yes", and "Yes".

Together with enum ... = { A, B, C, }; we may want to consider not
worrying about ancient compilers at some point, and it might be this
year or next year, but I do not think we want to do that as part of
this series.
