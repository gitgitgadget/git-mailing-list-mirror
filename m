Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E13EC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34520611F0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhIKQu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhIKQu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:50:26 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F458C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:49:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n24so6429045ion.10
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ahBwhjHdeApiKVbRei042tpJKaDL6dRwTGINBCUbQqE=;
        b=xHdS6l3TugdKObetsXkYhK1meOrlEc2cSNM7YyzmlUGI4HOLU1h3Ndr6pXKgGf15UB
         FYxfQuQXyiItq5HoTtn++xHi0uT20jmGzsqm1W5mwDreV5azpw/qlY2c9wyb37IBoAs7
         LD+QI1fEen11OBjDE2lJGIpm83609oEZ6GJRg0WPgpXmL1fR1kV4TIghgHgcCUkR9v+W
         BUgvyKKGlnUMa4i0Aj1MJclzJ+zyga5hurRkQ1pGfkfGR80ioIUBdM4sJi4LMQ6FF8O0
         nJ9VjCH9JI74CieC22fFKqQfbIDEDBD0A9nazy9d8Y2p4p6mRwL3Py//6miEfE0ERmxv
         E6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ahBwhjHdeApiKVbRei042tpJKaDL6dRwTGINBCUbQqE=;
        b=GaP4PCL7bXzhKdlQSrrXuv/AWJXeWRNIT6wgfttv2f99mx5UGjBl6xbODZsvHnUa1e
         Dw6LBlMwBwx9bqJKgltUPhEcR1xq1AcZEysGXtsOPg8EQisDkjZw/D4cTNJgJLoojAEF
         i5fGCpw5YUkR05EAaLZYMC9Q92COuZ5O1TXT+lE0sIVTUTOOv/zvnt+4xuvZqNw+YqAP
         BJGPKA+3NU2PdL2tg8uKWeaSGSrIOmJ2AMzW721UGNtDBAWTLoYjQypK5shSqy9XUAUj
         U+LN6rIbzLHu7N5pLJLpv4Y2/3ur6OMDzaFjLKkYTuqqVHvrQSTPnJYCPO9OHng1rHxk
         ebng==
X-Gm-Message-State: AOAM530caBP7mIlCZ409wWgZpj3e1iN+WrMjzTsoHDTuYFFAd5tf3sDh
        fC+gMvmoifU5R8yU2QYVF91Uxz64+sEGWjyW
X-Google-Smtp-Source: ABdhPJycWJ2otlC5zAfz7aarFZ6UK2I/C7YdaYU0G64YdILt9VBBPhl75Go/L/KfnhWjVDjvhpq1GQ==
X-Received: by 2002:a5d:9693:: with SMTP id m19mr2608827ion.72.1631378953544;
        Sat, 11 Sep 2021 09:49:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j5sm1138902ilu.11.2021.09.11.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 09:49:13 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:49:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Message-ID: <YTzeCD4AKcgTnkm2@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
 <871r5v9z3i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r5v9z3i.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:27:39PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Sep 10 2021, Taylor Blau wrote:
>
> > +struct midx_snapshot_ref_data {
> > +	struct tempfile *f;
>
> Style/readability: Spare more than one byte for a variable name in a
> struct, maybe file, or tmpfile?

Sure.

> > +	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
> > +		oid_to_hex(oid));
>
> Just an idea: Maybe the file could be lines of "+\tOID\n" instead of
> "+OID\n"? Lends itself more naturally to extension, use with the likes
> of string_list_split() etc.
>
> > +		for_each_string_list_item(item, preferred) {
> > +			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
> > +		}
>
> Cheap style commenst I know, but throughout this series there's an odd
> mixture of sometimes adding braces for one-lines, sometimes not, or in
> the case of that "else ;" I commented on not for something *much* bigger
> :)

I've always been uncomfortable with brace-less for loops when the loop
is hidden behind a macro. I haven't bothered to check, but my gut
feeling is that it is pretty rare to see a for_each_something() macro
with a one-line body that doesn't have braces.

But my gut is wrong, because

    git grep 'for_each_.*($' **/*.c | wc -l

turns up 99 results! So I'm happy to be more consistent with the other
code (despite my general discomfort with it). An observation is that
even this file isn't consistent about braceless macro'd for loops, even
before this series.

So even cleaning it up will still leave this file in an inconsistent
state, but I don't think it's worth spending much time at all thinking
about cleaning it up.

>
> > +		if (midx_snapshot_refs(refs_snapshot) < 0)
> > +			die(_("could not take a snapshot of references"));
>
> Seems like this die() should be moved into the midx_snapshot_refs()
> function and that function should use die_errno(), not die(), also it
> uses close_tempfile_gently(), shouldn't save the errno on failure there,
> clean up the tempfile, and then die?

Yeah, makes sense.

Thanks,
Taylor
