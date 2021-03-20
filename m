Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C97C433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2928F6193A
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 21:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCTVGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 17:06:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62640 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTVGc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 17:06:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A33741203BB;
        Sat, 20 Mar 2021 17:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1zQ5fqW17O90sq+KYM+eEQwZPdI=; b=CKmKuH
        HEFIvlYlN2wC08A+/Xs++s/dtsHMjdMf6XuV9rPvsHJcVfdgdF1mB56/Po3tDKLJ
        X6+D0nTPbC1GEoA7t/WoNtTMhLSLBsN6zw0dqITkXsuGc3iP4WdkSUDOf+pXkssr
        QSy57DiSTqGakpzED1enOYDJhSyw/lW1IufpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iNEQcN4jGvO9nUHizOT/GE0YFQiI73Ow
        W8cV4m7fKCf5KJFTY5zydJbp/b8BHrbdAHWAEoZlg2E7STdp8ieGoQxZMSrSoyT5
        S5kYFCoeNyLJ5PMWG/i1aZpeC9hWPVicyZroh0JQ1sKkkJj9MKC2h3PHkGFHa4MR
        e8vw8s6G+s4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B6D81203BA;
        Sat, 20 Mar 2021 17:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E113A1203B9;
        Sat, 20 Mar 2021 17:06:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqn?= =?utf-8?B?biBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] interpret-trailer: easy parse trailer value
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
        <ca521d3c01d652e09e716fb447b0b26da1a014e8.1616251299.git.gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 14:06:27 -0700
In-Reply-To: <ca521d3c01d652e09e716fb447b0b26da1a014e8.1616251299.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 20 Mar 2021 14:41:38
        +0000")
Message-ID: <xmqqft0pk018.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23A10946-89C0-11EB-9813-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/commit.h b/commit.h
> index 49c0f503964e..970a73ccd5be 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -371,4 +371,6 @@ int parse_buffer_signed_by_header(const char *buffer,
>  				  struct strbuf *signature,
>  				  const struct git_hash_algo *algop);
>  
> +const char *find_author_by_nickname(const char *name);
> +
>  #endif /* COMMIT_H */

As I already said, we do not want to pretend that this is a
generally reusable helper function.  We should at least have a
comment to tell people to never add new callers to this function,
with explanation of the reason.
