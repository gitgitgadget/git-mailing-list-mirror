Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF1F21F516
	for <e@80x24.org>; Fri, 29 Jun 2018 22:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936897AbeF2WUI (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 18:20:08 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36512 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936433AbeF2WUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 18:20:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so5081966plp.3
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2oVlk2x3nUvJU3cBxd9dfikBGhCW8ug6Qk0j5tbc7CA=;
        b=dlCb+WF3Kbqj2qPVwiAC/LDr5HGSCoGGuHc6N+qhdW+od38RmYVZJMuSH2gYJYj6gD
         M0O3PSx3ol9VSAiKdR82mGF7IMzjEn+zdeh5kXoK8ctPwASNtcJB1u2+UIbnzakLJyn1
         H7u1+eqbH0dt2uKGNKyDstli7JflbwBWoXNw7Vpgapll4aFxlnA3L6ZYC4FnpCIXvurR
         tpdks7faI3WOS6au3pHUO6XNhFPjQ0qK5QR1v8rG/8d89e6c68xS/KjqlOGyUAkyt3/W
         r/g+Ns5p7o5+pk0DEtKTnFwbytDDfa2NVDjeDS9z1wsKVXaXVepl3b7DP6OhrixffJKA
         q+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2oVlk2x3nUvJU3cBxd9dfikBGhCW8ug6Qk0j5tbc7CA=;
        b=fexeR1Zty5gtHluC73zul1RANc3fuc7RSyiLw7FxnnqNo0a8YFRzgMSoCQKM5EaeMh
         zpBblRGDv5sHIzvbAa3l++sDMNQW8CgcqftdU6uZ6nBxKpdfHj948yEZCdoJmEY/xsz0
         Z6k/F6l6UN52nx/tRH+5u/srhOMbN0LklJDzJ21clbxPpK5ngE0Ti+XnHh9yDvwHbcZO
         41I3wvN7Gcgx54EkwjD+vVawea3gwtOQrjzd+MRp12Bd4fIwspeNkBQbGaKoCVKz581C
         IgxqMk5Unnj0R6Pz1iKKHaRp/05s29g6v1nnb2El1MWH8GPNHFAP7knBs8I0E6zb5red
         1Ghw==
X-Gm-Message-State: APt69E38QLQLUXhj1As8RS6eqfeHOcWmFJX0HAjzAX+ZprmQNYIdS/rF
        2r//7y8aHeKyPSm7uiznFuVulw==
X-Google-Smtp-Source: ADUXVKLmCWZ8nbjqpst29IYZTHccgQGyxwGz6+BhofKNfdPjBqBq++s+c5UtvVn+NtM88CJWOLlFHQ==
X-Received: by 2002:a17:902:8a87:: with SMTP id p7-v6mr16426058plo.281.1530310806854;
        Fri, 29 Jun 2018 15:20:06 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id s12-v6sm14987854pfm.41.2018.06.29.15.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 15:20:05 -0700 (PDT)
Date:   Fri, 29 Jun 2018 15:20:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 00/32] object-store: lookup_commit
Message-ID: <20180629222004.GA197765@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
 <xmqq8t6xv5kb.fsf@gitster-ct.c.googlers.com>
 <xmqq4lhlv5a8.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kb=W5_3FB6qSinPpcPzRgAe-qkuOCkXTjs6RLqUTjoboA@mail.gmail.com>
 <xmqqvaa1tme8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvaa1tme8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/29, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > On Fri, Jun 29, 2018 at 11:03 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > One technique these (not just this) recent efforts seem to be
> >> > forgetting is to introduce "new" names that take a_repo and then
> >> > make the existing one a thin wrapper that calls the new one with
> >> > &the_repo as the argument.
> >
> > So you'd rather want to see it less invasive done similar to
> > NO_THE_INDEX_COMPATIBILITY_MACROS ? Someone (jrnieder?)
> > called that a failed experiment, as now we need to carry that baggage
> > for quite some time and never cleaned up the started migration;
> > only recently Duy started to kill off the_index, which would finish
> > that migration?
> 
> I do not think it was a failed experiment at all.  In fact, most of
> our code is still happy with the single in-core instance of
> the_index, and I think it is a mistake to trying to use the variant
> that take an istate instance as parameter just for the sake of it.
> 
> IOW, if there is a good concrete reason why it helps to teach the
> set of functions involved in a callchain to operate on an in-core
> instance of the index_state, passing an istate through the callchain
> is a very welcome change.  If you do not do so, and then just
> replace $foo_cache(...) with $foo_index(&the_index, ...), that is an
> irritating and useless code churn that harms other topics in flight.

I 100% think that we need to continue these refactorings with both the
object store as well as with the_index (removing the index macros and
removing the dependency on global state).  The whole compat macros most
definitely was a failed experiment as we still haven't rid the code
base of them yet.  Having two APIs which can be used interchangeably
from different pieces of library code which have very different
semantics is _very_ difficult for contributors to reason about and work
around.  Especially when one API relies on implied global state while
the other does not.  (If global state isn't involved, as in the char[20]
-> OID work, then having two APIs is 'ok' so long as you're working
towards converging to one API).

Having clean APIs makes it incredible easy to reason about sections of
code, reason about multi-threading, and implement newer features in a
sane manner (talking about submodules here).  I implemented submodule
support for grep twice, once using a multi-process paradigm because we
could not have two repositories open in a single process and then an
in-process one once a minimum viable solution for opening multiple
repositories in a single process was created.  Being able to open up a
submodule repository in-process made things infinitely simpler to reason
about as well as made it much easier to handle errors. This work needs
to continue if we want to improve the submodule experience in git.

Yes this might mean there are a few more conflicts when merging a series
(because of the scope of these refactorings) but it is well worth it
given what the end-state will look like.

-- 
Brandon Williams
