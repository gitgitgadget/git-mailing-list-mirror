Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8171F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbdARVXU (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:23:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56775 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751076AbdARVXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:23:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1A1362DAB;
        Wed, 18 Jan 2017 16:22:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8JZXae22G+/X4GkV+splbuIGrxc=; b=GtSZE5
        zsn/E1cMi/G5XcrffPO800CqgEAKJIj2NMB+BYLW86X7kyOafVsxXv4CvPv6qCam
        ji6QkTxIjjhor5uCoUoMJRNAxLeP6FN0m5FXTkPT0cj9XKLeLK+mVTyVXnC8QXtt
        MJ9X8z8iTaHi6TUCAczptoNluOCDKf/xqCrrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mqSPGVaMJT+1+u4Dv2jDph7x11+2q4k9
        eniINA5f4y/SGShS4DjVZk/f/HyoC4lxECx86FPH0Vuk0aGxpUattjbPWD+yjDlG
        9n0onLJQoqlMY1JTcpMfpwESLHW1entsU090CA13EWBt4X/IHB2l/uftJnxa++3+
        iD9eyKa7cGQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D917D62DAA;
        Wed, 18 Jan 2017 16:22:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D8F062DA9;
        Wed, 18 Jan 2017 16:22:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] document add_[file_]to_index
References: <20170117233503.27137-1-sbeller@google.com>
        <20170117233503.27137-4-sbeller@google.com>
Date:   Wed, 18 Jan 2017 13:22:42 -0800
In-Reply-To: <20170117233503.27137-4-sbeller@google.com> (Stefan Beller's
        message of "Tue, 17 Jan 2017 15:35:02 -0800")
Message-ID: <xmqqbmv43vx9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 403771AA-DDC4-11E6-9D3C-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  cache.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 26632065a5..acc639d6e0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -605,13 +605,20 @@ extern int remove_index_entry_at(struct index_state *, int pos);
>  
>  extern void remove_marked_cache_entries(struct index_state *istate);
>  extern int remove_file_from_index(struct index_state *, const char *path);
> -#define ADD_CACHE_VERBOSE 1
> -#define ADD_CACHE_PRETEND 2
> -#define ADD_CACHE_IGNORE_ERRORS	4
> -#define ADD_CACHE_IGNORE_REMOVAL 8
> -#define ADD_CACHE_INTENT 16
> +
> +#define ADD_CACHE_VERBOSE 1		/* verbose */
> +#define ADD_CACHE_PRETEND 2 		/* dry run */
> +#define ADD_CACHE_IGNORE_ERRORS 4	/* ignore errors */
> +#define ADD_CACHE_IGNORE_REMOVAL 8	/* do not remove files from index */
> +#define ADD_CACHE_INTENT 16		/* intend to add later; stage empty file */

These repeat pretty much the same thing, which is an indication that
the macro names are chosen well not to require extraneous comments
like these, no?

> +/*
> + * Adds the given path the index, respecting the repsitory configuration, e.g.
> + * in case insensitive file systems, the path is normalized.
> + */
>  extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);

s/repsitory/repository/;

> +/* stat the file then call add_to_index */
>  extern int add_file_to_index(struct index_state *, const char *path, int flags);
> +

As you do not say "use the provided stat info to mark the cache
entry up-to-date" in the add_to_index(), I am not sure if mentioning
"stat the file then" has much value.  Besides, you are supposed to
lstat(2) the file, not "stat", no?

I'd cover these two under the same heading and comment if I were
doing this.

	These two are used to add the contents of the file at path
	to the index, marking the working tree up-to-date by storing
	the cached stat info in the resulting cache entry.  A caller
	that has already run lstat(2) on the path can call
	add_to_index(), and all others can call add_file_to_index();
	the latter will do necessary lstat(2) internally before
	calling the former.

or something along that line.

>  extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
>  extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
>  extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
