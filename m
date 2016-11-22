Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418001FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 23:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935284AbcKVXVJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 18:21:09 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33892 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933334AbcKVXVI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 18:21:08 -0500
Received: by mail-pf0-f182.google.com with SMTP id c4so6239776pfb.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 15:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQ0bRvthqvFKsQsSdOOUiyW2iymJr60sJ5hKVKV0W/I=;
        b=bDptwGGPoiYNPJDNQiLi73Pu3BSRePr2mdMH+gTwZn0y7OKKGBiXmuf+soNlHJn5TH
         EmXUvv3lYlDkxdir7esbj9UEpIIt9Jm8QWvoVmrejXLlqLEkKwF/UwjbQYsT2s64tPES
         yawXw177/qwYihU6eCV8LOTEmcHOE8/ADmsGjD95HW3zv6lAXS0wSyfc3wpIqdc9N8n/
         HmoVdX5rsgejF6TiEdNS2X1JmIKLqsYjyOqkRnNM6ykb7+AueMuqjQ5s3cy6Mf7p413z
         aYIwaQwgLZI59qepM6Dp0Nz/a4/btKX3rxXZcdHJdqVWsAz0kWsZt9Xqj4GC4U1aseTM
         Dulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQ0bRvthqvFKsQsSdOOUiyW2iymJr60sJ5hKVKV0W/I=;
        b=Trk9CbJ8HG+3mYzcebdX7ZOEjsJjKjjLJo/8l5p0Z+OFcfiUDJjk7b56CjUjE6OwD6
         NifC2pRODbldxRg8ga23fiJ54OpMjNye/N/mfzyHMZz44I9RUDxxMYtqc+IsU5KrPF8+
         84Yr8V02boJP1nv9YNLp7cCCuzbQ6DlkAcMZ4M/rLKrfX5Po5xLI5jeV2DflAGLteh21
         vnWlIcnF/gRrrPaVa1Uv8JZ6R7TNm89b7Az3twp1I0vFvKK1Zz1gZUTLEOegF5SS6Mml
         4i52Q/Qa87tCvu5w129zUYpXQJqhoD0Xmc0ooLMdywlF2ziMeMfjsH6+mqFzfWzURq2y
         Nykg==
X-Gm-Message-State: AKaTC03Fi/VTB56wpKYO1BIiT57I6p3nKrmi0LVmz2ppaytxOq8U89QQDTGTZlnfUM50YGMx
X-Received: by 10.84.170.195 with SMTP id j61mr317472plb.13.1479856867364;
        Tue, 22 Nov 2016 15:21:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a049:6e3d:16a5:8086])
        by smtp.gmail.com with ESMTPSA id i76sm47510757pfk.89.2016.11.22.15.21.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 15:21:06 -0800 (PST)
Date:   Tue, 22 Nov 2016 15:21:05 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161122232105.GC65825@google.com>
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1479840397-68264-6-git-send-email-bmwill@google.com>
 <xmqqshqjnmtc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshqjnmtc.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > diff --git a/tree-walk.c b/tree-walk.c
> > index 828f435..ff77605 100644
> > --- a/tree-walk.c
> > +++ b/tree-walk.c
> > @@ -1004,6 +1004,19 @@ static enum interesting do_match(const struct name_entry *entry,
> >  				 */
> >  				if (ps->recursive && S_ISDIR(entry->mode))
> >  					return entry_interesting;
> > +
> > +				/*
> > +				 * When matching against submodules with
> > +				 * wildcard characters, ensure that the entry
> > +				 * at least matches up to the first wild
> > +				 * character.  More accurate matching can then
> > +				 * be performed in the submodule itself.
> > +				 */
> > +				if (ps->recursive && S_ISGITLINK(entry->mode) &&
> > +				    !ps_strncmp(item, match + baselen,
> > +						entry->path,
> > +						item->nowildcard_len - baselen))
> > +					return entry_interesting;
> >  			}
> 
> This one (and the other hunk) feels more correct than the previous
> round.  One thing to keep in mind however is that ps->recursive is
> about "do we show a tree as a tree aka 040000, or do we descend into
> it to show its contents?", not about "do we recurse into submodules?",
> AFAICT.
> 
> So this change may have an impact on "git ls-tree -r" with pathspec;
> I offhand do not know if that impact is undesirable or not.  A test
> or two may be in order to illustrate what happens?  With a submodule
> at "sub/module", running "git ls-tree -r HEAD -- sub/module/*" or
> something like that, perhaps?

Maybe unrelated, but it looks like wildcard characters are overridden in
ls-tree.c per '170260ae'.  As such wildmatching just doesn't work with
ls-tree.  so `git ls-tree -r HEAD -- "*"` results in no hits.

-- 
Brandon Williams
