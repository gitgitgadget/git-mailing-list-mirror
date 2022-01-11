Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E7C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350959AbiAKTSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350838AbiAKTRV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:21 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253DC028B9C
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:16:54 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id v1so203544ioj.10
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HP5V+XvpvNZHsKLpLpyiw5ywzfSyx4EToDwhk2CyOAQ=;
        b=eJa23wd2mk3aanLrSIRpcdAnX1m7SCo8XgMT4UfMMGjTzFlGpOu3Lz7Uxmcm0c6nVg
         z26yzHe7UrLU08L7dDhxTXs8SrBw/ExUjtfgVn4/ygRGC9cWLVMiLRvSpHpv/0WHF/Zf
         F4WCEhKw60LTv9cay0uXpUTukSYlaNIOBzpV4K6fKMlHcQiwfALxaCFi5G1zp7UHP6g/
         NQvxhZBIzgJPy7iQI1QQ7Vxm+CqT1AscJcbNNfkQUuvhFUMT5RSQfHLAyrBFsjk2pISS
         mp0cPbv/F0YSo97aq6hMYsopxHqUqvcOJZ2/EeiyccELcRawxXEw7YD5AVDrXWp9pdhd
         bLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HP5V+XvpvNZHsKLpLpyiw5ywzfSyx4EToDwhk2CyOAQ=;
        b=DIluiD3U6krYM6saAu0WkCb+xQ8STk+n4/jOt79az6dt51U/oJjIg/XbMzYZmtGZ4A
         8T/ECXeEUV+EvAYUqLMugKlAR0fOOeG5IFEoC2F2IM/bWn4L+5VR5+cw/zTlkLEyn5xl
         3fLNOlLJjmH8r9NwGBvwIypMRrdIhgXN81w8U79nWKf3G3XqlY8xM+tRz2koJRyHQPSd
         Sv+2wsVG9PfbEM9eRbU4VZNLx2MTOgMyzlEUz2RWp/Kp7nchrsd/gm7caRxFXVDj+tHb
         lg9ad7C6GLq3Ww6Kjv9FlNnCKGUJ+1+sGgQtgRL/wSOja2rq13QT0rRvSv1AlenBEjEe
         /gqw==
X-Gm-Message-State: AOAM530jA+Xb1ZvaYMuJ9D8DRmpKGIvcpxCnNotNm4lX9/+/r1QuuMdr
        eixQAUnEH0+N1OAKE+V3NBh0VA==
X-Google-Smtp-Source: ABdhPJx1bogVCvCDeO/VHQQ/kOCBuv+BGNh7JuNkU62Mb16WM5zwHtNx9Uty4zVmqeMxqfMVnCA4Xw==
X-Received: by 2002:a05:6602:15cf:: with SMTP id f15mr3122245iow.129.1641928613463;
        Tue, 11 Jan 2022 11:16:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i15sm6445325iow.19.2022.01.11.11.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:16:53 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:16:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/3] reftable: remove unreachable "return" statements
Message-ID: <Yd3XpLaZ3qc25PzQ@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 05:40:22PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Remove unreachable return statements added in acb533440fc (reftable:
> implement refname validation, 2021-10-07) and f14bd719349 (reftable:
> write reftable files, 2021-10-07).
>
> This avoids the following warnings on SunCC 12.5 on
> gcc211.fsffrance.org:
>
>     "reftable/refname.c", line 135: warning: statement not reached
>     "reftable/refname.c", line 135: warning: statement not reached

Interesting. From a cursory reading, I agree with the assessment of
at least my compiler that these return statements are both unnecessary,
but...

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  reftable/refname.c | 1 -
>  reftable/writer.c  | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/reftable/refname.c b/reftable/refname.c
> index 95734969324..136001bc2c7 100644
> --- a/reftable/refname.c
> +++ b/reftable/refname.c
> @@ -132,7 +132,6 @@ static int validate_refname(const char *name)
>  			return REFTABLE_REFNAME_ERROR;
>  		name = next + 1;
>  	}
> -	return 0;
>  }

In this case the loop inside of validate_refname() should always
terminate the function within the loop body. But removing this return
statement here relies on the compiler to determine that fact.

I could well imagine on the other end of the spectrum there exists a
compiler which _doesn't_ make this inference pass, and would complain
about the opposite thing as you're reporting from SunCC (i.e., that this
function which returns something other than void does not have a return
statement outside of the loop).

So in that sense, I disagree with the guidance of SunCC's warning. In
other words: by quelching this warning under one compiler, are we
introducing a new warning under a different/less advanced compiler?

>  int validate_ref_record_addition(struct reftable_table tab,
> diff --git a/reftable/writer.c b/reftable/writer.c
> index 35c8649c9b7..70a7bf142a2 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -39,7 +39,6 @@ writer_reftable_block_stats(struct reftable_writer *w, uint8_t typ)
>  		return &w->stats.log_stats;
>  	}
>  	abort();
> -	return NULL;
>  }

Here I'm less skeptical, since it's almost certain that any compiler
would recognize this call to abort() as terminating the whole program.
So it should be able to infer that anything after it is unreachable.

But even though I'm less skeptical, I'm not sure that I would make the
same bet (though in practice this one is probably fine since there are
likely plenty of functions which end in the more standard `die()` and do
not have a return path).

Can reftable call die()? Or is this the least-common denominator among
Git and libgit2 for terminating a running program?

Thanks,
Taylor
