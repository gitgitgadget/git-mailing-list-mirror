Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B9C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DCB610CE
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhDBVhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBVhj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:37:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE49C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 14:37:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gv19-20020a17090b11d3b029014c516f4eb5so1309508pjb.0
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QPhiu3OjoLkm8NdseEMM9KoVcg7uLnU+TennWne3k/4=;
        b=gzTjZBMoHxvDDNJjIJP5AjqqwZhlb0D7WeQiGvBhxAvG4EjBBpcrwyMQFXt5BmYF3e
         7QrTixiJgZyrvkwy7Z17+CRmjXMezhSMuvD5ioFAETd4k0Ze3d4jbVY7/ts2+oZmyJ99
         mwMRu/fvsqcPMKLmvjwR9wOlLtDDXciz7iVTxaHSV9UN5ku/FiyKglpzfI2p2MWBJskz
         3orGGnnKFyu9jSil6LxWjmoJjUKMo+RYjCytPobl81Z7tLetL1nMNzT2fdUb9Bj++x4v
         d1oWHGqgd6VNMvaECoD/yFsCYZj2NM2OT/o32wHELhecnJ9HiNqXIv/fqiIzDPlzMlNk
         QLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QPhiu3OjoLkm8NdseEMM9KoVcg7uLnU+TennWne3k/4=;
        b=InR3Ap27fIFPdfZg+j3vF5lWQIrNuZNObuVcPK0ci3sU9XRHwZBu3XYsRuMQxqNNSo
         i7iPPpuYrtMYYuvuNVXKoXL62WPzUwLceIcfHs4x6ZKChfG3FZDNk0iT1MP6i2O2HoNC
         uKOJBGX1d7tnDzZAYOUCzk6kRHdvTQPq1BjECEREgM8NQhbWh3oMzEJC7mSyPENMPYMM
         wWbIQGT/g/WJR8uDhkitXk3hef3ZZNxw6c+56KFa1UbvS8hXulq520+/pmJVB/meIELl
         nkyneYNPzD02PMtyIVwGRvCeppZjB8zL7T6JgWfOEIro5nxnV16hBS+cXSJFBpgP0Jvm
         lrMA==
X-Gm-Message-State: AOAM533xvKQownVqCRQjrkIYURXzCdm2mUl1bMk3NN8TeG9lZS/b0x4U
        bsJrkMRamNPoKcl+yxGuS5s84g==
X-Google-Smtp-Source: ABdhPJweHMWXZToWAu6N32JJ+h94giynTo1Kskvlk5uU/K+05oPXSUBat4q0S4dGtI3bR2THe2gQbg==
X-Received: by 2002:a17:902:e312:b029:e7:3f29:c06d with SMTP id q18-20020a170902e312b02900e73f29c06dmr14516207plc.85.1617399457094;
        Fri, 02 Apr 2021 14:37:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:98b6:d0f8:7d1:479a])
        by smtp.gmail.com with ESMTPSA id gz12sm8970146pjb.33.2021.04.02.14.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 14:37:36 -0700 (PDT)
Date:   Fri, 2 Apr 2021 14:37:31 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] git-send-email: replace "map" in void context with
 "for"
Message-ID: <YGeOm+VNro9yofo6@google.com>
References: <YGTt2cNwq3BlpB7n@google.com>
 <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
 <patch-1.3-bea11504a67-20210402T112946Z-avarab@gmail.com>
 <xmqqo8ew2x1h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8ew2x1h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 02, 2021 at 02:31:38PM -0700, Junio C Hamano wrote:
> 
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > While using "map" instead of "for" or "map" instead of "grep" and
> > vice-versa makes for interesting trivia questions when interviewing
> > Perl programmers, it doesn't make for very readable code. Let's
> > refactor this loop initially added in 8fd5bb7f44b (git send-email: add
> > --annotate option, 2008-11-11) to be a for-loop instead.
> 
> ;-)
> 
> Will queue.  Thanks.

Oh cool, thanks both :)
