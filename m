Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BCC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 09:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjDFJcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 05:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjDFJcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 05:32:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA577EE4
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 02:31:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i5so147970384eda.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680773497;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A5KYU72Jbrvhw8TW6Gufg1zYxeEPsDnZ7cSXX2TySEg=;
        b=O/eAXkJbjzUnkPe0rYDj3cGWM2AnJTvkwCmhTqKsX9O1iSMF84Cu4uOgLJFrFYopBI
         7JA7bTgi3prw8dqg+GKT4aVYrCSAUzpv8uVl7dJtTtlU8KVcshTKjjRLAnlucn+i/Xd8
         5s+nwN2MwyH6YCcfKad/NXgxhDsI39EtnEtn1Ofv1JyMxpbG5PSxv4iZ2BfZJEwZJSNE
         83SJYsTZZpAAjJQW1GcsVaKborQvzDdolO/EuUEGR0jIkjMftPMj8+md0roTRS+1ea9W
         d6aKeYTwtK9+BDQ6vn27uJL8Yw7mzovnhlOKNltQKmuFo4Mf80/EbyvydGYEqsNaAUzE
         bHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680773497;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5KYU72Jbrvhw8TW6Gufg1zYxeEPsDnZ7cSXX2TySEg=;
        b=yVkoizqDStxO+fMQELYsM4Ha78yu770kEk+pCfdPn/Jka1eKoVdjhvnzbGfUFzQ6nD
         RfqLzm0ciQlO/3PRtaduAWvR5czPahpADo4JPbpWLnwvPv8oePZFyaw95FddVgqq0cEk
         Iaj/1TmcvN09kK1wt5xAb4HPHQVNjVKbqXkKOH5vHesFtnyu17ekZCJsxIuBbhvqdKht
         ppAdK7xX6pe0HOeqxsr8dPiYDT4vJjMw8O+1vn457mUt+64SOPWiOuupMxhlGrRikUU2
         5n9BHGiUSaBkYUAquBHR5ENsXLsddXzttazgUqbGustVdCF3plZ+Zz6fsV+GUC2Kwz8N
         Vk9w==
X-Gm-Message-State: AAQBX9eV5xrLxFlycKC5MkqhfERQLm50/cR4eIJLnsK+pspMak1sntEN
        N7+SG15WkqeEX0MO/uNDUuI=
X-Google-Smtp-Source: AKy350aUpJQRh1f1Nw79/FnZDjiotlalFCYgxNmYK6m9HOphPgpzRdbxXuk4FFkz6gjMGbfDD0MO7w==
X-Received: by 2002:a17:906:f296:b0:933:6ae6:374d with SMTP id gu22-20020a170906f29600b009336ae6374dmr4926919ejb.73.1680773496916;
        Thu, 06 Apr 2023 02:31:36 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l18-20020a50c112000000b004fc01b0aa55sm509778edf.4.2023.04.06.02.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 02:31:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkLxv-005Qid-2s;
        Thu, 06 Apr 2023 11:31:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robin Jarry <robin@jarry.cc>
Cc:     git@vger.kernel.org, Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH v2] hooks: add sendemail-validate-series
Date:   Thu, 06 Apr 2023 10:56:30 +0200
References: <20230402185635.302653-1-robin@jarry.cc>
 <20230405231305.96996-1-robin@jarry.cc>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230405231305.96996-1-robin@jarry.cc>
Message-ID: <230406.868rf5tkzs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 06 2023, Robin Jarry wrote:

> When sending patch series (with a cover-letter or not)
> sendemail-validate is called with every email/patch file independently
> from the others. When one of the patches depends on a previous one, it
> may not be possible to use this hook in a meaningful way.
>
> Changing sendemail-validate to take all patches as arguments would break
> backward compatibility.
>
> Add a new hook to allow validating patch series instead of patch by
> patch. The patch files are provided in the hook script standard input,
> one per line. Patch file names that contain LF characters are *not*
> validated.
>
> Signed-off-by: Robin Jarry <robin@jarry.cc>
> ---
>
> Notes:
>     v1 -> v2:
>     
>     - Use `git hook run --to-stdin` with a temp file.
>     - Skip validation (with an explicit warning) for patch file names that
>       contain newline characters.
>     - Updated docs.

At first glance I thought this was a re-roll of the patches to include
the headers in the output, but I see that's a *different* series:
https://lore.kernel.org/git/5758ffc7-eb8c-4c16-d226-dd882cb2406b@amd.com/

But that was waiting on the --to-stdin I recently added, which you're
using here (good!).

But it seems to me that if that's integrated we'd end up with yet
another interface, or not? Is this proposing that we use this interface
instead for that use-case?

>  Documentation/git-send-email.txt |  1 +
>  Documentation/githooks.txt       | 19 +++++++++++++++++
>  git-send-email.perl              | 36 ++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 765b2df8530d..45113b928593 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -438,6 +438,7 @@ have been specified, in which case default to 'compose'.
>  +
>  --
>  		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
> +		*	Invoke the sendemail-validate-series hook if present (see linkgit:githooks[5]).
>  		*	Warn of patches that contain lines longer than
>  			998 characters unless a suitable transfer encoding
>  			('auto', 'base64', or 'quoted-printable') is used;
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 62908602e7be..0e8573c6c116 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -600,6 +600,25 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
>  non-zero status causes `git send-email` to abort before sending any
>  e-mails.
>  
> +sendemail-validate-series
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by linkgit:git-send-email[1].  It allows performing
> +validation on a complete patch series at once, instead of patch by patch with
> +`sendemail-validate`.
> +
> +`sendemail-validate-series` takes no arguments.  For each e-mail to be sent,
> +it receives on standard input a line of the format:
> +
> +  <patch-file> LF
> +
> +where '<patch-file>' is an absolute path to a file that holds an e-mail to be
> +sent.  Any '<patch-file>' that contains a 'LF' character will *not* be fed to
> +the hook and an explicit warning will be printed instead.
> +
> +If the hook exits with non-zero status, `git send-email` will abort before
> +sending any e-mails.
> +
>  fsmonitor-watchman
>  ~~~~~~~~~~~~~~~~~~
>  
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 07f2a0cbeaad..b29050e14c06 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -800,6 +800,7 @@ sub is_format_patch_arg {
>  			validate_patch($f, $target_xfer_encoding);
>  		}
>  	}
> +	validate_patch_series(@files)
>  }
>  
>  if (@files) {
> @@ -2125,6 +2126,41 @@ sub validate_patch {
>  	return;
>  }
>  
> +sub validate_patch_series {
> +	my @files = @_;
> +
> +	unless ($repo) {
> +		return;
> +	}
> +	require File::Temp;
> +	my $tmp = File::Temp->new(
> +		TEMPLATE => "sendemail-series.XXXXXXXX",
> +		UNLINK => 1,
> +	);
> +	for my $fn (@files) {
> +		unless (-p $fn) {
> +			$fn = Cwd::abs_path($fn);

The code you mostly copy/pasted does "require Cwd", but can't we just
combine this with the existing function somehow?

> +			if ($fn =~ /\n/) {
> +				$fn =~ s/\n/'\\n'/g;
> +				printf STDERR __("warning: file name contains '\\n': %s. Skipping validation.\n"), $fn;
> +			} else {
> +				$tmp->print("$fn\n");
> +			}

Re feedback from others, I think *if* we keep this we should pass this
\0-delimited, that delimiter can be safley used with POSIX filenames.

> +		}
> +	}
> +	my $hook_name = "sendemail-validate-series";
> +	my @cmd = ("git", "hook", "run", "--ignore-missing",
> +		   "--to-stdin", $tmp->filename, $hook_name, "--");
> +	my $hook_error = system_or_msg(\@cmd, undef, "@cmd");
> +	if ($hook_error) {
> +		$hook_error = sprintf(
> +		    __("fatal: series rejected by %s hook\n%s\nwarning: no patches were sent\n"),
> +		    $hook_name, $hook_error);
> +		die $hook_error;
> +	}
> +	return;
> +}
> +
>  sub handle_backup {
>  	my ($last, $lastlen, $file, $known_suffix) = @_;
>  	my ($suffix, $skip);

Honestly, I don't really get the use-case. If your 02/N depends on 01/N
couldn't your hook just maintain its own state, e.g. in some file
created in the passed $GIT_DIR?

With the upcoming parallel hooks, I'm also skeptical of a an interface
that would preclude validating these in parallel.

I also don't understand the reason for the stdin interface. The
"git-send-email" program itself takes a <file|directory>, so concerns
about the files exceeding argument list seem out the window, i.e. we
could just pass the dir/files, and as we'd have the same limitations
here we should be able to pass the full set of files, no?

I.e. why not a sendemail-validate-all that just takes a dir or file(s)?
