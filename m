Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0371FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 10:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbcFPK5t (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 06:57:49 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:35784 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcFPK5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 06:57:49 -0400
Received: by mail-it0-f54.google.com with SMTP id z189so132666400itg.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 03:57:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CGYBLimnW/EdRx9L7wZBwDp3jL1TNzuIAagGPp8HwOs=;
        b=gCq9hNQumktcxobR5F1IZedjWQ7y/2I/qCUcgCxJsmgVai3RUHdCwZ6j2PAgjDt6Ab
         QiKDmR+Pee0M53WyMF3EvH92daULpkRNsIU02jyHyjSFFY9BWBUBzcOuyNJrc75ocM9F
         PHtXxJL+n1UqIytCvbDaqYQQAospoGtQeChfWFzmFQzPUL6IlBULOrGfUqGbd8gHKz6j
         nQNmuURIQqF9fx5pVcsbdrLfGOsqNQMoFlBg23Adg+xZ/imjGBBhGLomKrGa6CI1r1h5
         SBfCHtdiIB/XSrU+t278pw1I0uMFZhYmJUh4xLdjnRMKx+r4tJ8r6OKbBw/1GsyQc+Ub
         1c7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CGYBLimnW/EdRx9L7wZBwDp3jL1TNzuIAagGPp8HwOs=;
        b=YL6HQZYKZGZH71eQGzo/0g9q0EMtVG3yFtgXXILZ/hcP/batAMUS3Fk8t2ujb/GhLO
         dcTsEOj0m4nMg3RpdyoUPZwKjJClFvsbMi7KQhpCV7LhOngWFJxpu4ihbdOj7P0Fcem+
         V4cb7iV2KWqmvZbJGHiEcnbGLOWfiYSoNsgP527xCHWeZeSEy8RgNE4Eb3+xaMmLYToe
         3lby687mEH7lci240uVKiUrxIzB6+HoYRhRQfiPUV5U3fCaRjgjOkydXnM8sKGGVi67z
         tkccoTCUqNONQUZPwomK/nrlp3UaZlWawqOuXDGfZIcTvMgymxbqZhr8t96x0AF9M8Og
         r9BQ==
X-Gm-Message-State: ALyK8tKQpCTUXF3Z84h/3gCNreGV438b2JThdOwqia9js3aYldKyOVoY4pv8IG/jPwp5xxK2cVvEfECBQNFo2Q==
X-Received: by 10.36.123.199 with SMTP id q190mr1780051itc.42.1466074668086;
 Thu, 16 Jun 2016 03:57:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.173.167 with HTTP; Thu, 16 Jun 2016 03:57:18 -0700 (PDT)
In-Reply-To: <20160616094749.GA20681@hashpling.org>
References: <20160616065324.GA14967@hashpling.org> <20160616074709.GA24412@duynguyen-vnpc.vn.dektech.internal>
 <20160616094749.GA20681@hashpling.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 16 Jun 2016 17:57:18 +0700
Message-ID: <CACsJy8Bp6Mv2D1QCsR6MWhW2XMedo2svQKHBrx8AgA1Le56Grw@mail.gmail.com>
Subject: Re: [PATCH] grep: fix grepping for "intent to add" files
To:	Charles Bailey <charles@hashpling.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 4:47 PM, Charles Bailey <charles@hashpling.org> wrote:
> On Thu, Jun 16, 2016 at 02:47:09PM +0700, Duy Nguyen wrote:
>> I don't think revert is right. It rather needs a re-fix like below.
>> Basically we want grep_file() to run as normal, but grep_sha1()
>> (i.e. git grep --cached) should ignore i-t-a entries, because empty
>> SHA-1 is not the right content to grep. It does not matter in positive
>> matching, sure, but it may in -v cache.
>
> You don't think the revert is correct or you don't think the revert is
> sufficient? (I wasn't able to find a test case which proved that the
> change to line 399 was necessary, so perhaps I don't understand.)

OK insufficient.

> I would have thought that grepping the empty SHA-1 would be correct for
> with or without -v. An "intent to add" file has no content in the index
> so I would expect it to have zero matching and zero non-matching lines
> for any grep --cached query?
>
> Or is this an efficiency and not a correctness concern?

"git grep --cached" searches file content that will be committed by
"git commit" (no -a). An i-t-a entry will not be committed (you would
need "git add" first, or do "git commit -a"). So if I say "search
among the to-be-committed file content, list files that do not match
abc" (git grep -l -v --cached abc), the i-t-a entry will show up
because its fake content is empty (i.e. not contain "abc"), even
though it's not in the "to-be-committed" list. So yeah, correctness
issue.
-- 
Duy
