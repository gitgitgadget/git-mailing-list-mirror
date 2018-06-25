Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38A481F516
	for <e@80x24.org>; Mon, 25 Jun 2018 19:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934946AbeFYTUB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 15:20:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37041 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933030AbeFYTUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 15:20:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so11183947wmg.2
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+sKFCUoPfsYAwxjlN8a35pyBrQJGHvbfb0vj05eqT/8=;
        b=gny0qs3DZNR1Ap0ZZ73BZ5snh4TP2zAZez4EBjpbcSoicLbEOmumba1tCur0lOaKXE
         ncwCFFUsBQkBZOpK2O85bru+Ob7LNRmSu22F4ji6pv0tXD1yHZcTuc0NRq2mxeYAEu5M
         VYxTH17YXWn6K4ASVja/mhj3o6F45Jz5ve9wAQDqhdbwv4tvwF+zmR0PRn7zG0IHIXPk
         rk2AhlrYRVzQyxYkaWWkqJILIm8LKVnGRcu7QAtnY+uPnBmqTigoZbu1dp0M3WDr2bFN
         GEzQcO68mNCzM4tp7PWNyBDGj0k868ZCZy4a6lpMApOI9wK2qofUVmWdeG7S1pLE4N98
         LEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+sKFCUoPfsYAwxjlN8a35pyBrQJGHvbfb0vj05eqT/8=;
        b=SZYQZVKWka4IUUA+f+2hlbgi6Tp9RouyRvydKMAOO5YeCwjHX3/qTAUoYdfS7S2G69
         3PxTcLORUFZUtqxOLMJPBAv3dbbTAHRkZqzusb0E9eZrUx4Sa+cTXwtGe3yP/l/39l58
         NxQ73noOA9HFBCpnUvixg0HaqEd7MbxVbRzY8qYy4rv9wZhlem+vL3W9l9Ag/Wq3aIPa
         d7DzZ+YInS4cNG8af4eeVuM+LSbGowsKgrYq/NCzBzVWUjzq238IxU4iOAvMqceEAqIs
         0CNSWQtVboUaPkv6HoTtf6xtZtx2pmBCMGdWgJpIwI4/AIc8OuLpUynX3YfsecRR4iy/
         gerg==
X-Gm-Message-State: APt69E2+NU496BVu2Ml4G8ZG3ps8nKeDJP1Hu58B+Gqb1UYx3W/JNE1L
        t+ms4qCzEjcERO26wNG9QrA=
X-Google-Smtp-Source: AAOMgpeMpuzJ8OUUhtXGYJ3yyDLFOO3OWlOduBW70V/3r6aN4Hdpgp7r0YZn4/14XFEj9uDu9Xx1lg==
X-Received: by 2002:a1c:5d0e:: with SMTP id r14-v6mr1866536wmb.152.1529954398904;
        Mon, 25 Jun 2018 12:19:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g4-v6sm13061079wrq.32.2018.06.25.12.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:19:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 05/24] midx: write header information to lockfile
References: <20180607140338.32440-1-dstolee@microsoft.com>
        <20180625143434.89044-1-dstolee@microsoft.com>
        <20180625143434.89044-6-dstolee@microsoft.com>
Date:   Mon, 25 Jun 2018 12:19:57 -0700
In-Reply-To: <20180625143434.89044-6-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 25 Jun 2018 10:34:15 -0400")
Message-ID: <xmqqmuvioeqq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
> +#define MIDX_VERSION 1
> +#define MIDX_HASH_VERSION 1
> +#define MIDX_HEADER_SIZE 12
> +
> +static char *get_midx_filename(const char *object_dir)
> +{
> +	return xstrfmt("%s/pack/multi-pack-index", object_dir);
> +}
> +
> +static size_t write_midx_header(struct hashfile *f,
> +				unsigned char num_chunks,
> +				uint32_t num_packs)
> +{
> +	unsigned char byte_values[4];
> +	hashwrite_be32(f, MIDX_SIGNATURE);

WARNING: Missing a blank line after declarations
#48: FILE: midx.c:21:
+       unsigned char byte_values[4];
+       hashwrite_be32(f, MIDX_SIGNATURE);

> +	byte_values[0] = MIDX_VERSION;
> +	byte_values[1] = MIDX_HASH_VERSION;
> +	byte_values[2] = num_chunks;
> +	byte_values[3] = 0; /* unused */
> +	hashwrite(f, byte_values, sizeof(byte_values));
> +	hashwrite_be32(f, num_packs);
> +
> +	return MIDX_HEADER_SIZE;
> +}
> +
>  int write_midx_file(const char *object_dir)
>  {
> +	unsigned char num_chunks = 0;
> +	char *midx_name;
> +	struct hashfile *f;
> +	struct lock_file lk;
> +
> +	midx_name = get_midx_filename(object_dir);
> +	if (safe_create_leading_directories(midx_name)) {
> +		UNLEAK(midx_name);
> +		die_errno(_("unable to create leading directories of %s"),
> +			  midx_name);
> +	}
> +
> +	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
> +	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
> +	FREE_AND_NULL(midx_name);

I am not sure why people prefer FREE_AND_NULL over free() for things
like this.  It is on stack; it's not like this is a static variable
visible after this function returns or anything like that.

> +	write_midx_header(f, num_chunks, 0);
> +
> +	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
> +	commit_lock_file(&lk);
> +
>  	return 0;
>  }
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index ec3ddbe79c..8622a7cdce 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -4,7 +4,8 @@ test_description='multi-pack-indexes'
>  . ./test-lib.sh
>  
>  test_expect_success 'write midx with no packs' '
> -	git multi-pack-index --object-dir=. write
> +	git multi-pack-index --object-dir=. write &&
> +	test_path_is_file pack/multi-pack-index
>  '
>  
>  test_done
