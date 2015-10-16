From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] usage: do not insist that standard input must come from
 a file
Date: Fri, 16 Oct 2015 13:04:52 -0700
Message-ID: <20151016200452.GA1901@google.com>
References: <xmqqvba6ekip.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:05:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnBG1-0007Rh-Cu
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 22:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbbJPUFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 16:05:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34661 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbbJPUFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 16:05:35 -0400
Received: by pacez2 with SMTP id ez2so13252226pac.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/KkEoDorOLEucsAWd99lwaNHd5ii6gdFahYrvVXdpNM=;
        b=tMIneg8oLuFc1WenvE0M8j7ycIvphv2VYjpnyFBUQ+whinGeeIFvs19kv7FQ1l/77n
         g6eEp5uMHRROMBfbzczoPFHi/zzdL+7inv7f6KOZiry3N+KEP2OjuPBbnsRA6195l92R
         +b/RwYF7Lh9M/IzrgvnZsfn1xtxoBzR5PnGErciXzH110dUshS5NG/FVuHhsoaZkXc5G
         dPyefxUwh/kM6AE4Ih9r/yI/ElQIM6U3/EgeIF14wj3oqFx48cZi9tzHM+kxQF71ssyH
         iAHKKk7C/Y1agqtQW7q53NOnqfLZYX+tct1Y8j2g0N2UVqPo6oHZXxgp9DCinZZu/mVo
         2yeg==
X-Received: by 10.68.216.135 with SMTP id oq7mr18695743pbc.9.1445025934981;
        Fri, 16 Oct 2015 13:05:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:a41c:7a7:1f0e:ffad])
        by smtp.gmail.com with ESMTPSA id kw10sm22742579pbc.25.2015.10.16.13.05.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 13:05:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqvba6ekip.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279762>

Junio C Hamano wrote:

> The synopsys text and the usage string of subcommands that read list

nit: s/synopsys/synopsis/

[...]
> +++ b/Documentation/git-cat-file.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv ) <object>
> -'git cat-file' (--batch | --batch-check) [--follow-symlinks] < <list-of-objects>
> +'git cat-file' (--batch | --batch-check) [--follow-symlinks]

Makes sense.  The BATCH OUTPUT section explains the input format.

[...]
> +++ b/Documentation/git-check-attr.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git check-attr' [-a | --all | attr...] [--] pathname...
> -'git check-attr' --stdin [-z] [-a | --all | attr...] < <list-of-paths>
> +'git check-attr' --stdin [-z] [-a | --all | attr...]
>
>  DESCRIPTION
>  -----------
> @@ -28,7 +28,7 @@ OPTIONS
>  	Consider `.gitattributes` in the index only, ignoring the working tree.
>
>  --stdin::
> -	Read file names from stdin instead of from the command-line.
> +	Read pathnames from stdin instead of from the command-line.

Here I have to read the description of "-z" to understand that pathnames
come one per line.  How about

	Read pathnames from stdin, one per line, instead of from the command
	line.

?

[...]
> +++ b/Documentation/git-check-ignore.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git check-ignore' [options] pathname...
> -'git check-ignore' [options] --stdin < <list-of-paths>
> +'git check-ignore' [options] --stdin

Likewise.

	Read pathnames from stdin, one per line, instead of from the command
	line.

[...]
> +++ b/Documentation/git-commit-tree.txt
> @@ -9,7 +9,7 @@ git-commit-tree - Create a new commit object
>  SYNOPSIS
>  --------
>  [verse]
> -'git commit-tree' <tree> [(-p <parent>)...] < changelog
> +'git commit-tree' <tree> [(-p <parent>)...]

The DESCRIPTION explains the input --- good.

[...]
> +++ b/Documentation/git-fmt-merge-msg.txt
> @@ -9,7 +9,7 @@ git-fmt-merge-msg - Produce a merge commit message
>  SYNOPSIS
>  --------
>  [verse]
> -'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] <$GIT_DIR/FETCH_HEAD
> +'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log]

The input format isn't described anywhere, unless I think of looking
at the "-F" option.  More importantly, the expected usage isn't described
anywhere.

Perhaps an EXAMPLES section would help?

	EXAMPLE
	-------

	--
	$ git fetch origin master
	$ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
	--

	Print a log message describing a merge of the "master" branch from
	the "origin" remote.

> --- a/Documentation/git-get-tar-commit-id.txt
> +++ b/Documentation/git-get-tar-commit-id.txt
> @@ -9,17 +9,19 @@ git-get-tar-commit-id - Extract commit ID from an archive created using git-arch
>  SYNOPSIS
>  --------
>  [verse]
> -'git get-tar-commit-id' < <tarfile>
> +'git get-tar-commit-id'

Looks sensible.

[...]
> +Read an archive created by 'git archive' from the standard input and

Perhaps 'Reads a tar archive'?  Otherwise I would be tempted to pass in
a zip or tgz file.

[...]
> +++ b/Documentation/git-hash-object.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
> -'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters] < <list-of-paths>
> +'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]

Has the same ambiguity as the other --stdin option descriptions.

	Read pathnames from stdin, one per line, instead of from the command
	line.

[...]
> +++ b/Documentation/git-mktag.txt
> @@ -9,7 +9,7 @@ git-mktag - Creates a tag object
> -A tag signature file has a very simple fixed format: four lines of
> +A tag signature file, to be fed from the standard input, has a

s/from the/to this command's/

[...]
> +++ b/Documentation/git-patch-id.txt
> @@ -8,10 +8,12 @@ git-patch-id - Compute unique ID for a patch
[...]
> +Read a patch from the standard input, and compute the patch ID for it.

Punctuation nit: there shouldn't be a comma before "and".

[...]
> +++ b/Documentation/git-show-index.txt
> @@ -9,13 +9,14 @@ git-show-index - Show packed archive index
>  SYNOPSIS
>  --------
>  [verse]
> -'git show-index' < idx-file
> +'git show-index'
>  
>  
>  DESCRIPTION
>  -----------
> -Reads given idx file for packed Git archive created with
> -'git pack-objects' command, and dumps its contents.
> +Read an idx file for packed Git archive created with
> +'git pack-objects' command from the standard input, and
> +dump its contents.

Unrelated nit: this sounds like it's talking about "git archive"
on first reading.  Maybe:

	Reads the idx file generated alongside a Git packfile by
	'git pack-objects' and dumps a description of the pack's
	contents.

[...]
> +++ b/Documentation/git-show-ref.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
>  	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
>  	     [--heads] [--] [<pattern>...]
> -'git show-ref' --exclude-existing[=<pattern>] < ref-list
> +'git show-ref' --exclude-existing[=<pattern>]

What is the input format?

Should there be a --stdin option to allow people to explicitly say they want
to pass ref names (or patterns?) in stdin?

[...]
> +++ b/Documentation/git-stripspace.txt
> +++ b/Documentation/git-unpack-objects.txt
> +++ b/builtin/cat-file.c
> +++ b/builtin/check-attr.c
> +++ b/builtin/check-ignore.c
> +++ b/builtin/commit-tree.c
> +++ b/builtin/get-tar-commit-id.c
> +++ b/builtin/hash-object.c
> +++ b/builtin/mktag.c
> +++ b/builtin/patch-id.c
> +++ b/builtin/show-ref.c
> +++ b/builtin/stripspace.c
> +++ b/builtin/unpack-objects.c
> +++ b/show-index.c

Looks good.

Thanks,
Jonathan
