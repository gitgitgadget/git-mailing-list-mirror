Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F86A1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936563AbeFRTr4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:47:56 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:38257 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936040AbeFRTry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:47:54 -0400
Received: by mail-io0-f202.google.com with SMTP id g22-v6so14217521ioh.5
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=uhWTame3NrZHsVbQSke63+vLvJ6QV2lEv+ffPQpnMtI=;
        b=HHBTCDzJxW8d59AR7p2qa5Pu0dqrjk7juq+hEPlqR7GGfk2iFuLcKyzR9k/0U0+9X+
         dxaxskmXg3zo+B/R1u8ZMMyHw22COAAMoaL1XkCVmdxptBzd0BpF8VG/TuR0Tl45Ho3s
         7dZKfrQ0oOMM51bUPnZVXt9H8+P3iqD/epF5NwSSJTiHYESrGO1sxiBDC5sBi2p3ZlrF
         q9BSR9y8scSlSEqAFlp+ff9jiSRV3CgiNjchD9355sl2+oCSA6RG/ndzU8cRZlI93RgW
         mf36IPC+RINRheIofJu69oaxyCWqKC/uAVggk+bmfNaTZeWJonVeQI0PbIDQdO103CxO
         pbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=uhWTame3NrZHsVbQSke63+vLvJ6QV2lEv+ffPQpnMtI=;
        b=NkzrzT/bQ69IYRlChV+VXUKNy21NeF5B+JVpWMwMRTmIs9LWDECzaEXjkwaD5dZuiY
         5PVb/NnGFl8IvhmzKTrMAIfM1gNSqP1qEHdVosdcQ5DWduiCq229GZ25YyaN657YWKOP
         lqkhR+QYgsSXfw8vq2o2gaZEYTScQxWlSjteV6vcw7M1s6hRuwsWsN30RtV+w16A1lMV
         zEKM3XJ3yfV/elmL/3iD9pQEnp+rEfYyMi48wFi8eRCoySDmzDNt/N2PhVMxMc/5xsZ/
         3pdrLimddwnQiucCA4CmZWLymp+gjutbfr55xlghD7IvBxQbVKHZL+DQO4avQZ84FgN0
         6tKA==
X-Gm-Message-State: APt69E1j819Mt0sTU6aU37VgRO6btrNCQkpGIvXzTsouSyUtm3zvLtu7
        DFHhMoDoqRN5MQNsljD4DllZAowazHdbcuAv2yMU
X-Google-Smtp-Source: ADUXVKKhxCblRYNM8GXbgcXtLez3Amg1VNkANYa13DIyV8OEm0/WBBX4VbZ/V1XnkkDPJtAJZH7eB66Gv4l//rXKqyID
MIME-Version: 1.0
X-Received: by 2002:a24:b91b:: with SMTP id w27-v6mr5261779ite.41.1529351274141;
 Mon, 18 Jun 2018 12:47:54 -0700 (PDT)
Date:   Mon, 18 Jun 2018 12:47:50 -0700
In-Reply-To: <CAGZ79kbB0Tv8wb_7j0=OdQqGU78KHp3JzuCeD01JTF4EHwOH0w@mail.gmail.com>
Message-Id: <20180618194750.137341-1-jonathantanmy@google.com>
References: <CAGZ79kbB0Tv8wb_7j0=OdQqGU78KHp3JzuCeD01JTF4EHwOH0w@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> okay. Thinking long term, we may want to introduce a capability that
> can filter the tag space, e.g. "want-refs-since <date> refs/tags/*"
> as a client directive as then the client only asks for new (newly
> created/appearing) tags instead of all tags.

I don't think refs normally have a created/modified time.

> >  since tag refs are sent by
> > default now, the test has been switched to using branch refs instead.
> 
> That mismatches what I would expect to read below.
> I would expect the client to always ask for refs/tags/* now and
> instead of the server just giving them.

I don't understand why there is a mismatch, so I'll just answer all your
questions. Yes, the client indeed always asks for refs/tags/* now.

By the server just giving them, do you mean (1) giving them based on
what is being fetched, or (2) giving them as if refs/tags/* was sent? If
(1), this is possible, but requires the server to precompute all the
commits that would be sent (and this would be an overestimate, since
negotiation has not yet taken place). If (2), I think it's better to let
the client control this (since the client could just as easily want
--no-tags, then sending tags would be wasted).

> Oh, the problem is in that other test to restrict the refs/tags
> to *not* be sent?

The problem is that refs/tags/* is sent by default. Maybe adding
--no-tags would work (I haven't tried it, though), but I think it's
clearer for the test to just operate on branches, than to have --no-tags
and let the reader wonder what --no-tags has to do with what's being
tested.

> Maybe we can only ask for refs/tags/* if we do not have any
> "refs/tags/" on the CLI: if I invoke "git fetch refs/tags/v1"
> I would not get an advertisement for refs/tags/v2 but if I omit
> all tags from  the refspec, I'd get all its advertisements (v1+v2)

This would cause different behavior. For example, if I run "git fetch
refs/heads/master refs/tags/foo", I would expect tag following to work
even if the tag's name does not start with refs/tags/foo.

> > @@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
> >                 refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
> >
> >         if (ref_prefixes.argc &&
> > -           (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
> > +           (tags == TAGS_SET || tags == TAGS_DEFAULT)) {
> 
> Oh, I see. This always asks for refs/tags/ whereas before we only
> asked for them if there were *no* refspec given. Maybe we can
> change this to
> 
>     refspec_any_item_contains("refs/tags/")
> 
> instead of always asking for the tags?
> (that function would need to be written; I guess for a short term bugfix
> this is good enough)

Same answer as above.

> How is the tag following documented (i.e. when is the user least
> surprised that we do not tag-follow all and unconditionally)?

It's documented under the --no-tags option in the man page for git
fetch. I'm not sure what you mean by the user being surprised.
