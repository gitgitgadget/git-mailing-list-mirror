Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F69E1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 18:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755010AbdCBSBP (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 13:01:15 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35997 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbdCBSA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 13:00:58 -0500
Received: by mail-pf0-f177.google.com with SMTP id x66so24417527pfb.3
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e08KPgFU3XKoThqI1w9xAoYyKy76h/ClkYoIkhjIwDg=;
        b=Fe8/YKeFQdG580oOHDdZQ2NnI3U5Vl8TJDszZYDFL+6vUyHnFF1+KRfmzN6ZOv1H/Y
         7ZRnxAOyoYGcidIHfUiIX9bLqgnMbpD+WfT7fn/+NYcYoPcQNqX6Gl07Bjr35K9crMas
         TSAYZmTZlLXq5F5mFtqogNJiDfFtgU7++5INGAV3WkICsV0nY85iGMII6DMFuox+5BD9
         cslGZianRC2xbkmNJBwuflB7yKfJbdo67c1YuCluYcMqIjwsVovOk7r3DYsnq44jd0Fm
         e3zluNPWiLNVu6g1ry3w7p73558iEpL/y5MOsOYkkHQt/cJrYaiJ18Zzp44EBi1Ito5v
         ErTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e08KPgFU3XKoThqI1w9xAoYyKy76h/ClkYoIkhjIwDg=;
        b=uX5QYJfK53IndOYFKPxCdpUxAsWf/qTYZ0lh2g+B8Qwh+oBPU+6sUtm8QOMPIEfrdR
         LbT+tn1brskL4rE79R45OKR+aFr9mm1w2+LoWWQjhNYewJ6i9kic0ruUBW3XMcWJWsLI
         +iN7nwG6f8s8vzjNPM7vs1HrUUz2soR2xqmk1CShhq17i2KnvEEU2Qzh3c/uqUOPUZy9
         Q+7p68zeRg3zZusvyW1AsbxVlilU+iHjKJz+ByOyORr+lKOn/GCsxkQAn+U0rKDhqjta
         3W+z57Egu4rqtlMSS9tD0qH4DT3EUzeA3HIxq8mTWN/z/J8EXpBrGSAGILNiGlxNd9Y4
         adHw==
X-Gm-Message-State: AMke39mbl3IaGJ4kbTGTQAagR3ho/+lKbuxK/ERrYazBH6jVrgS8veyrqGtAVBamUDriDsSo
X-Received: by 10.98.4.71 with SMTP id 68mr16937366pfe.92.1488477641531;
        Thu, 02 Mar 2017 10:00:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d033:6603:834d:8912])
        by smtp.gmail.com with ESMTPSA id m29sm18391646pfi.54.2017.03.02.10.00.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Mar 2017 10:00:40 -0800 (PST)
Date:   Thu, 2 Mar 2017 10:00:38 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 3/5] grep: fix bug when recuring with relative pathspec
Message-ID: <20170302180038.GB30622@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170224235100.52627-4-bmwill@google.com>
 <xmqqefyijacj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefyijacj.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/28, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >  	/* Add super prefix */
> > +	quote_path_relative(name, opt->prefix, &buf);
> 
> Hmph, do you want a quoted version here, not just relative_path()?
> 
> Perhaps add a test with an "unusual" byte (e.g. a double-quote) in
> the path?

You're absolutely correct.

> 
> >  	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
> >  			 super_prefix ? super_prefix : "",
> > -			 name);
> > +			 buf.buf);
> > +	strbuf_release(&buf);
> >  	argv_array_push(&cp.args, "grep");
> >  
> >  	/*
> > @@ -1199,7 +1202,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >  
> >  	parse_pathspec(&pathspec, 0,
> >  		       PATHSPEC_PREFER_CWD |
> > -		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
> > +		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
> > +		       (super_prefix ? PATHSPEC_FROMROOT : 0),
> >  		       prefix, argv + i);
> >  	pathspec.max_depth = opt.max_depth;
> >  	pathspec.recursive = 1;
> > diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> > index 418ba68fe..e0932b2b7 100755
> > --- a/t/t7814-grep-recurse-submodules.sh
> > +++ b/t/t7814-grep-recurse-submodules.sh
> > @@ -227,7 +227,7 @@ test_expect_success 'grep history with moved submoules' '
> >  	test_cmp expect actual
> >  '
> >  
> > -test_expect_failure 'grep using relative path' '
> > +test_expect_success 'grep using relative path' '
> >  	test_when_finished "rm -rf parent sub" &&
> >  	git init sub &&
> >  	echo "foobar" >sub/file &&

-- 
Brandon Williams
