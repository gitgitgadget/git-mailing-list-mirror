Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A484C4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4704B22262
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rql3bOul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVQyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 12:54:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58033 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgIVQyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 12:54:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D487FD6C6;
        Tue, 22 Sep 2020 12:54:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qVCsumGuM0pheNp1i1s6qyCiaqQ=; b=rql3bO
        ulo64FzuIhqFI1zWzpTY+/O7vxRWXolOat5jP9vAWHmWXJOAA+MvZyy2OP3e8rin
        rblGLUplL8Lkc5pasbOwE2lfZJ4ze5Opr9AeyiHbpArOqgVvWcbFt0z60VGa2B50
        stiIqRNqw+wkZNTycBa1CGzb8PlngqvFuTqD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eDr0vTHNMYJQ4Ou3bS2qg74c0b5hHXTA
        pJcHZuANRNVuLUJO+gSWreNy0iDDyzmJZR4nY4bD+0RJnuTudGkR5Kl2m0FhaVGu
        C7UZbxXi9PIlKXMhunzNKeNi9UmpcEuTsOxRPOkcjRscfOUuHfbvf+6S4zKtAcAM
        Gjiu1i1IKQA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 469A0FD6C5;
        Tue, 22 Sep 2020 12:54:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D9E9FD6C0;
        Tue, 22 Sep 2020 12:54:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
        <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
        <CAPig+cQNiB8nw-JwwFweHzeFYcozGA06pPKr=0N9Metp8PBbSQ@mail.gmail.com>
        <6da3752f-5e45-1381-b54c-64a81d642b72@gmail.com>
        <xmqqeemvexr1.fsf@gitster.c.googlers.com>
        <52217e7a-5a51-48e4-5496-96ac68602200@gmail.com>
Date:   Tue, 22 Sep 2020 09:54:09 -0700
In-Reply-To: <52217e7a-5a51-48e4-5496-96ac68602200@gmail.com> (Phillip Wood's
        message of "Tue, 22 Sep 2020 14:38:03 +0100")
Message-ID: <xmqq5z85lpla.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D20462E-FCF4-11EA-817D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>>>> +test_reword_opt () {
>>>>> ...
>>> ... I should probably check that nothing is printed to stdout in
>>> these tests
>> Perhaps, but that is not the point of "do we diagnose options thare
>> are incompatble with --reword?" test.
>
> I think it depends if one views the test as checking "do we diagnose
> options there are incompatible with --reword?" or "what do we show the 
> user when there are options that are incompatible with --reword". For
> the former we just want to check that the correct error message is 
> printed, for the latter we want to check that only what we expect to
> be printed is actually printed.

I dunno.  It is plausible that we will further give some advices
(not directly related to --reword option being incompatible with
other options) and output may evolve.  I do not think we want to be
updating each and every test that expects exact output.

In other words, the answer to "what do we show when --reword and
another incompatible option are given?" is "we want to point it out
that --reword and --amend are not to be used together" and not "and
we should not ever say anything else".

Just like back when we started making sure everybody sets user.name
configuration variable (and the way to do so was to give warnings
and advices at strategic places), output can be added to commands
where authors if each individual feature would not expect.  I would
want to see our tests prepared for such an occasion.  We cannot be
perfectly prepared, of course, but keeping the expectation focused
enough to check what really matters for the objective at hand would
help.

Thanks.


