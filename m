From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: abbreviate hash in suggest_reattach
Date: Mon, 8 Apr 2013 17:03:03 -0400
Message-ID: <20130408210303.GA9649@sigill.intra.peff.net>
References: <1365436422-25554-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:03:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJDe-00061Z-I4
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931Ab3DHVDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:03:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34259 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964925Ab3DHVDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:03:08 -0400
Received: (qmail 15268 invoked by uid 107); 8 Apr 2013 21:04:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 17:04:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 17:03:03 -0400
Content-Disposition: inline
In-Reply-To: <1365436422-25554-1-git-send-email-kevin@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220513>

On Mon, Apr 08, 2013 at 06:53:42PM +0300, Kevin Bracey wrote:

> After printing the list of left-behind commits (with abbreviated
> hashes), use an abbreviated hash in the suggested 'git branch' command;
> there's no point in outputting a full 40-character hex string in some
> friendly advice.
> 
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>

I think this makes sense. We generally use the full sha1 when the output
is meant to live for a long time, but that is not the case here.

I suspect I would have been annoyed by it, too, if I did not have
advice.detachedHEAD turned off. :)

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a9c1b5a..e168bfb 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -700,7 +700,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
>  			"If you want to keep them by creating a new branch, "
>  			"this may be a good time\nto do so with:\n\n"
>  			" git branch new_branch_name %s\n\n"),
> -			sha1_to_hex(commit->object.sha1));
> +			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
>  }

Code looks obviously correct to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
