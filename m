Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7495EC28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350793AbiHSSfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350776AbiHSSfM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:35:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EBED6312
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:35:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y13so10302682ejp.13
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=uWTQD95cD8BySGikPMtAW4JpCJ7sPcNzkSH+kmNsAzQ=;
        b=qfB+3O7yXQstYf5pGA6fmz+auc1anQf9fJuSgCiDO7s7yrRUN04mIQLbP2QmRodEGv
         mjEmWcmTva1nsH+EVttYEE2UyePgWB84UQ2i/D8liObzNF481yjrX3Q/DwO4cxt7nQ5i
         8KPiHk9ScydJxed/8DxAODGkh1lXeprrdLRDiSVpzJ0/ATl6DPkj7IgUfylwWI1d331/
         INkvUCosOUMYTmT/XavheXTvmBOexL7+qG4ccDe25dmRi3ByAGzBvkFaNihQxlK4Pi2T
         P+IxM2Qgp0ewcPfnpF3xXDCnFSVeJtPhTihdJi8zdQephpkGbZ/m85TOHI9IygWrW9SB
         5DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=uWTQD95cD8BySGikPMtAW4JpCJ7sPcNzkSH+kmNsAzQ=;
        b=HKfKeJHEOvGsBbGq1hxicYk5CsRIZLK6A8/vhp2DohKaOlxc8Vcj8I3gJKNWtrx4R5
         UHnX1Drlm53xcuD3jtocfuI1zaU4b1Raa6nKaCY56Y5IioEQrAKrL0o+BhD8Xcb1Af2o
         33iaEsCDStl/3BRD74UcHPkJth+Nlt5MoOXbcYZpUnKQicCV8+dy90srRHEPbUuLyTOl
         /JFSZ0M1O4IhoafbyMgGac7/1U7m3yXuse0Im653/xICI7JOvVM1ZEMRvAWjP9TQq4yn
         b+BbWDvpcUBftGIyUiu01is9T/pyhjKbClAgHQfcNR0UXV7lQUjST9ktURWQZOAhxvgu
         NNdQ==
X-Gm-Message-State: ACgBeo0oTWoC2C5IuwBzl+5OUJ9jomaj9UmwT0OVCS+fIrOmC+1ElFO5
        Qj8z35zOW+Cd1sWpYIWPAb0=
X-Google-Smtp-Source: AA6agR5qYpDRT9M7aHJqH/Ve+CdnOVEJ1L7lADftHWJrgVqDGnGug2V17dO//Vy48wvq7aKxWGhiUw==
X-Received: by 2002:a17:906:93ef:b0:73c:cf83:5553 with SMTP id yl15-20020a17090693ef00b0073ccf835553mr3175447ejb.441.1660934110532;
        Fri, 19 Aug 2022 11:35:10 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709063d3100b00711edab7622sm2622159ejf.40.2022.08.19.11.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:35:10 -0700 (PDT)
Date:   Fri, 19 Aug 2022 20:35:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/20] parse-options: drop leading space from
 '--git-completion-helper' output
Message-ID: <20220819183508.GB3373722@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-9-szeder.dev@gmail.com>
 <220819.86fshs6sy6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220819.86fshs6sy6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 07:30:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Aug 19 2022, SZEDER Gábor wrote:
> 
> > subcommands) a tad more complex, so I wanted to test the result.  The
> > test would have to account for the presence of that leading space,
> > which bugged my OCD, so let's get rid of it.
> 
> On the subject of OCD it...
> 
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  parse-options.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/parse-options.c b/parse-options.c
> > index a0a2cf98fa..8748f88e6f 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -620,7 +620,8 @@ static int show_gitcomp(const struct option *opts, int show_all)
> >  			suffix = "=";
> >  		if (starts_with(opts->long_name, "no-"))
> >  			nr_noopts++;
> > -		printf(" --%s%s", opts->long_name, suffix);
> > +		printf("%s--%s%s", opts == original_opts ? "" : " ",
> > +		       opts->long_name, suffix);
> >  	}
> >  	show_negated_gitcomp(original_opts, show_all, -1);
> >  	show_negated_gitcomp(original_opts, show_all, nr_noopts);
> 
> ...bugs me a bit that we have a "suffix" variable, but not a "prefix"
> for this

That space acts as a separator, so calling it prefix would be
misleading.

