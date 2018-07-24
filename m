Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4476C1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGXR0n (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:26:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45302 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbeGXR0n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:26:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id t13-v6so4719189wrv.12
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eVepxz103zdLjvd9ib1X/WWE8mrGx5/gk03HFGZfDWU=;
        b=B0t++zYplRYk72neZjkJBBQn/PPiZbGYfgnUe9tFQxH2c5giaOeaEIWy+6gmeG58HQ
         X8tEh9yGzefJLXk4eFtjbB/NzDVPxzNvNg9+a2BRtqlL/iwz2poJ2ExJtwaWBF9iFONV
         JEcp9bag3Sri+KFdqstpC633grhx2b4voN5QCJeNwwfET2z4HMVUVUBMZuv+fjBmZaDr
         A90mWGv7wTZ6bmV7nf/+ICDzc3700xSSYd4kUT3+HcQ09NsL4bQgFeTjWtSeg4G+Vosv
         MhK9OMQ4rH4ZHNcJUgn0b4SK5LQjKzKi0muxaCx/wkFq8ga/+nuKh/kqOoOATB0xRmZd
         njLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eVepxz103zdLjvd9ib1X/WWE8mrGx5/gk03HFGZfDWU=;
        b=eD+0KqqvCSq2Ba7zszGHHDKzpAxwgkEA89Q5dDXT6KGlV4xRVEWJJ3bQyOfXJYwro2
         PkfoK43jpoizXV0dLEgP+bxrutlandQb4jlwEKxQfp/LVsWNHRi66m4CNRzX6yBt4+f3
         QZpGalYDkrlBebwEkp8/rl4VV8UFPVYkOHSh57LBNoLVgi+j7PJlqFHmaaQCsx4UShTW
         Zzc7bs1TnDLJKwpbHoCcoOOJJqdFwu/PcNrwCA19Q3XG1XPTepxYoIIkuZqAXFS5BYSs
         rTCMYYhaCrNJ1noorQAoEzskPmtUczmFhRKn11QAsuv1dSII1dMSMsvQgV3cYnEEeUMw
         a+fg==
X-Gm-Message-State: AOUpUlE8kJ+uQ3VUScHNzS4bFEsWqsqlLQzCyf+mtebVQTn/N/CJH/99
        zbHId3H5gOqKOlWloUG4S84=
X-Google-Smtp-Source: AAOMgpftotpMfLFpO9dutZ3eoXCFtBIg7ie1wtyMBtwN5fBdKRo9oCMpk7nOFEqBxZ2Thl/oqmNDWw==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr12278921wrc.93.1532449168894;
        Tue, 24 Jul 2018 09:19:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w9-v6sm19146414wrk.28.2018.07.24.09.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:19:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 1/5] packfile: make get_delta_base() non static
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
        <20180722054836.28935-2-chriscool@tuxfamily.org>
Date:   Tue, 24 Jul 2018 09:19:27 -0700
In-Reply-To: <20180722054836.28935-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 22 Jul 2018 07:48:32 +0200")
Message-ID: <xmqqy3e0zjw0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> As get_delta_base() will be used outside 'packfile.c' in
> a following commit, let's make it non static and let's
> declare it in 'packfile.h'.

As a public function in *.h, don't we want a bit of comment there to
help those who want to use it from outside packfile.c?


> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  packfile.c | 10 +++++-----
>  packfile.h |  3 +++
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 7cd45aa4b2..4646bff5ff 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1037,11 +1037,11 @@ const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
>  	return NULL;
>  }
>  
> -static off_t get_delta_base(struct packed_git *p,
> -				    struct pack_window **w_curs,
> -				    off_t *curpos,
> -				    enum object_type type,
> -				    off_t delta_obj_offset)
> +off_t get_delta_base(struct packed_git *p,
> +		     struct pack_window **w_curs,
> +		     off_t *curpos,
> +		     enum object_type type,
> +		     off_t delta_obj_offset)
>  {
>  	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
>  	off_t base_offset;
> diff --git a/packfile.h b/packfile.h
> index cc7eaffe1b..30f0811382 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -125,6 +125,9 @@ extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum
>  extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
>  extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
>  extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
> +extern off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
> +			    off_t *curpos, enum object_type type,
> +			    off_t delta_obj_offset);
>  
>  extern void release_pack_memory(size_t);
