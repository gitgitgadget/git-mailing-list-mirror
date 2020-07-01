Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDBDC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 19:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E3E20720
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KOACjCcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGATvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:51:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55244 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGATvV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 15:51:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B814C608A;
        Wed,  1 Jul 2020 15:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9iDn76eOro96
        OVSBOitpoHbE2BE=; b=KOACjCcmHDHPgbqMIRgXT9chmSsFG2BQ/NtXl4PQ6HwD
        J8rsZWXoKkS1TgWslmyYlwNIf0UD8JtUXEi4XAVj1A2u/F4SOTUnwIJX1u+g4Sr2
        L94hVYVHlD0kUFHwSYgFMi6S8ksMkGAa5ea/lsaYcFC07qcdoGc8cutc5l4F79s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yfUqC/
        zoNs+GI3XT5AthLkxp3vKI1ohSKcDXwUu+OfAMjhHfZ56gxfTL/GaHwQcO00yZ62
        wKJPkyQaDTgPZ61GPrOjymU8xQ/3nLsGLYaJ5L1jaOLyD9gvmq+efj/YnrHEElt6
        NT9XdrgwGn6HYN3qsT3RfjlsQaLss56RFaYCo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0445EC6089;
        Wed,  1 Jul 2020 15:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4359AC6088;
        Wed,  1 Jul 2020 15:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     sunlin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v5] Enable auto-merge for meld to follow the vim-diff beharior
References: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
        <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
        <20200701141755.GB1966@danh.dev>
Date:   Wed, 01 Jul 2020 12:51:15 -0700
In-Reply-To: <20200701141755.GB1966@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Wed, 1 Jul 2020 21:17:55 +0700")
Message-ID: <xmqq7dvndnf0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A3F4D80-BBD4-11EA-81D8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> +mergetool.meld.hasAutoMerge::
>> +	Older versions of `meld` do not support the `--auto-merge` option.
>> +	Setting `mergetool.meld.hasOutput` to `true` tells Git to
>
> s/hasOutput/hasAutoMerge/
>
> Bikeshed opinion: I don't know if hasAutoMerge is a good name :)

I do not think "has" is a good choice for this one, even though
hasOutput may very well be a good one for "output".  As the
paragraph describes (below), this lets the user "avoid" using
"--auto-merge", even if the version of "meld" the user has does have
the automerge capability.

So perhaps say "mergetool.meld.useAutoMerge"; that will let the users
express exactly their wish---don't use it (false), do forcibly try
to use it (true), or use it when able (auto).

