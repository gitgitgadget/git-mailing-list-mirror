Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC39C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 03:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345B020789
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 03:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUlAWRBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393935AbgJPDFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 23:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgJPDFX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 23:05:23 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71728C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 20:05:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r10so539085pgb.10
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 20:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7m5GoB1FvabU+rFeq4ujUJpJqT2pDOIzuMLhfUgjRY=;
        b=gUlAWRBX4z1QXa0XfekwOx4+mm9bFDF0BT4QkzI8nc4rAxM6IOAlWT7gD+IiqST6tm
         W9U/V811xEXoukA4s3WvLfGQN04jtqJSRTy9IHmob8RlnC3WrCHLFi1AN5WMonJS08n0
         uQaj8zwJorYQ6pJcUYAF31yz65+L4JWYNSO/imXwUzdeWGoZVICD+yefa2+pClbzfuHN
         2f277fM3R9ZIp6hogU8VETkh8og0L5rFwkFKX40Cdc2QnKOrNJeJxVygu3EQfjZMmBPq
         72/Q7mS8RmCjbp4ZKRnB0eznUG7AHozoMtdV1cqe3DcHLzzm+vVEfVtj/SBblPjcah25
         HkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7m5GoB1FvabU+rFeq4ujUJpJqT2pDOIzuMLhfUgjRY=;
        b=jGRfvGpviU0wSASfS1WhfC6WOZicjl1G+NNntenof8hP3oypwD7lmQPqvVseFg1jaA
         GxPnTu0Gll8nz4ypsxXDtMOT5DBOLVUS3UkEg/sCn7cxDgPYMlOrUIN877LkYCz4bw7J
         Klo59FKPRnzDm2RS87DFXP+kmeFvxubKVEwOerzxmozqzu1v15zTRwqmcOf7o+ITIvPP
         7SBFPai+wsqOqK6fL+kPfbPoUTDaM39WISIk0+6JxdXWnZ5a9lzHltif0wNcOd894qr4
         ZIHkHR/i5nGiVqPlfLKKnHVwIHQkdRa0BTJB321EqaGWBQ8s6GPLvS7hW9b6bjVAI6Xp
         HqHw==
X-Gm-Message-State: AOAM532EEjOu41QjLt3jDxe/J2DV+gNbx6wl8Zn6oTJiqYGRswFQol8S
        U4FkOTblvwPEVB6d/CTp4ms=
X-Google-Smtp-Source: ABdhPJzTsJUwAVEBVE5+h3Bmgqa7hYpwlXrlpZnM4YLlze/ylOEcmoUIOw2twCbJTJYVoRYJC0Kc5w==
X-Received: by 2002:aa7:9f8d:0:b029:152:28de:812a with SMTP id z13-20020aa79f8d0000b029015228de812amr1652377pfr.65.1602817521717;
        Thu, 15 Oct 2020 20:05:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id kb15sm733935pjb.17.2020.10.15.20.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 20:05:20 -0700 (PDT)
Date:   Thu, 15 Oct 2020 20:05:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Amanda Shafack <shafack.likhene@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>
Subject: Re: Introduction - An Outreachy 2020 Applicant
Message-ID: <20201016030518.GE539114@google.com>
References: <mailman.1.1602590401.25101.wireshark-dev@wireshark.org>
 <CAGxm6oUcxLCqhN0+tSA37xsNUJbjcyj3ahraVdiwxnQn-7qC4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxm6oUcxLCqhN0+tSA37xsNUJbjcyj3ahraVdiwxnQn-7qC4g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Amanda,

Amanda Shafack wrote:

> Also, regarding my initial starter contribution, I chose the
> "micro-project" titled "Avoid pipes in git related commands in test
> scripts" (source https://bit.ly/3iZQcT2).

Thanks, sounds good.

> I plan to complete the micro-project and then move on to more research
> on Git's HTTP protocol and other resources you've pointed out.
>
> Let me know your thoughts on this, thanks.

I think that a good next step after the Git micro-project is to get to
know wireshark --- this would involve building wireshark, finding
something to change, and then changing it.

https://gitlab.com/wireshark/wireshark/-/wikis/Development/ describes
how to download and build wireshark.  Then for something to change, I
have a few different ideas:

a. tighten the error handling in epan/dissectors/packet-git.c
   (for example, what happens when there are not exactly 4 hexdigits
   at the beginning of a pkt-line?).  Git's
   Documentation/technical/protocol-common.txt describes the pkt-line
   format and Documentation/technical/pack-protocol.txt describes the
   Git transport dissected by packet-git.

b. add tests for the Git dissector.  test/README.test and the page it
   links to describe how wireshark's tests work

c. try to parse out the service name and protocol version in
   epan/dissectors/packet-git.c.  Git's
   Documentation/technical/protocol-v2.txt describes where we can find
   that information

That would get us more comfortable with the wireshark codebase and
would help prepare for fleshing out a plan for the internship.

Thoughts?

Sincerely,
Jonathan
