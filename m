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
	by dcvr.yhbt.net (Postfix) with ESMTP id 788D91F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbfITRJq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:09:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51544 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392155AbfITRJq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:09:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so3294697wme.1
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BeiCJU/fl88Z6iPoN/5FwdO2PMFurSovoOERh50jzqw=;
        b=XMjwWq0QJP+h7uXC9Ru5BXcCIf5h4rAquJa+Z6vAonU/2pGi+UX7zyJj1PqHBixoY0
         OLcs6kCnzGwAlTjiX/0R0KxjMFOaK9xXexYOOqs0W2fiVtRmd/1nxBMtIDfRErII5Ruo
         qwbmiIxIYCbNfGo5jfhW9AKMuEvTEjxTBBPseLvK+WxbwmdCpV2vRCj95wj61cvc149Y
         9N3kYgUGS4rz6ayIq377+ObUQWjwzm2gIP7MRDuJXJWHfhdixrnidPYivYDWnDXQWueY
         R/SJ/fk+0QX3hMBf1gd3JbjngHOKaW1ABUWsH4+u03QpvXZmVL5XIr2/tfF1agahcuV6
         Wr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BeiCJU/fl88Z6iPoN/5FwdO2PMFurSovoOERh50jzqw=;
        b=gACkY4lFEqwGH4w6jC/Bjv22z11dk3N3gOtPONeSAi8GkoURFfYwfRkY1oxL6/ENwV
         ZS9Hlwm/erhK3CpFbL/dk9xY/V6X93DGhkuHH3sdN9TgTcD1C+dgu5UGGbQwN9bRegMR
         6DkPOX6afYUvo3UpdBDkSi2QdnZuwH2EwgC2aTnlekTduEnZ6mRvIobzOmdkQkpKcuq0
         J9L1+jClelutMj4YzcmANI3qOZUH2mtsmY3KQRxPDMEYDZLrEikCkv12qtt5dPEN8NM8
         Vxcyh3fezFHw2wsMFhrhp38K71Wa8kEZgMReUtQW45kMr5wL+8UMDPQjCJXkdnxcD4AR
         mOPw==
X-Gm-Message-State: APjAAAU/my4h2oa4X9bwRRtarourvEmbWr45qCh22JX2IaiSzr12DRuK
        aAXPioZso/2/xTARGRzMPk0ZL9EO
X-Google-Smtp-Source: APXvYqy3xAbJBGZBUlwWJFx3SC+A0DT5LXvvWsW5ejMzKYwaq/ytuEaqiabKVVjPy0VphCV9epMbUQ==
X-Received: by 2002:a05:600c:12:: with SMTP id g18mr4083713wmc.158.1568999383278;
        Fri, 20 Sep 2019 10:09:43 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id l7sm2906496wrv.77.2019.09.20.10.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 10:09:41 -0700 (PDT)
Date:   Fri, 20 Sep 2019 19:09:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 10/15] name-rev: restructure creating/updating 'struct
 rev_name' instances
Message-ID: <20190920170936.GA32474@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-11-szeder.dev@gmail.com>
 <515a4590-47e8-fe95-833b-307364fc8fa4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <515a4590-47e8-fe95-833b-307364fc8fa4@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 11:27:49AM -0400, Derrick Stolee wrote:
> On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> > At the beginning of the recursive name_rev() function it creates a new
> > 'struct rev_name' instance for each previously unvisited commit or, if
> > this visit results in better name for an already visited commit, then
> > updates the 'struct rev_name' instance attached to to the commit, or
> > returns early.
> > 
> > Restructure this so it's caller creates or updates the 'struct
> > rev_name' instance associated with the commit to be passed as
> > parameter, i.e. both name_ref() before calling name_rev() and
> > name_rev() itself as it iterates over the parent commits.
> > 
> > This makes eliminating the recursion a bit easier to follow, and it
> > will be moved back to name_rev() after the recursion is eliminated.
> > 
> > This change also plugs the memory leak that was temporarily unplugged
> > in the earlier "name-rev: pull out deref handling from the recursion"
> > patch in this series.
> [snip]
> >  
> > @@ -276,11 +277,17 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
> >  		path = name_ref_abbrev(path, can_abbreviate_output);
> >  		if (commit->date >= cutoff) {
> >  			const char *tip_name;
> > +			char *to_free = NULL;
> >  			if (deref)
> > -				tip_name = xstrfmt("%s^0", path);
> > +				tip_name = to_free = xstrfmt("%s^0", path);
> >  			else
> >  				tip_name = xstrdup(path);
> 
> So this xstrdup(path) is not a leak?

Well... yes, everything is leaked, eventually ;)

First of all, name_ref() is a callback function invoked by
for_each_ref(), and 'path' is one of its parameters.  This means
that we must duplicate this string, because we might need to access it
even after iterating over refs is over (when displaying the name of
the commits).

This copy then becomes the initial name_rev() invocation's 'tip_name'
parameter, and things get a bit harder to reason about because of
merges, the recursion, and being in the middle of the refactorings...

So for argument's sake look at current master's 'builtin/name-rev.c',
and assume that it has to deal with a linear history with a single
branch, and no tags.  When name_ref() is invoked with a branch, then
deref = 0, so in name_rev() the condition:

  if (deref) {
        tip_name = to_free = xstrfmt("%s^0", tip_name);

won't be fulfilled, and 'tip_name' remains unchanged.  Then comes the
initialization of the 'struct rev_name' associated with the tip commit
in the commit slab, including the

  name->tip_name = tip_name;

assignment, IOW we now have a pointer to the original 'tip_name' in
the commit slab.

Then name_rev() looks at the tip commit's parents, or rather, because
of the linear history, at its only parent.  This means that neither of
the other two xstrfmt() will be invoked, and name_rev() will be
recursively invoked with the original 'tip_name' pointer.  This will
then initialize another 'struct rev_name' instance, including yet
another pointer to the original 'tip_name'.

This will go on until the root commit is reached, and in the end every
commit will have an associated 'struct rev_name' instance with a
pointer to the original 'tip_name' string.

At this point we're done with the recursion, and since the repo has
only a single branch, we're done with for_each_ref() as well, and
finally print names of the commits.

Then it's time to clean up and free() memory, but:

  - we could only release the commit slab and free() all 'struct
    rev_name' instances within, but we can't free() the
    'name->tip_name' pointers, because, as shown above, we might have
    a bunch of pointers pointing to the same string.

  - we are at the end of cmd_name_rev() and are about to exit the
    program, so the OS will release any and all resources anyway.
    Yeah, it's far from ready to be turned into a library call...

Now, in a real repository we'll have multiple branches, tags, and
merges, so there will be cases when an existing 'struct rev_name'
instance is updated, and it's 'name->tip_name' is overwritten by a
better name.  At that point the old value is potentially leaked, but
we can't really do anything about it, because we don't know whether
any other 'struct rev_name' instances point to it.

Eliminating the recursion doesn't change anything in this respect.


