Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C381CC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 20:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbjEKUGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjEKUGc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 16:06:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B5D5276
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:06:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6436e075166so6815930b3a.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683835588; x=1686427588;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDC/O4CZlfa5y1As0cGINsoP78JuxsrkC51PHzzOFY4=;
        b=BYIJu82H0hjoLp0XWvu44IXNzDgABKEu74mkhBVTxbe1Bk9MFNejgdomm40iTSaSo4
         X9wB8KSDfWkKBVczXpjRPe0KTEGMyTdP/j33avwXttk898yIMD/xzOekm8yVPS1zjz10
         qDCokOI8fW2+3P39KUGxEkSDaFlj1bGw4vfWR8VLp4ilZbjaR5zMK7JluOLiABUU/2A7
         MrjXYt6Sk4VeMFzpWQpIpaiUzgtftU1FnzH6SLKK/aE5nymv8vB5vS4ba/J9ekoJvBmm
         MFHz7AOK7Tl6kZRgZZ+TLtOZ3zw0ulbX/KigJ8L455+JkZUaz7x9DSmh5T00s5Erd9zE
         wMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683835588; x=1686427588;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yDC/O4CZlfa5y1As0cGINsoP78JuxsrkC51PHzzOFY4=;
        b=JE5fo9NnG4E6ixd9fWZflDau5Fh9hLTKMd3LlniE7syKmgT9csCVXA6nEWO/Np5QZq
         UwYec3722XzuSmR8RWTHvB7yPhUTyDaePkCD9ERG3jk7zc7OBFVAvgB/VXDQd8lG7h73
         jzMV8gC8CWtVlqE7kSf90SkhBhvuHH32lXTZfCWclZ6swCPqXR4IieKj31vOtfT05J2E
         tBuVr9A23qjFzBqjXjDBGeCJriiHJSgAiWuzhj/7dX5bpiOBr+33oEhhAI2Mk40duLHN
         VBP5jbIhl7tXNvsUqM89K8mQHuxVWy4OqU5Egbqy+5rcjDYyhWX+g7T83S857HLVeYjz
         8ysQ==
X-Gm-Message-State: AC+VfDz0pq7whYDj8EAF95Koc/OymMprim9ShQv3Mh7V93JV8YZa2x+C
        E9/D/Wzn4Htm50j+8F9k5oc=
X-Google-Smtp-Source: ACHHUZ7z7E1t1SXHIPBHlvbslQEq/rUqd5JvMrtSLZIrOiU/UDdIIsLjqrb753+YdG6aX62jTDbJ5A==
X-Received: by 2002:a17:902:d505:b0:1ab:1351:979e with SMTP id b5-20020a170902d50500b001ab1351979emr28016591plg.10.1683835588128;
        Thu, 11 May 2023 13:06:28 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p36-20020a634f64000000b0050f56964426sm5391665pgl.54.2023.05.11.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:06:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] pack-refs: teach pack-refs --include option
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
        <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
        <b2f3b98cd2461a25ab708adbcd8a95f5e2b18e5e.1683828635.git.gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 13:06:27 -0700
In-Reply-To: <b2f3b98cd2461a25ab708adbcd8a95f5e2b18e5e.1683828635.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Thu, 11 May 2023 18:10:34
        +0000")
Message-ID: <xmqq8rduvdj0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1198,7 +1191,13 @@ static int should_pack_ref(const char *refname,
>  	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
>  		return 0;
>  
> -	return 1;
> +	if (opts->visibility && ref_excluded(opts->visibility, refname))
> +		return 0;
> +
> +	if (opts->visibility && ref_included(opts->visibility, refname))
> +		return 1;
> +
> +	return 0;
>  }

When the user did not say --exclude or --include, can we not have
opts->visibility?  IOW, can opts->visiblity be NULL?

Even if it can be NULL, shouldn't we be defaulting to "pack", as we
rejected refs to be excluded already?

> @@ -33,5 +38,14 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
>  	for_each_string_list_item(item, &option_excluded_refs)
>  		add_ref_exclusion(pack_refs_opts.visibility, item->string);
>  
> +	for_each_string_list_item(item, &option_included_refs)
> +		add_ref_inclusion(pack_refs_opts.visibility, item->string);
> +
> +	if (pack_refs_opts.flags & PACK_REFS_ALL)
> +		add_ref_inclusion(pack_refs_opts.visibility, "*");
> +
> +	if (!pack_refs_opts.visibility->included_refs.nr)
> +		add_ref_inclusion(pack_refs_opts.visibility, "refs/tags/*");

Given the above code, I think visibility is always non-NULL, and the
inclusion list has at least one element.  So the above "what should
be the default?" question is theoretical.  But it would be nicer if
we do not check opts->visibility there.  By writing

	if (opts->visibility && ref_included(opts->visibility, refname))
		return 1;

you are saying "if visibility is defined and it is included, say
YES", and logically it follows that, if we did not return true from
here, we do not know if the end-user supplied inclusion list did not
match (i.e. ref_included() said no), or we skipped the check because
the end-user did not supply the visibility rule.  It is easy to
mistake that the next statement after this, i.e. "return 0;", is the
default action when the end-user did not give any rule.

But that is not what is going on.  Because visibility is always
given,

The last part would become

	if (ref_included(opts->visibility, refname))
		return 1;
	return 0;

and the "return 0" is no longer confusing.  If inclusion check says
yes, the result is "to include", otherwise the result is "not to
include".  Even shorter, we could say

	return !ref_excluded(opts->visibility, refname) &&
		ref_included(opts->visibility, refname) &&

which we can trivially read the design decision: exclude list has
priority, and include list is consulted only after exclude list does
not ban it.

Thanks.
