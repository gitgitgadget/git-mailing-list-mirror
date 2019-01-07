Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC311F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfAGTcb (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:32:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33949 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfAGTca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:32:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so6827911wmd.1
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KlHzLcP9DiLBvVT7E/Ip69/XqhJcHn3POMt+0ZXZ/14=;
        b=C8cWsI10d26CGiOa1kjXwf8w1cDt5x8eSgIKKzujgQgsW2LVxi261FBxVp8GQAbWXR
         c7znPVPByRQTZ7prBY24ANpNZ1e+xvnFTBhyA2qJzbu8XDQCSRZfmFBVJoC9W+8S11eA
         wmx18tO9qhWXrlKl9/zy5nG7gz0qTDmDWAC12DZe6YuVTX/IN1qEbt616DPnNUGzfGQe
         V6nxfjwb/Rq4ROJjpjj7mhsYSKagN86pEI0iUF9gsiic/PgU9agrbFF8lWDp6GgQD+gj
         Xlt2bFfMuGPBFQeX4x6r+Dg/4EnQxh8iv+2nqOa77AH1oT1E6+605ZFBNp0oZYmj9iQo
         SUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KlHzLcP9DiLBvVT7E/Ip69/XqhJcHn3POMt+0ZXZ/14=;
        b=GgGPajA9GDpxrx/D3VmqghHfMB2w/Gd8YHE9Hs1rDVLU+DJE43IZBwDfYn0PcCueQx
         DkXctG0xMSlwus9QNh3fHgpCBYchAKx6fz3z9Qla8jKMVMDu9IPy4jSzQxN6d6w3lmSZ
         yRR/9DrajlAHL/JPYWUyvoZJRDYwlRoiSsauykYkwg6VtHLpSVTd+Uwmm6Yg5Se3d3lr
         591wOjEXKOekNfixdofanXeFp4T1u9ASWOG/5fchrPjC2U2gNbx1gu19tb+R1ZpexSqw
         FrMEt3oceSEno7bd7DV3gI+8r5/dnexdwo61EgyPB+SzkYAwHkFfnBvMpqsMQq8LX9z8
         TE9Q==
X-Gm-Message-State: AJcUukeopR8PhaRzab/L0QgNGhmEQqwXLryZB+xqXNzwidHsmCWlm9Im
        EJvbCZtfYDN47sqiPGGIgk4=
X-Google-Smtp-Source: ALg8bN5yJco5XKgkdWiDX/PivO0cyRqDzUPywWtiWQSduA+OqikYZYYE77apm4B9Ev16yQs2cacnRw==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr9393902wme.1.1546889547992;
        Mon, 07 Jan 2019 11:32:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p139sm16535172wmd.31.2019.01.07.11.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:32:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 4/3] object-store: retire odb_load_loose_cache()
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
        <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
        <a836870b-c803-5ff4-0019-58012773efb7@web.de>
Date:   Mon, 07 Jan 2019 11:32:26 -0800
In-Reply-To: <a836870b-c803-5ff4-0019-58012773efb7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 7 Jan 2019 18:29:16 +0100")
Message-ID: <xmqqd0p88drp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Inline odb_load_loose_cache() into its only remaining caller,
> odb_loose_cache().  The latter offers a nicer interface for loading the
> cache, as it doesn't require callers to deal with fanout directory
> numbers directly.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

OK, that's much better ;-)  Thanks.

>  object-store.h | 7 -------
>  sha1-file.c    | 9 ++-------
>  2 files changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/object-store.h b/object-store.h
> index 2fb6c0e4db..e16aa38cae 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -47,13 +47,6 @@ void add_to_alternates_file(const char *dir);
>   */
>  void add_to_alternates_memory(const char *dir);
>  
> -/*
> - * Populate an odb's loose object cache for one particular subdirectory (i.e.,
> - * the one that corresponds to the first byte of objects you're interested in,
> - * from 0 to 255 inclusive).
> - */
> -void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
> -
>  /*
>   * Populate and return the loose object cache array corresponding to the
>   * given object ID.
> diff --git a/sha1-file.c b/sha1-file.c
> index c3c6e50704..efcb2cbe74 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -2154,12 +2154,6 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
>  				  const struct object_id *oid)
>  {
>  	int subdir_nr = oid->hash[0];
> -	odb_load_loose_cache(odb, subdir_nr);
> -	return &odb->loose_objects_cache[subdir_nr];
> -}
> -
> -void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
> -{
>  	struct strbuf buf = STRBUF_INIT;
>  
>  	if (subdir_nr < 0 ||
> @@ -2167,7 +2161,7 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
>  		BUG("subdir_nr out of range");
>  
>  	if (odb->loose_objects_subdir_seen[subdir_nr])
> -		return;
> +		return &odb->loose_objects_cache[subdir_nr];
>  
>  	strbuf_addstr(&buf, odb->path);
>  	for_each_file_in_obj_subdir(subdir_nr, &buf,
> @@ -2176,6 +2170,7 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
>  				    &odb->loose_objects_cache[subdir_nr]);
>  	odb->loose_objects_subdir_seen[subdir_nr] = 1;
>  	strbuf_release(&buf);
> +	return &odb->loose_objects_cache[subdir_nr];
>  }
>  
>  void odb_clear_loose_cache(struct object_directory *odb)
