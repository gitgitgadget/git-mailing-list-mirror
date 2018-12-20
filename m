Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32671F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbeLTNgs (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:36:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36029 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLTNgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:36:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so2221230wmc.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=16rp+R4jZOV0wAkbNOf9nFypi1qHr1Z+xt+QBEkQc8I=;
        b=W/3wcdrAmIRPj3887Y3u4BT+1RKotqbXcnVlKBajdA6brEJW5IGR+jiUUECCjD9MQZ
         MwSRBkD579+5oeNbA15TKPZ7usiKIuqYpxo7vioyk1xS+tmdJ4SU8NXwZnIkf/fO6Fun
         RI2v7eAqiDGAJyY0r0VQgE+f+73sCr4ZoHtXHjSWblk8LhhzWYSF1DIzi3e4M697KRk4
         lqo4kG1TxilLzJl+VWIBweeoSQf7PPgpzKJSsAwRSETXsildhQ6Q80LQmMvYO3DQG0Cn
         joFkj8OAu/K0fk3YceArmbTGERza7Atc0YzHO0owGtSB3m79r2L1sNcbttICoc9nDEZA
         y81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=16rp+R4jZOV0wAkbNOf9nFypi1qHr1Z+xt+QBEkQc8I=;
        b=sTboMUzuNCr6C5gENp6Kn6ZgfD+eWAdA36CK5iMOD/Ja/8HUGIxGOVZJH7IH3ExSWD
         sfwvmUWM9FG2k4W3Q+MdjmfiLFoPvw+tb8FUSXLeCvgQKM7QPKoJElL01lWsKM4gKcgF
         BSRq4MdO6wudu3UhT0ywW0njASDPr0LDOtFj2s2gtlAt8uRgPc96UV06G7LLpNiud0Q+
         l4iWYQdWXhEpLUuxru0qWP5KO3jRyxMl11Ext7UjRs+U3jCUTwi2o25XXXXmH7XvNPeY
         gLPAS2t+x+qRRbrNRxVF29MJaMCAUsdNhYhrqU4L500qoHFyS00AN7Qk/EzO8kQCOaBQ
         YFKg==
X-Gm-Message-State: AA+aEWZ4XcgfctNSg1YS4Y4lXwm72lBOwc4qZIZ/Rcw16uVZnmAUAidH
        iAFOnXntOcqDGSLTG5m6NksCJNZvyf0=
X-Google-Smtp-Source: AFSGD/VJYT22cAcJ39olG7+n9EpfrtmnkxyqBz4oUDBSFbmVUFOllIXH5t1FuNROS8TZTKKTSXDp2w==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr3118214wme.84.1545313006247;
        Thu, 20 Dec 2018 05:36:46 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id s1sm10434127wro.9.2018.12.20.05.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:36:44 -0800 (PST)
Date:   Thu, 20 Dec 2018 13:36:43 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/8] entry: factor out unlink_entry function
Message-ID: <20181220133643.GA25639@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-3-t.gummerer@gmail.com>
 <CACsJy8AGerhjnT0O6vT264tND78N5cbgFREzYtdmriXERu0Jtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8AGerhjnT0O6vT264tND78N5cbgFREzYtdmriXERu0Jtw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Duy Nguyen wrote:
> On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Factor out the 'unlink_entry()' function from unpack-trees.c to
> > entry.c.  It will be used in other places as well in subsequent
> > steps.
> >
> > As it's no longer a static function, also move the documentation to
> > the header file to make it more discoverable.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  cache.h        |  5 +++++
> >  entry.c        | 15 +++++++++++++++
> >  unpack-trees.c | 19 -------------------
> >  3 files changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/cache.h b/cache.h
> > index ca36b44ee0..c1c953e810 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1542,6 +1542,11 @@ struct checkout {
> >  extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
> >  extern void enable_delayed_checkout(struct checkout *state);
> >  extern int finish_delayed_checkout(struct checkout *state);
> > +/*
> > + * Unlink the last component and schedule the leading directories for
> > + * removal, such that empty directories get removed.
> > + */
> > +extern void unlink_entry(const struct cache_entry *ce);
> 
> I'm torn. We try to remove 'extern' but I can see you may want to add
> it here to be consistent with others. And removing extern even from
> functions from entry.c only would cause some conflicts.

Yeah I felt like favoring consistency here would be better.  Once your
path counting series and my series land, this may get quieter and we
can remove the 'extern' then?

> I wonder if we should move the 'removal' variable in symlinks to
> 'struct checkout' to reduce another global variable. But I guess
> that's the problem for another day. It's not the focus of this
> series.

Yeah, I'd prefer leaving that for another day :)

> -- 
> Duy
