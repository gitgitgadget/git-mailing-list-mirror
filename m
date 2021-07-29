Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A7FC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F53608FB
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhG2Taq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhG2Tap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:30:45 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44531C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:30:41 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a13so8574710iol.5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y9h10qeSPkjTbVXtoKlg/Fz9WMU3lU2Nz4ZYxgKACQI=;
        b=FNLoXjk2MdgZ3u+iE7DaMs9tI2hxMHAJNF1fI1qFj8ZFDFmi3Y2FstjCnuji5raIv9
         BeHaxutPCa6F/Jq2hj4jf173LS+JvZNJXU3r/qLpW4lGxs0sKWLiEQ7rbjRVadSStdF6
         P0KT8ANY3P1dpu1hGXOCQMD1CXeAFkFoszAHbTev/SezxMYI89/r7x5FYuAw5NUEKnk5
         1dpKMjrsP+00N+LjRkWPB+Eaeq1YsrItRC66+9kFpufZ4cDSs+allE0S0gJKDWutZYyZ
         6dLVgM8Z0QpwParnjwQXyDuuOUIn5SLY9077rvI3J0daVhb0nyPCR98pPXnyQ53gRk8D
         TPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y9h10qeSPkjTbVXtoKlg/Fz9WMU3lU2Nz4ZYxgKACQI=;
        b=gtmUWy+dfcOp79I9nmuHXSqnC1JqdKY66wPlGPVikYfiBT8p+u7QzyK6/lB+Y4gUn7
         ytHByN6CLnp+AgQA2jozL7YbowauH80OKPlkoUm2lYmS6iNeIp9wuGvn017tL5WoZTuZ
         MLl1ywTLgVRXfWboPfbmn6guQtjX07QHMWFXxOJraEZqUEJaYMlEH/217Zrra13qVwLx
         pIGUSa6lO9NuCH7GN/TTr/j0erSVxkk2+hAbJRiAsWlMQ2rqXfMCGcmWQNideYpZ07EG
         PAarlSumr/RCEjYKRs8/Hw9HMVR6ZulQeb6/n+gLEJYUqtpXyKvXfHfqnox4I+UYBECw
         KDnw==
X-Gm-Message-State: AOAM5304k4acHnp0KVswZ9OOPbSdrhZCiqRsNIUskoJxBtnMPH1cFKvc
        LlkRlRhuwtndFF4/TBuDO+i5gPhaW4qGcRIL
X-Google-Smtp-Source: ABdhPJx07XN87ZjbR+B6aAShC6kWX1ZhziNCAbYOIfXpvaHzl0qwWVx2T7vJVGU4PrnIGJO4wyFXmg==
X-Received: by 2002:a02:6606:: with SMTP id k6mr270673jac.51.1627587040581;
        Thu, 29 Jul 2021 12:30:40 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:46df:20:8c6c:2d4b])
        by smtp.gmail.com with ESMTPSA id j4sm2788195iom.28.2021.07.29.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:30:40 -0700 (PDT)
Date:   Thu, 29 Jul 2021 15:30:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 09/25] midx: avoid opening multiple MIDXs when writing
Message-ID: <YQMB32fvSiH9julg@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <40cff5beb50cdfbd13ae7f6017152f2628b25814.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40cff5beb50cdfbd13ae7f6017152f2628b25814.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 05:19:46PM -0400, Taylor Blau wrote:
> @@ -914,10 +915,14 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  		die_errno(_("unable to create leading directories of %s"),
>  			  midx_name);
>
> -	if (m)
> -		ctx.m = m;
> -	else
> -		ctx.m = load_multi_pack_index(object_dir, 1);
> +	for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
> +		if (!strcmp(object_dir, cur->object_dir)) {
> +			ctx.m = cur;
> +			break;
> +		}
> +	}
> +	if (!ctx.m)
> +		ctx.m = get_local_multi_pack_index(the_repository);

Oops, the `if (!ctx.m)` part of this diff is just plain wrong.

I think that I had in my mind that some callers don't pass object_dir,
and so that we should fall-back to the local MIDX in that case. And so I
probably meant to write `if (!object_dir && !ctx.m)` instead.

But, all of the callers *do* pass the result of get_object_directory(),
so we don't need to do anything of the sort.

On a related note, though, a side-effect of this change is that this
makes it no longer possible to do

    git multi-pack-index write --object-dir=/not/an/alternate.git/objects

since get_local_multi_pack_index() will only populate the MIDXs in
alternate object stores. We never enforced that `--object-dir` must
point to an alternate, but the documentation uses `<alt>` to describe
the argument to this flag, and accepting arbitrary non-alternate paths
seems like a footgun to me.

So I'm OK with "breaking" that behavior, as long as nobody complains
loudly. Obviously it makes the fix easier to write, but I'd argue that
the behavior we're losing is worth getting rid of anyway.

Thanks,
Taylor
