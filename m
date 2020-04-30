Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6313DC83003
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DA72082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdTwrtxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgD3DTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726357AbgD3DTx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 23:19:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9DDC035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 20:19:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so1729674plr.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 20:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wB4dvab+gA/j13tf4gF2pOMyrY4w79T3fBxBLtn09f0=;
        b=YdTwrtxFhkqVwXHSAqCVWD7ysUSuFumjr0iCqcL5Klh50BFQ2qks2HBtRYTouxrUAr
         KptO9POhjxACgXnDLt3DfJVV8bwEMJQBHyn5QluroIcNftSHcyGAky4JJ2zkkX16zBNq
         /e/YnJGw+fG41c8V46fiSpTQwWuHWTgMJFDTGr3LIMgj2XYy89oN3EHykwD+Cuub++QP
         YVw36qEhgH86UcYuajSTXiKbYFQ4FlrYyUwrMwgsvVNCxr7TpG/z67a7SU3AN6A+uzEj
         K/lHMZGP/bhut/QFYdpUfmzSFF7WBs+hIRd6W5SV/LPH+aDUjtyYLroF1JX6HjbVt61S
         dxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wB4dvab+gA/j13tf4gF2pOMyrY4w79T3fBxBLtn09f0=;
        b=ZveJ26omwAJ3+rwiLodQLNSk6+7dyEbvCHPuZFlmurkITMITZl1NdUvh+cy1ESzB8D
         I7L8vWzFjRlVrVWy6sfO+Z5dxI12yk2U3ebf+qthqGJJQk5NJEks/eqeY/YvS8Di9IrC
         37a6QF6UcCTZG4knWigNkNlXtwjAJSFRS6pkHO3KSY0nFmEc9U1K+y9pqqX3xMqbrvkh
         f/nmOrtkCSt5t35q+Mdm/Li/tCE70GGr5nhyDDVBFQSR6jJmwzOGeuNB/203oHvfu2sg
         /cN68Yr+LXfJvvkpHq8syKvF7+aW5A1AecQEBLGxCxsOs7VHkJ9hARM9vE+0BgM/WxO8
         jrqg==
X-Gm-Message-State: AGi0Pubi/vBdxPVLHW+Y2Z27VITrCrB8VJujAYOMbxI8wU+1CDCzvaSw
        eqbu/v/pX285MsL7or4bAk4=
X-Google-Smtp-Source: APiQypJbJGYizBowqWJGbwCP6v3ezzOjvmJxYCJvzCNg3W24XYelSCUjk9fC3R4CqjhL0LdG/82MSg==
X-Received: by 2002:a17:902:ec04:: with SMTP id l4mr1683585pld.6.1588216792616;
        Wed, 29 Apr 2020 20:19:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i15sm2133255pfo.195.2020.04.29.20.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 20:19:51 -0700 (PDT)
Date:   Wed, 29 Apr 2020 20:19:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH 2/5] shallow: extract a header file for shallow-related
 functions
Message-ID: <20200430031949.GE115238@google.com>
References: <cover.1588199705.git.me@ttaylorr.com>
 <0b93abe072aa35ab96ba3b97118caa8ffe8e439d.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b93abe072aa35ab96ba3b97118caa8ffe8e439d.1588199705.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:

> There are many functions in commit.h that are more related to shallow
> repositories than they are to any sort of generic commit machinery.
> Likely this began when there were only a few shallow-related functions,
> and commit.h seemed a reasonable enough place to put them.
>
> But, now there are a good number of shallow-related functions, and
> placing them all in 'commit.h' doesn't make sense.

Sure.  For me, there are a few additional sources of motivation:

- shallow clone is a bit of a thorny feature, so I like having the
  indication of which source files are interacting with it

- this will give us a good place to put any overview documentation on
  the shallow API

> This patch extracts a 'shallow.h', which takes all of the headers from
> 'commit.h' for functions which already exist in 'shallow.c'. We will
> bring the remaining shallow-related functions defined in 'commit.c' in a
> subsequent patch.
>
> For now, move only the ones that already are implemented in 'shallow.c',
> and update the necessary includes.

It's probably worth a mention of the builtin.h part here.

(By the way, I wouldn't be against propagating that to the callers,
to better match what https://include-what-you-use.org/ would enforce.)

Thanks,
Jonathan
