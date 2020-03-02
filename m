Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FBC3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE1420848
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WAn/Mrog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCBS51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:57:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54230 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBS50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 13:57:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F36FB4B7AE;
        Mon,  2 Mar 2020 13:57:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t227ZaSeCtwAGwcfc3iX8bd+FuU=; b=WAn/Mr
        ogMHRMCpPslxjTsBkh/PQOMbNDq4d6BFcoT8r9oY7H/zEWuHpYdXOIuKylYg4OAm
        f88yDAsOYHTXv8EVLQksXrEK8ZiRlci/hYKQvsEml4qAGtv+IL4uNbVVN24F/fXQ
        JWGKJXz8NUUU1WaDtGnrn7WuG8VSMLRdrdWB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lawaty6P4WlCtM9KUVRrn1CIz6Iafvhs
        RPwLrm85miRLKQbmCMXo3al4einYIzDVghaKggXZMkxT8Do6FuZZig8Dq5UYRu+C
        kWs1oyQ/6MW0QtCztBUzlU1IlPQy7wmYaYE3AGwuczJuvZCbpk/+mty/TF1SHLTW
        gAmDztR2Nus=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9A3A4B7AD;
        Mon,  2 Mar 2020 13:57:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50E184B7AC;
        Mon,  2 Mar 2020 13:57:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH 1/2] doc: update the documentation of pack-objects and repack
References: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
        <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
Date:   Mon, 02 Mar 2020 10:57:16 -0800
In-Reply-To: <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
        (Damien Robert's message of "Fri, 28 Feb 2020 16:43:56 +0100")
Message-ID: <xmqqk142bn5f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A31B2972-5CB7-11EA-826A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index fecdf2600c..7f4923ddea 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -80,6 +80,14 @@ base-name::
>  	as if all refs under `refs/` are specified to be
>  	included.
>  
> +--reflog::
> +	This implies `--revs`.
> +	Include objects referred by reflog entries.
> +
> +--indexed-objects::
> +	This implies `--revs`.
> +	Include objects referred to by the index
> +

Missing full-stop (.) at the end.

> +--write-bitmap-index::
> +	Write a reachability bitmap index as part of the pack. This
> +	only makes sense when used with `--all` and the pack is not
> +	outputted to stdout.

Using "output" as a verb and conjugating it like this makes my head
hurt.  Let's instead borrow the phrase used in the description for
the "--stdout" option, i.e.

	... and the pack is not written to the standard output.

>  --keep-unreachable::
> -	Objects unreachable from the refs in packs named with
> -	--unpacked= option are added to the resulting pack, in
> -	addition to the reachable objects that are not in packs marked
> -	with *.keep files. This implies `--revs`.
> +	Unreachable packed objects are added to the resulting pack.
> +	This implies `--revs`.

Well spotted, and this update is very much appreciated.
`--unpacked` does not take a name of a packfile at all, at least
since 03a9683d ("Simplify is_kept_pack()", 2009-02-28).

> @@ -88,13 +88,14 @@ to the new separate pack will be written.
>  
>  --window=<n>::
>  --depth=<n>::
> -	These two options affect how the objects contained in the pack are
> -	stored using delta compression. The objects are first internally
> -	sorted by type, size and optionally names and compared against the
> -	other objects within `--window` to see if using delta compression saves
> -	space. `--depth` limits the maximum delta depth; making it too deep
> -	affects the performance on the unpacker side, because delta data needs
> -	to be applied that many times to get to the necessary object.
> +	These two options are passed to `git pack-objects` and affect how
> +	the objects contained in the pack are stored using delta
> +	compression. The objects are first internally sorted by type, size
> +	and optionally names and compared against the other objects within
> +	`--window` to see if using delta compression saves space. `--depth`
> +	limits the maximum delta depth; making it too deep affects the
> +	performance on the unpacker side, because delta data needs to be
> +	applied that many times to get to the necessary object.

It took me a while to realize that this only inserts "are passed to
`git pack-objects` and" and does nothing else.  It would have saved
reviewers' time if the whole paragraph did not get rewrapped.

I wonder if it helps the readers to tell the implementation detail
(i.e. are passed to X) upfront like the updated text.  It is true
that it would help the interested readers who want to know _more_
to tell them that these corresponds to the options the underlying
command has so they can go to the documentation of that other
command and read more about them, though.  

>  The default value for --window is 10 and --depth is 50. The maximum
>  depth is 4095.
> @@ -103,13 +104,13 @@ depth is 4095.
>  	This option is passed through to `git pack-objects`.
>  
>  --window-memory=<n>::
> -	This option provides an additional limit on top of `--window`;
> -	the window size will dynamically scale down so as to not take
> -	up more than '<n>' bytes in memory.  This is useful in
> -	repositories with a mix of large and small objects to not run
> -	out of memory with a large window, but still be able to take
> -	advantage of the large window for the smaller objects.  The
> -	size can be suffixed with "k", "m", or "g".
> +	This option is passed to `git pack-objects` and provides an
> +	additional limit on top of `--window`; the window size will
> +	dynamically scale down so as to not take up more than '<n>' bytes
> +	in memory.  This is useful in repositories with a mix of large and
> +	small objects to not run out of memory with a large window, but
> +	still be able to take advantage of the large window for the smaller
> +	objects.  The size can be suffixed with "k", "m", or "g".

Likewise.

>  	`--window-memory=0` makes memory usage unlimited.  The default
>  	is taken from the `pack.windowMemory` configuration variable.
>  	Note that the actual memory usage will be the limit multiplied
> @@ -122,6 +123,7 @@ depth is 4095.
>  	prevents the creation of a bitmap index.
>  	The default is unlimited, unless the config variable
>  	`pack.packSizeLimit` is set.
> +	This option is passed to `git pack-objects`.

Here, you use a different way to add the information to help readers
who would want to learn _more_.  And I think this approach makes
more sense than the previous two.  All readers would appreciate if
they can learn what they need to know to drive _this_ subcommand on
the documentation page for _this_ subcommand without having to
consulte another page, but those interested _can_ use reference like
this.

> @@ -129,7 +131,8 @@ depth is 4095.
>  	only makes sense when used with `-a` or `-A`, as the bitmaps
>  	must be able to refer to all reachable objects. This option
>  	overrides the setting of `repack.writeBitmaps`.  This option
> -	has no effect if multiple packfiles are created.
> +	has no effect if multiple packfiles are created, and is passed to
> +	`git pack-objects`.

Ditto.

> +Default options
> +---------------
> +
> +The command passes the following options to `git pack-objects`:
> +`--keep-true-parents`, `--no-empty`, `--all`, `--reflog`, `--indexed-objects`.
> +It also add `--exclude-promisor-objects` if there exists a promisor remote,
> +and `--honor-pack-keep` except if `--pack-kept-objects` is passed.

This is somewhat unconventional.  I think we usually say, when
describing each option --<option>, if it is enabled by default.

I kind of like this sort of summary where options that are on by
default can be seen in a single place, but (1) if we can reach a
concensus that this is a good practice, we should do it in more
places, and (2) if the sections for these individual options do not
say that they are on by default, we should make them say so.

Thanks.

