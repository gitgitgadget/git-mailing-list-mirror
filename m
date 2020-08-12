Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FADFC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383AD20771
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIg+7/On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHLWu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHLWu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 18:50:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23465C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:50:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so1784420pgl.10
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 15:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aqKaWD1SvaotC2G5FdIVLH6BcTqR4swf2FX/2iSK0iU=;
        b=XIg+7/OnIH5EIr/I723+c3xzvjJ/zsnASIFBgsT0j52/md+eQXkcrkudVIlTrizCHM
         s/LHBZ8C4Tneo35TgauPP6GtcaQYEEMTfzuGf7vt9ilRNteGpfIMl90NE4F+H65pYNsa
         n1hN11nY7Xs6VBQB1oFVXupxSdQFPYhN3xQXwQUYFwEzSBIWKNp4T+XT3MMdoAtlyTDp
         Q4SKhiMr2eZRryuddZKn0PjJ1ggmNnEKvBfr+a3NM0zT65wmbNMyLZMOs3AtWiGulKfX
         B0f605Z70sJVu2vCtIur6SUxGlgHruqNWfQnKAg0LY+PFdICNrCHedVadn1Q8I7l4SRN
         sAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqKaWD1SvaotC2G5FdIVLH6BcTqR4swf2FX/2iSK0iU=;
        b=TevMUeY8okn1iDxN4TSShJ6/qvZk1/P1ar7aCC5lZJG+5k1kxummSZp/2qWVdaW7lm
         Z/cKNHQFd4tClaGPmbG1h24QUtMfJ3C35SB3Vj8Xexsk7BgAJBHXKH+iIjSo1RIuRJLH
         rdR+ntLaOo/tkZnsaGQeo5pLC5DWfWDFTyuCOhBVqHmBmUTtBzLE74vb/lrO+A7PkIQs
         wRigvPnjLXBjU7p2CXLZ0A2Zj4FsFYhYyM/liP6kcNP0rFzUjFzIh6PqwBjfsh0sRlD4
         4303Yh/b71R4RCNEe1C6nGsaWJrudKvlbeRBjd49ZrN/yhnBFkHTzPZTbVH5Ie5xLN6D
         336Q==
X-Gm-Message-State: AOAM531TAP1utA+VtGBbxi2U6lOD7o1THikVmd8TIW1vzIu1MXsLsQF7
        KrNuhh4kWmdrjHQL+KT1fqI=
X-Google-Smtp-Source: ABdhPJwB+gPxAH+g7CTsO+SPlNctgpzr5fvSWCdUF/DVq0jm4yk8Zlb6lZd/vcgv50o0/VI1ipvLXQ==
X-Received: by 2002:aa7:9a09:: with SMTP id w9mr1648174pfj.206.1597272657304;
        Wed, 12 Aug 2020 15:50:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id u15sm3249485pgm.10.2020.08.12.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 15:50:56 -0700 (PDT)
Date:   Wed, 12 Aug 2020 15:50:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/11] maintenance: create basic maintenance runner
Message-ID: <20200812225054.GB104953@google.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
 <2b9deb6d6a23e53bec75e109f2e3ef9217420425.1596728921.git.gitgitgadget@gmail.com>
 <20200812210326.GA104953@google.com>
 <xmqqsgcr4ixo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgcr4ixo.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> +static int maintenance_run(struct maintenance_opts *opts)
>>> +{
>>> +	return maintenance_task_gc(opts);
>>> +}
>>> +
>>> +int cmd_maintenance(int argc, const char **argv, const char *prefix)
>>> +{
>>> +	static struct maintenance_opts opts;
>>> +	static struct option builtin_maintenance_options[] = {
>>> +		OPT_BOOL(0, "auto", &opts.auto_flag,
>>> +			 N_("run tasks based on the state of the repository")),
>>> +		OPT_END()
>>> +	};
>>
>> optional: these could be local instead of static
>
> Do we have preference?  I think it is more common in our codebase to
> have these non-static but I do not think we've chosen which is more
> preferable with technical reasoning behind it.  As the top-level
> function in any callchain, cmd_foo() does not have multiple instances
> running at the same time, or it does not have to be prepared to be
> called twice, so they can afford to be static, but is there any upside
> for them to be static?

Code size, execution time:

- benefit of static: can rely on automatic zero-initialization of
  pages instead of spending cycles and text size on explicit
  zero-initialization

- benefit of local: avoids wasting address space in bss when the
  function isn't called

Neither of those seems important enough to care about. :)

Maintainability:

- benefit of static: address is determined at compile time, so can build
  using C89 compilers that require struct initializers to be constant
  (but Git already cannot be built with such compilers)

- benefit of local: less likely to accidentally move the static var into
  a function that needs to be reentrant

- benefit of local: allows readers and reviewers to build the habit of
  seeing non-const "static" declarations within a function as the
  unusual case.  When a "static" is declared in a function body, this
  means we are caching something or have some other performance reason
  to sacrifice reentrancy

It's mostly that last aspect (saving readers from having to think
about it) that motivates my suggestion above.

Older Git code used static more because it was needed when building
using C89 compilers.

Thanks,
Jonathan
