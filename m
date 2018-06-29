Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2F51F516
	for <e@80x24.org>; Fri, 29 Jun 2018 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936184AbeF2WAp (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 18:00:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54624 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933750AbeF2WAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 18:00:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so3521515wmf.4
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1AmpZuNAw7FUSyI9qxacBZzeU4qvu5THlFqjBJGiLA4=;
        b=Ea7UsfoxVjUGXRQg6ZCrl9YtZD6q07V1RQq6hX7fF4qSvI1RgYLXcgPGjVN/ktdEUc
         3y9EKeG2Itdeulu+XulFCQrqH1cOKKzw4BhuTNdRbQezmTkB8tzZyXH7FES5I2PWEBR0
         bXoasPLQY7EBU/+d+QV2APG3UCfisWyuV7yLjnaaSU2/mpfzfua1gjW1c/CmoLAXmuSw
         pN0vEqhX0QmoIbhHHiaj3I3kE795y+a9bzDVtFe8QLcM7mbZ8OU/XCMUc+O0ma4gmRIm
         F/W0mkat/bBI45xhvZn16ESqwgCCDuw+Iz1NL99DwUfk8Khkb9ueRLkmLlvwRy+AePa8
         YKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1AmpZuNAw7FUSyI9qxacBZzeU4qvu5THlFqjBJGiLA4=;
        b=XrwkoZ46YiLRiyBu2AY9tYLyXEyi1DAcciUO2VRxreTAN3s9dL0NOpbJcPVh/JRYoW
         1BMmmgPlhHJsv2dCJAxSEjt96jYpwZEaV2Hmb/pxxmfN/uPDyG6DEUJ7g5+2g/9aTG5P
         PDYATzt8o9F/3GCq+msfa6qBa46J3bQLZ8k6Jta9ORgTcMvN1C5pGbhW61kS0GGu5qcn
         uP4kSbV76jSZsFyP3stl8hQGtMV6xQGDDgPajbWuD8HygA1fxYAep4NW40LeHChnXI8c
         ESra8Cq//X6lU0YSoLq0TaMXS1ARB0CYegLCx8UqlkrPVbaIPCeEk3fvQ9rOTUw48E2r
         O0Ew==
X-Gm-Message-State: APt69E2ixHWafeSK734w5awRHYKg+uvyxrof/W+4U/nyGC4z36V3ffET
        wQq4umgEF+giqvEFk40YFCU=
X-Google-Smtp-Source: AAOMgpfWYz4K+GnpYMBs+qfRbgMduUAB6dzXVgdaxOBMwzndA1angkhExCh0nPeXf/o4QweyrKgp7g==
X-Received: by 2002:a1c:f20d:: with SMTP id s13-v6mr2747143wmc.36.1530309642514;
        Fri, 29 Jun 2018 15:00:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h8-v6sm1831355wmb.32.2018.06.29.15.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 15:00:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>
Subject: Re: [RFC PATCH 03/13] commit-reach: move commit_contains from ref-filter
References: <20180629161223.229661-1-dstolee@microsoft.com>
        <20180629161223.229661-4-dstolee@microsoft.com>
Date:   Fri, 29 Jun 2018 15:00:41 -0700
In-Reply-To: <20180629161223.229661-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 29 Jun 2018 16:12:41 +0000")
Message-ID: <xmqq36x5tfqu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> +int commit_contains(struct ref_filter *filter, struct commit *commit,
> +		    struct commit_list *list, struct contains_cache *cache)

This is a symbol that is used to be file-local private.  Is it named
appropriately in the new context, which is "globally visible
throughout the system"?  The convention to call into it now must be
documented a lot better (e.g. how should list/cache etc are to be
prepared?).

> +{
> +	if (filter->with_commit_tag_algo)
> +		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
> +	return is_descendant_of(commit, list);
> +}
> diff --git a/commit-reach.h b/commit-reach.h
> index 35ec9f0ddb..986fb388d5 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -2,42 +2,24 @@
>  #define __COMMIT_REACH_H__
>  
>  #include "commit.h"
> +#include "commit-slab.h"
> +#include "ref-filter.h"
>  
> -struct commit_list *get_merge_bases_many(struct commit *one,
> -					 int n,
> -					 struct commit **twos);
> -struct commit_list *get_merge_bases_many_dirty(struct commit *one,
> -					       int n,
> -					       struct commit **twos);
> -struct commit_list *get_merge_bases(struct commit *one, struct commit *two);
> -struct commit_list *get_octopus_merge_bases(struct commit_list *in);
> -
> -/* To be used only when object flags after this call no longer matter */
> -struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
> -
> -int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
> -int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
> -int in_merge_bases(struct commit *commit, struct commit *reference);
> -
> +int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
>  
>  /*
> - * Takes a list of commits and returns a new list where those
> - * have been removed that can be reached from other commits in
> - * the list. It is useful for, e.g., reducing the commits
> - * randomly thrown at the git-merge command and removing
> - * redundant commits that the user shouldn't have given to it.
> - *
> - * This function destroys the STALE bit of the commit objects'
> - * flags.

The above removal of lines is sloppy; they are mostly duplicates in
commit.h that should never have been moved here in the first place,
no?

> + * Unknown has to be "0" here, because that's the default value for
> + * contains_cache slab entries that have not yet been assigned.
>   */
> -struct commit_list *reduce_heads(struct commit_list *heads);
> +enum contains_result {
> +	CONTAINS_UNKNOWN = 0,
> +	CONTAINS_NO,
> +	CONTAINS_YES
> +};

Are these names specific enough, or were they OK in the limited
context inside ref-filter but now are overly broad as globally
visible names?  I suspect it might be the latter.
