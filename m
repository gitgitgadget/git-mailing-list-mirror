Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484C41F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeJKI2i (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 04:28:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33162 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKI2i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 04:28:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so7711674wrs.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qkwIfBurbqbnBiRz4c3oNdG0IeVV6S2dYHdYsK1jgy0=;
        b=aZCMzHOvDo1i/WYPySV2Zfwhulo2j9+6X3Gi31FipJo+4uZ9f6BtyzxVOeVNcAyIPi
         aQ35m9074ABbHCIT/j1JfXuA4IVSRNOAnTXMmzT45Ak6e3LdNHJXy+JC5pUcm8vacrSp
         FWfTA35kj7QNv2GrVhdguDUbfnSxVP4OgIwh0498CPwCPIf7+QO+fZma/PMUUEIE1VTH
         p2dFE6gKeU460wW25h7YgFrqRtttD+QeGC44D3sp9lAiPCTlkjZDMbLKPOoJ57iSVte/
         w/mxFlzKd9sQL/YXh+Li6DBE5z0FqcoZX8VlWMc12FHBkv5qQVcfCGGQkst8MjbP/qj+
         mGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qkwIfBurbqbnBiRz4c3oNdG0IeVV6S2dYHdYsK1jgy0=;
        b=QafoHCOdjE3cO8J088AslMj4gPjk+EWN6rEsIQWUxBnpSQKFrTJ/P6B1FzG4bqy9Uf
         /cfdNoJJdnTaZFPubh76JcQjdvyDHjvpMZiDNCczt8cLBkqtGw+dtAmZGTenrnVPMmDQ
         1i98NWNWQpgaqWVXyUNhE4ynft4Uz2zelRY2tepIed/2cbraBkocU07i04a+ricyTxTL
         KAz2Ab5zEZ+ZQ7MRx8nC8yQKKjNhNfQu5B43smILhwdGqPgsgsyL9cAZcUKox2N0s2UK
         Bz3g4YmGN5ls6yAkFcibb0A+sVGQT/0QlaUR03860CFP/TQTw3+HO2ZcSBY7fQsnXgTt
         0emQ==
X-Gm-Message-State: ABuFfohESehlKmjEkzJym3L/+DeAGCdAuJC3RsVO+6u67uYYtWp4TF7D
        yOtsFGI/XLtyR8XrBUyOXBg=
X-Google-Smtp-Source: ACcGV60cyczowTvjthzW1ahvYMJ6e5VcVB9jDzrw8a4wu5uQXSmLQkwlusd1mrpaBU+od1T7eSrhNQ==
X-Received: by 2002:a5d:4706:: with SMTP id y6-v6mr24398252wrq.256.1539219829105;
        Wed, 10 Oct 2018 18:03:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r131-v6sm16100965wmb.32.2018.10.10.18.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 18:03:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] ref-filter: free memory from used_atom
References: <CAL21BmkdUiNgr4NqpwTdi9f47i85s8oXCZMmVx5VyNKotL78uA@mail.gmail.com>
        <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
Date:   Thu, 11 Oct 2018 10:03:46 +0900
In-Reply-To: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Tue, 9 Oct 2018 08:18:21 +0000")
Message-ID: <xmqq5zy9jnv1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Release memory from used_atom variable.

That much readers would know from a quick look of the patch text.

Without knowing what you are aiming at, it is impossible to judge if
the patch is a good change.

Seeing FREE_AND_NULL(array->items) in the same function makes me
think that the designer of ref_array_clear() function would want
this sequence of events to work correctly in an ideal future:

 * Do a ref-filter operation by calling filter_refs(), receiving the
   result into an array..

 * Do another ref-filter by calling filter_refs(), using different
   criteria, receiving the result into a different array.

 * Iterate over the resulting refs in the first array, and call
   format_ref_array_item().

 * ref_array_clear() the first array, as the caller is done with it.

 * Iterate over the resulting refs in the second array, and call
   format_ref_array_item().

 * ref_array_clear() the second array, as the caller is done with
   it.

However, I think it would make it impossible for the second call to
work correctly if this code freed used_atom without clearing, and
not re-initializing the used_atom_cnt etc.

If on the other hand, the only thing you are interested in is to
just discard pieces of memory we no longer use, and you are not
interested in helping to move us closer to the world in which we can
call filter_refs() twice, then the change this patch makes is
sufficient.

And the place to answer the "what are you aiming at?" question is in
the proposed commit log message.

In an ideal future, I _think_ the file-scope static variables in
ref-filter.c like used_atom and used_atom_cnt should become fields
of a new structure (say "struct ref_filter"), with initializer and
uninitializer ref_filter_new() and ref_filter_destroy().  When that
happens, I think FREE_AND_NULL(used_atom) + used_atom_cnt=0 should
become part of ref_filter_destroy(), not part of ref_array_clear().

But we are not there yet, and a clean-up patch like this does not
have to be a step towards that goal.

> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
>  ref-filter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index e1bcb4ca8a197..1b71d08a43a84 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1996,6 +1996,9 @@ void ref_array_clear(struct ref_array *array)
>  {
>  	int i;
>  
> +	for (i = 0; i < used_atom_cnt; i++)
> +		free((char *)used_atom[i].name);
> +	free(used_atom);
>  	for (i = 0; i < array->nr; i++)
>  		free_array_item(array->items[i]);
>  	FREE_AND_NULL(array->items);
>
> --
> https://github.com/git/git/pull/538
