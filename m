Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31301FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbcLASth (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:49:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58649 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752602AbcLASth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:49:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1EEB52562;
        Thu,  1 Dec 2016 13:49:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GwGSyNvi98YgAmRrV6O+LFV1LJw=; b=KJNNcd
        cAgQCFreBZCtJaji8gjH5/j7kBdtt24d5etvqD04GJJy2iIUX7sHlvqnPdAiLNhU
        yTnUfItFedbafcBt7EngdUHtFyiK8q64xntvywkYk07qMVugmpOUM9mOuEVVnxxq
        LWubwDTcnV4j7hroULMTCzB8KVDJjOIS7nq68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IkttVbHU7jimmP5RRUAegZvSKbfLIqSO
        BcIZazOQUoab/R72rbL7Xak/fUQEfua9mw4n1Aqh5Swj4waAWWh9Nc5mafLvc004
        FdLV+5c25KJanxH4c/6OOGzP+Xc9uZfZD8Dnmgm7Lqjaqp0Ym6P9vbEHhEcYKp3R
        O22KGUpDBZ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9DD952561;
        Thu,  1 Dec 2016 13:49:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30B8D52560;
        Thu,  1 Dec 2016 13:49:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, peff@peff.net,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 5/6] grep: enable recurse-submodules to work on <tree> objects
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
        <1480555714-186183-1-git-send-email-bmwill@google.com>
        <1480555714-186183-6-git-send-email-bmwill@google.com>
        <c6b2ddad-ac09-3457-8289-88a3f52b7e4b@kdbg.org>
        <20161201175107.GB51406@google.com>
Date:   Thu, 01 Dec 2016 10:49:34 -0800
In-Reply-To: <20161201175107.GB51406@google.com> (Brandon Williams's message
        of "Thu, 1 Dec 2016 09:51:07 -0800")
Message-ID: <xmqqshq7a3i9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E75CCC08-B7F6-11E6-8777-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 12/01, Johannes Sixt wrote:
>> Am 01.12.2016 um 02:28 schrieb Brandon Williams:
>> >+	git init "su:b" &&
>> 
>> Don't do that. Colons in file names won't work on Windows.
>> 
>> -- Hannes
>> 
>
> This test is needed to see if the code still works with filenames that
> contain colons.  Is there a way to mark the test to not run on windows?

Something like:

test_expect_success !MINGW 'a test' '
	git init s:u:b
'

