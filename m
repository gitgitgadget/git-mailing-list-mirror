Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7329A1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 21:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbdHPVfW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 17:35:22 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:37910 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbdHPVfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 17:35:21 -0400
Received: by mail-pg0-f42.google.com with SMTP id t80so1520957pgb.5
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uRYWvl0f4U1sJ8WbrERgOYYEo1kFM0fVA58ToymeVwI=;
        b=VbFg0+dDUy0oDXUuGdckOThjRhUfZ0ZSY4IMqlsPtRE39prlaFVB3M5b5zkAJwtqMh
         mm6oJWrmq5QsjvG5oPpI+tBKzPFe8WeP6GdrsR9GzxeHvkxvpxE1PgA5lBqE8W/E/3z+
         /q9F8M3EcBonurjr+QxovsZyDxUBINhpjDb6aNQOfeI1j/8uPK/9Xnm8tJXxn9e1aH9D
         qiYNHZ87HRMqMRZEHcVh2R71cHmlkPep9JwxO2I5sqkaDWABsn0uigNUGH3a82adEsES
         TiC+RK9Q3ofgSmSRuNDTGirnjvlEDJITQs6n7PuMbMsfm7mrHoZ2JLdvIW654m4RglvZ
         2pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRYWvl0f4U1sJ8WbrERgOYYEo1kFM0fVA58ToymeVwI=;
        b=Lfjk58rIjse43kDBiTcpPKFM+ihUtxPKLoueFBbtxOTeO0DZhLa0XJH4m3FnYXAnv6
         dLRXf3l/vdTBVdJ2VH/Z3L/7aMV5R/ZdXRGiYz/tQpxMvdIueDOAhiETFgl0/fA+9ktS
         2urTVHah5FU604HN3Ttnn3fMxKmpHhkReesuSmkGe/xS/BjWm7tNWXy57RDUvrE1qjS2
         XdYokLnzhpbDjHn8BQxdwosTHPuj5xB4jsp0YAuwSsqo/k/KbhP2ivqodN3eedOoP6H/
         E7K0PbZSxs+CTviVq8FzQwyt3TFlpsDrPkdgP0w8myC6kEqCKCsZxeocGQzugd9zzBrP
         uaLA==
X-Gm-Message-State: AHYfb5hbzaYlj2nHTxl5hEo8+Bxbd6L63UqVUQSvIy6hVvtkUHBixQsd
        a4KLjQq68TTEtwB7FOpGOQ==
X-Received: by 10.99.96.149 with SMTP id u143mr2349931pgb.348.1502919320988;
        Wed, 16 Aug 2017 14:35:20 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:5897:a569:433e:2b7b])
        by smtp.gmail.com with ESMTPSA id i133sm3180088pgc.0.2017.08.16.14.35.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 14:35:19 -0700 (PDT)
Date:   Wed, 16 Aug 2017 14:35:15 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peartben@gmail.com
Subject: Re: [RFC PATCH] Updated "imported object" design
Message-ID: <20170816143515.0a74f959@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqa82zjlt4.fsf@gitster.mtv.corp.google.com>
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
        <20170816003200.19992-1-jonathantanmy@google.com>
        <xmqqa82zjlt4.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 16 Aug 2017 13:32:23 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Also, let me know if there's a better way to send out these patches for
> > review. Some of the code here has been reviewed before, for example.
> >
> > [1] https://public-inbox.org/git/cover.1502241234.git.jonathantanmy@google.com/
> >
> > [2] https://public-inbox.org/git/ffb734d277132802bcc25baa13e8ede3490af62a.1501532294.git.jonathantanmy@google.com/
> >
> > [3] https://public-inbox.org/git/20170807161031.7c4eae50@twelve2.svl.corp.google.com/
> 
> ... and some of the code exists only in the list archive, so we
> don't know which other topic if any we may want to eject tentatively
> if we wanted to give precedence to move this topic forward over
> others.  I'll worry about it later but help from others is also
> appreciated.

Thanks - I can help take a look when it is time to move the code in.

I think the issue here is whether we want to move this topic forward or
not, that is, if this (special ".imported" objects) is the best way to
solve (at least partially) the connectivity check part of tolerating
missing objects. I hope that we can continue to talk about it.

> This collects names of the objects that are _directly_ referred to
> by imported objects.  An imported pack may have a commit, whose
> top-level tree may or may not appear in the same pack, or the tree
> may exist locally but not in the same pack.  Or the tree may not be
> locally available at all.  In any of these four cases, the top-level
> tree is listed in the "promises" set.  Same for trees and tags.
> 
> I wonder if all of the calls to oidset_insert() in this function
> want to be guarded by "mark it as promised only when the referrent
> is *not* locally available" to keep the promises set minimally
> populated.  The only change needed to fsck in order to make it
> refrain from treating a missing but promised object as an error
> would be:
> 
>         -       if (object is missing)
>         +       if (object is missing && object is not promised)
>                         error("that object must be there but missing");
> 
> so there is no point in throwing something that we know we locally
> have in this oidset, right?
> 
> On the other hand, cost of such additional checks in this function
> may outweigh the savings of both memory pressure and look-up cost,
> so I do not know how the tradeoff would turn out.

I also don't know how the tradeoff would turn out, so I leaned towards
the slightly simpler solution of not doing the check. In the future,
maybe a t/perf test can be done to decide between the two.

> > +static int is_promise(const struct object_id *oid)
> > +{
> > +	if (!promises_prepared) {
> > +		if (repository_format_lazy_object)
> > +			for_each_packed_object(add_promise, NULL,
> > +					       FOR_EACH_OBJECT_IMPORTED_ONLY);
> > +		promises_prepared = 1;
> > +	}
> > +	return oidset_contains(&promises, oid);
> > +}
> 
> Somehow I'm tempted to call this function "is_promised()" but that
> is a minor naming issue.

I was trying to be consistent in using the name "promise" instead of
"promised object/tag/commit/tree/blob" everywhere, but we can switch if
need be (for example, if we don't want to limit the generic name
"promise" to merely objects).

> >  static const char *describe_object(struct object *obj)
> >  {
> >  	static struct strbuf buf = STRBUF_INIT;
> > @@ -410,7 +472,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
> >  					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
> >  			obj->used = 1;
> >  			mark_object_reachable(obj);
> > -		} else {
> > +		} else if (!is_promise(oid)) {
> >  			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
> >  			errors_found |= ERROR_REACHABLE;
> >  		}
> 
> This is about certainly is one place we want to check if the missing
> object is OK, but I'm a bit surprised if this were the only place.
> 
> Don't we need "while trying to follow all the outgoing links from
> this tree object, and we found this object is not available locally;
> normally we would mark it as an error but it turns out that the
> missing one is in the promised set of objects, so it is OK" for the
> normal connectivity traversal codepaths, for example?

That's right. The places to make this change are the same as those in
some earlier patches I sent (patches 2-4 in [1]).

[1] https://public-inbox.org/git/cover.1501532294.git.jonathantanmy@google.com/
