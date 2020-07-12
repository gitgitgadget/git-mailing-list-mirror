Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC8C433E1
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 20:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F4C20720
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 20:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbnQmScO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgGLULH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 16:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgGLULG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 16:11:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8540CC061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 13:11:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so10949656wmi.4
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3Ok38qX0HDKWSfC28VyJxLlym+vx/r1HyvKAvsskjao=;
        b=GbnQmScOi115b/x+5ncu/s+MDfctoQdWE8gGeWBbS2ptbtrWqbPEqG+ilbjyD2hsfo
         glLX2uleV763xCSZGdJW5Cv3GJO8DBKF1BZmVWQniCl+EMBQFT9OwWZFHyCBIt5JlM5p
         6nddodBcAFyBenjkXN/pLwhQYHdmqFMy9A6NI4svg8VUhYO3P7KgWV1NNmLW4E5Vo6E8
         CsDQtAx9HJvKj8/1SJD0VgAD7NQ567AM4syiXEPM6kqw39cECBy4WqFw44KOywNZiMhv
         pDDlftR4vZ0KRh/aeDb8EWdPjN1Q+n0nMmWunxrUXe9hxxUuw904yTj73FDSMSrtoOvJ
         f18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3Ok38qX0HDKWSfC28VyJxLlym+vx/r1HyvKAvsskjao=;
        b=R+4xMrtFDdOEsZY6j38NHy5HLKHXv+RjACtudfF9Ele9CZOq5fU0WyYOWp8w28PY4z
         gIYCMZH4BIFScL5pNMl0oYxZ92xA8moQaqOjmvIwf2zv4Cf+8pJ6eo3zJs2JhScaSGNl
         B8iNq/Z6B3+2E6UsBHQK5m9h2keFWA9BnHrG8r8nF7MDzL+bA+hbUMoPG6nHEWS1Fj45
         ETpcdiRfR8nU/WUy6bLy+TQ5ARFwuAxTuP0lZMXlUo3q5vm8cwytWJYXdueZ3oXBoR5U
         AFcpJL0IrL/nvULFrb8+DBDQkk1KmuhaSHv6CxrYmS4RqKWpUT82UNkaN2BQPjcwfWum
         U3oA==
X-Gm-Message-State: AOAM533KuEPzWkK0oaSBmS7X+JCEK/GRJKKUYbiQBiRlYVt3oJomZZRi
        e3S5FAsi2+cAGkvRyQHYrPI=
X-Google-Smtp-Source: ABdhPJzzhpSHJPzAXAuBoPYnNd96IHFxNFq4HnjhwOQiJxyO6rin88McmWXdOTmauErvgCMtNWwFHg==
X-Received: by 2002:a7b:cd18:: with SMTP id f24mr16404394wmj.40.1594584665313;
        Sun, 12 Jul 2020 13:11:05 -0700 (PDT)
Received: from andromeda.lan (abayonne-651-1-46-3.w92-156.abo.wanadoo.fr. [92.156.151.3])
        by smtp.gmail.com with ESMTPSA id d81sm41972367wmc.0.2020.07.12.13.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 13:11:04 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:10:54 +0200 (CEST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v1 06/17] merge-index: libify merge_one_path() and
 merge_all()
In-Reply-To: <6f1427f7-29f3-ef77-b2a9-41264dc2fd32@gmail.com>
Message-ID: <alpine.LFD.2.21.2007122205480.4475@andromeda.lan>
References: <20200625121953.16991-1-alban.gruin@gmail.com> <20200625121953.16991-7-alban.gruin@gmail.com> <0e20fa12-4628-d1fe-fc6e-df83d26edda3@gmail.com> <alpine.LFD.2.21.2007121330130.17922@andromeda.lan> <6f1427f7-29f3-ef77-b2a9-41264dc2fd32@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Phillip Wood (phillip.wood123@gmail.com) a écrit :

> Hi Alban
> 
> On 12/07/2020 12:36, Alban Gruin wrote:
> > Hi Phillip,
> > 
> > Phillip Wood (phillip.wood123@gmail.com) a écrit :
> > 
> >> Hi Alban
> >>
> >> On 25/06/2020 13:19, Alban Gruin wrote:
> >> -%<-
> >>> diff --git a/merge-strategies.c b/merge-strategies.c
> >>> index 3a9fce9f22..f4c0b4acd6 100644
> >>> --- a/merge-strategies.c
> >>> +++ b/merge-strategies.c
> >>> @@ -1,6 +1,7 @@
> >>>  #include "cache.h"
> >>>  #include "dir.h"
> >>>  #include "merge-strategies.h"
> >>> +#include "run-command.h"
> >>>  #include "xdiff-interface.h"
> >>>  
> >>>  static int add_to_index_cacheinfo(struct index_state *istate,
> >>> @@ -189,3 +190,101 @@ int merge_strategies_one_file(struct repository *r,
> >>>  
> >>>  	return 0;
> >>>  }
> >>> +
> >>> +int merge_program_cb(const struct object_id *orig_blob,
> >>> +		     const struct object_id *our_blob,
> >>> +		     const struct object_id *their_blob, const char *path,
> >>> +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
> >>> +		     void *data)
> >>
> >> Using void* is slightly unfortunate but it's needed later.
> >>
> >> It would be nice to check if the program to run is git-merge-one-file
> >> and call the appropriate function instead in that case so all users of
> >> merge-index get the benefit of it being builtin. That probably wants to
> >> be done in cmd_merge_index() rather than here though.
> >>
> > 
> > Dunno, I am not completely comfortable with changing a parameter that 
> > specifically describe a program, to a parameter that may be a program, 
> > except in one case where `merge-index' should lock the index, setup the 
> > worktree, and call a function instead.
> 
> There is some previous discussion about this at
> https://lore.kernel.org/git/xmqqblv5kr9u.fsf@gitster-ct.c.googlers.com/
> 

Thanks.  If no-one seems really against doing that, I'll include the patch 
below in the v2, with an additional note in the man page.

> I'll try and have a proper look at your comments towards the end of the
> week (or maybe the week after the way things are at the moment...)
> 
> Best Wishes
> 
> Phillip
> 

Cheers,
Alban

