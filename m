Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56D61F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 17:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJaRMX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Oct 2019 13:12:23 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42428 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfJaRMX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 13:12:23 -0400
Received: by mail-wr1-f53.google.com with SMTP id a15so7094627wrf.9
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 10:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3/5Xdg9NhlmzCRNlui7wT9xM+C+nliCDFDTWaW+jsAQ=;
        b=a3SLg2d1E3t3S8NRT/t0GGD0quz04WY9Su+9R1SQthPfFOAZjOZzyNeMBmUHdqku4z
         O7SvGfrBIVFhLJg7pE8hCxJiAmogdBI4pMHIKlI2w1FOSLAs3yBzTqaaA06rFqCguZoS
         FwXVtrPYIrfiIE/cDibq+ziLsDLsQIsFJNKISHK97OcFrhWIYiJLriks281xFumMissR
         vYuwd/qu+k3JPywgRJoE6ey5NjvHSgpD10t1YzfBoge5hnhnVZsvTe002/iRFSItRtRI
         zpLje5FJVQR2lzRXkLhimdKsQebw8M8y76tmeaBMIa9FbZeAI7l0g8S0QGBJCudyHPtZ
         XJkA==
X-Gm-Message-State: APjAAAXGISj4ICcLeD6OIW06qw+IsioOVn1yLZzwaDzyxxhe6CI15cMw
        m0N1hynM7Rd2zUrOvgO5j5iBGcpfYDAckXYEqZ0yFTmd
X-Google-Smtp-Source: APXvYqzZzKBo+fq3GDLDYH+/VNX/Gbthr/Y7Eq8P/HN2V7re+GeiNC4gLeQ1+QU54rvvCcREYqG29/A06L+wCKfL47c=
X-Received: by 2002:adf:f989:: with SMTP id f9mr6615886wrr.163.1572541941617;
 Thu, 31 Oct 2019 10:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191031092749.074ed112.olaf@aepfle.de> <20191031101539.GY4348@szeder.dev>
 <20191031142118.747693c1.olaf@aepfle.de> <20191031165632.GA4348@szeder.dev>
In-Reply-To: <20191031165632.GA4348@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Oct 2019 13:12:10 -0400
Message-ID: <CAPig+cTNq_gPxECZks7sNde4Q758Vixgpy9eL2B3xrKO-O+qNQ@mail.gmail.com>
Subject: Re: git fsck, badDate: invalid author/committer line - bad date
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Olaf Hering <olaf@aepfle.de>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 12:56 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> All the usual warnings about rewriting already published history
> apply.  The hash of a couple of commits from 2009 might seem
> irrelevant now, a decade later, but after correcting those author and
> committer lines the hashes of all subsequent commits will inherently
> change as well.  This is, in general, upsetting for everyone who have
> cloned the repo and built their own work on top.  Furthermore, some
> commit messages refer to older commits by their hash (e.g. in
> 431dbd98ba: "Simplifies and updates commit
> dbef8dd3bf00417e75a12c851b053e49c9e1a79e"); those references will go
> stale after rewriting history, unless you put in extra work to update
> them.

For completeness for future readers of this thread who have cases when
rewriting history is a valid option, a tool such as Elijah's
git-filter-repo[1] can not only fix the "broken" email addresses, but
also can adjust hash references in commit messages so they don't go
stale.

[1]: https://github.com/newren/git-filter-repo
