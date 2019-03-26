Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDBA20248
	for <e@80x24.org>; Tue, 26 Mar 2019 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfCZRhN (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 13:37:13 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48271 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZRhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 13:37:10 -0400
Received: by mail-qt1-f202.google.com with SMTP id 54so14270945qtn.15
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=48gj/lQeQlJHfGUJjN7/R2nz7csIo0YBAt6cRzi2QxA=;
        b=dktapl5xtOKRvQCFDFcPqix1PqO3FKI8LXDd1ytMqS0vM1DDfJs09vIWhbPBYnCsYx
         vtdOUULSys6MRvntUvvYKK8hBntT5ARl6SkfG14l7Qgb8WDBrClN4Yww+zRsq+o55rlU
         us0O0eqtI6RShXhx+auBsKep9yMBWItLzxjkxcpCaPFzb5XVAwR7KD/HmUf+g4pV2ZvE
         eITzane9WIZHDfDtTonxfAwbmq6amCG+JOYPUVsy8zGC5wm4//jG5eo93HcHrnj4rpYK
         e3VhrBK1/4kXtrv7mmQf6BUhiKL2XHi8Ns4lq0jyYT6ewQlB4SHW4WsBAPKdrNDudqll
         KCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=48gj/lQeQlJHfGUJjN7/R2nz7csIo0YBAt6cRzi2QxA=;
        b=C9ncgFPwsCoBYyOyzUGLxHVZAR+3NEXJhAMFMnckZoA12rnth0N2j7RzFMGw1P/k7E
         WoWTSVgQTXXHiaDq6NCpmCLhusaczPHcWpDyvmbt8aRE56kHTFzsBRuzvavAwS+JzNCK
         HHOPp+hJMoiRWxgK/Gq692KmNQxt3m8fpCDlPvWACblUjhgo1IXKnobIxsY0I5o8QK6L
         iJBxfwrc/5+KUMdIeSos4kkNwOukpCDZ/PQvVC+JZOpurADx1b8pB/Bq6uqMOpxwQrTg
         Z+aKlbn53SJDBHBLOvDIxbPPzhAODiVz4txUMrXd4VOzqR+rnK0leQ86PoHay/go8F7d
         nFGg==
X-Gm-Message-State: APjAAAUYSxnWC6ZZMOw9IZxzFUv7ItXbQOlEILRyWOw7yjbU7DbCgUOK
        gWepgx2kpxo5vlyWFKPjToTR80SkmxjqbrQKg2Uz
X-Google-Smtp-Source: APXvYqxlSgRPwn8Nd5MQouFoKR/r9ql3YH3dugHS8T8Hv1tVOqsHhoJAD8/vBhllxoUYcHTKaCqxQKxZkbhKktTVDq3I
X-Received: by 2002:ac8:f86:: with SMTP id b6mr27186801qtk.330.1553621830066;
 Tue, 26 Mar 2019 10:37:10 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:37:06 -0700
In-Reply-To: <20190326052011.GB1933@sigill.intra.peff.net>
Message-Id: <20190326173706.175638-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190326052011.GB1933@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: Re: [PATCH 2/2] fetch-pack: respect --no-update-shallow in v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Mar 25, 2019 at 01:43:23PM -0700, Jonathan Tan wrote:
> 
> > In protocol v0, when sending "shallow" lines, the server distinguishes
> > between lines caused by the remote repo being shallow and lines caused
> > by client-specified depth settings. Unless "--update-shallow" is
> > specified, there is a difference in behavior: refs that reach the former
> > "shallow" lines, but not the latter, are rejected. But in v2, the server
> > does not, and the client treats all "shallow" lines like lines caused by
> > client-specified depth settings.
> > 
> > Full restoration of v0 functionality is not possible without protocol
> > change,
> 
> That's rather unfortunate. Is this because the v2 ls-refs phase is
> separate, and that's when a v0 server would tell us about its shallows?
> It looks like in v2 it comes in a separate "shallow-info" section.

That's right. In v2, it comes in "shallow-info", which happens right
before the server sends the packfile.

> What would the protocol change look like?  Would we just need a
> capability to instruct the server to mark the two different types of
> shallow distinctly? Or do we actually need to convey the information
> separately (e.g., in the ls-refs phase)?
> 
> None of that matters for your patch here, but I'm just wondering what
> the path forward is.

Conveying it in the ls-refs would work.

> > but we can implement a heuristic: if we specify any depth
> > setting, treat all "shallow" lines like lines caused by client-specified
> > depth settings (that is, unaffected by "--no-update-shallow"), but
> > otherwise, treat them like lines caused by the remote repo being shallow
> > (that is, affected by "--no-update-shallow"). This restores most of v0
> > behavior, except in the case where a client fetches from a shallow
> > repository with depth settings.
> 
> That seems like the best we can do without the protocol change. And even
> if we adjust the protocol, we need some fallback behavior for existing
> v2 servers, so this is worth doing.

Thanks.

> The patch looks reasonable to me, though I am far from an expert on the
> shallow bits of the protocol. One thing I did notice:
> 
> >  static void receive_shallow_info(struct fetch_pack_args *args,
> > -				 struct packet_reader *reader)
> > +				 struct packet_reader *reader,
> > +				 struct shallow_info *si)
> >  {
> > -	int line_received = 0;
> > +	struct oid_array *shallows;
> > +	int unshallow_received = 0;
> > +
> > +	shallows = xcalloc(1, sizeof(*shallows));
> 
> This has to be heap-allocated, since we pass off ownership to "si"
> (sometimes). But in the v0 case, it comes from the transport's
> &data->shallows of a local variable in cmd_fetch_pack(), and we never
> free it. So I think this oid_array ends up getting leaked.

Thanks for the catch.

> Perhaps it's worth passing down the shallows array we get from the
> caller of fetch_pack(). Something like the patch below (I think it is
> never NULL, which means in your patch 1 you can simplify the conditional
> for the BUG).

[snip patch]

You're right that it is never NULL - I have removed that check. As for
passing down the shallows array that we get from the caller of
fetch_pack(), that would get confusing because we end up modifying the
shallows array in some code paths, and the transport is sometimes reused
(for example, when backfilling tags). I have instead made a
shallows_scratch variable in fetch_pack(), and made it pass it down
(like in the diff you provided).
