Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BE91F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933800AbeGIR7n (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:59:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35016 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933676AbeGIR7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:59:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so6379185plt.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/U+keujjg+1ryfMFfdplwNBTm+4vexT4sfqSMTqRfA=;
        b=IbHaW6t2uVGZ/mnZJQi9O8IL306MICZcW+o+5CYKNvm8ek1remG6kZmv5ywlYPkQqM
         pmDlYt568xkHonQIE6iWobbdcXf1R9zzlRiN+QdQKsJfCsY6aIc4rVAYR2kGC6PeNOtE
         ikBgskzcJlE6Hc5WHBKVkAPgvOphH92aDRsJVHWK3OnilktqialktP55jHCXGpuC5IEA
         6m5lVCmksaQhaydHS94J0a7teM+Pob35HWR4rUgQosKwlit8xMuli1ZMYrl2bzfQrOnx
         ogY8hWx3y3hoG20yaATAunF+NYG74gqzSDv9dnRT7CfPijOyz5IVEC/DIcG55ZPR6XP+
         O1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/U+keujjg+1ryfMFfdplwNBTm+4vexT4sfqSMTqRfA=;
        b=mGWg+pwq7hEGycWhHHSXZMmMFEvvQ5ClycIQkCs7DfDQU/+uDmqHdW6KA/WYUkPRIc
         gvrcP1OKEV6pKeMrBqAGzNpzi0Bwc1Os68m+oPO+GBsy1JUVbBybZeDc0Q33gkpXbBiS
         Wb+u4Xcmxq1LyIvVR9NtiU3ize/489pQCxoTjLKte1IkNelsJqFGW47C+Y9G50vCZuKt
         w13E2ka3ZVE19m6BaraM36O9W63JC/Bqv4bOxdromboE6kcq/KY9x4IKidEYImz4ViC5
         DEC/vUAWc5wuE8iwWdpDvxHnT8jpyt5t7mK6iw5F9E3xsleh4u6PVbG55utQD5OS1MJ5
         llPg==
X-Gm-Message-State: APt69E21PvbQq+ZcKb1sCPcuzA/vZ9OYPB8JLXegcCslNMx8rhHxCQ/E
        JI/TBRtgg4BGWXWUic3XSH9C6Q==
X-Google-Smtp-Source: AAOMgpcaqeuZydeqs72oBvj9aX2i/mIgMKdHG9i2YBUzEuRK3dHV3j95nuFYW5hqPbgRbIE+dChK3g==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr21575261plb.24.1531159181797;
        Mon, 09 Jul 2018 10:59:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id u42-v6sm31673044pgn.1.2018.07.09.10.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:59:40 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:59:39 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
Message-ID: <20180709175939.GC81741@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
 <cover.1528234587.git.jonathantanmy@google.com>
 <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
 <20180709173813.GA14196@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709173813.GA14196@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09, Jonathan Nieder wrote:
> Hi,
> 
> Jonathan Tan wrote:
> 
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
> >  		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
> >  
> >  	if (ref_prefixes.argc &&
> > -	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
> > +	    (tags == TAGS_SET || tags == TAGS_DEFAULT)) {
> 
> Makes a lot of sense.
> 
> This means that if I run
> 
> 	git fetch origin master
> 
> then the ls-refs step will now include refs/tags/* in addition to
> refs/heads/master, erasing some of the gain that protocol v2 brought.
> But since the user didn't pass --no-tags, that is what the user asked
> for.
> 
> One could argue that the user didn't *mean* to ask for that.  In other
> words, I wonder if the following would better match the user intent:
> 
>  - introduce a new tagopt value, --tags=auto or something, that means
>    that tags are only followed when no refspec is supplied.  In other
>    words,
> 
> 	git fetch --tags=auto <remote>
> 
>    would perform tag auto-following, while
> 
>    	git fetch --tags=auto <remote> <branch>
> 
>    would act like fetch --no-tags.
> 
>  - make --tags=auto the default for new clones.
> 
> What do you think?
> 
> Some related thoughts on tag auto-following:
> 
> It would be tempting to not use tag auto-following at all in the
> default configuration and just include refs/tags/*:refs/tags/* in the
> default clone refspec.  Unfortunately, that would be a pretty
> significant behavior change from the present behavior, since
> 
>  - it would fetch tags pointing to objects unrelated to the fetched
>    history
>  - if we have ref-in-want *with* pattern support, it would mean we
>    try to fetch all tags on every fetch.  As discussed in the
>    thread [1], this is expensive and difficult to get right.
>  - if an unannotated tag is fast-forwarded, it would allow existing
>    tags to be updated
>  - it interacts poorly with --prune
>  - ...
> 
> I actually suspect it's a good direction in the long term, but until
> we address those downsides (see also the occasional discussions on tag
> namespaces), we're not ready for it.  The --tags=auto described above
> is a sort of half approximation.
> 
> Anyway, this is all a long way of saying that despite the performance
> regression I believe this patch heads in the right direction.  The
> performance regression is inevitable in what the user is
> (unintentionally) requesting, and we can address it separately by
> changing the defaults to better match what the user intends to
> request.

I agree with this observation, though I'm a bit sad about it.  I think
that having tag auto-following the default is a little confusing (and
hurts perf[1] when using proto v2) but since thats the way its always been
we'll have to live with it for now.  I think exploring changing the
defaults might be a good thing to do in the future.  But for now we've
had enough people comment on this lacking functionality that we should
fix it.

[1] Thankfully it doesn't completely undo what protocol v2 did, as we
still are able to eliminate refs/changes or refs/pull or other various
refs which significantly add to the number of refs advertised during
fetch.

-- 
Brandon Williams
