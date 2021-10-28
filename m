Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0902C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6836610E8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJ1Qsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhJ1Qsp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:48:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911A8C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:46:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h7so27919903ede.8
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/Go5kjFolZ37nNddtRIavKuuS8yWM/cyipyDYZyY9BY=;
        b=pSFGTS8ax9taZghZZF9rA68ueVC2xRr7QG5ODF/q203o88vexhA+qMs8k8LoIJw0Ku
         skqcnyqaNV14QwajturBkpA9N4iA4PYpfLaoiJ0IRiHK+opIbv99Vu5MaBKyWGcqUZ/H
         CkiOWq0ruYUyHdVdOXgtOBBbjXty84QLw0AUaJcFl+L0V6p3ruChmJSPtkTbzxESfhdh
         uqpEljwamqr1FLW4oSgFlzCmGu5e0nIf6jqplS2FavlYoDyYsmZyjXnw2YjOXGC4KVFx
         K0HCO4CB8letsnTl5WQHjH2at3epynHKdWkloGKiBpeb5sIjUut6FTVzIxCU3uI1lnvO
         2JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/Go5kjFolZ37nNddtRIavKuuS8yWM/cyipyDYZyY9BY=;
        b=Yhkyv3xpfCEOTQrH0nn2waL5hRB6wj6dCEcVQk2bcKWL4Ug8yBVCLdE3M2f4l3ZM0Y
         oovMp810Z40muim1WuMyqoE+Mc9cRbojycNyDflCaGUKnFBI8CdAAvDIQMuuYLs/8IfU
         /nzFZL+GHewyEDynG0+rqRiTBGBmAIV1xEJ+wATBa1w41IgEFcv77AAMcQTsAdEMz0Qg
         1ZJUdn5wB1myU+x5lXEFJ4I+U1zGKHoZTLoSYfDpDkLRGwjvQ7b+kgwqTBlzeCW0oTb3
         LuyyCOJUS06Rsj1PceAOCRoGNq/bdu2Cj2t57zbGpqWVbvMReHErUi8p/m7lMJ+t3GEm
         HVMw==
X-Gm-Message-State: AOAM532DiHtXCt3c+8m7RXk2D/jy1heghDD7LjJi1gveArtbba8DFw9r
        iiKU6D86lQ19T243i9v0MlQxH4EFuh0=
X-Google-Smtp-Source: ABdhPJxE02pPj5KBwRngCMhz8jZNCFZgGM1Dsua6cbMkpmBj+7cHZWjQlGaYeOoBehULgx4dbNgSPw==
X-Received: by 2002:a05:6402:40cd:: with SMTP id z13mr7375536edb.220.1635439577020;
        Thu, 28 Oct 2021 09:46:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm2sm476383edb.39.2021.10.28.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:46:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mg8Xg-0023PJ-41;
        Thu, 28 Oct 2021 18:46:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH v4 2/2] http-fetch: redact url on die() message
Date:   Thu, 28 Oct 2021 18:39:18 +0200
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
 <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
 <c7f0977cabd4ba7311b8045bc57e9e30198651fd.1635288599.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <c7f0977cabd4ba7311b8045bc57e9e30198651fd.1635288599.git.gitgitgadget@gmail.com>
Message-ID: <211028.86sfwlw10o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Ivan Frade via GitGitGadget wrote:

> From: Ivan Frade <ifrade@google.com>
>
> http-fetch prints the URL after failing to fetch it. This can be
> confusing to users (they cannot really do anything with it) but even
> worse, they can share by accident a sensitive URL (e.g. with
> credentials) while looking for help.
>
> Redact the URL unless the GIT_TRACE_REDACT variable is set to false. This
> mimics the redaction of other sensitive information in git, like the
> Authorization header in HTTP.
>
> Signed-off-by: Ivan Frade <ifrade@google.com>
> ---
>  http-fetch.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/http-fetch.c b/http-fetch.c
> index fa642462a9e..bbe09a6ad9f 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -4,6 +4,7 @@
>  #include "http.h"
>  #include "walker.h"
>  #include "strvec.h"
> +#include "urlmatch.h"
>  
>  static const char http_fetch_usage[] = "git http-fetch "
>  "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile=hash | commit-id] url";
> @@ -63,8 +64,18 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
>  	if (start_active_slot(preq->slot)) {
>  		run_active_slot(preq->slot);
>  		if (results.curl_result != CURLE_OK) {
> -			die("Unable to get pack file %s\n%s", preq->url,
> -			    curl_errorstr);
> +			struct url_info url;
> +			char *nurl = url_normalize(preq->url, &url);
> +			if (!git_env_bool("GIT_TRACE_REDACT", 1) || !nurl) {
> +				die("Unable to get pack file %s\n%s", preq->url,
> +				    curl_errorstr);

small nit: arrange if's from "if (cheap || expensive)", i.e. no need for
getenv() if !nurl, but maybe compilers are smart enough for that...

nit: die() messages should start with lower-case (in CodingGuidelines), and I think it's better to quote both, so:

    die("unable to get pack '%s': '%s'", ...)

Or maybe without the second '%s', as in 3e8084f1884 (http: check
CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors, 2021-09-24) (which
I authored, but just copy/pasted the convention in the surrounding
code)>

> +			} else {
> +				char *schema = xstrndup(url.url, url.scheme_len);
> +				char *host = xstrndup(&url.url[url.host_off], url.host_len);
> +				die("failed to get '%s' url from '%s' "
> +				    "(full URL redacted due to GIT_TRACE_REDACT setting)\n%s",
> +				    schema, host, curl_errorstr);

Hrm, I haven't tested, but aren't both of those xstrndup's redundant to
using %*s instead of %s for the printf format? I.e.:

    die("failed to get '%*s'[...]", url.schema_len, url.url, )
