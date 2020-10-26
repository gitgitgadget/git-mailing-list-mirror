Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE8C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D8820773
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aZHawY0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgJZVOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:14:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52741 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgJZVOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 17:14:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25FC310DAAB;
        Mon, 26 Oct 2020 17:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JUrBcrkRFrb3L+kcESQI+Xl/a/o=; b=aZHawY
        0P4M6SOezWDFS5pvZeqtQWCahx4fdMGkkTUdR1Xzhilz/hm7igcQjEbcCUyqNlxs
        dxicQZsYF4NNLQGhgbgjaIi2EruLoWAb/ndwTJj5PA3gBT92hNfJ04aoF5YWKp8s
        40uRa/kNd7K7gtj3HDwAn6T4f93UaW0xUOGC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SjA6MATampjJ/PVuPXk3vY2DWqt6i86h
        q2JrIgnA5oRiNadqWH+glTbx+UfK93pKYVJQrwRxwVExd50XGIZGOl+I3Br36Pf1
        NGlRgVhtx9S53hkEHecEQvJAU5nNFHLexKs6zzYJd+f8WU7Qt4HadFmc1vCLGhdJ
        C8+PviNUyqs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DC4810DAAA;
        Mon, 26 Oct 2020 17:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6217010DAA8;
        Mon, 26 Oct 2020 17:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH 03/10] t/perf/fsmonitor: improve error message if
 typoing hook name
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
        <79cc61f56adf7769521d2e2ba4c27c1a3bbc1d76.1603740773.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 14:14:00 -0700
In-Reply-To: <79cc61f56adf7769521d2e2ba4c27c1a3bbc1d76.1603740773.git.gitgitgadget@gmail.com>
        (Nipunn Koorapati via GitGitGadget's message of "Mon, 26 Oct 2020
        19:32:46 +0000")
Message-ID: <xmqq1rhkellz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C064798-17D0-11EB-A4C2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> Previously - it would silently run the perf suite w/o using
> fsmonitor - fsmonitor errors are not hard failures.
> Now it errors loudly.
>
> GIT_PERF_7519_FSMONITOR="$HOME/rs-git-fsmonitorr"
> ./p7519-fsmonitor.sh -i -v
>
> fatal: cannot run /home/nipunn/rs-git-fsmonitorr:
> No such file or directory
> not ok 2 - setup for fsmonitor
>
> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 4030f569cf..88b3717e2a 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -126,7 +126,9 @@ test_expect_success "setup for fsmonitor" '
>  	fi &&
>  
>  	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
> -	git update-index --fsmonitor &&
> +	git update-index --fsmonitor 2>error &&
> +	cat error &&
> +	[ ! -s error ] && # ensure no silent error

I usually do not review or write t/perf/, but is test_must_be_empty
available to you at this point?

>  	git status  # Warm caches
>  '
