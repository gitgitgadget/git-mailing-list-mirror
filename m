Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E381F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 00:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeK0LqM (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 06:46:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62843 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeK0LqM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 06:46:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB59E11A03D;
        Mon, 26 Nov 2018 19:50:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6m02IX2yHg90XdXHeeQ/AbO7Eoc=; b=cexSvs
        GymetSKRGfcAaFILOCoMUxdJ6MWqWPWRy2xrXs+doqc5rcwTJUt+65HK++tsrcfO
        RSixgCteYcwrTwDu/c/tzTybiD2xAyxyiZEfPzGJHgY07e/6SNdtZpw7CJQvNC7m
        EtFQYepl/StudTHFqQtYNLmdM5+nZBmJE0JfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yg9fPT8toCthvKU5xMttw1CtlerBf2Sb
        MSJI9WhKuSRgRw120HnX8ipY6vqL2ONI01cCBDeGIh/tAcgIk/lQMHukKhOKU7uW
        SRPeOWaPGjDqSlm/NkZUJaU5aqy4hXbAYcQF8XFJiOiZEr4DSnD9hkEtmFeZnyy4
        O22te1wJgOw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D380811A03C;
        Mon, 26 Nov 2018 19:50:09 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47EFB11A03A;
        Mon, 26 Nov 2018 19:50:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/5] ieot: default to not writing IEOT section
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003938.GC170017@google.com>
        <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
        <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
        <20181120060920.GA144753@google.com>
        <20181120061221.GC144753@google.com>
        <05e7df80-0dfc-c1ec-df14-c196357524f4@gmail.com>
        <CAGZ79kbaPKaCFGGXnbNchvk=1Q4Q5Hgt2hXOhcGo6pVwquhaEg@mail.gmail.com>
Date:   Tue, 27 Nov 2018 09:50:08 +0900
In-Reply-To: <CAGZ79kbaPKaCFGGXnbNchvk=1Q4Q5Hgt2hXOhcGo6pVwquhaEg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 26 Nov 2018 11:59:16 -0800")
Message-ID: <xmqq8t1fuywv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63BBB836-F1DE-11E8-95BB-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> > +static int record_ieot(void)
>> > +{
>> > +     int val;
>> > +
>>
>> Initialize stack val to zero to ensure proper default.
>
> I don't think that is needed here, as we only use `val` when
> we first write to it via git_config_get_bool.

Yup.
