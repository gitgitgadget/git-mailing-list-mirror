Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF848C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 14:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiF0Ofg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiF0Of3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 10:35:29 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1736EB4B0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 07:35:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u9so13022710oiv.12
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QMr7p3sE5uBTWTprse1Su3A76UGryGT9HnF/JKjtQ8U=;
        b=U7DF2ppYU+xDxCNY9Y8MOpnq9OssmLdT7qeE1ivKZWbg8rWesG0AnCO+oHp1hb/Hc2
         zSpv6Hx3VRcdSYKTVXFWs72rhtbK4bHj9JYwwBf72MDI6cqsSrtQEjgwa0lzuSbm1AR0
         nB95U35Oj3+B+ASL+xBOpzCE/qml4QpIVZWiV65GrKTY+M8Tg6NMEh9VBXiRwn25bav9
         7YmY2lwdsphTDAKx4y04ftBA9n2GtN2fX4srmivqa9eFRXIdgmi95WXvKEzrW5uhk69u
         3wCDfxBJySYqkPzfNOqeNbk9UNHWJRuf54vzzmpCdUCJbcQILpn4cD+4mE6vWnTq+KXm
         Yh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QMr7p3sE5uBTWTprse1Su3A76UGryGT9HnF/JKjtQ8U=;
        b=fG/uUe5oSMbGcwfD3M3EuGtTZ5T+c18liYcTjI6V7SbfjtKIcTwN2XQ/jZwgUXGnx7
         sTRvpVJRiC6bB5lwCxfjxohc3e+i3kfYnOC5OFSuKZfBGoTG+2SnzzSSTRrIPpKdLgSz
         QAmeuiT5KF7NLJOA4RXeBgZrZE34GY1+kLXa2nTnK2W6yhi1kJyeCk8nUmwvwLtQpqd9
         jptDBR7RB/HR6Kd01IBz27Dy5hX89kp3rNSur9Gj267s5YwMvTxCx2f1na8yQAxESgqh
         girT4pNDiOqTVQD0SOZNn3BpfvqHgKcmJZDHwlRnaKu86LMgSypo4QCoPzgi0358hK7Z
         2ChA==
X-Gm-Message-State: AJIora/OSvAYHNxkygN/anZ6a11S9cBmjOB1lb2AtXRpudwAGQzC6DHf
        AaLwRgDI0WD+5MtJUbzKc3a9
X-Google-Smtp-Source: AGRyM1sOZ+cALsqCoQSVPFNjVoOpi5JlQ5Jv259kQC/vVhLYTs9IAB+nxjGu013c6akKLGZvgAjsFQ==
X-Received: by 2002:a05:6808:1784:b0:335:67d8:a2f8 with SMTP id bg4-20020a056808178400b0033567d8a2f8mr4057894oib.279.1656340527312;
        Mon, 27 Jun 2022 07:35:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:714a:b337:6fac:e704? ([2600:1700:e72:80a0:714a:b337:6fac:e704])
        by smtp.gmail.com with ESMTPSA id s64-20020acaa943000000b0032f51af1999sm5362449oie.42.2022.06.27.07.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:35:27 -0700 (PDT)
Message-ID: <560d1802-8565-04eb-9faf-0f821861d321@github.com>
Date:   Mon, 27 Jun 2022 10:35:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/6] pack-bitmap-write.c: write lookup table extension
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <d118f1d45e6202925d4efd5435acdd08545bf132.1656249017.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <d118f1d45e6202925d4efd5435acdd08545bf132.1656249017.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2022 9:10 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> The bitmap lookup table extension was documentated by an earlier

s/documentated/documented/

> change, but Git does not yet knowhow to write that extension.

s/knowhow/know how/

> +static int table_cmp(const void *_va, const void *_vb, void *commit_positions)
> +{
> +	int8_t result = 0;
> +	uint32_t *positions = (uint32_t *) commit_positions;

nit: drop the space between the cast and commit_positions.

> +	uint32_t a = positions[*(uint32_t *)_va];
> +	uint32_t b = positions[*(uint32_t *)_vb];
> +
> +	if (a > b)
> +		result = 1;
> +	else if (a < b)
> +		result = -1;
> +	else
> +		result = 0;
> +
> +	return result;
> +}

Ok, here you are sorting by commit OID (indirectly by the order in the
[multi-]pack-index). I suppose that I misunderstood in the previous
patch, so that could use some more specific language, maybe.

> +static void write_lookup_table(struct hashfile *f,
> +			       uint64_t *offsets,
> +			       uint32_t *commit_positions)
> +{
> +	uint32_t i;
> +	uint32_t *table, *table_inv;
> +
> +	ALLOC_ARRAY(table, writer.selected_nr);
> +	ALLOC_ARRAY(table_inv, writer.selected_nr);
> +
> +	for (i = 0; i < writer.selected_nr; i++)
> +		table[i] = i;
> +
> +	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);

At the end of this sort, table[j] = i means that the ith bitmap corresponds
to the jth bitmapped commit in lex order of OIDs.

> +	for (i = 0; i < writer.selected_nr; i++)
> +		table_inv[table[i]] = i;

And table_inv helps us discover that relationship (ith bitmap to jth commit
by j = table_inv[i]).

> +	for (i = 0; i < writer.selected_nr; i++) {
> +		struct bitmapped_commit *selected = &writer.selected[table[i]];
> +		uint32_t xor_offset = selected->xor_offset;

Here, xor_offset is "number of bitmaps in relationship to the current bitmap"

> +		hashwrite_be32(f, commit_positions[table[i]]);
> +		hashwrite_be64(f, offsets[table[i]]);
> +		hashwrite_be32(f, xor_offset ?
> +				table_inv[table[i] - xor_offset]: 0xffffffff);

Which means that if "k = table[i] - xor_offset" that the xor base is the kth
bitmap. table_inv[k] gets us the position in this table of that bitmap's
commit.

(It's also strange to me that the offset is being _subtracted_, but I guess
the bitmap format requires the xor base to appear first so the offset does
not need to be a negative number ever.)

This last line is a bit complex.

	uint32_t xor_offset = selected->xor_offset;
	uint32_t xor_row = 0xffffffff;

	if (xor_offset) {
		uint32_t xor_order = table[i] - xor_offset;
		xor_row = table_inf[xor_order];
	}

...then we can "hashwrite_be32(f, xor_row);" when necessary. I'm not sure
that we need the "uint32_t xor_order" inside the "if (xor_offset)" block,
but splitting it helps add clarity to the multi-step computation.

>  enum pack_bitmap_opts {
> -	BITMAP_OPT_FULL_DAG = 1,
> -	BITMAP_OPT_HASH_CACHE = 4,
> +	BITMAP_OPT_FULL_DAG = 0x1,
> +	BITMAP_OPT_HASH_CACHE = 0x4,
> +	BITMAP_OPT_LOOKUP_TABLE = 0x10,
>  };

Excellent.

Thanks,
-Stolee
