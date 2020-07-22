Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9559C433E1
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 23:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9449720825
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 23:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TEJrcpz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgGVXuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:50:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52427 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGVXuG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 19:50:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A0AA77EB6;
        Wed, 22 Jul 2020 19:50:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oBZQ0x3RMiapPicd4oPKyg61MHQ=; b=TEJrcp
        z41ynvIFdWQIHEagf95n/SuPRbHVJSQT5pmCSI0raGmXv6ofM90fYAMl3LY+yaJr
        tlifHTOq/mAh0YmeNGOzzQrD7a9Sptr2Ko658dCi0Bo/l94uh5V7H7GSMAuZfo/8
        rGfE3krbw//X8a6PR2OG/UVawtfLtYeHnkXSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JGxMftVSt8rGyyh333g1I5jK0Wggj2h4
        bK2ERQHX7zH8eIOyAEqO7PCEZ+oItPZVyi1Evgy2D+4C6fhnO5qtnSCr6CD6C3fh
        1C912jvrl48yNN4UXLM89oSF7BCNZU5Y2n438LQXz4B3ySGTuHVVL1xFRIgklgwa
        hyQ5R6dOhlc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 331D677EB3;
        Wed, 22 Jul 2020 19:50:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B83DA77EB2;
        Wed, 22 Jul 2020 19:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org, bup-list@googlegroups.com,
        Jamie Wyrick <terrifiedquack80@gmail.com>
Subject: Re: [PATCH v3] pack-write/docs: update regarding pack naming
References: <20200722214031.116161-1-johannes@sipsolutions.net>
Date:   Wed, 22 Jul 2020 16:49:59 -0700
In-Reply-To: <20200722214031.116161-1-johannes@sipsolutions.net> (Johannes
        Berg's message of "Wed, 22 Jul 2020 23:40:31 +0200")
Message-ID: <xmqqk0yv3yag.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E626DAC-CC76-11EA-92FF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> The index-pack documentation explicitly states that the pack
> name is derived from the sorted list of object names, but
> since commit 1190a1acf800 ("pack-objects: name pack files
> after trailer hash") that isn't true anymore.
>
> Be less explicit in the docs as to what the exact output is,
> and just say that it's whatever goes into the pack name.
>
> Also update a comment on write_idx_file() since it no longer
> modifies the sha1 variable (it's const now anyway), as noted
> by Junio.
>
> Fixes: 1190a1acf800 ("pack-objects: name pack files after trailer hash")
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> It was reported that bup writes pack files that have a name
> different from what git does, and I think it's quite possibly
> because of this documentation ... it doesn't actually really
> *matter* though, as long as the file is internally consistent
> nothing checks that the name also matches the footer.

Thanks.

>
> You can also take this as a bug report and fix the language in
> some other, perhaps more precise way, if you prefer :-)
>
> v2: correct bup list address, oops
> v3: don't re-indent, update the comment as well
> ---
>  Documentation/git-index-pack.txt | 4 ++--
>  pack-write.c                     | 5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
> index 9316d9a80b0d..ac74d058e01d 100644
> --- a/Documentation/git-index-pack.txt
> +++ b/Documentation/git-index-pack.txt
> @@ -104,8 +104,8 @@ This option cannot be used with --stdin.
>  NOTES
>  -----
>  
> -Once the index has been created, the list of object names is sorted
> -and the SHA-1 hash of that list is printed to stdout. If --stdin was
> +Once the index has been created, the hash that goes into the name of
> +the pack/idx file is printed to stdout. If --stdin was
>  also used then this is prefixed by either "pack\t", or "keep\t" if a
>  new .keep file was successfully created. This is useful to remove a
>  .keep file used as a lock to prevent the race with 'git repack'
> diff --git a/pack-write.c b/pack-write.c
> index f0017beb9dd4..685d327d800a 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -38,9 +38,8 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
>  }
>  
>  /*
> - * On entry *sha1 contains the pack content SHA1 hash, on exit it is
> - * the SHA1 hash of sorted object names. The objects array passed in
> - * will be sorted by SHA1 on exit.
> + * The *sha1 contains the pack content SHA1 hash.
> + * The objects array passed in will be sorted by SHA1 on exit.
>   */
>  const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
>  			   int nr_objects, const struct pack_idx_option *opts,
