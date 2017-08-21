Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0436B1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 06:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbdHUGfC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 02:35:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55556 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751048AbdHUGfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 02:35:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3977CA6E9D;
        Mon, 21 Aug 2017 02:34:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4KvZba22sM9jCtKTNu/ezjWRVWs=; b=iRVH6Y
        0sSl0ihYuqqxWeJZSuA5iwv403QeKxiERtJPiB2qF66Ec4/o//Ot84NxXUSwW2Ww
        LWCb8i5pd7/jVWA7Ck00lDZgv+aVHSb1Z9Ws6JQ+vzJP5H4V2zVo88Mk+SFNgPRH
        SXNXe9/tOKR06tCc1iLgc0ngz/1sJJzhbF9Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ih6BSQrGb9gKe/vIVLT6FqqyI/gA9Sg/
        wyHe/zQfCvbZbn0CFtymDgmUlXLZMlcOcSpPteewsaVWlahRDfbBlHdyqmJueodI
        br/9zNQbI8x/Xe0UitjYTKaC6BsWUYaRzjOCUFPqu1V0UZE8FanIGjdRhsH9vyJ/
        +XNZm6yzaAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31180A6E9C;
        Mon, 21 Aug 2017 02:34:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 935B4A6E9A;
        Mon, 21 Aug 2017 02:34:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 16/19] Convert various things to size_t
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
        <1502914591-26215-17-git-send-email-martin@mail.zuhause>
Date:   Sun, 20 Aug 2017 23:34:50 -0700
In-Reply-To: <1502914591-26215-17-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Wed, 16 Aug 2017 22:16:28 +0200")
Message-ID: <xmqqziat5sz9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6174122-863A-11E7-B539-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
>  bisect.c                | 2 +-
>  blame.c                 | 2 +-
>  builtin/fmt-merge-msg.c | 2 +-
>  builtin/mktag.c         | 2 +-
>  dir.c                   | 4 ++--
>  dir.h                   | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 2549eaf..0580c82 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -131,7 +131,7 @@ static void show_list(const char *debug, int counted, int nr,
>  		struct commit *commit = p->item;
>  		unsigned flags = commit->object.flags;
>  		enum object_type type;
> -		unsigned long size;
> +		size_t size;
>  		char *buf = read_sha1_file(commit->object.sha1, &type, &size);

Hmph.  At this point in the series, read_sha1_file() has already
been modified to take size_t, but before this patch this caller used
to pass a pointer to ulong, so between these two places in the
series the code wouldn't have compiled.  

But the end result is obviously consistent.

> diff --git a/blame.c b/blame.c
> index 739a280..f628b42 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1621,7 +1621,7 @@ static const char *get_next_line(const char *start, const char *end)
>  static int prepare_lines(struct blame_scoreboard *sb)
>  {
>  	const char *buf = sb->final_buf;
> -	unsigned long len = sb->final_buf_size;
> +	size_t len = sb->final_buf_size;
>  	const char *end = buf + len;
>  	const char *p;
>  	int *lineno;

The final_buf_size member has already been made to size_t, and this
code used to receive it in ulong, which is OK for size_t <= ulong
platforms (which is about everybody).  OK.

> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index 61ab796..3faf100 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -464,7 +464,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  static void fmt_tag_signature(struct strbuf *tagbuf,
>  			      struct strbuf *sig,
>  			      const char *buf,
> -			      unsigned long len)
> +			      size_t len)
>  {
>  	const char *tag_body = strstr(buf, "\n\n");
>  	if (tag_body) {

The callers have been passing size_t but due to the above, size_t
the callers had were coerced into ulong before this function used
it.  Again, as long as size_t <= ulong, that was fine, and this
makes things even more consistent.  Good.

> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 0663106..ff919a7 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -34,7 +34,7 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
>  	return ret;
>  }
>  
> -static int verify_tag(char *buffer, unsigned long size)
> +static int verify_tag(char *buffer, size_t size)
>  {
>  	int typelen;
>  	char type[20];

The only caller of this function was passing .len member of a
strbuf, which has been size_t forever, so this is exactly the same
situation as fmt_tag_signature() above.  Good.

> diff --git a/dir.c b/dir.c
> index f161c26..0c7c767 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -180,7 +180,7 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
>   */
>  char *common_prefix(const struct pathspec *pathspec)
>  {
> -	unsigned long len = common_prefix_len(pathspec);
> +	size_t len = common_prefix_len(pathspec);
>  
>  	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
>  }

xmemdupz() takes size_t, so this could have been truncating "len"
that is ulong before this change, but common_prefix_len() returns
size_t anyway, so there wasn't any information loss.  This change
just makes the code to use the correct type that is sufficiently
wide.  Good.

> @@ -2673,7 +2673,7 @@ static void load_sha1_stat(struct sha1_stat *sha1_stat,
>  	sha1_stat->valid = 1;
>  }
>  
> -struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
> +struct untracked_cache *read_untracked_extension(const void *data, size_t sz)
>  {
>  	struct untracked_cache *uc;
>  	struct read_data rd;

Ditto.  The sole caller had size_t, that used to be promoted to
ulong in the old code but with thie patch, things become consistent.

Overall it looks good to me.

The "bisect.c" one feels a bit odd, though; I'd expect it to be done
when read_sha1_file() is made to take a pointer to size_t to avoid
intermediate breakage.

Thanks.
