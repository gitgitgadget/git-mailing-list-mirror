Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C39C1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 18:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405763AbfITSNJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 14:13:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52254 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404864AbfITSNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 14:13:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id x2so3499377wmj.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=duPFsQUiAB394NLJIG6CxXbuWqIVANIn/AeH/CjYalg=;
        b=JGSJ12TxTzVAzI+mvcj7j9s7CLr5aPhqbpNnyg964GJPtvPslPOxyvGX9cAuyXVzi4
         ywFjWHZxQiPFCsi2BeqbPZfpGGjp6BFbhI6X04AlRNjbGRWF842R3zKxlWDBurjeLp8W
         8otgQuohUr/VLXpLIQ6aFTk9sT0ibGsxG4VOmBWex6YWMMitUP70WPrTK8k6U8t9hicu
         a8dbEzv9Oq1zh+IFbK85abxyAabOLU1io+EQPAA1QteyuvhC63jURjF2ixz+N6bvjuAK
         QvC1jiW5JO60S3Ux0SAZqHXlK6TOfu0D+dbzN+u+1HheV916pYK2VbFTQjNXkp7TuJWY
         G2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=duPFsQUiAB394NLJIG6CxXbuWqIVANIn/AeH/CjYalg=;
        b=GoyRlwE1O6TxEffrLV9Glo/BnLgoLWpEo7BmmdEyjb4wZ3cZ6fMTvkQxBsCmBiccun
         sYSRJ/wG02mlaM8r3zYfhfNcWzYUrIXkn79d6KN4SQi1Gt0b+CYHVBakS8YpVzTaQt5w
         Es7JUKDvPW78UDzLp4m06TvB3ckhRDP4YYhuvCon9H6zgk/r2NQepXq+zFJEPwXXT51W
         3iZd1CTo4CHLOpAOyXoKCapRSW3+MgWbRun3b78i10lc9QJlY5hwG3CehqL+TeL0a+T7
         JtBce8P7wOkd7C/Dj6SOegVT6uvWFIUIPz/KdAkrdcGWOpFNx/MueaUHg2lswOGuNYxk
         pUWg==
X-Gm-Message-State: APjAAAXFtE5nyNCenfBr64pxqfz4ttPlXRZss0wDqfdW0dq5KuK8CG4S
        Oowy6gzx1msWQtguG3HXNa/FQklm
X-Google-Smtp-Source: APXvYqwgZdI/O1nl22JvQs9HvtlovwZyducxDpDuWSF3dvmWuUUiaB40gbu/qADzprbH1NAhatGUBg==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr4417904wme.115.1569003187226;
        Fri, 20 Sep 2019 11:13:07 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id o188sm6661143wma.14.2019.09.20.11.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:13:06 -0700 (PDT)
Date:   Fri, 20 Sep 2019 20:13:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190920181302.GA26402@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -280,12 +269,16 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
> >  	if (o && o->type == OBJ_COMMIT) {
> >  		struct commit *commit = (struct commit *)o;
> >  		int from_tag = starts_with(path, "refs/tags/");
> > +		const char *tip_name;
> 
> This should not be const because you allocate the buffer it points to
> right here in the function, in each execution path.

Marking it as const indicates that this function doesn't modify the
buffer where the pointer points at.

> >
> >  		if (taggerdate == TIME_MAX)
> >  			taggerdate = commit->date;
> >  		path = name_ref_abbrev(path, can_abbreviate_output);
> > -		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
> > -			 from_tag, deref);
> > +		if (deref)
> > +			tip_name = xstrfmt("%s^0", path);
> > +		else
> > +			tip_name = xstrdup(path);
> > +		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
> 
> tip_name should be free(3)'d here.  Except we can't do that because
> name_rev() sometimes stores that pointer in a commit slab.  Ugh.
> 
> If the (re)introduced leak doesn't impact performance and memory
> usage too much then duplicating tip_name again in name_rev() or
> rather your new create_or_update_name() would likely make the
> lifetimes of those string buffers easier to manage.

Yeah, the easiest would be when each 'struct rev_name' in the commit
slab would have its own 'tip_name' string, but that would result in
a lot of duplicated strings and increased memory usage.

