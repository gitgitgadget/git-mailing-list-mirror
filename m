Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3111220966
	for <e@80x24.org>; Mon,  3 Apr 2017 03:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdDCDmR (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 23:42:17 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57407 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751704AbdDCDmP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2017 23:42:15 -0400
X-AuditID: 1207440d-029ff70000003721-32-58e1c49553e3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B0.13.14113.594C1E85; Sun,  2 Apr 2017 23:42:13 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDFF7F.dip0.t-ipconnect.de [79.237.255.127])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v333gAYJ017611
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 2 Apr 2017 23:42:12 -0400
Subject: Re: [PATCH v7 5/5] remove_subtree(): reimplement using iterators
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
 <1491163388-41255-6-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        Daniel Ferreira <daniel.calibeta@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <92bd74cc-1ad9-608b-f431-017d35ce72bc@alum.mit.edu>
Date:   Mon, 3 Apr 2017 05:42:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1491163388-41255-6-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqDv1yMMIg5n/TC0ef3rLZrH1w0tm
        i64r3UwWDb1XmC26p7xltNi8uZ3Fgc1j56y77B4LNpV6XLyk7PF5k1wASxSXTUpqTmZZapG+
        XQJXxpG9E1gKNkpU/D7/na2B8YRwFyMnh4SAicTxu6cZuxi5OIQEdjBJ3D4ygw3COc8k8ePn
        GRaQKmEBT4k9K76xdzFycIgIWEtcX+MFEhYSKJd49+YCK4jNLFAk8XrFFHYQm01AV2JRTzMT
        iM0rYC8xuaWdDcRmEVCR6H/zAywuKhAiMWfhA0aIGkGJkzOfgK3iFHCU+Nf2lg1ipp7Ejuu/
        oObLS2x/O4d5AiP/LCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJ
        XmpK6SZGSBjz7mD8v07mEKMAB6MSD6+G88MIIdbEsuLK3EOMkhxMSqK834vvRQjxJeWnVGYk
        FmfEF5XmpBYfYpTgYFYS4Q09CFTOm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgST
        leHgUJLgjTwM1ChYlJqeWpGWmVOCkGbi4AQZzgM0PAmkhre4IDG3ODMdIn+KUVFKnHfdIaCE
        AEgiozQPrheWZl4xigO9IszrB9LOA0xRcN2vgAYzAQ22+HoXZHBJIkJKqoEx75DCV88as+N7
        T4oq116/fHChjdAOCdl3B9+szp0q82dpIbP5CuaEmeuu+JokrP2aef3LkwzrQyb7A3JsXudP
        vTB/3uXLxzUY9upKOR3J3By8RT3gtVhZSPflGuflwWey65/Nupxxcp7eVt29ca3CJyd+Z9gz
        t3u/9MP2+2Fmyql3ej8dfhIbqMRSnJFoqMVcVJwIANojB6QOAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02/2017 10:03 PM, Daniel Ferreira wrote:
> From: Daniel Ferreira <daniel.calibeta@gmail.com>
> 
> Use dir_iterator to traverse through remove_subtree()'s directory tree,
> avoiding the need for recursive calls to readdir(). Simplify
> remove_subtree()'s code.
> 
> A conversion similar in purpose was previously done at 46d092a
> ("for_each_reflog(): reimplement using iterators", 2016-05-21).
> 
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>

This patch has a different author email than the others. If possible,
please choose one email address that you will use for your commits, and
try to be consistent.

> ---
>  entry.c | 38 ++++++++++++--------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index d2b512d..bd06f41 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -3,6 +3,8 @@
>  #include "dir.h"
>  #include "streaming.h"
>  #include "submodule.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
>  
>  static void create_directories(const char *path, int path_len,
>  			       const struct checkout *state)
> @@ -45,33 +47,17 @@ static void create_directories(const char *path, int path_len,
>  	free(buf);
>  }
>  
> -static void remove_subtree(struct strbuf *path)
> +static void remove_subtree(const char *path)
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
> -			die_errno("cannot unlink '%s'", path->buf);
> -		strbuf_setlen(path, origlen);
> +	struct dir_iterator *diter = dir_iterator_begin(path, DIR_ITERATOR_POST_ORDER_TRAVERSAL | DIR_ITERATOR_LIST_ROOT_DIR);

The line above is way too long. Try to limit lines to 80 characters max.
(This is documented in `Documentation/CodingGuidelines`.)

> +	while (dir_iterator_advance(diter) == ITER_OK) {
> +		if (S_ISDIR(diter->st.st_mode)) {
> +			if (rmdir(diter->path.buf))
> +				die_errno("cannot rmdir '%s'", diter->path.buf);
> +		} else if (unlink(diter->path.buf))
> +			die_errno("cannot unlink '%s'", diter->path.buf);
>  	}
> -	closedir(dir);
> -	if (rmdir(path->buf))
> -		die_errno("cannot rmdir '%s'", path->buf);
>  }
>  
>  static int create_file(const char *path, unsigned int mode)
> @@ -312,7 +298,7 @@ int checkout_entry(struct cache_entry *ce,
>  				return 0;
>  			if (!state->force)
>  				return error("%s is a directory", path.buf);
> -			remove_subtree(&path);
> +			remove_subtree(path.buf);
>  		} else if (unlink(path.buf))
>  			return error_errno("unable to unlink old '%s'", path.buf);
>  	} else if (state->not_new)
> 

That's a gratifying decrease in code size :-)

Michael

