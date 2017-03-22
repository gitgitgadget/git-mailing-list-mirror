Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E522620323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbdCVWTz (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:19:55 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36656 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdCVWTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:19:53 -0400
Received: by mail-pf0-f177.google.com with SMTP id o126so97118739pfb.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GeKHMwdn2hFfnBNh3lAnsLTPB8kt8ap9iczEFy07Z44=;
        b=ICofxMDVGRal+uud+j1JmvAshXnR53s+TPNtCu9Qs2hsi8AWpE7gV4iInnBiXgnf5y
         wtGDZPEfIj8GfKy8VJY6NeDxF06Lg5aFH7zBi60vZwfX84dZGSGpW64ngAoYPKktfY9q
         35jJr87Z05NRKhyqEIauoyeJ6E3iJHe/e/JpZe4sqpT+axPIcLsryj8qhi7O1vnQZahl
         wVdEWW6aLhSVi3XIln3XGE9IhpKQh0+R1NmS/kium3UeMlrLsYZEdNpP8HlhtdRXtMjS
         S/5ewo3sGcthmtnpnJOR6gDFoBQu36+7QZ5enn+aBgxleRtLuwNw553vAbc2e2nMhXhs
         Yldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GeKHMwdn2hFfnBNh3lAnsLTPB8kt8ap9iczEFy07Z44=;
        b=kxBRomHJw7GRzDNOZFwJMknwY/QI4Zo/599qpnrV3M/5HX2vetXu1r0nhvQeweHdo0
         bCfkN0jMySvLFEjhxWquHNxgr9aQemR6aaOD8PNxB9CtFgQv9mU1zjcV/rr0qHffbZdo
         Y9oTfIN/l989hjM3TyupEmWIa6+8X0F89cIsS7ssIYUHxj6oeq/8p0SivZ9rYabexD5a
         HX+RqR3YIJNvwhTqqsOF2Mj6kDaWGVF/RZb67XLlO/ogcoSS+/h3/phs+SXjBQhhbbrZ
         c0ksDYMpBQxtLD6KmdPvhnj+qybAuDr4QX90RvENOwPJPslzJ7IT7M8SAhVdKnm7djBZ
         9cqg==
X-Gm-Message-State: AFeK/H09anx+fjSiM/WjFSE5fGfrSAj+VUp2SGhmORh/1d2SElold+SxXsoDv/lswe5pomMG
X-Received: by 10.98.15.7 with SMTP id x7mr49969276pfi.217.1490221192423;
        Wed, 22 Mar 2017 15:19:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:4506:c5a2:cf62:91cb])
        by smtp.gmail.com with ESMTPSA id g75sm1434293pfj.107.2017.03.22.15.19.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:19:51 -0700 (PDT)
Date:   Wed, 22 Mar 2017 15:19:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] send-pack: send push options correctly in
 stateless-rpc case
Message-ID: <20170322221950.GE11254@google.com>
References: <20170322195102.165314-1-bmwill@google.com>
 <20170322195102.165314-2-bmwill@google.com>
 <20170322211546.GB26108@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322211546.GB26108@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/22, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > "git send-pack --stateless-rpc" puts each request in a sequence of pkt-lines
> > followed by a flush-pkt. The push option code forgot about this and sends push
> > options and their terminating delimiter as ordinary pkt-lines that get their
> > length header stripped off by remote-curl before being sent to the server.
> >
> > The result is multiple malformed requests, which the server rejects.
> >
> > Fortunately send-pack --stateless-rpc already is aware of this "pkt-line within
> > pkt-line" framing for the update commands that precede push options. Handle
> > push options the same way.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  send-pack.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> This is only a hypothetical issue until the next patch though, right?

Correct, Its in preparation for the next patch.

> 
> For what it's worth,
> 
> Tested-by: Jonathan Nieder <jrnieder@gmail.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks.

-- 
Brandon Williams
