Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323FC32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E32E21D56
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BVJz1zlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgARSKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:10:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50094 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgARSKD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 13:10:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C839407D6;
        Sat, 18 Jan 2020 13:10:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bpagU2BfeiE0foSKzIYaj+8jdic=; b=BVJz1z
        lCgEx5jqrda2niyrtDeuD4YGUxiuE+P8QzpGpdPkZWtMM+rbvqWEutYVIzPdnWro
        WU3lkzBneSBpBwd7uNzPWrYGeikNRvZNMh4xltNfNzMo5biLsg0GCRQekXvEBgZ6
        gR0xbZ+jazoQsyvS1sGsZ/SwB6pIHC8zntqrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H4IVef5ZzA0ajjNhydlQ4AhAfZHt3Xvj
        yCx8Cn2/ajg4W2kl7fIyzWtk9mDmtqwIgfpBDtTH7tk//c7dw/bTTLtLoejfXbCr
        yf/3HXyTBJMAkO39u3Sa1YOuQxbyBLuKtWoNL9jYgT7Af7pz+t+MWhui+Qlc+SKT
        7nPgQxGW8Mo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 380AB407D4;
        Sat, 18 Jan 2020 13:10:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D350407D3;
        Sat, 18 Jan 2020 13:09:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] config: refine config scope enum
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <f06f9291b7c357422abad9f9cdd7425ef9e22509.1579275102.git.gitgitgadget@gmail.com>
        <xmqq1rrxertd.fsf@gitster-ct.c.googlers.com>
        <CAOjrSZsnyt5PO5n74YYC4_T4rw77dEZ49frH4Fq+bKoMBX9exg@mail.gmail.com>
Date:   Sat, 18 Jan 2020 10:09:58 -0800
In-Reply-To: <CAOjrSZsnyt5PO5n74YYC4_T4rw77dEZ49frH4Fq+bKoMBX9exg@mail.gmail.com>
        (Matt Rogers's message of "Sat, 18 Jan 2020 10:27:16 -0500")
Message-ID: <xmqqblr0d4ax.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD806208-3A1D-11EA-AA6C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

>> So the gist of the change is to split REPO into two, LOCAL and
>> WORKTREE.
>>
>> If we can find a way to state that concisely, perhaps we can improve
>> "refine enum" and make it more informative.
>>
>
> Should I just say "split repo scope" Or is that too on the nose?

Yeah, I think phrasing along that line would work well.

	config: split repo scope to local and worktree

That's 46 chars.

