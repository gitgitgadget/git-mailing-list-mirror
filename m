Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16421F453
	for <e@80x24.org>; Mon, 24 Sep 2018 16:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbeIXWSG (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 18:18:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33761 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbeIXWSF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 18:18:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so9084614wro.0
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tOQu0UShXJn2oE9RIoKm4dKpdNgopYbvInIcSxliM90=;
        b=LhVVCg2QC9S4dHHj7v1WfWWGzAmOpiRd953uZaqnCUAj2gQy6P3NyKzYJuH4FUNsU4
         p/TvmCTC5oadg7Ljkg8JiuVwWTPC8dKawWhUmbwkU6ECFLxPBtJpTKFHeY/hIULf8kiM
         jK2MTwADDfRRrjPHsTs817pr9Xd5GvGb48ajpxNb5u0u/xIdoNPpYfB/TQpchH1z24dE
         Tt425ZBGD2NRjojgrglfRhyGyAga8K5z2ybST5lS/swyiPGFraI9oF3gRypsZoMk+wW2
         Sju7Z8tC6Y93zXLDkRx49kDYMngomA2aBc2hSeSCtu1l6vBPnXqEb25EZooVLFrDL0Gl
         hB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tOQu0UShXJn2oE9RIoKm4dKpdNgopYbvInIcSxliM90=;
        b=M7BvYuAfDwn957flwllMKnDnKqeSuxfeQ11nrcXUphVNkBy3I5jNMhifodIpHPMe+J
         ktAfev+WImQ2zpeXqhh+QBnKxrCH2WZK1c3QNSuESGubQEsXrYdW6Hi67yFpoODOEzX7
         5T23OFqk0FTmdSlifV6Sr4JsCs7NXMgWR7RCpKJ0KHTXlBIzYoo4Ge7Y14xRpLuXY/9k
         UkRBaRtTTM5cT/JpqtMu3LmxM+QqQ+CPxnR5mnY0mif/bB3eTVBlInpQkifQhZUspMYi
         O+I2oAHnrFFC//llUEFWPRjGdiJUH5JM0YrgOG0zjncjV7u/Q7RfT8eJEvKaLwD2XL8H
         79fw==
X-Gm-Message-State: ABuFfoh4FIYt9w7wnSuSu4UaOLIXRH73cxQRNO6DmqXI8aC0v7J2Y3Xj
        QFHjINhkWSfbYMS4t8nicq9QzNPE
X-Google-Smtp-Source: ACcGV62fw9prjT65lGIJJ+HuURQ9IXJpDGgS/RE3/WJniNMRDez285x52t9FFT84mBI8zQhWoq7cVg==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr10181103wrq.225.1537805709501;
        Mon, 24 Sep 2018 09:15:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x65-v6sm19398450wmg.39.2018.09.24.09.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 09:15:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a repository
References: <20180922124215.0c8172d1@pc09.procura.nl>
        <20180922141145.10558-1-szeder.dev@gmail.com>
Date:   Mon, 24 Sep 2018 09:15:08 -0700
In-Reply-To: <20180922141145.10558-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sat, 22 Sep 2018 16:11:45 +0200")
Message-ID: <xmqqzhw6swhf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The command 'git ls-remote --sort=authordate <remote>' segfaults when
> run outside of a repository, ever since the introduction of its
> '--sort' option in 1fb20dfd8e (ls-remote: create '--sort' option,
> 2018-04-09).
>
> While in general the 'git ls-remote' command can be run outside of a
> repository just fine, its '--sort=<key>' option with certain keys does
> require access to the referenced objects.  This sorting is implemented
> using the generic ref-filter sorting facility, which already handles
> missing objects gracefully with the appropriate 'missing object
> deadbeef for HEAD' message.  However, being generic means that it
> checks replace refs while trying to retrieve an object, and while
> doing so it accesses the 'git_replace_ref_base' variable, which has
> not been initialized and is still a NULL pointer when outside of a
> repository, thus causing the segfault.
>
> Make ref-filter more careful and only attempt to retrieve an object
> when we are in a repository.  Also add a test to ensure that 'git
> ls-remote --sort' fails gracefully when executed outside of a
> repository.

OK.  So by forcing get_object() return an error, we do the same to
populate_value() which in turn will make get_ref_atgom_value return
an error and cmp_ref_sorting() will notice and die.

I think that is the best we could do.

>
> Reported-by: H.Merijn Brand <h.m.brand@xs4all.nl>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>
> I'm not quite sure that this is the best place to add this check...
> but hey, it's a Saturday afternoon after all ;)
>
>  ref-filter.c         | 3 ++-
>  t/t5512-ls-remote.sh | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index e1bcb4ca8a..3555bc29e7 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1473,7 +1473,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
>  		oi->info.sizep = &oi->size;
>  		oi->info.typep = &oi->type;
>  	}
> -	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
> +	if (!have_git_dir() ||
> +	    oid_object_info_extended(the_repository, &oi->oid, &oi->info,
>  				     OBJECT_INFO_LOOKUP_REPLACE))
>  		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
>  				       oid_to_hex(&oi->oid), ref->refname);
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index bc5703ff9b..7dd081da01 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -302,4 +302,10 @@ test_expect_success 'ls-remote works outside repository' '
>  	nongit git ls-remote dst.git
>  '
>  
> +test_expect_success 'ls-remote --sort fails gracefully outside repository' '
> +	# Use a sort key that requires access to the referenced objects.
> +	nongit test_must_fail git ls-remote --sort=authordate "$TRASH_DIRECTORY" 2>err &&
> +	test_i18ngrep "^fatal: missing object" err
> +'
> +
>  test_done
