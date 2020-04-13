Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59404C2BB85
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 00:47:48 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1079F20709
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 00:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lRdHYI0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1079F20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDMAr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 20:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgDMAr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 20:47:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9FFC0A3BE0
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 17:47:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k18so2833768pll.6
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 17:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zLsc4uwT6nE6meJtlCRnRlmJMt5T9E5dLMZR8BUs8ZE=;
        b=lRdHYI0E/pHuNn+Pd4Epw8j5iO31TmiKbov03e6jSHn5Bz8IYtet4jFCnu111+lv9p
         mxuEan50ARdLHpWj4h1mzw+jrhBXPWKwzulX4ly1d6vDVGTbPNoYB57H72HUpONYB/zo
         esrquuYA+9x38zkvstywN7SNhUeW17K0tc2jpCJeG56uRLV2/aGgtvSGRK7wemihQ2R1
         FFR6875GjHkE6oMhCKZI3ieFVCZWPYmUlswzDQY4Un0Ei1YXzenqfFLzw+uor0l5cKv/
         PvrKV2z5cTFU0iyv1h8VEdboK4hPJ5cWI4aTBVl0Zd1rcPFjAF7R+35yArlp5tSkh+tJ
         lmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLsc4uwT6nE6meJtlCRnRlmJMt5T9E5dLMZR8BUs8ZE=;
        b=lNaXl1WHh0kaENGHRPsOoOltkHdqyYHm4I695KMZzkEHst2Tgm/8o1h6chEeBabEI4
         cR2xpoSBzNhQm2JhWOREb161Tbmr1yOAc8EQ4tclDrHQMeYwfa5LK9UHgfPcKwwU1FW9
         cKu4YBtbD1I5c0p8OgG5cm4wi96DZiZWLma2EmgsQXq/kGtc5dsjKLdjiXy3iVKQp0HF
         x2C3Gk487CqkulZfTPkvdpwX1BYCsSlTa97uagdW4+mkoLu3yzGxmDduhERdoVTw9+tH
         Lbn3T0ShMM6//nuAKwkbBSVQJck1iGNiwvN9LDj6fD2R44DF2UY9VcCIQ3SAv5o40+Bm
         Qz9A==
X-Gm-Message-State: AGi0Pubc1NDTRrZN7z7z7ZRDO+sUMT2wbWgMwfXgiHaYq1/7WYYNIExx
        3Ph8VgLP6gIbuLbLHCSTzK+4DZ5YSUFZkg==
X-Google-Smtp-Source: APiQypJjUD4Lx2d8HfgZQIo87tvR4X8xaE1TnAH4BcPzGm0Dti83ULln+wMVH6f+ZTWf7Ueln4T+fw==
X-Received: by 2002:a17:90a:c392:: with SMTP id h18mr19098975pjt.89.1586738845900;
        Sun, 12 Apr 2020 17:47:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 135sm6179628pfy.60.2020.04.12.17.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 17:47:25 -0700 (PDT)
Date:   Sun, 12 Apr 2020 18:47:24 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] config: reject parsing of files over INT_MAX
Message-ID: <20200413004724.GB55122@syl.local>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
 <20200410195007.GF1363756@coredump.intra.peff.net>
 <xmqqzhbjgfps.fsf@gitster.c.googlers.com>
 <20200410221549.GA2078378@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410221549.GA2078378@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 06:15:49PM -0400, Jeff King wrote:
> On Fri, Apr 10, 2020 at 03:04:31PM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > So given the fact that these are insane cases which we have no need to
> > > support, the weird behavior from feeding the results to printf even if
> > > the code is careful, and the possibility of uncareful code introducing
> > > its own integer truncation issues, let's just declare INT_MAX as a limit
> > > for parsing config files.
> >
> > Makes sense.
> >
> > > +	if (c != EOF && ++cf->total_len > INT_MAX) {
> >
> > Would this work correctly if size_t is uint?  Sure, as int-max would
> > fit within it.  And of course if size_t is wider than uint, there is
> > no problem in this comparison.
>
> Good question, but yeah, I think it's right.
>
> Another method would be to do:
>
>   if (cf->total_len >= INT_MAX)
>
> _before_ reading any character. We'd have to remember to increment
> total_len then (I suppose we could do it preemptively; as long as people
> don't try to read EOF from us over and over again it would never move
> again).
>
> I also considered making the limit much lower than INT_MAX because
> really, who needs even a 1GB config file? :)

;). Making it lower than INT_MAX moves us into the territory of deciding
what is an "appropriately" sized config file, which I'd rather not do.
At least we can blame INT_MAX if someone has a too-large config file.

> -Peff

Thanks,
Taylor
