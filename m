Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0260520248
	for <e@80x24.org>; Tue,  9 Apr 2019 02:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDICgd (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 22:36:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44488 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDICgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 22:36:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so8755227pfm.11
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vcJCYKvhCaYHj1A3vfHVEFBs58nZppurpgUFF9GAtH4=;
        b=wmkGJhThOXrX+GhLsndlxpAfRdsl7q03zHi9n+eyw1txwGL6WlFgK9OySxyaY5+saG
         Pepd6GeDKuKbGEuDkdgkg9p3rT7PZWZyWZSplHS0AGriK/TF47EUaXKew2enpHw7gNjg
         WSgedor4fGUbdXFKxATXnzfvuJZ0f7gA0ON4QJYwiQysFENAEpPkHW+s4iuVjVkgsc4E
         i1I2dnWD/iBSs5HYrYhkyug9/JUReyxsf6Ygz8NDOV8mm135G3jSGOavSwzY/XsLCeSg
         TVTa+NdWWnme2t9YE/ZlY3724gdx3AVTRizDLUqF0eOn2Fuwl12fwLMxIz8UU0B5z20V
         RbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vcJCYKvhCaYHj1A3vfHVEFBs58nZppurpgUFF9GAtH4=;
        b=BWiFNl040O2JipupiaeWEfKaptDuWLURsGPazLdI+UOXIXbpoxbxsilN1N67S8xYUT
         HeHiUQ/TUfN+SRre/hMvLbUTdSLw+R5XaqVQXF2eOZW0WcXpdApxVN/pz8AjYjm5+fN/
         5cDYwC/gih4evx7WPlP/IkRABAUPXWdEgSjhP3DVh1HMylA147uytf4hGpH7Ud0oONuz
         yvu7Qc+AuhdW0xDoAnVdWOHTo2lblLbYrunx3JKlNNe74pkb8Hi2ZYRVPkqq/7rHMOnt
         MHiJ6SrVeF2Tn8btdsXxNu3SPPRW4a9C3m0n9spsQBqzFQXQ/zDOKTEJPqbLc5A7/LGe
         jtGg==
X-Gm-Message-State: APjAAAXgyHgSrF3RTyWqmjcJoMDtpne9In7+q87FXitkRvKIzD/66Xw7
        7B09GeAPl1WHoFdCqxms/PrZTw==
X-Google-Smtp-Source: APXvYqxFhHzaTOwaZ6YdxkDLeV2t7runpoMkNAX397r/pWDTYxNwVuQnMxDw9T2FFt8lQWLuCGJbQw==
X-Received: by 2002:aa7:8282:: with SMTP id s2mr33892791pfm.7.1554777392429;
        Mon, 08 Apr 2019 19:36:32 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d869:cd1a:616d:3c11])
        by smtp.gmail.com with ESMTPSA id q87sm48349110pfa.133.2019.04.08.19.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:36:31 -0700 (PDT)
Date:   Mon, 8 Apr 2019 19:36:30 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH] Unbreak real_path on Windows for already absolute paths
 (with Visual Studio)
Message-ID: <20190409023630.GG81620@Taylors-MBP.hsd1.wa.comcast.net>
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sven,

On Mon, Apr 08, 2019 at 01:16:33PM +0200, Sven Strickroth wrote:
> A path such as 'c:/somepath/submodule/../.git/modules/submodule' wasn't
> resolved correctly any more, because the *nix variant of
> offset_1st_component is used instead of the Win32 specific version.

I'm not a win32 expert by any sense, but I am do have a meta-question
about your patch...

> Regression was introduced in commit
> 25d90d1cb72ce51407324259516843406142fe89.

I can't seem to find this commit anywhere upstream. Is this SHA-1 pasted
correctly?

>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
>  git-compat-util.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e0275da7e0..9be177e588 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -210,6 +210,7 @@
>  #include "compat/mingw.h"
>  #include "compat/win32/fscache.h"
>  #elif defined(_MSC_VER)
> +#include "compat/win32/path-utils.h"
>  #include "compat/msvc.h"
>  #include "compat/win32/fscache.h"
>  #else
> --
> 2.21.0.windows.1

Thanks,
Taylor
