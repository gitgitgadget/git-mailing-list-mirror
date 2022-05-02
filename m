Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D282AC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 11:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiEBLK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiEBLKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 07:10:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE420BEA
        for <git@vger.kernel.org>; Mon,  2 May 2022 04:07:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l9-20020a056830268900b006054381dd35so9517111otu.4
        for <git@vger.kernel.org>; Mon, 02 May 2022 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WRTP51qOeu0/qVNirxPKOraM3uVgVjqbZt64ouMd1Sc=;
        b=RxoRJWJFzN2nseBpaAifiuep3SJv1BWM/6gZ5b3rVw+onYl4I12UcRW4gbbe4lF0oi
         ehtFfwxn+9mXBxs2SSW/QWFhxpLcWxHctIVAYcoiZCo9uYOiR636PQNZdUyePxwruS1v
         wlkVbWAgWvHhZ+LFtWElTbyHrhDTIyZiRp/QImTv1LaZ2yqKRMhkgiAqbYJepyTZO+NZ
         /AWeeIUEAcQXs0QXzp7O+bFOzRY9bkAe1GkqXi47UtAyw1+KLy55DNvqfobvF6oay+Vh
         Z63b6Rnr/tpEgA8ekurnD5y6wkDMZkmIhXRd79PAJedK7cvKti1qBjO31gHqyqOM5dbC
         NQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WRTP51qOeu0/qVNirxPKOraM3uVgVjqbZt64ouMd1Sc=;
        b=VCHncWXhbRjRJmMZ/JwsX8AM+2wZfVrDcbWNbA3o2rGBb8CxAVhDygrenL/ZbZqU9q
         YjP9euJlAWQteOcOlpa6Ic7nejRjn8FdEs/bP13QSA/ynG06OVQiURg8u4ocBQ1zuW76
         R/rlkztUbxnKRJzxDo9K/xQkKtqTUKRCWiqtuhMbJEJMlQUrQjnZqZjQf938qIiglS83
         rKfI5K61wejHOTULQcJaZbD9a50bdiAb3gg7DmajcJTjnRBJ3UnnD7CK8XmOt54OYXgT
         uyZhCzCtn3bO3Wd0SLeCo5T5owJTCmW64ad2hVVEJFNocNFxCVHsftqfs2HDN3vDYMkL
         xmuA==
X-Gm-Message-State: AOAM531ODnP/7DKjz9GUzao9igibeL+OsL2pN9MMGZW/WOL/U0B2NV3x
        uffmrXq+R+NvJ6XkgadJvkQ=
X-Google-Smtp-Source: ABdhPJwZtMrybA+uUncatNgDGIFUm1J7958aDd8+vgAZ9ll7VOK+Qwf8rrLPI8ZKn+UX4IuRJDd16Q==
X-Received: by 2002:a05:6830:1c65:b0:606:3cc:862 with SMTP id s5-20020a0568301c6500b0060603cc0862mr3549368otg.75.1651489628567;
        Mon, 02 May 2022 04:07:08 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id y1-20020a4ae701000000b0035eb4e5a6d1sm3729749oou.39.2022.05.02.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 04:07:07 -0700 (PDT)
Date:   Mon, 2 May 2022 04:07:05 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
Message-ID: <20220502110705.gfdr65dondyigdik@carlos-mbp.lan>
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
 <20220430041406.164719-2-gitter.spiros@gmail.com>
 <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
 <xmqqpmky70jb.fsf@gitster.g>
 <a3e06290-052e-af36-4170-301e567d561d@iee.email>
 <xmqqr15e5fm3.fsf@gitster.g>
 <xmqqmtg25cjw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmtg25cjw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 30, 2022 at 05:20:03PM -0700, Junio C Hamano wrote:
> diff -u -p a/compat/mkdir.c b/compat/mkdir.c
> --- a/compat/mkdir.c
> +++ b/compat/mkdir.c
> @@ -9,7 +9,7 @@ int compat_mkdir_wo_trailing_slash(const
>  	size_t len = strlen(dir);
>  
>  	if (len && dir[len-1] == '/') {
> -		if ((tmp_dir = strdup(dir)) == NULL)
> +		if (!(tmp_dir = strdup(dir)))

did not check them all, but wanted to raise that this specific case, seems
to be regressing in readability.

sure; it fails another rule of "not doing assignments inside if", but maybe
when it was introduced with 0539ecfdfce (compat: some mkdir() do not like a
slash at the end, 2012-08-24), that wasn't valid or it was considered ok
for code in compat.

but more importantly it serves as an example of why most of those rules
use "try"; after all the assignment WITH the parenthesis and == is clear
enough that might not warrant the need of two lines, but without the ==
it is likely to cause trouble or confuse someone.

Carlo
