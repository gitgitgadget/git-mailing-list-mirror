Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253FBC4332F
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347662AbiDAQi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350588AbiDAQiK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 12:38:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045E11BE107
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 09:16:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E2A611DCA0;
        Fri,  1 Apr 2022 12:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PFC1FW7lEtMlGV7dJcqzLx3jAizzJuDYcvAKbB
        n6kv4=; b=OvYUDpoBXgFpPOG6TOh1tGN2hX0v7eSxubR8YgxiV9svM/FOl4EM0Z
        Mk/PoTWGb/tgJJMuYmaKUzcxXYww4b/GGieWooWK6dsk7HkUb5Uo7IVZIxi4b3C7
        x+6LHxH0KZ5AqmXSQN2Afl/mT3BwNKLKFRxLDnNTog0Jb3gVTDrzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35F1511DC9F;
        Fri,  1 Apr 2022 12:16:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9603F11DC9C;
        Fri,  1 Apr 2022 12:16:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        jonathantanmy@google.com, philipoakley@iee.email
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
References: <20220208235631.732466-1-calvinwan@google.com>
        <20220328191112.3092139-1-calvinwan@google.com>
        <20220328191112.3092139-4-calvinwan@google.com>
        <15354CB8-E1DD-476C-B6E0-52F9451108A6@gmail.com>
        <CAFySSZAwXJc6BG8Q9P3h9njyMGz9YsOuCWSwTp+33vafiJ4L_A@mail.gmail.com>
Date:   Fri, 01 Apr 2022 09:16:40 -0700
In-Reply-To: <CAFySSZAwXJc6BG8Q9P3h9njyMGz9YsOuCWSwTp+33vafiJ4L_A@mail.gmail.com>
        (Calvin Wan's message of "Thu, 31 Mar 2022 12:56:14 -0700")
Message-ID: <xmqqpmm0ye1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DB79E60-B1D7-11EC-BAB8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> But, as a larger question for the list, I'm wondering if it's
>> best practice to separate client from server in tests, or if it's
>> an accepted style to just use one repository in cases when it
>> doesn't really matter?
> I am as well!

I do not speak for "the list", but many fetch-push tests were
written to use the same repository, and many early submodule tests
imitated them to use the initial test repository and add it as its
submodule, out of pure laziness (and I am probably the most to be
blamed)---these scenarios are not very useful but when the transfer
itself is not the focus of the tests it was a handy way.  Of course
it is not encouraged, and those tests that do care about seeing
objects getting transferred do make sure that they are as
independent as the real world settings that we want the feature
being tested to be working in.
