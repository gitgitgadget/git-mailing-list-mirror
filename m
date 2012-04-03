From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix a "Using plain integer as NULL pointer" sparse
 warning
Date: Tue, 3 Apr 2012 16:27:06 -0400
Message-ID: <20120403202706.GA24815@sigill.intra.peff.net>
References: <4F7B331E.5080604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFAJv-000712-7i
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 22:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab2DCU1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 16:27:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44811
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286Ab2DCU1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 16:27:09 -0400
Received: (qmail 32426 invoked by uid 107); 3 Apr 2012 20:27:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Apr 2012 16:27:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2012 16:27:06 -0400
Content-Disposition: inline
In-Reply-To: <4F7B331E.5080604@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194643>

On Tue, Apr 03, 2012 at 06:27:58PM +0100, Ramsay Jones wrote:

> If you need to re-roll your run-command patch [commit b0984f82,
> "run-command: treat inaccessible directories as ENOENT", 30-03-2012],
> could you please squash this patch into it. Thanks!

I don't think it needs re-rolled, but it hasn't hit next yet. Junio, can
you squash this in?

> diff --git a/run-command.c b/run-command.c
> index 47afb78..ae72b9b 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -86,7 +86,7 @@ static char *locate_in_PATH(const char *file)
>  	struct strbuf buf = STRBUF_INIT;
>  
>  	if (!p || !*p)
> -		return 0;
> +		return NULL;

I missed this when converting the code from "is there anything in path"
to "here is what there is in path".

-Peff
