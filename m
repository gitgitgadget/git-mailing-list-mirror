Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D53C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33110208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbgJMGiY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Oct 2020 02:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389433AbgJMGiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 02:38:24 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33820C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 23:38:24 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 261983AB1AA;
        Tue, 13 Oct 2020 06:38:24 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 1496E16008A;
        Tue, 13 Oct 2020 06:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id DF525160053;
        Tue, 13 Oct 2020 06:38:23 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xBCLSA3xZg7R; Tue, 13 Oct 2020 06:38:23 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 01EB116003E;
        Tue, 13 Oct 2020 06:38:22 +0000 (UTC)
Date:   Tue, 13 Oct 2020 08:38:19 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
Message-ID: <20201013063819.GE3278@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
 <20201012091751.19594-3-michal@isc.org>
 <xmqqk0vvnrcb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0vvnrcb.fsf@gitster.c.googlers.com>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +	/* see Documentation/diff-options.txt */
> 
> This comment adds negative value.
> 
> If it were
> 
> 	/* "-I<regexp>" */
> 
> the readers won't have to switch to the file only to find out that
> the comment didn't tell them where in the file to look at. 

Agreed, thanks, I will fix this in v3.

> > +	regex_t **ignore_regex;
> > +	size_t ignore_regex_nr, ignore_regex_alloc;
> > +
> >  	const char *single_follow;
> >  	const char *a_prefix, *b_prefix;
> >  	const char *line_prefix;
> > diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> > index 032e3a9f41..883a0d770e 100644
> > --- a/xdiff/xdiff.h
> > +++ b/xdiff/xdiff.h
> > @@ -79,6 +79,10 @@ typedef struct s_mmbuffer {
> >  typedef struct s_xpparam {
> >  	unsigned long flags;
> >  
> > +	/* See Documentation/diff-options.txt. */
> 
> Likewise.

I will fix this in v3.

-- 
Best regards,
Michał Kępień
