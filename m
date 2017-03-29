Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD16420966
	for <e@80x24.org>; Wed, 29 Mar 2017 10:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755749AbdC2KBS (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 06:01:18 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:51895 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755725AbdC2KBQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 06:01:16 -0400
X-AuditID: 1207440d-041ff70000003721-72-58db85ea162c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C6.65.14113.AE58BD85; Wed, 29 Mar 2017 06:01:14 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDF5D2.dip0.t-ipconnect.de [79.237.245.210])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2TA1Cuk015722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 29 Mar 2017 06:01:13 -0400
Subject: Re: [PATCH v4 3/5] remove_subtree(): reimplement using iterators
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-4-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <679957e0-bb06-2dd9-bfc5-024da5ab49ce@alum.mit.edu>
Date:   Wed, 29 Mar 2017 12:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490747533-89143-4-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqPuq9XaEwbouG4vHn96yWXRd6Way
        aOi9wmzRPeUto8Xmze0sDqweO2fdZfdYsKnU4+IlZY/Pm+QCWKK4bFJSczLLUov07RK4Mrom
        /mQvWCNcseXfcaYGxoP8XYycHBICJhJfzn5h7mLk4hAS2MEkMe3sLiYI5wKTROO7/cwgVcIC
        nhL3G2eydzFycIgIWEtcX+MFEhYSKJd4/Wo1K4jNLGAjcbyplxHEZhPQlVjU08wEYvMK2Et8
        +DEVbAyLgKpE34P1YDWiAiEScxY+YISoEZQ4OfMJC4jNKeAocfrhCXaImXoSO67/gpovL7H9
        7RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsY
        IcHLu4Px/zqZQ4wCHIxKPLw78m5FCLEmlhVX5h5ilORgUhLlPWF4O0KILyk/pTIjsTgjvqg0
        J7X4EKMEB7OSCK++IlCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB
        +7oFqFGwKDU9tSItM6cEIc3EwQkynAdo+OdmkOHFBYm5xZnpEPlTjIpS4rzXQRICIImM0jy4
        XlhyecUoDvSKMG8+yAoeYGKC634FNJgJaLC4zS2QwSWJCCmpBsbEz3M26wV5x+eWyZy68uFi
        +ddI+f3FR7ebm13OYfzrLsf6+YnJkSb5X4vbXxua1LTVOqlPWjCzS0wvtnBh5d6DvyYsZfte
        YPBHcv4W/tnhc8pWfQ6dYMGqGMix1HZPaaYkZ8eRhY4+tpuW11h/fNHmn64wy+sU/7Lsk7a+
        l9Y89TNYOWXmlUolluKMREMt5qLiRABbKFUrCQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29/2017 02:32 AM, Daniel Ferreira wrote:
> Use dir_iterator to traverse through remove_subtree()'s directory tree,
> avoiding the need for recursive calls to readdir(). Simplify
> remove_subtree()'s code.
> 
> A conversion similar in purpose was previously done at 46d092a
> ("for_each_reflog(): reimplement using iterators", 2016-05-21).
> 
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  entry.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index c6eea24..bbebd16 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -2,6 +2,8 @@
>  #include "blob.h"
>  #include "dir.h"
>  #include "streaming.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
> 
>  static void create_directories(const char *path, int path_len,
>  			       const struct checkout *state)
> @@ -46,29 +48,16 @@ static void create_directories(const char *path, int path_len,
> 
>  static void remove_subtree(struct strbuf *path)

The reason that this function took a `strbuf` as argument was that it
used to modify the strbuf while it was working. Now that `dir_iterator`
does all of that work, you could simplify it to take a `const char *`
argument, and change the caller to pass `path.buf`.

>  {
> -	DIR *dir = opendir(path->buf);
> -	struct dirent *de;
> -	int origlen = path->len;
> -
> -	if (!dir)
> -		die_errno("cannot opendir '%s'", path->buf);
> -	while ((de = readdir(dir)) != NULL) {
> -		struct stat st;
> -
> -		if (is_dot_or_dotdot(de->d_name))
> -			continue;
> -
> -		strbuf_addch(path, '/');
> -		strbuf_addstr(path, de->d_name);
> -		if (lstat(path->buf, &st))
> -			die_errno("cannot lstat '%s'", path->buf);
> -		if (S_ISDIR(st.st_mode))
> -			remove_subtree(path);
> -		else if (unlink(path->buf))
> +	struct dir_iterator *diter = dir_iterator_begin(path->buf, DIR_ITERATOR_DEPTH_FIRST);
> +
> +	while (dir_iterator_advance(diter) == ITER_OK) {
> +		if (S_ISDIR(diter->st.st_mode)) {
> +			if (rmdir(diter->path.buf))
> +				die_errno("cannot rmdir '%s'", path->buf);
> +		} else if (unlink(diter->path.buf))
>  			die_errno("cannot unlink '%s'", path->buf);

The two `die_errno()` calls must be changed to use `diter->path.buf`
rather than `path->buf`.

> -		strbuf_setlen(path, origlen);
>  	}
> -	closedir(dir);
> +
>  	if (rmdir(path->buf))
>  		die_errno("cannot rmdir '%s'", path->buf);
>  }

Michael

