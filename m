Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219E4C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89462074D
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH6tdkoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFMS7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMS7A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 14:59:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51033C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 11:59:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so5074960pll.10
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=EWTlpejQs5KkwDuiDgkScJIFjkz+wdAmollSbpMGQxg=;
        b=sH6tdkoFf7CdoaV/Qwo5qmigCxxZ/dL40SkM6Db3Edg7hcp00y+bBWFBJN3g6pvusA
         ia4/KilmLofNx0NCo3//LH9EA/L6EfIwBUbzxPPkA3W7VyKg4WqD88aVUMDP4Cw/8X7K
         9pmrGet2oV1J42M+VC7IK4FN3hTrWB4lNe/mOxr4z0NsWgrCiQxg4yqBGY3YAMrHEJZd
         yRhG1wdO81+WHQMlbGpfg09jlBBD64pr18VwlxwmJKXlXJjyMjo4oChFznVCclY7JVKG
         pPFgsfmkb1i5WmQlV9+OYAzQ3YtgnxLYZhraUHbFNULfkp/40G3pPp03+s8v5QqBSJII
         BpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=EWTlpejQs5KkwDuiDgkScJIFjkz+wdAmollSbpMGQxg=;
        b=Cg9gPJT73zYbZJhVcH1XmOTaxULV2WlmyDYsMjAmvDbRMwpsG637S+Wjnst+jdQiQv
         Dgqh+YPSxjyttphYrl+p9ISsqtip7XODvDjupUWszbaa0Paqdv+oZVoATFC1FbMX/V/Z
         tyL777EO6Ao/wv3QH/wMW8JWZIXI3PlRNEK+A82z0NH/+rYXWyE3URx95uyq9ApH0SDC
         ugg0YGqI4zXRHU/c4lRHzKoH/mPvhwTSTJTeIEtkWU7xDLv9JfnGfRpW8dWSHfrL2cf2
         YuwQ5N3bEvcvPqF4eOi+YAeY6qGNtxBMG7SS4vCDjCDJ5FxJONDt9ww/nsHiDa8Qg5l1
         9RNQ==
X-Gm-Message-State: AOAM530jEd1yUeZMaol0s/NLnEPpzXQEbkoquWnfgYsk/ePh7ZXLLxrX
        PmaopzrUKxLR7OiHrgPigqM=
X-Google-Smtp-Source: ABdhPJxii3LMr2sOWHPd2kMLz6kn2oNbv2/0Kpi/JWNGK9c5joIvl8bBcPgH6zQOBkbPAU6/cORzFw==
X-Received: by 2002:a17:902:ea91:: with SMTP id x17mr16562081plb.325.1592074739435;
        Sat, 13 Jun 2020 11:58:59 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:307:970b:360c:5006:374c:b8c0])
        by smtp.gmail.com with ESMTPSA id 140sm9792883pfz.154.2020.06.13.11.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 11:58:58 -0700 (PDT)
Date:   Sun, 14 Jun 2020 00:27:13 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     jnareb@gmail.com, stolee@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3 1/4] alloc: introduce parsed_commits_count
Message-ID: <20200613185713.GA73354@Abhishek-Arch>
Reply-To: xmqq8sgr28yd.fsf@gitster.c.googlers.com
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
 <20200612184014.1226972-2-abhishekkumar8222@gmail.com>
 <xmqq8sgr28yd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sgr28yd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 12, 2020 at 03:52:26PM -0700, Junio C Hamano wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> 
> >  static unsigned int alloc_commit_index(struct repository *r)
> >  {
> > -	return r->parsed_objects->commit_count++;
> > +	static unsigned int parsed_commits_count = 0;
> > +	r->parsed_objects->commit_count++;
> > +	return parsed_commits_count++;
> >  }
> 
> I'll queue this as-is, together with the rest of the series, but
> with the following SQUASH??? to document why we are counting
> globally.
> 
> I do not think r->parsed_objects->*_count is used by anybody, and we
> probably can eventually get rid of these stats fields, and when that
> happens, we may want to lose the "struct repository *" pointer from
> the functions in the callchain, but not right now.
> 
> Thanks.
> 
>  alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/alloc.c b/alloc.c
> index 29f0e3aa80..ee92661b71 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -99,6 +99,11 @@ void *alloc_object_node(struct repository *r)
>  	return obj;
>  }
>  
> +/*
> + * The returned count is to be used as an index into commit slabs,
> + * that are *NOT* maintained per repository, and that is why a single
> + * global counter is used.
> + */
>  static unsigned int alloc_commit_index(struct repository *r)
>  {
>  	static unsigned int parsed_commits_count = 0;
> -- 
> 2.27.0-90-geebb51ba8c
> 

Thanks for taking a closer look. I have created an issue on
gitgitgadget [1] to get rid of commit count and avoid passing repository
to the functions anymore.

[1]: https://github.com/gitgitgadget/git/issues/657

Abhishek
