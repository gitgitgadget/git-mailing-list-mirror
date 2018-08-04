Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9B31F597
	for <e@80x24.org>; Sat,  4 Aug 2018 15:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeHDRz7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 13:55:59 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45702 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeHDRz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 13:55:59 -0400
Received: by mail-wr1-f52.google.com with SMTP id f12-v6so8168961wrv.12
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PgiUu9aW625+EwN3P2c/xeWHnQe8wNjiHwJuVCc/UP4=;
        b=NQ6SC6edAsbfOvcBH4nGwePy9I2bRHXVEwzHA4a9dtpTF03UsGnBFF4dwiJHmkPmCe
         4XH3zVDWl04h/5JQpk/T+Z5vwUHqghCfT7wSekKSlvH+7iSVgh+viRWZleRbSGSLb2BH
         4fYzSwjbbpKeS/NJrLkwuCyNgE0cU1ed7gGzsp3IIweR2pBZMplE8FUMa5xaAJa5+fbZ
         3foQ6flpBN8bnbrkMLADOyZLqIJXiZaf3sLAJTqhfxQ730vu05gnWxf6f1EeCYAqKtue
         hT/su6DiGN2Mu/w/HsMn0BkIl4vfWnjae367vMA3tFDaup2bQUcvj3HLTSbL7Zq+INdN
         0ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PgiUu9aW625+EwN3P2c/xeWHnQe8wNjiHwJuVCc/UP4=;
        b=n/MiFUqR+Uh9/sPeq+nqPfnnrYrn4zJJjtXQCNnrbHDo3r/eTu5dPDUWiIMlydZAwJ
         rGwDlZnvTMdf3I9HCrip5iPhtDIOmF23NP69KhBKGp2wqRtWoBgg7Gmry2yge3Qpoxsq
         4E+BkFLzmSsPZNZMFM5KMiVBv2A76AdiIgKxv8Mlpr8by3mjfoizIlz74tjQ6WJFibQV
         6WgBXj7/fL666FIlsysq5nDvOgV6nOlJnzPmJl8cH6NFCU5elMXnzN9r5woZnKVduO6M
         DYqJZxYg1xgeV8qUmduwOd9Zz0TM3MuoD5xVz3MjPRP0NJMrJTLRvBvpzS6SZVV3Ca2D
         9iXw==
X-Gm-Message-State: AOUpUlHkPciHnkx1z1zl0GfcuLT7Q07hSkyNyymJXMSeoEgAniyrPceU
        Rf3W5aSFWUZemxMPZCSwUAA=
X-Google-Smtp-Source: AAOMgpd8/GU0WvzQs3ZJGyIW4bDlKAsuhFI8S+tMdeBUC8lKlQZ4ou9E39+FhQs3GgW8dynNM1PZ9A==
X-Received: by 2002:a5d:60c5:: with SMTP id x5-v6mr5768753wrt.232.1533398090351;
        Sat, 04 Aug 2018 08:54:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b202-v6sm5121339wme.22.2018.08.04.08.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 08:54:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] recover: restoration of deleted worktree files
References: <20180804142247.GA7@e3c0ce5ceb57>
        <20180804142416.GA6@5f28dc333bbd>
Date:   Sat, 04 Aug 2018 08:54:49 -0700
In-Reply-To: <20180804142416.GA6@5f28dc333bbd> (Edward Thomson's message of
        "Sat, 4 Aug 2018 14:24:16 +0000")
Message-ID: <xmqqpnyyt9di.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edward Thomson <ethomson@edwardthomson.com> writes:

> Introduce git-recover, a simple script to aide in restoration of deleted
> worktree files.  This will look for unreachable blobs in the object
> database and prompt users to restore them to disk, either interactively
> or on the command-line.
> ---
>  git-recover.sh | 311 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 311 insertions(+)
>  create mode 100755 git-recover.sh

My first reaction was to say that I am not going to take a new
command written only for bash with full bashism, even if it came
with docs, tests nor Makefile integration, for Git itself.  Then I
reconsidered, as not everything related to Git is git-core, and all
of the above traits are sign of this patch _not_ meant for git-core.

In other words, I think this patch can be a fine addition to
somebody else's project (i.e. random collection of scripts that may
help Git users), so let's see how I can offer comments/inputs to
help you improve it.  So I won't comment on lang, log message, or
shell scripting style---these are project convention and the git-core
convention won't be relevant to this patch.

> diff --git a/git-recover.sh b/git-recover.sh
> new file mode 100755
> index 000000000..651d4116f
> --- /dev/null
> +++ b/git-recover.sh
> @@ -0,0 +1,311 @@
> +#!/usr/bin/env bash
> +#
> +# This program helps recover files in your repository that were deleted
> +# from the working tree.
> +#
> +# Copyright (c) 2017-2018 Edward Thomson.
> +
> +set -e
> +
> +IFS=$'\n'
> +
> +PROGNAME=$(echo "$0" | sed -e 's/.*\///')
> +GIT_DIR=$(git rev-parse --git-dir)
> +
> +DO_RECOVER=0
> +DO_FULL=0
> +DO_INTERACTIVE=0
> +BLOBS=()
> +FILENAMES=()
> +
> +function die_usage {
> +	echo "usage: $PROGNAME [-a] [-i] [--full] [<id> [-f <filename>] ...]" >&2
> +	exit 1
> +}
> +
> +while [[ $# -gt 0 ]]; do
> +	case "$1" in
> +	-a|--all)
> +		DO_RECOVER=1
> +		;;
> +	-i|--interactive)
> +		DO_INTERACTIVE=1
> +		;;
> +	--full)
> +		DO_FULL=1
> +		;;
> +	*)
> +		if [ "${1:0:1}" == "-" ]; then
> +			echo "$PROGNAME: unknown argument: $1" >&2
> +			die_usage
> +		fi
> +		BLOBS+=("$1")
> +
> +		shift
> +		if [ "$1" == "-f" ] || [ "$1" == "--filename" ]; then
> +			shift
> +			if [ $# == 0 ]; then
> +				die_usage
> +			fi
> +			FILENAMES+=("$1")
> +			shift
> +		else
> +			FILENAMES+=("")
> +		fi

You do not want to take "--file=Makefile" (i.e. abbreviated option
name, and value as part of the option arg after '=')?

> +		continue
> +	;;
> +	esac
> +	shift
> +done

So, as a user, I can run this with "-a" but no blob object names to
run it in DO_RECOVER mode, or I can give one or more "blob spec"
where I say object id, optionally followed by one "-f filename"; in
the latter mode, BLOBS[] and FILENAMES[] array would have the same
number of elements, corresponding to each other.

> +if [ ${#BLOBS[@]} != 0 ] && [ $DO_RECOVER == 1 ]; then
> +	die_usage
> +elif [ ${#BLOBS[@]} != 0 ]; then
> +	DO_RECOVER=1
> +fi

If I did not say "-a" but did not give "blob spec", then I am
implicitly asking for "-a" to work in DO_RECOVER mode.

I think I understood what the program wants to do so far.

> +case "$OSTYPE" in
> +	darwin*|freebsd*) IS_BSD=1 ;;
> +	*) IS_BSD=0 ;;
> +esac
> +
> +function expand_given_blobs() {
> +	for i in "${!BLOBS[@]}"; do
> +		ID=$(git rev-parse --verify "${BLOBS[$i]}" 2>/dev/null || true)
> +
> +		if [ -z "$ID" ]; then
> +			echo "$PROGNAME: ${BLOBS[$i]} is not a valid object." 1>&2
> +			exit 1
> +		fi
> +
> +		TYPE=$(git cat-file -t "${ID}" 2>/dev/null || true)

An earlier "set -e" makes "|| true" ugliness required.  I suspect
use of "set -e" overall is a loss (vs explicit error checking).

> +		if [ "$TYPE" != "blob" ]; then
> +			echo "$PROGNAME: ${BLOBS[$i]} is not a blob." 1>&2
> +			exit
> +		fi

A user may have given us 11f5bcd9 and this function makes sure such
an object exists in the object store *and* is a blob.  Otherwise
it dies.  The main objective of this function is to turn that user
supplied object name to a full hex that is known to refer to an
existing blob.

> +		BLOBS[$i]=$ID
> +	done

I find a disconnect between this being a loop and the attiude "we
won't tolerate any erroneous input".  If a user is feeding dozens of
blob object names, wouldn't it be more helpful to give a warning, go
on and help the user with the rest?

> +}
> +
> +# find all the unreachable blobs
> +function find_unreachable() {
> +	FULLNESS="--no-full"
> +
> +	if [ $DO_FULL == 1 ]; then FULLNESS="--full"; fi
> +
> +	BLOBS=($(git fsck --unreachable --no-reflogs \
> +		"${FULLNESS}" --no-progress | sed -ne 's/^unreachable blob //p'))
> +}

If you are going to do a full sweep with fsck anyway, perhaps have
make it do the work of writing out lost-found, so that you can
iterate over them?

As a blob that is only reachable from a commit in reflog and not in
the histories that are alive is something a user would want to recover,
the use of --no-reflogs option makes sense to me.

> +function read_one_file {
> +	BLOB=$1
> +	FILTER_NAME=$2
> +	ARGS=()
> +
> +	if [ -z "$FILTER_NAME" ]; then
> +		ARGS+=("blob")
> +	else
> +		ARGS+=("--filters" "--path=$FILTER_NAME")
> +	fi
> +
> +	git cat-file "${ARGS[@]}" "$BLOB"
> +}

We get a blob object name and optional "--filename=name"; drives
cat-file possibly with "--filters --path=name" to grab its contents.
I find it a good thinking to use "--filters" that does the equivalent
of the smudge codepath, as you eventually want to materialize the
found contents as a working tree file ...

> +function write_one_file {
> +	BLOB=$1
> +	FILTER_NAME=$2
> +	OUTPUT_NAME=$3
> +
> +	ABBREV=$(git rev-parse --short "${BLOB}")
> +
> +	echo -n "Writing $ABBREV: "
> +	read_one_file "$BLOB" "$FILTER_NAME" > "$OUTPUT_NAME"
> +	echo "$OUTPUT_NAME."
> +}

... which happens here.

> +function unique_filename {
> +	if [ ! -f "${BLOB}" ]; then
> +		echo "$BLOB"
> +	else
> +		cnt=1
> +		while true
> +		do
> +			fn="${BLOB}~${cnt}"
> +			if [ ! -f "${fn}" ]; then
> +				echo "${fn}"
> +				break
> +			fi
> +			cnt=$((cnt+1))
> +		done
> +	fi
> +}

The function comes up with a name for a given blob to be written in
the directory, in which the user happened to have started the
command.  The function cannot be used unless we are processing each
blob fully before moving onto the next one. In other words,
"resurrect abcde --file=Makefile abcde --file=README.pdf" would
leave the same blob in the BLOBS[] array twice, so that two
different --filters can be attempted, but the calling code cannot
first call this function for all the BLOBS[] elements to assign them
unique-filename, as this function depends on "test -f" to be able to
see what happened to the previous elements in the BLOBS[] array.

> +function write_recoverable {
> +	for i in "${!BLOBS[@]}"; do
> +		BLOB=${BLOBS[$i]}
> +		FILTER_NAME=${FILENAMES[$i]}
> +		OUTPUT_NAME=${FILENAMES[$i]:-$(unique_filename)}
> +
> +		write_one_file "$BLOB" "$FILTER_NAME" "$OUTPUT_NAME"
> +	done
> +}

And we do that for all in BLOBS[].

> +function interactive {
> +	echo "Recoverable orphaned git blobs:"
> +
> +	sort_by_timestamp
> +	for BLOB_AND_TIMESTAMP in "${BLOB_AND_TIMESTAMPS[@]}"; do
> +		echo
> +
> +		BLOB=${BLOB_AND_TIMESTAMP::40}
> +		TIME=${BLOB_AND_TIMESTAMP:41}
> +		DATE=$([ ! -z "$TIME" ] && timestamp_to_s "$TIME" || echo "(Unknown)") 
> +
> +		echo "$BLOB  ($DATE)"
> +		show_summary "${BLOB}" | head -4 | sed -e 's/^/> /'
> +		echo
> +
> +		while true
> +		do
> +			echo -n "Recover this file? [y,n,v,f,q,?]: "
> +			read -r ans || return 1
> +
> +			case "$ans" in
> +			[yY]*)
> +				write_one_file "${BLOB}" "" "$(unique_filename)"
> +				break
> +				;;
> +			[nN]*)
> +				break
> +				;;
> +			[vV]*)
> +				view_file "${BLOB}"
> +				echo
> +				;;
> +			[fF]*)
> +				prompt_for_filename
> +
> +				if [ "$FILENAME" == "" ]; then
> +					break
> +				fi
> +
> +				write_one_file "${BLOB}" "${FILENAME}" "${FILENAME}"
> +				break
> +				;;
> +			\?*)
> +				echo
> +				echo "Do you want to recover this file?"
> +				echo " y: yes, write the file to ${BLOB}"
> +				echo " n: no, skip this file and see the next orphaned file"
> +				echo " v: view the file"
> +				echo " f: prompt for a filename to use for recovery"
> +				echo " q: quit"
> +				echo
> +				;;
> +			[qQ]*)
> +				return 0
> +				;;
> +			esac
> +		done
> +	done

Shows a bit of snippet from an orphaned blob, offer to write to
disk, to show it in full to give larger clue on its contents, etc.
I am not sure the value of [yY] that does not do the prompt thing,
possibly using the generated uniq name as the default---after all,
this is interactive.

One thing that I am mildly disappointed about this script is that it
does not give much over lost-found service fsck gives, other than
the "interactive" loop.  A dedicated "resurrect" command should do a
lot more.

Let me throw one piece of idea out, which may or may not work well.

"fsck" finds unreachable blobs, but it should be finding trees that
are also unreachable that contain them, recursively.  A command to
truly help users recover lost blobs should be taking advantage of
that fact and spending cycles to exploit it to help them.  For
example, you could (and this won't happen inside a bash script)

 - enumerate unreachable trees and blobs;
 - identify _a_ tree the sought-blob appears in;
 - identify _a_ tree that tree appears in;
 - recursively do the above until you find no more.

That gives you _a_ path to the blob in _a_ tree.  That top tree
might be the toplevel of a working tree (it may be referenced by a
commit that is unreachable, for example), or the commit and its top
level tree may already have been lost to gc and what you have might
be a tree structure representing a subtree (e.g. you thought that
you found "Makefile", but it turns out not to be the top-level
Makefile, but "t/Makefile").

But any such name is 1000x better than a random name derived from
the object name.
