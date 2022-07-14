Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CFC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbiGNSqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbiGNSqg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:46:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D0A6B257
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:46:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DA1D1A0D7A;
        Thu, 14 Jul 2022 14:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0FZ8EHFZne3Q+Mv4jxHGCqI8yNiA94GRRNaamv
        rqnkI=; b=dJ//fzcihLHizS5qC3IgbIk9vgHbfe1dJK1G+Cs62tN70005Jbj51G
        ynGK9O7pVCM4Y9uaveCOqAbu93GwAxx3LW2OcEwL8iUkkhLg8SOu60dapYpQaxK0
        AVTjQ3hvg9tw55389c1NZFhfZIWjiex1doCzpxFoe9VSlFIhupUxA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 767121A0D79;
        Thu, 14 Jul 2022 14:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28F6B1A0D76;
        Thu, 14 Jul 2022 14:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: grep: unify configuration variables definitions
References: <cover.1657819649.git.matheus.bernardino@usp.br>
        <439cfdf858f5b1917ae7ca3ca327bb33b42f71c7.1657819649.git.matheus.bernardino@usp.br>
Date:   Thu, 14 Jul 2022 11:46:30 -0700
In-Reply-To: <439cfdf858f5b1917ae7ca3ca327bb33b42f71c7.1657819649.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Thu, 14 Jul 2022 14:44:02 -0300")
Message-ID: <xmqqfsj35y7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46DEA278-03A5-11ED-A7B3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> The configuration variables for git-grep are duplicated in
> "Documentation/git-grep.txt" and "Documentation/config/grep.txt", which
> gqcan make maintenance difficult. The first also contains a definition

gqcan?

> that is not present in the latter (grep.fullName), and the latter
> received a wording improvement that was not replicated in the former:
> see 91028f765 ("grep: clarify what `grep.patternType=default` means",
> 2021-12-05).
>
> To avoid such problems, unify the information in one file and include it
> in the other.

OK.

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  Documentation/config/grep.txt | 10 ++++++++--
>  Documentation/git-grep.txt    | 37 ++++++-----------------------------
>  2 files changed, 14 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
> index 182edd813a..6996e64574 100644
> --- a/Documentation/config/grep.txt
> +++ b/Documentation/config/grep.txt
> @@ -17,8 +17,14 @@ grep.extendedRegexp::
>  	other than 'default'.
>  
>  grep.threads::
> -	Number of grep worker threads to use.
> -	See `grep.threads` in linkgit:git-grep[1] for more information.
> +	Number of grep worker threads to use. See `--threads`
> +ifndef::git-grep[]
> +	in linkgit:git-grep[1]
> +endif::git-grep[]
> +	for more information.
> +
> +grep.fullName::
> +	If set to true, enable `--full-name` option by default.

All of the above makes sense.

>  --threads <num>::
> -	Number of grep worker threads to use.
> -	See `grep.threads` in 'CONFIGURATION' for more information.
> +	Number of grep worker threads to use. If not provided (or set to
> +	0), Git will use as many worker threads as the number of logical
> +	cores available. The default value can also be set with the
> +	`grep.threads` configuration.

This change is clearly outside of the "unify 'git config --help' and
'git grep --help'" theme, isn't it?

I wonder if you want to leave this untouched, and instead put more
work and words in the description of grep.threads in the other file?
