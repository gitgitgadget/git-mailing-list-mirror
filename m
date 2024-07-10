Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D9D535
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647069; cv=none; b=WazLX0ZrzqVEmlwJp/wx/djHqO0I6iU+ZrS3R/GeyREAWMxLVX/0EPcO3lGSIGf2frViYV7WM/GMiL0x0Qc56sTCA2QXbR0i1iEnYM9MLBqndHQkwsWEHDk3HRUcIq+UYWiPHQwpoxgu4eNgRIuzDAyB4vs8pyfgCNCvMzmnQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647069; c=relaxed/simple;
	bh=ZJtEUgqVpmwYogWhYKNOl35WlXJjiXpzhxIba7sIfdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KQxirzF+3vOyKIHO8HM45WaMwVUaojhoMDGamDIKd2tuyC19oWT67frqidXo8nf7wYUbofN9PERi681x4f40gYWyjcqL6dleHt3QT3jjVq5oZK6uGuS4w6RB00izw88e9QgEpJ7YBOkYYXlzTqGjmm31INknQ3qYZ0jtxtgPP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uQUrucyF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQUrucyF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D08736950;
	Wed, 10 Jul 2024 17:31:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZJtEUgqVpmwYogWhYKNOl35WlXJjiXpzhxIba7
	sIfdE=; b=uQUrucyFd7MRVgzE/jLcvonRxH3vVWX0+kZvP1wZTRmHkTpAGiuSr8
	Ksh2+FsMPkkpYHnPB9s/gDAWfNQm9HFjTRh8aJh5gmUmCPH9uPLpqTvmHN4EgJPa
	G9VmeJpzIBO2kaxWRzTLCvu1Ajxf4rWWYWrozMm4AdiZnehCK++nQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 59AED3694F;
	Wed, 10 Jul 2024 17:31:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BBC63694B;
	Wed, 10 Jul 2024 17:31:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v10 06/10] builtin/refs: add verify subcommand and
 verbose_refs for "fsck_options"
In-Reply-To: <Zo6fFS7xzFwWKrEW@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 10 Jul 2024 22:47:49 +0800")
References: <Zo6eJi8BePrQxTQV@ArchLinux> <Zo6fFS7xzFwWKrEW@ArchLinux>
Date: Wed, 10 Jul 2024 14:31:03 -0700
Message-ID: <xmqq7cdtue7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B61E0B60-3F03-11EF-98C2-965B910A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> Subject: Re: [GSoC][PATCH v10 06/10] builtin/refs: add verify subcommand and verbose_refs for "fsck_options"

Just saying

	git refs: add verify subcommand

would be clearer.  If you really want to talk about two modes, you
could say

	git refs: add "verify [--strict|--verbose]" subcommand

but that may be too much.

> Introduce a new subcommand "verify" in git-refs(1) to allow the user to
> check the reference database consistency and also this subcommand will
> be used as the entry point of checking refs for "git-fsck(1)". Last, add
> "verbose_refs" field into "fsck_options" to indicate whether we should
> print verbose messages when checking refs consistency.

Is there a reason why this has to be verbose_refs and not a simple
verbose bit?  When people see how it is useful to ask for the
verbose output while checking refs, wouldn't people wish to add the
same "--verbose" support while checking objects, and at that point,
wouldn't it be awkward to add verbose_objs member to the struct and
having to flip both bits on?

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/git-refs.txt | 13 +++++++++++
>  builtin/refs.c             | 44 ++++++++++++++++++++++++++++++++++++++
>  fsck.h                     |  1 +
>  3 files changed, 58 insertions(+)
>
> diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
> index 5b99e04385..1244a85b64 100644
> --- a/Documentation/git-refs.txt
> +++ b/Documentation/git-refs.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git refs migrate' --ref-format=<format> [--dry-run]
> +'git refs verify' [--strict] [--verbose]
>  
>  DESCRIPTION
>  -----------
> @@ -22,6 +23,9 @@ COMMANDS
>  migrate::
>  	Migrate ref store between different formats.
>  
> +verify::
> +	Verify reference database consistency.
> +

The error reporting function for refs consistency check was still
about reporting a problem for a single ref.  I am wondering how
consistency violations that are not about a single ref should be
handled.  For example, if refs/packed-backend.c:packed_fsck() finds
that the file is not sorted properly or has some unparseable garbage
in it, it is not something you can report as "refs/heads/main is
broken", but those who are interested in seeing the "reference
database consistency" verified, it is very much what they want the
tool to notice.  How would detection of such a breakage that is not
attributed to a single ref fit in this "ref consistency check
infrastructure" that was introduced by [05/10]?

> +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
> +	if (argc)
> +		usage(_("too many arguments"));

I do not think we want to change this line in this topic, but
because I noticed that the issue is widespread, let me make a note
here that we may want to clean up all the commands that give this
message as a #leftoverbit item:

    $ git cmd foo baz
    usage: too many arguments

is very unfriendly in that it is not immediately obvious to users
which arguments are excess.  Should they have given "git cmd<RET>"?
Is it "git cmd foo" that does not take any argument?

If you said something like

    $ git refs verify baz
    error: 'git refs verify' takes no arguments

or even

    $ git refs verify baz
    error: unknown argument 'baz' given to 'git refs verify'

it would be much more helpful.


Thanks.
