Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E98B20401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbdFUVpz (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:45:55 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33518 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdFUVpy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:45:54 -0400
Received: by mail-pf0-f180.google.com with SMTP id e7so11089809pfk.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/4AIMegv65MBTvCDXkyXcIU809aRevx/V3/6BfNg3I=;
        b=QqevtI1Z+AJmtbrvBiWLltGUsssR7NMO5uqDt5XXx4dPC7C+lmrUFriQJOX/Zq1fI9
         8t1q6DrD9viWi0f5XC9zxuAdqN0fCIEEvqmfWXvMbVX6iuzCwNQWcIg2kTGUOC54dkpj
         oYcDcELfxTWX/2uEPLv+z3RlI6/1X+qqRlmZaGISbPXXBVY/B97fxc2bs5qF+mmwz2J9
         l7pTNfeaVWe+aXgZwNBloQVNdGn9hSYVkwrG+HJH+yOMmZo87Em1uFHFLlJg0UBNsnMg
         ywTy9PojUi7mEDDeA++HorZ4c0THElUIqfDjbKo4D0icQTekCYldGLc/Z0bUMUPMQUr3
         gMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/4AIMegv65MBTvCDXkyXcIU809aRevx/V3/6BfNg3I=;
        b=eRrtkZxDqIufpIyioP1iMsvFXecz6T7tVW25Y5ZfwDphSTbDMmeatj/Nfqqf0vVfrt
         InfUxPgpOsj17gKx8HbdYqVM5x4i6R5bg4kpT7/RXs4/rMMKg+PO61sXI+nVihVajJEO
         KTV6Z8FmTYfPZuCeA8oYLcVDejphn32ceqFfa2zPiVCyVlnoX00gtNoIXlTKkH70efmn
         sSADpJ3zxVQOPg02sgFjRXvYVaFiCawdF+dxvSCfv0PKmDt0ZZUAQEF9rcDm20yZzHOd
         VAep1BHrnSDFK1EAHEO+Svjvl+Z+zl9GF7+Zyk6ztTaUaxFReZpynSJKLl0l/ittvc9M
         K+Og==
X-Gm-Message-State: AKS2vOwiaWkYa7+VbwtER5nLFkkkP2vN0UAOV5fMJXCkJs3yEX18jQlT
        fURmE05TjYJQWETb
X-Received: by 10.99.123.18 with SMTP id w18mr27971548pgc.122.1498081553389;
        Wed, 21 Jun 2017 14:45:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id 3sm35219134pfp.11.2017.06.21.14.45.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:45:52 -0700 (PDT)
Date:   Wed, 21 Jun 2017 14:45:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
Message-ID: <20170621214551.GE53348@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
 <20170620024816.20021-5-sbeller@google.com>
 <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/21, Stefan Beller wrote:
> On Wed, Jun 21, 2017 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Stefan Beller <sbeller@google.com> writes:
> >
> >> Signed-off-by: Stefan Beller <sbeller@google.com>
> >> ---
> >>  diff.c | 22 +++++++++++++++++++---
> >>  1 file changed, 19 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/diff.c b/diff.c
> >> index 2f9722b382..89466018e5 100644
> >> --- a/diff.c
> >> +++ b/diff.c
> >> @@ -559,6 +559,24 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
> >>       emit_line_0(o, set, reset, line[0], line+1, len-1);
> >>  }
> >>
> >> +enum diff_symbol {
> >> +     DIFF_SYMBOL_SEPARATOR,
> >
> > Drop the last comma from enum?
> 
> I looked through out code base and for enums this is
> actually strictly enforced, so I guess I have to play
> by the rules here as I do not want to be the first
> to deviate from an upheld standard.
> 
> This will be painful though as the next ~20 patches
> add more symbols mostly at the end, maybe I need
> to restructure that such that the last symbol stays the same
> throughout the series. Thanks for that thought.

I don't think this is strictly enforced.  If you look at grep.h:197 the
enum 'grep_source_type' has a trailing comma.

> 
> >
> >> +static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
> >> +                          const char *line, int len)
> >> +{
> >> +     switch (s) {
> >> +     case DIFF_SYMBOL_SEPARATOR:
> >> +             fprintf(o->file, "%s%c",
> >> +                     diff_line_prefix(o),
> >> +                     o->line_termination);
> >> +             break;
> >
> > As the first patch in the "diff-symbol" subseries of this topic,
> > this change must seriously be justified.  Why is it so important
> > that a printing of an empty line must be moved to a helper function,
> > which later will gain ability to show other kind of lines?
> 
> Ah yes. This got lost in comparison to the currently queued series with
> diff_lines. The justification for the change was in the buffer patch,
> but now we need to have the justification here.
> 
> In the old series, I had copied the same text in all these
> refactoring patches, but thought to delete them in this series. The first
> refactoring patch makes sense though.
> 
> Thanks,
> Stefan

-- 
Brandon Williams
