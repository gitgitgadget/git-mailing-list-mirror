Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10EF20248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfDDXrh (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:47:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45279 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfDDXrg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:47:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so1958416plb.12
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rgPdrcJ0tqOlqTkxiELK2PBjqzZ9GXk0qJ8NAXf2//M=;
        b=QNCgB+ZL+kCguTRg/OIdEBkbF+j225iR64UDORZEwolKTyJcxaDjpIqs69QMzg7kJB
         jnNZvR7KUJrCCCBZrm7EUVL6BiREec/QeZoC9qgPJ2OGtiLxq2UaeSUyaxXCWP14rTLR
         lIL+Diy4LbquxOnIG2/2Jwd8ggMxlKeC0j6lbsEobrgD4XGYl76EsI+ztlmObxmljth+
         C/jQTMdTULJcs0oFKY4V/ySd3/w9CCTYveCQ3ne0sWtp6xKGbdnOC6llp+kG0I/7VACQ
         Y838YRzNWbI8laHQCQcQEEz6Pvv+R0a10DvjvwMbZtZ9w+20HHeQvuYlqm7WxUXvGm5Y
         B8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rgPdrcJ0tqOlqTkxiELK2PBjqzZ9GXk0qJ8NAXf2//M=;
        b=Z5XMjcy+gVHJsDevUTJBViB5+zUI+m4CLDEQGywqwe9Sn9j9vtvlclC7U8XMc7rbkY
         I8kRZIM/rybjiWbyBI3fvNFUx9gKXqX83zIeorSKkGiZIiumqOpicAzyox3ZnQ/HivF/
         5+vTlUrj9HvuVMQnKxh7fj4hzoSWn8kVosMEjSv6ziaLzr8SDRmCZgIS/psBzNIyJ2Q1
         3X4kU7J8W8JqUh0XteB7q/nXHeZaC2X8uYK8hP6gMnorcZIgYcLjs/7kfRjc9thpF6WU
         8JTX3XX8sOCJ2zqw6blFeb3NVauXSEAlRiE0ZmADvCkhKdF97iAINN71GSBEq9R9Oo5y
         yG4A==
X-Gm-Message-State: APjAAAWV5UhS7dg5JaZqI0w29Ie5q0xOpIhtUJw85FgXWiNemBz4Fobj
        uHPZdpjmge+YAezxrQKzk3itaQ==
X-Google-Smtp-Source: APXvYqxepXY34j8Pbkj2VOs8DNL0onwz21ChPV2CdKHZHr0RYAeyiSfkzpbyReJJD1ymWjFrMNNEzw==
X-Received: by 2002:a17:902:b597:: with SMTP id a23mr9094591pls.284.1554421654962;
        Thu, 04 Apr 2019 16:47:34 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id b63sm54152441pfj.54.2019.04.04.16.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 16:47:34 -0700 (PDT)
Date:   Thu, 4 Apr 2019 16:47:26 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2] rev-list: exclude promisor objects at walk time
Message-ID: <20190404234726.GG60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9f327d6d8dc5e71eb0039aef3ac76ea16c2adab3.1554417917.git.steadmon@google.com>
 <20190404230759.GA26623@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404230759.GA26623@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.04 19:08, Jeff King wrote:
> On Thu, Apr 04, 2019 at 03:53:56PM -0700, Josh Steadmon wrote:
> 
> > For large repositories, enumerating the list of all promisor objects (in
> > order to exclude them from a rev-list walk) can take a significant
> > amount of time).
> > 
> > When --exclude-promisor-objects is passed to rev-list, don't enumerate
> > the promisor objects. Instead, filter them (and any children objects)
> > during the actual graph walk.
> 
> Yeah, this is definitely the approach I was thinking of.
> 
> Did you (or anybody else) have any thoughts on the case where a given
> object is referred to both by a promisor and a non-promisor (and we
> don't have it)? That's the "shortcut" I think we're taking here: we
> would no longer realize that it's available via the promisor when we
> traverse to it from the non-promisor. I'm just not clear on whether that
> can ever happen.

I am not sure either. In process_blob() and process_tree() there are
additional checks for whether missing blobs/trees are promisor objects
using is_promisor_object()...  but if we call that we undo the
performance gains from this change.


> > Helped-By: Jonathan Tan <jonathantanmy@google.com>
> > Helped-By: Jeff King <peff@peff.net>
> > Helped-By: Jonathan Nieder <jrnieder@gmail.com>
> > 
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> 
> Minor nit, but these should all be part of the same block.

Will fix in v3.


> > diff --git a/list-objects.c b/list-objects.c
> > index dc77361e11..d1eaa0999e 100644
> > --- a/list-objects.c
> > +++ b/list-objects.c
> > @@ -30,6 +30,7 @@ static void process_blob(struct traversal_context *ctx,
> >  	struct object *obj = &blob->object;
> >  	size_t pathlen;
> >  	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
> > +	struct object_info oi = OBJECT_INFO_INIT;
> >  
> >  	if (!ctx->revs->blob_objects)
> >  		return;
> > @@ -37,6 +38,11 @@ static void process_blob(struct traversal_context *ctx,
> >  		die("bad blob object");
> >  	if (obj->flags & (UNINTERESTING | SEEN))
> >  		return;
> > +	if (ctx->revs->exclude_promisor_objects &&
> > +	    !oid_object_info_extended(the_repository, &obj->oid, &oi, 0) &&
> > +	    oi.whence == OI_PACKED &&
> > +	    oi.u.packed.pack->pack_promisor)
> > +		return;
> 
> This conditional gets repeated a lot in your patch. Perhaps it's worth a
> helper so we can say:
> 
>   if (skip_promisor_object(&ctx->revs, &obj->oid))
> 	return;
> 
> in each place?

Will fix in v3.


> One other possible small optimization: we don't look up the object
> unless the caller asked to exclude promisors, which is good. But we
> could also keep a single flag for "is there a promisor pack at all?".
> When there isn't, we know there's no point in looking for the object.
> 
> It might not matter much in practice. The main caller here is going to
> be check_connected(), and it only passes --exclude-promisor-objects if
> it's in a partial clone.

I'm not necessarily opposed, but I'm leaning towards the "won't matter
much" side.

Where would such a flag live, in this case, and who would be responsible
for initializing it? I guess it would only matter for rev-list, so we
could initialize it in cmd_rev_list() if --exclude-promisor-objects is
passed?

> > [...]
> 
> I didn't see any tweaks to the callers, which makes sense; we're already
> passing --exclude-promisor-objects as necessary. Which means by itself,
> this patch should be making things faster, right? Do you have timings to
> show that off?

Yeah, for a partial clone of a large-ish Android repo [1], we see the
connectivity check go from >180s to ~7s.

[1]: https://android.googlesource.com/platform/frameworks/base/
