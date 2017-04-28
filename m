Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A551FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 09:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946071AbdD1JlA (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 05:41:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:54229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165122AbdD1Jkx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 05:40:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBnvD-1dD8o32xkd-00AjJu; Fri, 28
 Apr 2017 11:40:16 +0200
Date:   Fri, 28 Apr 2017 11:40:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/26] http-backend: avoid memory leaks
In-Reply-To: <xmqq4lxao0ds.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281117040.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <366e4d805da9b4b610fe216537de5e4a4c3941ed.1493237937.git.johannes.schindelin@gmx.de> <xmqq4lxao0ds.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZqwP8kS7IkwJXLF7Aw8P/579SY0HPCgOh/BtGcT6I1rvWhWCeLX
 7Yns7gCCFYgGmq77JZO04E2FVmh4xGw4Cco9td4BTm+1CgJdzr9/rQPDJWDqQ22D66qCfmN
 bpFJxWV29Ma7JQdvK//nyC8d+QVdoQv9T4zWMndJNmizGXNym9rcVuWZPA/BJMhQU+nntbl
 KJbyZwe8FvMdhAIfeUUvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EsRT/mBxMZ4=:DLxGsd+ydIsw0V5WwCy6P2
 M3nqPpvozC0UYK+PCXzADKIWjMRiuYgH/xZp0HyC1u0VxBYQ58XmTzL8pv9X9jaaca8b4gXMK
 NtahhmCXbqlSf7BwieCzl8cfeFwuDcBd32G4sgBVsMEvlcoUYObHfomRVfx/JZZ/sogvOTaxe
 WwOOFORcz1dZay0n7Lb7W5pt/Rkwk83MId/e1bSjLVIuVW3Dgh8OPD/l4Qrz7pof1yiGwFMLw
 /ZqpBtmmTmSm8/DSzRoyXpC3jxShVDDOW2kgcgiXvNqrhzfYiOO0u7TmUMuMqc7fq/7KYhvQA
 WXRNB7Sepo34pjfputtY9xfs5wWxkGKS33FVsAu5a/u8MBi3pz7TAvWMssCtwHP8DLdYSSbCW
 dj+GvNouzVJsi5g75KL01yBWKps7DC5Rqnj0xZc59+ZCo/QVlWMyC1NV+2OZdVAmADiBEffLC
 UFlafoGOYc6dLO7pvTRuAVSe83gV3qgQAbWl3LqjtS0PbLmK7JZe7BVjdT12/Xv4D9HEGLqr/
 8EL9Fay/v7mVq1ycekYwjDZpyqMeR2fSqSwU4N1rHPpDdiNQmloBPvgkIUQ2m+d1pUKraFa8T
 UsCK56DMt1LKtiagBfCQJ/b4QAqgQbKEawdHMjlp2QJjVMt2d1jv8VBzfxNKE5c5kkpuMmrtp
 nTUohQuZFY/YEvaxwzGAblp2g3HyFdDk0gjatW6JleNZM95nyXiHom2SC/2lNLF6ZyiHgbQET
 TV35hxa8TJL/4e1KH73B6T0mUomQClh1gbzQ2y4Me/uTQd7cpO+URh+FQh26d6c54HAdtnvVy
 OXTxpLW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Reported via Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  http-backend.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/http-backend.c b/http-backend.c
> > index eef0a361f4f..d12572fda10 100644
> > --- a/http-backend.c
> > +++ b/http-backend.c
> > @@ -681,8 +681,10 @@ int cmd_main(int argc, const char **argv)
> >  		if (!regexec(&re, dir, 1, out, 0)) {
> >  			size_t n;
> >  
> > -			if (strcmp(method, c->method))
> > +			if (strcmp(method, c->method)) {
> > +				free(dir);
> >  				return bad_request(&hdr, c);
> > +			}
> >  
> >  			cmd = c;
> >  			n = out[0].rm_eo - out[0].rm_so;
> > @@ -708,5 +710,7 @@ int cmd_main(int argc, const char **argv)
> >  					   max_request_buffer);
> >  
> >  	cmd->imp(&hdr, cmd_arg);
> > +	free(dir);
> > +	free(cmd_arg);
> >  	return 0;
> >  }
> 
> Hmph.  I find a "leak" of a resource acquired inside the main
> function and not released when the main function leaves a lot less
> interesting than the other ones this series covers.

Ah, I missed that this falls squarely into the "one-shot programs are
allowed to be sloppy in their memory management, essentially using exit()
as garbage collector" category.

Will drop,
Dscho
