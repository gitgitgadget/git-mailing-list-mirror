Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABB51F462
	for <e@80x24.org>; Tue, 30 Jul 2019 20:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfG3U5b (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 16:57:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63267 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfG3U5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:57:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE86A76231;
        Tue, 30 Jul 2019 16:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IFf8c9E9hgElZd3WkLTRaeTiqGU=; b=hDG1zk
        MccZAg3hB+dVSkVF/KSjhtSqyGQ8gA8GVy+HFfoTqYYdrYu9vzF18VaK2mWScQjr
        KCo/XbvyII1yFFe7DNAKICWXmRcJY3IWI/2Na0qPCRZcv1Pdq0yMeGonaLLLiee+
        Iq8Tr3Gou1aAQDNLWcCcDjQ8uIm3Asjbs+eU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KVwH01vHIyEmkjmoxU6sc0GTzFte0mJm
        7PzNHSYmDz5Dcs2D/H/KPW3WocARd8i+1duF3Ww56k7gqki3k86e80tGHnMcPF+F
        w4KYTGjy7mMAfq/1hnh3KxwtA+mWDMv4oNlFGnCtKmx9AVmpxslxEuLualsDKe+e
        gfuApdLUZN8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C43EA76230;
        Tue, 30 Jul 2019 16:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0066E7622F;
        Tue, 30 Jul 2019 16:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/5] repo-settings: add feature.manyCommits setting
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
        <c0129066a02b39535110ae592c16ca0e5d6d6c24.1564515324.git.gitgitgadget@gmail.com>
Date:   Tue, 30 Jul 2019 13:57:21 -0700
In-Reply-To: <c0129066a02b39535110ae592c16ca0e5d6d6c24.1564515324.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 30 Jul 2019
        12:35:27 -0700 (PDT)")
Message-ID: <xmqqh873s0jy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A163FFDC-B30C-11E9-A46A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> new file mode 100644
> index 0000000000..f74314ae90
> --- /dev/null
> +++ b/Documentation/config/feature.txt
> @@ -0,0 +1,15 @@
> +feature.*::
> +...
> +* `gc.writeCommitGraph=true` enables writing the commit-graph file during
> +garbage collection.
> \ No newline at end of file

No newline at end of file

> diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
> index 02b92b18b5..31a5fc4f75 100644
> --- a/Documentation/config/gc.txt
> +++ b/Documentation/config/gc.txt
> @@ -63,8 +63,8 @@ gc.writeCommitGraph::
>  	If true, then gc will rewrite the commit-graph file when
>  	linkgit:git-gc[1] is run. When using `git gc --auto`
>  	the commit-graph will be updated if housekeeping is
> -	required. Default is false. See linkgit:git-commit-graph[1]
> -	for details.
> +	required. Default is false, unless `feature.manyCommits`
> +	is enabled. See linkgit:git-commit-graph[1] for details.
>  
>  gc.logExpiry::
>  	If the file gc.log exists, then `git gc --auto` will print
> diff --git a/repo-settings.c b/repo-settings.c
> index 309577f6bc..fc05f4fbc4 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -2,6 +2,8 @@
>  #include "config.h"
>  #include "repository.h"
>  
> +#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)

A few points:

 1. give 's' and 'v' a bit better name, perhaps 'slot' and 'value'?

 2. "do { if ((s) == -1) { (s) = (v); } } while(0)"

 3. When we learn to set default values for variables that are not
    boolean in the future, we will regret that we did not name it
    UPDATE_DEFAULT_BOOL(slot, value).

