Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143D12027B
	for <e@80x24.org>; Thu, 18 May 2017 04:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbdERETe (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 00:19:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33813 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdERETd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 00:19:33 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so4218310pfk.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 21:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NLMLijX6jTGVBE/dT44p5LLHpYqP8xhXfkip+qj/eE8=;
        b=o5nHfg2Z0n57n8TFrgM5aeCMLdnc3+wBM49DcOiS1JKzRWdxq2aOPtJjgpQe/A6Vw3
         Q4n8omH0jRud1PmK8Enq254KiCFM2BYqD1s5A/pM6Nl7UNt9zTr7eV7CtLVve+nLpWD5
         0wc1Uw+LgA7rqm3w0qpaGlzVBQH76G7y+1hY3ulyM9PjFy+HEezL2IlGv/hng6Q4pk/b
         UOuoP/+h5imkGVUO++keVb1NM8YOFzpr5a4yrzRjbJFp0dX8dlW5IjCiLAtO99hdXXhR
         rDxODRiM5z7p5GGInsdf8t1n54ml8dgBivW39LEGYh0IyT1WbKAUQjj9RJnZKTv/TsYD
         AMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NLMLijX6jTGVBE/dT44p5LLHpYqP8xhXfkip+qj/eE8=;
        b=ZjVjEp8CewbVBZRS+I5FvrF6RkhWWAu/qYw3XMnBkHBVNfd7SdJcufCspCaVI3hxZe
         u7McGKolEBSuSFCgjTygzovvJYGA4BWaTJ7GFCP0Y8tprF8MUVOnx5WwQPFgVAS5wY1V
         Pq6kf20Uane12HJDGrGjul27uLHM4E2lZ55/TqWt8DT+xdCXbxOlaR6oKwK5t+h9CaWp
         kkTe34LvZG0pFfIDXA+ZUQuCs9TfTF9Eas6tVVVTgjHpPnRMQBdchSE3dLONjQno41iQ
         Vfe0iyTPGVPJpMCn6MYoYvbqx83bdsV0jGg5m1S849/vWtNsUJRsJXlLI0x+KtKh6buR
         XBUg==
X-Gm-Message-State: AODbwcAMJYVLdq6Ucp2avxLLrGZYNpw3YrpDFnKUK4jllR2wdwySVgG8
        JoyVM9nWM94fEA==
X-Received: by 10.99.141.76 with SMTP id z73mr2237933pgd.118.1495081172532;
        Wed, 17 May 2017 21:19:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id x12sm7006594pge.60.2017.05.17.21.19.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 21:19:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 04/23] prefix_ref_iterator: don't trim too much
References: <cover.1495014840.git.mhagger@alum.mit.edu>
        <eecc015af8d7ed71223b591b13847fdb56ee69f0.1495014840.git.mhagger@alum.mit.edu>
Date:   Thu, 18 May 2017 13:19:31 +0900
In-Reply-To: <eecc015af8d7ed71223b591b13847fdb56ee69f0.1495014840.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Wed, 17 May 2017 14:05:27 +0200")
Message-ID: <xmqq1srmvlt8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The `trim` parameter can be set independently of `prefix`. So if some
> caller were to set `trim` to be greater than `strlen(prefix)`, we
> could end up pointing the `refname` field of the iterator past the NUL
> of the actual reference name string.
>
> That can't happen currently, because `trim` is always set either to
> zero or to `strlen(prefix)`. But even the latter could lead to
> confusion, if a refname is exactly equal to the prefix, because then
> we would set the outgoing `refname` to the empty string.
>
> And we're about to decouple the `prefix` and `trim` arguments even
> more, so let's be cautious here. Skip over any references whose names
> are not longer than `trim`.

Should we be silently continuing, or should we use die("BUG") here
instead, if the motivation is to be cautions?  Personally, I do not
find this memchr() implementation too bad, especially when our
objective is to play cautious, but strlen() based one is fine, too.

It's not like refname field would point at a run of non-NUL bytes at
the end of the last-mapped page and taking strlen() would segfault,
right?

> +		if (iter->trim) {
> +			/*
> +			 * If there wouldn't be at least one character
> +			 * left in the refname after trimming, skip
> +			 * over it:
> +			 */
> +			if (memchr(iter->iter0->refname, '\0', iter->trim + 1))
> +				continue;
> +			iter->base.refname = iter->iter0->refname + iter->trim;
> +		} else {
> +			iter->base.refname = iter->iter0->refname;
> +		}
> +
>  		iter->base.oid = iter->iter0->oid;
>  		iter->base.flags = iter->iter0->flags;
>  		return ITER_OK;
