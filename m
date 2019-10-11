Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35A41F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 23:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfJKX0l (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 19:26:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39511 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfJKX0k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 19:26:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so6947908pff.6
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8MwVDR56CskZ+WnRMU7/G+hFQYloypOSlvagAtSSDT4=;
        b=fyIRidkGo8EBxYE/933st4BL4mxGcBHtYEnnFSmTQuNq9rbNRqtUf6ZWNxvq3X+kd8
         pU7CGABfg3HArRnq0WHIZy9jHj7KOZZ9L/hE82hsC9zqkqQkqrO9Wj8qIJeKwm84GBmw
         620uLJ8t8ZDi+tMJvPAcU+NMJ/Wss6LunUE2iUd0fFrv97TUobmadpRNkgMmC3Nwui1R
         qyUphZ6t3p+Wv8AATmimrPsLdMfEUki6Xcqcc+h+HzAEBmWH6so8HapWGtZzRnnmGEqc
         M11safv/bEDzEsq5/BrPusy+E/sd40DFYN+j+QAIWhhako77IDlThaOAthl7zkONwA0S
         rpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8MwVDR56CskZ+WnRMU7/G+hFQYloypOSlvagAtSSDT4=;
        b=khk1x6J9e21DAK7ox8QjXPUwPmq2hU5BEauUsq1CzBOSnuOzRBPiSBPWazxTS7VHoP
         c7N+1Oo62Al4vJzs6Ab99JTVHnR860bg3a9ZO4KTyXnSjuU8GE+F9lTV2mzOT7yuvNhU
         OvkU7W7aOYfRWhvQ84sZ9lObnjghU5wKbwUKYyIcZsHdzf4nxyXlJGmBD+S5D2Gz7fOH
         17dKE1t/exAe7FSz3Bk+jliVTwkW6Fo3+5uCfhwbuQcO/iOJgPX0pMOk2MOG/7iZ+Tjh
         oJj35N4AtJ5f5M3FSudIScuaoPK7nE53L1985sZafT93ib1tv4Yer5yR0rSaenmolIlB
         R/qA==
X-Gm-Message-State: APjAAAUwoyHfPxOQ0OTH2lwp6PnUss8oF/GgnGuFeonWO4Hp4FTMYnLd
        bovBEdxtoJ7Y+FjymrqAilyUmklBQqen4w==
X-Google-Smtp-Source: APXvYqzMPvsVrpv/sPAPWxjvkGcpmmvtQtFUe2L8AD2BwYu3lX+2nEQZLxBB8uyVYlKni1Ob+z/sXQ==
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr20420147pjb.90.1570836399405;
        Fri, 11 Oct 2019 16:26:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u65sm3704819pgb.36.2019.10.11.16.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:26:38 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:26:33 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v5] documentation: add tutorial for object walking
Message-ID: <20191011232633.GB20450@google.com>
References: <20191010151932.2716-1-emilyshaffer@google.com>
 <xmqqr23jhlud.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr23jhlud.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 02:50:34PM +0900, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > @@ -77,6 +77,7 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
> >  SP_ARTICLES += $(API_DOCS)
> >  
> >  TECH_DOCS += MyFirstContribution
> > +TECH_DOCS += MyFirstRevWalk
> 
> s/Rev/Object/ probably (if so I can locally amend).
Yes, that's the case, although I'll send a reroll shortly if you don't
want to amend locally - there's other stuff to fix according to you and
SZEDER.

> 
> > diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> > new file mode 100644
> > index 0000000000..7085f17072
> > --- /dev/null
> > +++ b/Documentation/MyFirstObjectWalk.txt
> > @@ -0,0 +1,905 @@
> > +My First Object Walk
> > +======================
> > +
> > +== What's an Object Walk?
> > +
> > +The object walk is a key concept in Git - this is the process that underpins
> > +operations like `git log`, `git blame`, and `git reflog`. Beginning at HEAD, the
> > +list of objects is found by walking parent relationships between objects.
> 
> The above is more about revision walk, for which we have plenty of
> docs already, isn't it?  Walking objects, while walking the commit
> DAG, is a lessor concept than the key "revision walk" concept and
> underpins different set of operations like object transfer and fsck.
> 
> Also, the object walk, unlike the revision walk, follows containment
> relationships between objects.

Good point; I'll rewrite this paragraph rather than trying to just edit
it a little for the next reroll.

> 
> > +A related concept is the revision walk, which is focused on commit objects and
> > +their relationships.
> 
> Yes, s/their/& parent/ perhaps, to contrast the two a bit better.
> `git log` and friends, if they need to be listed, should come on
> this side, I think.
> 
OK.
