Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A10A202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 21:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdGEVOV (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 17:14:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35730 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdGEVOU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 17:14:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so142260pfq.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=z1fjs1EfUF1uEK2M22RKjfvNAFhj1h4cQ8a0unHmKJw=;
        b=Oul18P2eq/tpNzSi1WJcMw7ssxEVXGQz1u5CO1/DtuFc2bCM5wzFL1QkaTOTlQ5Y2C
         0NQZKJRpF8TEMEib/SdzqLwByQYXx3nqrlq4lSpxEM9PJH7A3oNUKNLDL9JaRdm6bpAH
         mTnzLspRCz8mARK+wh5ZX7CCSqd0fIbvvcbetSn3W2tK1cDlTr/L09/UA1fNYI0PWGyX
         nrHF/6aCE2HAzbATgkR0qZg6q7r9NiBE6YvGYpk7PpD5//tloaml/a8+YCVCITrV5Qpz
         KoACpuecx0VDgPWJ3T4g+mxqA40OLO316hdV1d5Bg7D9U9TzYZovAbVonQqubaWb8Dan
         GbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=z1fjs1EfUF1uEK2M22RKjfvNAFhj1h4cQ8a0unHmKJw=;
        b=P31YQejDCsu8wc/QjcBtUfyFQ4kYe67+Vk1jPLFby3bpbZNTn1rqnEBOVSEpAFMzh8
         Fa7K4ZmgzqUK72NtIEGG6eotv0mXSDbVa9rZ64tJttQrHpg8DGdxxlQJR1SnRY06/xDm
         jMtj8LrllIxw/pQrDL5stGBSo0PzV4QhemXNxLN1SspU4bDP+84xojJAAiWwXcVVWnNA
         o+je6i9x8un0Fh6CNUyUzcjT0F66sKGwJEv68DYCjuVebRdNIwG9g4EhSgcC84lkjlBR
         45TcYX3Lql8QOKlHflCct5DR5lwX0IhhWpMzjiAwL64SG33wuHGGqH6xBMt/rXc1ZRw4
         /Sug==
X-Gm-Message-State: AIVw113W64u220IqQv5xViZdKnRXyOm9L3Zn9gtYm1b9LxEXhedlUIkZ
        7qLjzM53FNpsxg==
X-Received: by 10.84.172.131 with SMTP id n3mr24307439plb.14.1499289257480;
        Wed, 05 Jul 2017 14:14:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id a4sm114638pfc.22.2017.07.05.14.14.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 14:14:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cygwin: Allow pushing to UNC paths
References: <xmqqr2y0nk88.fsf@gitster.mtv.corp.google.com>
        <20170703144137.27176-1-tboegi@web.de>
Date:   Wed, 05 Jul 2017 14:14:13 -0700
In-Reply-To: <20170703144137.27176-1-tboegi@web.de> (tboegi@web.de's message
        of "Mon, 3 Jul 2017 16:41:37 +0200")
Message-ID: <xmqqinj6h9i2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
>  cygwin can use an UNC path like //server/share/repo
>  $ cd //server/share/dir
>  $ mkdir test
>  $ cd test
>  $ git init --bare
>
>  However, when we try to push from a local Git repository to this repo,
>  there is a problem: Git converts the leading "//" into a single "/".
>
>  As cygwin handles an UNC path so well, Git can support them better:
>  - Introduce cygwin_offset_1st_component() which keeps the leading "//",
>    similar to what Git for Windows does.
>  - Move CYGWIN out of the POSIX in the tests for path normalization in t0060
>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>
> I think I skip all the changing in setup.c and cygwin_access() for the
> moment:
> - It is not clear, what is a regression and what is an improvement
> - It may be a problem that could be solved in cygwin itself
> - I was able to push a an UNC path on a Windows server
>   when the domain controller was reachable.

OK.  

It certainly makes it simpler to improve things one at a time ;-)

> diff --git a/compat/cygwin.h b/compat/cygwin.h
> new file mode 100644
> index 0000000..8e52de4
> --- /dev/null
> +++ b/compat/cygwin.h
> @@ -0,0 +1,2 @@
> +int cygwin_offset_1st_component(const char *path);
> +#define offset_1st_component cygwin_offset_1st_component

I originally found this somewhat iffy, but decided to take it as-is.
But we may want to fix it (and the original sin that brought this
file into this shape) later.

The reason of "iffy"-ness I felt were twofold:

 - This header file is only two lines long and is designed to be
   included at a single place (git-compat-util.h).  It might be
   better to inline its contents directly there, if we do not expect
   it to grow aggressively in the future.

 - If it is to be a header file on its own, it should have the
   standard double-inclusion guard

    #ifndef COMPAT_CYGWIN_H
    #define COMPAT_CYGWIN_H
	...
    #endif /* COMPAT_CYGWIN_H */

  around it.

I see this was modeled after existing compat/mingw.h, which is
sufficiently large that it deserves to be its own header, but then
it should have the double-inclusion guard around it.  

I am neutral between inlining the contents of cygwin.h to where it
is included and keeping the organization this patch proposes.  If we
anticipate futher development on Cygwin, perhaps having the header
as a separate file, even if it starts small, makes sense, so I do
not mind it.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 047172d..db9c22d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -189,6 +189,9 @@
>  #include <sys/sysctl.h>
>  #endif
>  
> +#if defined(__CYGWIN__)
> +#include "compat/cygwin.h"
> +#endif
>  #if defined(__MINGW32__)
>  /* pull in Windows compatibility stuff */
>  #include "compat/mingw.h"


Thanks.
