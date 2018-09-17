Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648FF1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeIRBYS (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 21:24:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44655 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeIRBYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 21:24:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so8043794pff.11
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vc2/Y/psoxntTD8G0RiENqcRFIgsSMDo0Mq5j494LLU=;
        b=OYyh9aDQHmcKTnqbxG2oW6iEzSvKr3qoLlKhlLlAZEpJD4M30K2WiTm6j4KokwOVPn
         a/A+dUc2IXk2co4kj7TYYpUDu0uPwi4m+lAihyDQwQwZvFeoz1zFtmSWpL6G33wnmQh/
         ksTyAusvjHdG77oy/RnD73AYRm6uxFSWuRkjyAb9V6Pz7cEF08xzl8QzlS6eza93L41O
         CqrcocvvX6+l44O3gkITDjmwWmGFlFF/FfwnMYL0dso/jyI2WDUbeeCdI5AO04kK7SH9
         fj8OkXuDxWOyBpTjvrsdZeDvykTo40jqhdUEJ/XAXWBR+5sh9A92LRgFJ0gKio347zci
         0G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vc2/Y/psoxntTD8G0RiENqcRFIgsSMDo0Mq5j494LLU=;
        b=lYvO9eZ40eBNh/zkh7QI/SlMwJ1BrQXP0UAC9K4KABhCrvD+ID7yNuatozVUpQUu/q
         TICTS+6IK/IddNCy3efvCP30W2GKF/tJ/yC9HoPqV+s0crp4vOo4TDZFRxvX8G/vUulh
         BJB5CuoG3DTnH8XSJ9zTMOjG4WYZoq6uzpj/6lGg4pKW/f+7yWnaPHYAf08lhgPmLPqD
         AvYpRWjCFqhlygmLaddosNm6+b0OP0NDpRTlrNDF8Ing72OGkTe9tU4Tkr+q6yrr5syb
         Cabkun7UTBhOWO2WPbieFqEhoCvPQQy4IGaZmiJWnyMAiqSSheMC/813GmZDswRFdu6e
         umPA==
X-Gm-Message-State: APzg51DapZlwXtK25iS/2uzrnVFnYEZU+DfxgEy6hLom0S3mr21CdKFu
        W/WgQ6E/OSuGOS8xQSvm/7U=
X-Google-Smtp-Source: ANB0VdYGhY0ANQaRpVyLqoEiB5lWf91eN3Sov9LDBYSDSOjbL1o8rWjxuYjzwBB00WFo9xYVCBrtlg==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr24841192pgj.15.1537214129084;
        Mon, 17 Sep 2018 12:55:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r23-v6sm31587990pfj.5.2018.09.17.12.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:55:28 -0700 (PDT)
Date:   Mon, 17 Sep 2018 12:55:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary
 files on "make clean"
Message-ID: <20180917195526.GH140909@aiede.svl.corp.google.com>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-4-sunshine@sunshineco.com>
 <20180917183258.GC140909@aiede.svl.corp.google.com>
 <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com>
 <20180917194214.GG140909@aiede.svl.corp.google.com>
 <xmqqy3bz6h24.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3bz6h24.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I'd rather that we revert this change altogether.  I have nothing
>> against a convenient command to do this kind of non build related
>> cleanup, but it shouldn't be spelled as "make clean".
>
> OK, let's do this for now as I wanted to merge the remainder to
> 'master' today.
>
> -- >8 --
> Subject: Revert "doc/Makefile: drop doc-diff worktree and temporary files on "make clean""
>
> This reverts commit 6f924265a0bf6efa677e9a684cebdde958e5ba06, which
> started to require that we have an executable git available in order
> to say "make clean", which gives us a chicken-and-egg problem.
>
> Having to have Git installed, or be in a repository, in order to be
> able to run an optional "doc-diff" tool is fine.  Requiring either
> in order to run "make clean" is a different story.
>
> Reported by Jonathan Nieder <jrnieder@gmail.com>.
> ---
>  Documentation/Makefile | 1 -
>  1 file changed, 1 deletion(-)

Does this want a sign-off?

In any event, this matches what I had applied in Debian[1] and is

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Jonathan

[1] http://repo.or.cz/git/debian.git/blob/refs/heads/debian-experimental:/debian/patches/0002-Revert-doc-Makefile-drop-doc-diff-worktree-and-tempor.diff
aka http://repo.or.cz/git/debian.git/blob/9872ab1d87634a9288266de290571928e5b9346f:/debian/patches/0002-Revert-doc-Makefile-drop-doc-diff-worktree-and-tempor.diff
