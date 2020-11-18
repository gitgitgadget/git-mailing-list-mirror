Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDF8C56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C18246B0
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yQ0OnfUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgKRS0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:26:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51233 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgKRS0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:26:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C32510D020;
        Wed, 18 Nov 2020 13:26:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nq8Alg5HwiTXdNVS3dc4DiVOA5w=; b=yQ0Onf
        UDJpsSNvguWvz0rSvuztFENGHiqQtCR61iwc8OEi3RZ/TsS+KzJwnWCiObhvgd/R
        vcGhDpgBDSFx2v9z6mJgOUKtfLtGE0z4ey2TQAYOtwNd83dnn5eirNV0o5BHMcn2
        oKB9d+BKQ1X1SYpx8KA+Tvf/+Bw/1Pm7GPKCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pfZwxdg16T1PvtpBHKZmDrK6nymkhK5h
        uRgSISkyXgGkPnDH+oQ+j9te08PkO5qQKh4uV8T2AYvCqGWWI1NEpmDX9tEK/5tW
        LV6ArTHydbhNZvwvAghVnf6wPI8KJ0mXFDaZE6s19m685ApX0KA09JKZOuAwdtGQ
        +/CG1ZS5Jhw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 654B110D01F;
        Wed, 18 Nov 2020 13:26:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA3D810D01E;
        Wed, 18 Nov 2020 13:26:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] t2106: make test independent of the current main
 branch name
References: <pull.792.git.1605710947.gitgitgadget@gmail.com>
        <d477b02b5a3ca6d2beef5bdea21407a3c555f83e.1605710947.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 10:26:23 -0800
In-Reply-To: <d477b02b5a3ca6d2beef5bdea21407a3c555f83e.1605710947.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 18 Nov 2020
        14:49:06 +0000")
Message-ID: <xmqqsg961pyo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 914358E6-29CB-11EB-9DA2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We do have this wonderful shortcut `git checkout -` to go back to the
> previous branch, thanks to the reflog.

;-)

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t2106-update-index-assume-unchanged.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
> index ff0947f388..3396f23363 100755
> --- a/t/t2106-update-index-assume-unchanged.sh
> +++ b/t/t2106-update-index-assume-unchanged.sh
> @@ -20,7 +20,7 @@ test_expect_success 'do not switch branches with dirty file' '
>  	git checkout other &&
>  	echo dirt >file &&
>  	git update-index --assume-unchanged file &&
> -	test_must_fail git checkout master
> +	test_must_fail git checkout -
>  '
>  
>  test_done
