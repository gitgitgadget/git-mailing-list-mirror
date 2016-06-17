Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C417F1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbcFQX3D (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:29:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:56434 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750774AbcFQX3C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:29:02 -0400
Received: (qmail 7722 invoked by uid 102); 17 Jun 2016 23:29:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:29:00 -0400
Received: (qmail 30100 invoked by uid 107); 17 Jun 2016 23:29:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:29:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 19:28:58 -0400
Date:	Fri, 17 Jun 2016 19:28:58 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] run-command: add pipe_command helper
Message-ID: <20160617232857.GA26564@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
 <20160616093745.GD15851@sigill.intra.peff.net>
 <CAPig+cR-Z+dpKN0dG_BG7JWRBZeo4Xtpa1HQAU1Tt3WRunsrXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cR-Z+dpKN0dG_BG7JWRBZeo4Xtpa1HQAU1Tt3WRunsrXg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 04:03:18PM -0400, Eric Sunshine wrote:

> > diff --git a/run-command.h b/run-command.h
> > @@ -79,17 +79,34 @@ int run_command_v_opt(const char **argv, int opt);
> >  /**
> > - * Execute the given command, capturing its stdout in the given strbuf.
> > + * Execute the given command, sending "in" to its stdin, and capturing its
> > + * stdout and stderr in the "out" and "err" strbufs. Any of the three may
> > + * be NULL to skip processing.
> > + *
> >   * Returns -1 if starting the command fails or reading fails, and otherwise
> > - * returns the exit code of the command. The output collected in the
> > - * buffer is kept even if the command returns a non-zero exit. The hint field
> > - * gives a starting size for the strbuf allocation.
> > + * returns the exit code of the command. Any output collected in the
> 
> Did you mean s/returns/Returns/ ?

I don't think so. This is a continuatino of "...and otherwise" from the
context line above.

> > + * buffers is kept even if the command returns a non-zero exit. The hint fields
> > + * gives starting sizes for the strbuf allocations.
> >   *
> >   * The fields of "cmd" should be set up as they would for a normal run_command
> > - * invocation. But note that there is no need to set cmd->out; the function
> > - * sets it up for the caller.
> > + * invocation. But note that there is no need to set the in, out, or err
> > + * fields; capture_command handles that automatically.
> 
> s/capture_command/pipe_command/

Whoops, yes.

-Peff
