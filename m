Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE18C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2442070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LqRIdATa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFJRJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:09:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64751 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgFJRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:09:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50306D7B19;
        Wed, 10 Jun 2020 13:09:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BZvs+LEKpDUytwSNslu/cGpiOSY=; b=LqRIdA
        Ta2/H5f/nT6uHGfLjHOfyGA9hhUOAIQ1jnkm34H/QuStv+pCA0JJCJZiuK4oZZ+E
        rsLZBNIDcddHLZ6pPdgS7J14OV6qAUzimWB7ermFCy9efDhHXzRwlj15j2Bn3xHQ
        N+8Zf2cKnj7elTqZ7k/T1yU09+QHbLPes+jv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cwz/d3O4QluCEv02L5jr9f862+AEJIpT
        JGs4tRdQFyDYO/tu1Zef0izRYWA0CkhTYeamn6X2K24mktyDb67xkZDWh7TrO4dJ
        5lktKrqiY6evkDJadGfO6xSeugGr8nRPoEBFr7Rzvm4pYgNnMH265uVB73dcE1Vf
        aKFEB/ErYXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47FE2D7B18;
        Wed, 10 Jun 2020 13:09:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 78274D7B16;
        Wed, 10 Jun 2020 13:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwenn@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "hanwen\@google.com" <hanwen@google.com>
Subject: Re: [PATCH v16 00/14] Reftable support git-core
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>
        <CAOw_e7ZzEyb+21QHcNGcj5A8N501-a5fF3HNL0Jq6uD8S37G6A@mail.gmail.com>
Date:   Wed, 10 Jun 2020 10:09:48 -0700
In-Reply-To: <CAOw_e7ZzEyb+21QHcNGcj5A8N501-a5fF3HNL0Jq6uD8S37G6A@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 10 Jun 2020 08:56:43 +0200")
Message-ID: <xmqqimfyg84j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31CCC17A-AB3D-11EA-B569-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwenn@gmail.com> writes:

> There is also:
>
> reftable/stack_test.c:27:7: error: incompatible pointer types
> initializing 'PREC_DIR *' with an expression of type 'DIR *'
> [-Werror,-Wincompatible-pointer-types]
>         DIR *dir = fdopendir(fd);
>
> on OSX. What is the proper dialect for reading out a directory within
> the git source code? opendir and fdopendir are POSIX, so I'm surprised
> this fails.

I am reasonably sure we use opendir() to iterate over existing files
and subdirectories in a directory (e.g. in the codepaths to
enumerate loose object files in .git/objects/??/ directories).  

I do not offhand know we also use fdopendir() elsewhere.  I strongly
suspect we do not.  Perhaps some platforms do POSIX.1-2001 but not
ready for POSIX.1-2008 or something silly like that?
