Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CEB200B9
	for <e@80x24.org>; Tue,  8 May 2018 00:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeEHA1v (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 20:27:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39473 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbeEHA1u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 20:27:50 -0400
Received: by mail-pf0-f193.google.com with SMTP id a22so8980859pfn.6
        for <git@vger.kernel.org>; Mon, 07 May 2018 17:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uu+uZd8yCk1JOY6n5XwNvKm+F6027ppSE//Cu81PxEk=;
        b=ZjvGFdR1pehI1deNnntAXPTkJRhmpeqN8M1I0jq+XNDLcpClqeo4zaNwtjFu1EBsya
         112K4h20x5fKNzHuH9zU7rs6LRiTXGsmZTWKaktO54Dx++Jz0lDtR6R4F6wjmcdp11vJ
         mzRNx1phfmjxJCXme/t/cOx8JJOjy0ucQafMeuSQpOKlj9cZEi6p0qmQj874KTPt9yez
         ZATV91Q8Ian/l2ZscsuCG+egz1M0YAWFrxoly4pbnF84hIKr/nNB0jGXjPxpf6m6ktkM
         gtIkYg2GPamJIRqXLZMkoN+8OSm0FWQZiY23fJfkXURudypKcUiczwR0MW8vKhVtBHkn
         9ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uu+uZd8yCk1JOY6n5XwNvKm+F6027ppSE//Cu81PxEk=;
        b=Fu3OyQ6kxpCDUzaTBpW24PCGSgEkSZwKdcAvRZrwUOG8Soyt/P2TBRYqQdfY5axqBp
         Bo9oEBtMrXmzwY41CESebqTgWFbeBQXFwNUuRou6vwWZ9UUqwoJurgWYDYx9/AirudMN
         uvO/WGRYXJojlndbpU8/7YWcI0OP0jH0dHZ+rBJl/8b4HQ2o4GiDqAeme0RZdXrIdNYr
         8bi0vbvQtpuUWYdra1p3fahAehgv2QGIujMrdXQoukfgD04YcJboWVVp5zd6YQpddWsV
         0ZBhR+0XxlAVMHiNG8lSlYMqKZhRoVmS81jzLBla9F27z+FY99T7sbVoi9Rh0wFjPeoz
         bA/A==
X-Gm-Message-State: ALQs6tB6+HTaNy3EWILTGezbNICqQ3fdn3mbkX+45cPwsN2iHiRSfren
        GtKbrsF7QZD3GhvzIhccx8zTDRHDrEdFhA==
X-Google-Smtp-Source: AB8JxZox2ofwHB6eebPHPi4QGaLiAVQ1CYwXEMUUea7BXfpyKL21BI+AkmgZr/GlLhbnQ32cxxh7dQ==
X-Received: by 2002:a65:4b02:: with SMTP id r2-v6mr30580159pgq.82.1525739269898;
        Mon, 07 May 2018 17:27:49 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e0dd:ed95:919f:45e6])
        by smtp.gmail.com with ESMTPSA id l90sm50298183pfb.149.2018.05.07.17.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 17:27:48 -0700 (PDT)
Date:   Mon, 7 May 2018 17:27:48 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/grep.c: teach '-o', '--only-matching' to
 'git-grep'
Message-ID: <20180508002748.GB6763@syl.local>
References: <cover.1525492696.git.me@ttaylorr.com>
 <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
 <CAPig+cSRJWW4-7vj6wK8aOfNB20bqUCSOOySjdPci1r5Vb83Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSRJWW4-7vj6wK8aOfNB20bqUCSOOySjdPci1r5Vb83Uw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 05, 2018 at 03:36:12AM -0400, Eric Sunshine wrote:
> On Sat, May 5, 2018 at 12:03 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > Teach GNU grep(1)'s '-o' ('--only-matching') to 'git-grep'. This option
> > prints only the matching components of each line. It writes multiple
> > lines if more than one match exists on a given line.
> >
> > For example:
> >
> >   $ git grep -on --column --heading git -- README.md | head -3
> >   README.md
> >   15:56:git
> >   18:20:git
> >
> > By using show_line_header(), 'git grep --only-matching' correctly
> > respects the '--header' option:
>
> What is the '--header' option? I don't see it used in any example.

I think '--header' is a typo for '--heading', which is used in the
following example.

> >   $ git grep -on --column --heading git -- README.md | head -4
> >   README.md
> >   15:56:git
> >   18:20:git
> >   19:16:git
>
> How does this example differ from the earlier example (other than
> showing 4 lines of output rather than 3)?

Ack. I clipped from my terminal what I meant to be the seocnd
example, and pasted it in for both examples. They are meant to be as
follows:

  1. 'git grep' without heading, showing the full line prefix, and
  2. 'git grep' with heading, showing the file heading with '--heading'.

The later has '| head -n4' on the end to include 3+1 lines (3 matches, 1
heading) whereas the former has '| head -n3' to include 3 lines (3
matches, no heading).

I have updated my patch locally to reflect this.


Thanks,
Taylor
