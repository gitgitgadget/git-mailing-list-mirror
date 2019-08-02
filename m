Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F04F1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 19:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392202AbfHBTcc (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 15:32:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53966 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392153AbfHBTcc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 15:32:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30E9115D0F6;
        Fri,  2 Aug 2019 15:32:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LIPNaOLhN+HVoO1OIFQsAcQ8nEQ=; b=AayF0u
        yFlGmmLDsbjzG67dW5A8/5PmbNrcxdBOwwaW3DnMV0F5jKpIy0vS5A285YwgmTep
        dEv3/lPf6QjzF097J7/037mDH1w+171y/RwPFztlEZ/LfTdetSAomnXdObBKgJp/
        gpDfqYAkxhtlkrEk7lTlikO22lrCRvwLqcWV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=it8ITNXjymKhIrtc16gweBdNlQPL5MZU
        OlViiPJj3hhaUxiTW4WJtv+qvfKK+MB2VvJdTn0Eyy5i4OUz8OXjoMYyLurJKpBP
        TMjYjsj5lTwVMTW6ue5F9V8eIYnAgsEWvLqdDTIwLlAkHhA8cyPxDgkMku0KdPsI
        ntIj4cl7368=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 279B615D0F5;
        Fri,  2 Aug 2019 15:32:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79FC015D0F4;
        Fri,  2 Aug 2019 15:32:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-log on a file, and merges
References: <CAA01Csp=g08N4+S1HKAjV2a12VJNSJU0UYdAU6LW1jGWLD9SLQ@mail.gmail.com>
        <05c77291-48d1-a592-6296-d8a8bdb16b02@gmail.com>
        <CAA01CspHCKA3itmTxFO1NeNB6DpdFx3CTbXKtO=TvtznLn_zAg@mail.gmail.com>
Date:   Fri, 02 Aug 2019 12:32:28 -0700
In-Reply-To: <CAA01CspHCKA3itmTxFO1NeNB6DpdFx3CTbXKtO=TvtznLn_zAg@mail.gmail.com>
        (Piotr Krukowiecki's message of "Fri, 2 Aug 2019 21:21:28 +0200")
Message-ID: <xmqqtvazjrcj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44124BC0-B55C-11E9-9D98-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> At this moment I'm not sure myself if I consider this a bug or not.

This definitely is not a bug but is a designed and intended
behaviour.

Think of running "git log" without "--full-history" that is limited
with a pathspec as a tool to ask Git to show _one_ way (preferrably
the simplest one) to explain how the current contents in paths that
match the pathspec came to be.  The "just explain to me one way" is
not about machine performance but reducing the clutter in the output
to help human reader(s) reading an otherwise complex history.

