From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 10:35:47 -0400
Message-ID: <20110329143547.GB10771@sigill.intra.peff.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 16:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4a1S-0006IG-LH
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 16:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab1C2Oft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 10:35:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47703
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab1C2Oft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 10:35:49 -0400
Received: (qmail 27996 invoked by uid 107); 29 Mar 2011 14:36:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 10:36:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 10:35:47 -0400
Content-Disposition: inline
In-Reply-To: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170272>

On Tue, Mar 29, 2011 at 12:05:09PM +0200, Michael J Gruber wrote:

> -		if (!prefixcmp(arg+13, "refs/"))
> +		if (!prefixcmp(arg+offset, "refs/"))
>  			/* happy */;
> -		else if (!prefixcmp(arg+13, "notes/"))
> +		else if (!prefixcmp(arg+offset, "notes/"))
>  			strbuf_addstr(&buf, "refs/");
>  		else
>  			strbuf_addstr(&buf, "refs/notes/");
> -		strbuf_addstr(&buf, arg+13);
> +		strbuf_addstr(&buf, arg+offset);
>  		string_list_append(revs->notes_opt.extra_notes_refs,
>  				   strbuf_detach(&buf, NULL));

This issue is not introduced by your patch, but maybe it is a good
opportunity to refactor this to use expand_notes_ref from notes.c?

-Peff
