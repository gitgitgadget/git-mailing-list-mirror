Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D783EC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 05:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02B6207EA
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 05:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omF09as5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgICFo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgICFo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 01:44:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16970C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 22:44:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ds1so954809pjb.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 22:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyyjErVAds/X5ZPEQcHWJS/iNjxSZsGZ90djNE05QiI=;
        b=omF09as5Ed7lMKs807J4RSSnPt5EY/+Ro9XAEL6Kyf0mMzNGWdGZggDAmfwoiaIHhF
         4I+1FCMCn2wsz7FBa0Qd15jp75XlLktP2e7R6mJCZKkmTpidfTl6rmNHjBtjCHflMVdR
         ZBae2uGzArq71NofTr2OE3AA/go39epCaLvn5YGH76rlK3fIw1+B0vvdy4OTSQGpCi+z
         mhBOiHfE70uIhtWXNiC7hlXQXbDHPoFGsV32eKvxCdudMFjPFv0xeI49+Pcmb+IJ8DEU
         J3oGLheG9F+VcoMsD6mA5bbgRLB5abX5rn2Ae52U3kTvOLFd1S0pgTeGL9qrG/PI2Om2
         kDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyyjErVAds/X5ZPEQcHWJS/iNjxSZsGZ90djNE05QiI=;
        b=XwLla2c+DlraNzsvgL30kVzt6VmrsNPKgoi/KhNObdc4uEsbVH511q/yTaIQwF+khl
         9D4DdEc0dX+LbWZLKTDZQl13MphNFVM5RrR6W/aWkuvEJpF0cKEw84bEhC3M7sWw+3lB
         u5KP9dxsMwx31c2GuLH0A+Cer3DUQ1RZLYZzjMhcsrqom9aVba825HhW5enX2Sxd0/do
         YsJB02DjYwqwGJ6ewl+2buIf0MtUv2KHV134LFKRQIoHy7vDnLB45k3o0cCdTaIgc9Rs
         58X92O81U4UMKC9BT+IetSfgWMCS8uNGbUgW780kXlNEi1Qa7mzrRnItQ1WwY+4NBSWL
         tMnA==
X-Gm-Message-State: AOAM533s5wdv4XaypQWUII8CKms5jVpyPIcaYrojz6vWsYyOG0ZhtZm+
        mhHNi/64qtFuHWgbojcPML4=
X-Google-Smtp-Source: ABdhPJzFyI/fmKBboWQn44UaSZEYjQVChIkQHfjnDw6y50j8G67iqeTesITNh9C/lE7Gqo/aGgif2g==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr1631420pjt.68.1599111865152;
        Wed, 02 Sep 2020 22:44:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id p9sm1446378pfq.112.2020.09.02.22.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 22:44:24 -0700 (PDT)
Date:   Wed, 2 Sep 2020 22:44:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hanwenn@gmail.com,
        hanwen@google.com, git@jeffhostetler.com, stolee@gmail.com,
        Jeff King <peff@peff.net>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] RFC: refs: add GIT_DEBUG_REFS debugging mechanism
Message-ID: <20200903054422.GG4035286@google.com>
References: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
 <20200902174939.3391882-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902174939.3391882-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+Peff and Josh, trace experts)
Jonathan Tan wrote:
> Han-Wen Nienhuys wrote:

>> This should be integrated with the trace2 sub-system, and I would appreciate
>> pointers on how to start.
>
> The trace2 subsystem seems to be designed to detect errors coarsely
> (e.g. by looking at process invocations) and log timings. It currently
> doesn't seem to be made for this kind of fine debugging information -
> and perhaps this is by design, because such logging information would
> not be useful to most users and would just clutter up the logs.
>
> But I think there is a place for this in Git - in particular, we have
> packet tracing (GIT_TRACE_PACKET), and this has been useful both in
> automated tests (t/????-*.sh) and in manual tests. Ref backend tracing
> seems to be similar. But this would be best if we had an additional
> option that could control whether ref backend tracing was on or off,
> independent from other things like the trace2 target.
>
> Is the plan to migrate all usages of "trace" to "trace2" or for both to
> exist simultaneously? If the latter, then ref backend tracing could just
> use "trace", but if the former, we'd have to designing this additional
> option.

Here's my not-completely-thought-through take:

trace.h defines a convenient and simple API for unstructured traces.
You can define a key

	static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);

and then you have available

	trace_want(&trace_refs)
	trace_printf_key(&trace_refs, fmt, args...)
	trace_strbuf(&trace_refs, data)

and so on.

One use of trace_printf (i.e. tracing without a key) is to print lines
for important events like starting a subprocess.  For those, trace2 is a
natural replacement, with the advantage that the resulting event is
associated with any enclosing trace2 regions.

One design goal of trace2 was to be able to replace the original trace
subsystem completely.  Its output routines are flexible that it should
be able to produce GIT_TRACE style output.  It should be possible to
implement a trace_printf style API on top of trace2.

For ref tracing, do we care much about the human-friendliness of the
output?  Do we expect this to be useful for debugging once reftable is
more established?  Is it something we'd want to extract timing regions
from and use for performance improvements?

For ad hoc debugging, the structured tracing features of trace2 are
not all that important.  So if using the trace_key API is simpler,
then for that application I'd say go for it.  Some day we could
reimplement that same API on top of trace2 (or use a coccinelle
transform to a similar API) and your could would still work. :)

For producing logs that get aggregated, the structured output of
trace2 tends to be quite useful.  Event tracing doesn't have a notion
of setting which subsystems to trace on but it would be a natural
thing to add.  See TR2_SYSENV_CFG_PARAM for an example of configurable
"what to trace" information used by GIT_TRACE2_EVENT.  Happy to
provide more advice if this seems applicable for the problem at hand.

Summary:

- if this is only going to be used for tests and for ad hoc debugging,
  I'd suggest sticking to the simple trace_key based unstructured
  tracing API

- if we expect it to be something we want to aggregate over many runs
  and query, then structure becomes more important and trace2 starts
  to pull its weight

Thanks,
Jonathan
