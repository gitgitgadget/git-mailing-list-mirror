Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8BAB1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 20:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfJXUpH (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 16:45:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36041 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJXUpG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 16:45:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so24349plk.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TP9HcosOXRSIR4HiyL9c10Na9QHNrbp8P1hscJJVG/w=;
        b=H71xfotSPtPhuLkg4P8kwz+7IulBJ2L5CQRTq9opuaR2aO+FNeYui+Ol/aEN7S3pwC
         i/3TDDqiMIzCCF66WzJBf1iUjNP7bHe06yY73EqYW1BptpvSTqcPBUM1InxK0IswlxpR
         6avINuNujeju79PrkD3aQD1wHMmb5V5Fb9ILL8FtZqr//EnGM8zjJmdET3repHQ58jK3
         cT2wM4bDAbHYTwPkUQz4a/wv1fVVv9EpaHFjkGZvnwIeYxzmzUnW4LWhowhUHyjLWU8q
         QwoPwEf3BcXDDkYPQwoJJi6p2dralsJb3iwVdLGROb73jPykOIdIgYaXXxCEabAroERs
         3pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TP9HcosOXRSIR4HiyL9c10Na9QHNrbp8P1hscJJVG/w=;
        b=mcglckMrg3eqE9LSIoEWidVKQKEjPFSYQfeENC6rqkY+M7O/1GN5mN0H9fdnm1PM9Y
         //5dLJymAwpWCJvgzp6JlEy0vVKZrAeH3FNRVVqxLl5WVnoVqIT5+uExVvjT18I4QUd9
         LoJGAikUTIhBIiPuOiRfiGGfPLdSgT6gyJYRXV9NlhHwsNNA3Adli+B/xR6Ke/gNIMOZ
         m+1XswcM4UneLq9S7Bz6kHcUy0pPcqy2+H+nTihPFtUYdB1J/yJdrJe0l3sFHCjzrKS+
         8DTC828aS5jsWM0J5SNNDxLAuw1EHo6cSlfo3oCGYXjKM5UzwzQa62h+8wTPzxBKUcIO
         hG5A==
X-Gm-Message-State: APjAAAV/DuFmSKph9Dw1gyjq8HXmXG2oeGUGhj5HzsDo0CYrBWVXvLXu
        q0hKEjfGYGj82bNj25j5gPhFBg==
X-Google-Smtp-Source: APXvYqxUn2cPlzXg8UTi6RBhvzrxtAohJJbLYQ5bqhKgCWnPwsb/nqSKQ4lfBgxThV1Ala6ob0P/yw==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr17810758plp.221.1571949905499;
        Thu, 24 Oct 2019 13:45:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id z2sm3907314pgo.13.2019.10.24.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:45:04 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:45:00 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and
 `is_directory()`
Message-ID: <20191024204500.GG9323@google.com>
References: <20191024092745.97035-1-mirucam@gmail.com>
 <20191024114148.GK4348@szeder.dev>
 <20191024181344.GD12892@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024181344.GD12892@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 02:13:45PM -0400, Jeff King wrote:
> On Thu, Oct 24, 2019 at 01:41:48PM +0200, SZEDER Gábor wrote:
> 
> > > diff --git a/builtin/clone.c b/builtin/clone.c
> > > index c46ee29f0a..f89938bf94 100644
> > > --- a/builtin/clone.c
> > > +++ b/builtin/clone.c
> > > @@ -899,12 +899,6 @@ static void dissociate_from_references(void)
> > >  	free(alternates);
> > >  }
> > >  
> > > -static int dir_exists(const char *path)
> > > -{
> > > -	struct stat sb;
> > > -	return !stat(path, &sb);
> > 
> > But look at this, it only checks that the given path exists, but it
> > could be a regular file or any other kind of path other than a
> > directory as well!
> > 
> > So this function clearly doesn't do what it's name suggests.  That's
> > bad.
> > 
> > Unfortunately, it gets worse: some of its callsites in
> > 'builtin/clone.c' do expect it to check the existence of _any_ path,
> > not just a directory.
> 
> Yes, that's the reason for the funny name (and the fact that it was
> never re-factored to use is_directory() in the first place). There's
> some more discussion in:
> 
>   https://public-inbox.org/git/xmqqbmi9dw55.fsf@gitster.mtv.corp.google.com/
> 
> and its subthread.

Hm. Then, is the solution to use dir_exists() for "a directory exists
here" and also add path_exists() for "literally anything exists here"?
That seems like it's still a pretty minor change. It'd be nice to
un-stick our Outreachy applicant :)

 - Emily
