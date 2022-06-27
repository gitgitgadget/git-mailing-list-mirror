Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72496C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiF0QO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbiF0QMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 12:12:41 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B4186E3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 09:12:37 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b125so7151432qkg.11
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=INy2zWSRjUVpbWVcMIMc5tQ+/QiSW6OZoqbtsdG+Odc=;
        b=gZAxHnHK+OI7NnRgmPKd49U3vzruwKcRsKc2B/FxpW+OGt/Xz1IbVhgvYISfVuwIkg
         KoOdwq+9W3nXZ7PUaWB+1PczASE3MFgCNnfqYgwLX/kncv5gOzTZomOzLCEgucVCxhId
         Y6ImuV7LNxbdTmC0UIIKDsrzIB4QYC+bbf1DzdNBFgZ3cDbkNyM3Ti7ue2JkzgYZLwTJ
         q8iyt4RAzjolKNElbPSzG4aJtLqaPgwMCe5tcLPuPJx3NqqNxmujkW+G+40EfFc0mfM4
         rx8fDQJGm6XaSKv4BPvI8wdpN8sruP+w4fqX/tWmFXBDqt/KtKdgLKi3X3QWXjw/ctlG
         Z9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INy2zWSRjUVpbWVcMIMc5tQ+/QiSW6OZoqbtsdG+Odc=;
        b=JivXkTpM+2fNJY3/PVF8+H1uRCaZwzJx9+z4LZr0PhiCb+rtHE7MBsFUjrGYqrgEHh
         iIpjNx5J3R9m2AB6sWBJKZL+fywK87qV3he8b1D/Wk9CPH6jwxyZ/O8uZG3uBgobYZ+W
         vTg7luAeyh2YYhi6JdPyYe/sMShc+jdpIyEgnU1uQEFMo41Tlf4DoZN31HjagZCujCMy
         CWY8In0dNczDTW3WY8v7jIJiLTZiHOvFu7dxpfsDjqOhGtpKaRQoT/WaVuYM2bMxtDCS
         OrBO8/tq1mgfEyy0SlYYX7bCWGQEJ/oEy61CYWOo+A7uTdYMisuSw6cAnnUiuVVp9NXn
         Uz0A==
X-Gm-Message-State: AJIora9NKW/tCihEh9W0uQHmMS/R5wWzU6Z0MJTf8EU7V33ZIAdJCoNG
        xIdh7jwF2W3bhBShYpyUDORLUw==
X-Google-Smtp-Source: AGRyM1ttZaCnSc1riHv6IBx3XTphr9EQmqS7uqXe/mZcCulbman1CllZsrJeFHYj8Z0ho9bbG+W7ig==
X-Received: by 2002:ae9:ed0d:0:b0:6ae:f1e4:9c90 with SMTP id c13-20020ae9ed0d000000b006aef1e49c90mr8614200qkg.290.1656346356291;
        Mon, 27 Jun 2022 09:12:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a400f00b006af147d4876sm5827147qko.30.2022.06.27.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:12:35 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:12:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 2/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <YrnW81NV7yY68Z2v@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <d118f1d45e6202925d4efd5435acdd08545bf132.1656249017.git.gitgitgadget@gmail.com>
 <560d1802-8565-04eb-9faf-0f821861d321@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <560d1802-8565-04eb-9faf-0f821861d321@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2022 at 10:35:25AM -0400, Derrick Stolee wrote:
> On 6/26/2022 9:10 AM, Abhradeep Chakraborty via GitGitGadget wrote:
>
> > +	uint32_t a = positions[*(uint32_t *)_va];
> > +	uint32_t b = positions[*(uint32_t *)_vb];
> > +
> > +	if (a > b)
> > +		result = 1;
> > +	else if (a < b)
> > +		result = -1;
> > +	else
> > +		result = 0;
> > +
> > +	return result;
> > +}
>
> Ok, here you are sorting by commit OID (indirectly by the order in the
> [multi-]pack-index). I suppose that I misunderstood in the previous
> patch, so that could use some more specific language, maybe.

Yeah, I agree that some more specific language could be used, with the
main idea being there that we make it clearer that the list of tuples is
still sorted (and can be binary searched).

> > +	for (i = 0; i < writer.selected_nr; i++)
> > +		table[i] = i;
> > +
> > +	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
>
> At the end of this sort, table[j] = i means that the ith bitmap corresponds
> to the jth bitmapped commit in lex order of OIDs.
>
> > +	for (i = 0; i < writer.selected_nr; i++)
> > +		table_inv[table[i]] = i;
>
> And table_inv helps us discover that relationship (ith bitmap to jth commit
> by j = table_inv[i]).

These are both great descriptions and should give an idea of what sort
of information is worth putting into a comment.
>
> > +	for (i = 0; i < writer.selected_nr; i++) {
> > +		struct bitmapped_commit *selected = &writer.selected[table[i]];
> > +		uint32_t xor_offset = selected->xor_offset;
>
> Here, xor_offset is "number of bitmaps in relationship to the current bitmap"

It's an offset to an earlier commit which must be used to XOR-decompress the
current one (if any).

> > +		hashwrite_be32(f, commit_positions[table[i]]);
> > +		hashwrite_be64(f, offsets[table[i]]);
> > +		hashwrite_be32(f, xor_offset ?
> > +				table_inv[table[i] - xor_offset]: 0xffffffff);
>
> Which means that if "k = table[i] - xor_offset" that the xor base is the kth
> bitmap. table_inv[k] gets us the position in this table of that bitmap's
> commit.

Yes, exactly. Abhradeep: this is also worth commenting ;-).

> (It's also strange to me that the offset is being _subtracted_, but I guess
> the bitmap format requires the xor base to appear first so the offset does
> not need to be a negative number ever.)

You're right, this follows from the fact that the XOR bases must come
before the commits who must use them to decompress themselves. From
Documentation/technical/bitmap-format.txt:

    This number is always positive, and hence entries are always xor'ed
    with **previous** bitmaps, not bitmaps that will come afterwards in
    the index.

> This last line is a bit complex.
>
> 	uint32_t xor_offset = selected->xor_offset;
> 	uint32_t xor_row = 0xffffffff;
>
> 	if (xor_offset) {
> 		uint32_t xor_order = table[i] - xor_offset;
> 		xor_row = table_inf[xor_order];
> 	}
>
> ...then we can "hashwrite_be32(f, xor_row);" when necessary. I'm not sure
> that we need the "uint32_t xor_order" inside the "if (xor_offset)" block,
> but splitting it helps add clarity to the multi-step computation.

I had the same thought, though I would also say that xor_row should be
declared, not initialized, and the "else" block of "if (xor_offset)"
should set it to 0xffffffff to make the relationship between xor_offset
and the value written a little clearer.

Thanks,
Taylor
