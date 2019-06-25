Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313AD1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfFYLFP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:05:15 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:59522 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbfFYLFP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Jun 2019 07:05:15 -0400
Received: from [2001:16b8:5c70:2000:5cc1:ca70:89c5:11f6]; authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hfjGD-0003iF-Mp; Tue, 25 Jun 2019 13:05:13 +0200
Subject: Re: [PATCH] make slash-rules more readable
To:     git@vger.kernel.org
References: <20190604173446.2664-1-admin@in-ici.net>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Message-ID: <bd722415-1547-8db5-f88a-c35c8b48d8be@in-ici.net>
Date:   Tue, 25 Jun 2019 13:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604173446.2664-1-admin@in-ici.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1561460715;2e4dea16;
X-HE-SMSGID: 1hfjGD-0003iF-Mp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

any comments about the patch note from 04.06 ?

All the best,
Adam

On 04.06.19 19:34, Dr. Adam Nielsen wrote:
> gitignore.txt: make slash-rules more readable
> 
> Renew paragraphs relevant for pattern with slash.
> Aim to make it more clear and to avoid possible
> pitfalls for the reader. Add some examples.
> 
> Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>
> 
> ---
>   Documentation/gitignore.txt | 66 ++++++++++++++++++++++++-------------
>   1 file changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index b5bc9dbff0..d47b1ae296 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -89,28 +89,28 @@ PATTERN FORMAT
>      Put a backslash ("`\`") in front of the first "`!`" for patterns
>      that begin with a literal "`!`", for example, "`\!important!.txt`".
>   
> - - If the pattern ends with a slash, it is removed for the
> -   purpose of the following description, but it would only find
> -   a match with a directory.  In other words, `foo/` will match a
> -   directory `foo` and paths underneath it, but will not match a
> -   regular file or a symbolic link `foo` (this is consistent
> -   with the way how pathspec works in general in Git).
> -
> - - If the pattern does not contain a slash '/', Git treats it as
> -   a shell glob pattern and checks for a match against the
> -   pathname relative to the location of the `.gitignore` file
> -   (relative to the toplevel of the work tree if not from a
> -   `.gitignore` file).
> -
> - - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
> -   anything except "`/`", "`?`" matches any one character except "`/`"
> -   and "`[]`" matches one character in a selected range. See
> -   fnmatch(3) and the FNM_PATHNAME flag for a more detailed
> -   description.
> -
> - - A leading slash matches the beginning of the pathname.
> -   For example, "/{asterisk}.c" matches "cat-file.c" but not
> -   "mozilla-sha1/sha1.c".
> + - The slash '/' is used as the directory separator. Separators may
> +   occur at the beginning, middle or end of the `.gitignore` search pattern.
> +
> + - If there is a separator at the beginning or middle (or both) of the
> +   pattern, then the pattern is relative to the directory level of the
> +   particular `.gitignore` file itself. Otherwise the pattern may also
> +   match at any level below the `.gitignore` level.
> +
> + - If there is a separator at the end of the pattern then the pattern
> +   will only match directories, otherwise the pattern can match both
> +   files and directories.
> +
> + - For example, a pattern `doc/frotz/` matches `doc/frotz` directory,
> +   but not `a/doc/frotz` directory; however `frotz/` matches `frotz`
> +   and `a/frotz` that is a directory (all paths are relative from
> +   the `.gitignore` file).
> +
> + - An asterisk "`*`" matches anything except a slash.
> +   The character "`?`" matches any one character except "`/`".
> +   The range notation, e.g. `[a-zA-Z]`, can be used to match
> +   one of the characters in a range. See fnmatch(3) and the
> +   FNM_PATHNAME flag for a more detailed description.
>   
>   Two consecutive asterisks ("`**`") in patterns matched against
>   full pathname may have special meaning:
> @@ -152,6 +152,28 @@ To stop tracking a file that is currently tracked, use
>   EXAMPLES
>   --------
>   
> + - The pattern `hello.*` matches any file or folder
> +   whose name begins with `hello`. If one wants to restrict
> +   this only to the directory and not in its subdirectories,
> +   one can prepend the pattern with a slash, i.e. `/hello.*`;
> +   the pattern now matches `hello.txt`, `hello.c` but not
> +   `a/hello.java`.
> +
> + - The pattern `foo/` will match a directory `foo` and
> +   paths underneath it, but will not match a regular file
> +   or a symbolic link `foo` (this is consistent with the
> +   way how pathspec works in general in Git)
> +
> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
> +   in any `.gitignore` file. In other words, a leading slash
> +   is not relevant  if there is already a middle slash in
> +   the pattern.
> +
> + - The pattern "foo/*", matches "foo/test.json"
> +   (a regular file), "foo/bar" (a directory), but it does not match
> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
> +   pattern does not match "bar/hello.c" which has a slash in it.
> +
>   --------------------------------------------------------------
>       $ git status
>       [...]
> 

-- 
photograph 	
*Dr. Adam Nielsen
* Administrator | IN/ICI/WHO
*IN:* 	nlp-institutes.net <https://nlp-institutes.net>
*ICI:* 	coaching-institutes.net <https://coaching-institutes.net>
*WHO:* 	world-hypnosis.org <https://world-hypnosis.org>

