Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB3220954
	for <e@80x24.org>; Sun, 26 Nov 2017 00:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbdKZAwJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 19:52:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:53041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751798AbdKZAwI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 19:52:08 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiDrv-1ewEys2Kh9-00nNB8; Sun, 26
 Nov 2017 01:52:05 +0100
Date:   Sun, 26 Nov 2017 01:52:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 21/33] merge-recursive: add get_directory_renames()
In-Reply-To: <20171121080059.32304-22-newren@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711260147330.6482@virtualbox>
References: <20171121080059.32304-1-newren@gmail.com> <20171121080059.32304-22-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:s7NyQ4dn62Yc4T4z7S/XjQch6H5eZkiP8paPg7qyBVDq5At2lXo
 IYNcyz9JdhGRPyyPha6jUtU0ziQTeiduLxUv09X9zIlg41TGc7lT/BHls24iQ+w6BL9cKyu
 4IlLWOQNKx8VmXBJB2rtSDqQRnxSRqmghFj3/xPsRZu8d9h0X0PbTZutdHLmTgrtKG0Qs/7
 tFkpVLy2jIrILKBZFcr1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k/MErriHUj0=:zq+ZvkvxKVf3doPPnZqgBO
 Fnpsb+xn2FCw28buX3vAD9b50F7FPZSklHpT7F/L2vz4HnZWdQaUQc6bkZuByu30Uf1/L5+Qa
 Xji7J9RwQu74qVJc9nOnYAXibJYhdVxwPPctQSvz3yO25vqHA/x0k1qUxrYH4CYPNBlhFnpxr
 npSIBmMg9Bxp06vWOZ6Lc4bS5o3AjnEBJxfGfpdFEQk5syrFe8SynqO3uly6QcYrgWDDxAadY
 MMwfQzrUmM6YAf4zTbI27U2ayKq6kwXFwVZuUAP5/L5KxI0CB4yNXpKkTTrRrinxwEA6HG/EA
 N+LcAPapDwcJmJZkHAjVVMGt9sUdOjHE/gwHk0G7UF0b2KgCgE7Ovkmy/zQwC0ouVHHUpaLtL
 4n9PXQKqQgGn6FsLndFWNaT1rVRdUrSZtJHxZziv7q7Td+PRiCKkevGZrGwuVCI8FTdDKxDXO
 wtVygKlsLhTzOJAEHSrhU3Rxu3DI/gQ/7tBNaerhLuyQFZhVH9rwjQmI/FY5PffOeLGls6/Lj
 HOP1kXu4zkn7Jpe0VVkp0t8S2lPtIu7uPbIGmAk2gFzJdb5nagjAjZUFIqElTGNSLNxE8VdmJ
 4AMzhQv5f3m5fRaND+avTH+ze5qajiogRKbMqNc/yvaieK6Awc0qGelabdsrGI5FeDx1o4BtZ
 9+n06+8zYgV5qh+SSoq4ndTUOmOmktZqw3StoCEktQXU9CeLoTRBXbrvn+7zgq3HwVLfMa2eE
 QtI6FnxhVQh+14A/hWEjaQGop46CpHQ0UeM6Fiob/CNa3wwDMiyeGK3xrO1CCrpvCXUBdMWH4
 UYpNxo2Q+H8XxzamRWSRAnra+MWZhkejkzO5fvzK5jovcWI+lc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 21 Nov 2017, Elijah Newren wrote:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 2f4f85314a..6a0a6d4366 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1384,6 +1384,132 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
>  	return ret;
>  }
>  
> +static void get_renamed_dir_portion(const char *old_path, const char *new_path,
> +				    char **old_dir, char **new_dir)
> +{
> +	char *end_of_old, *end_of_new;
> +	int old_len, new_len;
> +
> +	*old_dir = NULL;
> +	*new_dir = NULL;
> +
> +	/* For
> +	 *    "a/b/c/d/foo.c" -> "a/b/something-else/d/foo.c"
> +	 * the "d/foo.c" part is the same, we just want to know that
> +	 *    "a/b/c" was renamed to "a/b/something-else"
> +	 * so, for this example, this function returns "a/b/c" in
> +	 * *old_dir and "a/b/something-else" in *new_dir.
> +	 *
> +	 * Also, if the basename of the file changed, we don't care.  We
> +	 * want to know which portion of the directory, if any, changed.
> +	 */
> +	end_of_old = strrchr(old_path, '/');
> +	end_of_new = strrchr(new_path, '/');
> +
> +	if (end_of_old == NULL || end_of_new == NULL)
> +		return;
> +	while (*--end_of_new == *--end_of_old &&
> +	       end_of_old != old_path &&
> +	       end_of_new != new_path)
> +		; /* Do nothing; all in the while loop */
> +	/*
> +	 * We've found the first non-matching character in the directory
> +	 * paths.  That means the current directory we were comparing
> +	 * represents the rename.  Move end_of_old and end_of_new back
> +	 * to the full directory name.
> +	 */
> +	if (*end_of_old == '/')
> +		end_of_old++;
> +	if (*end_of_old != '/')
> +		end_of_new++;
> +	end_of_old = strchr(end_of_old, '/');
> +	end_of_new = strchr(end_of_new, '/');
> +
> +	/*
> +	 * It may have been the case that old_path and new_path were the same
> +	 * directory all along.  Don't claim a rename if they're the same.
> +	 */
> +	old_len = end_of_old - old_path;
> +	new_len = end_of_new - new_path;
> +
> +	if (old_len != new_len || strncmp(old_path, new_path, old_len)) {
> +		*old_dir = strndup(old_path, old_len);
> +		*new_dir = strndup(new_path, new_len);

These two callers of strndup() are the only ones in Git's code base now.
It is also causing a compile error on Windows.

Any reason you did not use xstrndup() here?

Ciao,
Dscho
