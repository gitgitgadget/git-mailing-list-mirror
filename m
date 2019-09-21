Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A868A1F463
	for <e@80x24.org>; Sat, 21 Sep 2019 14:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393587AbfIUOV2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 10:21:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38422 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393568AbfIUOV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 10:21:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id l21so4098037edr.5
        for <git@vger.kernel.org>; Sat, 21 Sep 2019 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qcMeEbkwCYmY4j1ZZC1DJBQrbUMO32WFrZUfQq9Vops=;
        b=nhqXTVu2b8ssOJD2+CMGlAqwMZYt7y0dhEbUFebzz2EgYZ/U/OPLW7SwfFYrhjZTm1
         8WV84ZzkY6IDfU5NwG7tOojFgEB9fes0irrn/oEBY5sMNf++8JRj6MVr/w57KEqZcAIu
         WTLXurIhn4mvI0vVvfubdPhYE1eIHeeu8ME3bJkDCY6hLwcDiAGFTAB2Mpq55Kb0bda9
         uKOyCJYOuwfNfvtC3fuZAwTmRPd/NgU4914pJf/tduKw0dDYXzTjPJ0sOLbQyugR3/Lu
         0GAEnP2NVV5Yz3VNJBrHdRNNN7uAdSYor6xeJq4GRgLYz8Gr1g1AVrHvoANQQ22ui1KJ
         vEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qcMeEbkwCYmY4j1ZZC1DJBQrbUMO32WFrZUfQq9Vops=;
        b=CQXrNBIEaYD6k/T2jFlzsdtB5tflCss4lrXm4qP2Uf8a4jGrp3YY/WD4z7vvJzgUYz
         2C/v934mQo+C6+iVhs8Xrb3j0CgXEL2EfsIH49KNJVsvapwNrfdCvEqTMSgmoibfXj0s
         u6VyDqzJ366imLMpH0EiTkCT0XW9RKDrbFgejOzFVfUxi4M9GdvPRxcbdqdBvuZlqlc/
         fUI0ToqDdLuRJKoMQDIPALWUFE52LCff+W6YTEsGiAqGehTzzNARARYTBZap6FIx4opn
         ZhB5qu08XOlvJqWUZTeJdlOAi2seDAwO4sLtrl31ThacCiGcTs7ziLDpzxovEAVQWf3I
         rJFA==
X-Gm-Message-State: APjAAAXKoMck4f13PeLLA0bP2MueNMYZyQ1K25SHXwCTsx1HPNPM+cbf
        rjzVSgP/imokhdaME2lLVz8=
X-Google-Smtp-Source: APXvYqzo62nZsz1URLh6KF9tfKIGy1YgMPAiGi6BKC4F/8EUqWt5cw0G2JENlHtns2g1rYcaSzQRTQ==
X-Received: by 2002:a05:6402:1f4:: with SMTP id i20mr27678948edy.137.1569075686646;
        Sat, 21 Sep 2019 07:21:26 -0700 (PDT)
Received: from szeder.dev (x4db43ca8.dyn.telefonica.de. [77.180.60.168])
        by smtp.gmail.com with ESMTPSA id d13sm1050225edb.14.2019.09.21.07.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 07:21:25 -0700 (PDT)
Date:   Sat, 21 Sep 2019 16:21:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190921142121.GA10866@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev>
 <813f9deb-4448-ed4e-b124-5b85f1ca7147@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <813f9deb-4448-ed4e-b124-5b85f1ca7147@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 21, 2019 at 02:37:05PM +0200, René Scharfe wrote:
> Am 20.09.19 um 20:13 schrieb SZEDER Gábor:
> >>> @@ -280,12 +269,16 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
> >>>  	if (o && o->type == OBJ_COMMIT) {
> >>>  		struct commit *commit = (struct commit *)o;
> >>>  		int from_tag = starts_with(path, "refs/tags/");
> >>> +		const char *tip_name;
> >>
> >> This should not be const because you allocate the buffer it points to
> >> right here in the function, in each execution path.
> >
> > Marking it as const indicates that this function doesn't modify the
> > buffer where the pointer points at.
> 
> Right, and that's at odds with this code:
> 
> >>> +		if (deref)
> >>> +			tip_name = xstrfmt("%s^0", path);
> >>> +		else
> >>> +			tip_name = xstrdup(path);
> 
> ... which allocates said memory and writes a string to it.

... before assigning it to the const pointer.
