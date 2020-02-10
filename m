Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC116C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 20:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8502082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 20:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="arFsDLrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBJUkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:40:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59239 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJUkG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 15:40:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A097AB95D4;
        Mon, 10 Feb 2020 15:40:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G0XQKeYGDAfh5+nt8LhvNcIBBdM=; b=arFsDL
        rYJjYc73s+JaFPKO5JLyjRLv/gcfw+QDLeVWUrzgrcIe6fU++VYqKxfTYFe2i8Cg
        5C2R2Rn9+sTArRvvJYA8TN2MYPPUIWMPuwF/gLbXEpKxrdxEI9rip0okJ98gD2Dk
        d3Qb1rxo8r/XyjNjWP6UQ1y8t7qEvzDKkVYGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PRmZksPEeS1f33bZKLO4VuPAQnVhhauy
        wL6gPjMTRQaH9oiwJQa/tMZpcrcK913Wy2I2NlpjM8vCSsDeY3iopX5cpG99SQp9
        9iJaTSN++/pMcWDCxDLasY87EArWHWJdjoe2qUr+enu4v908mA/4L3Rk3Cn8NwXk
        6UIs6WauzzY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98A86B95D3;
        Mon, 10 Feb 2020 15:40:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2AC5B95CE;
        Mon, 10 Feb 2020 15:40:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 2/8] rm: support the --pathspec-from-file option
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <7ccbab52e51423a9ba74c0cab77448ceabb9dcdc.1581345948.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 12:39:58 -0800
In-Reply-To: <7ccbab52e51423a9ba74c0cab77448ceabb9dcdc.1581345948.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Mon, 10 Feb 2020
        14:45:41 +0000")
Message-ID: <xmqq4kvyyy5d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82B3F59C-4C45-11EA-AEA5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
> new file mode 100755
> index 0000000000..4542a0f02f
> --- /dev/null
> +++ b/t/t3601-rm-pathspec-file.sh
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +
> +test_description='rm --pathspec-from-file'
> +
> +. ./test-lib.sh
> +
> +test_tick
> +
> +test_expect_success setup '
> +	echo A >fileA.t &&
> +	echo B >fileB.t &&
> +	echo C >fileC.t &&
> +	echo D >fileD.t &&
> +	git add fileA.t fileB.t fileC.t fileD.t &&
> +	git commit -m "files" &&
> +	

Trailing whitespace on this line.

> +	git tag checkpoint
> +'
> + ...
> +test_expect_success 'error conditions' '
> +	restore_checkpoint &&
> +	echo fileA.t >list &&
> +
> +	test_must_fail git rm --pathspec-from-file=list -- fileA.t 2>err &&
> +	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
> +
> +	test_must_fail git rm --pathspec-file-nul 2>err &&
> +	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
> +	

And here too.

> +	>empty_list &&
> +	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
> +	test_i18ngrep -e "No pathspec was given. Which files should I remove?" err
> +'
> +
> +test_done
