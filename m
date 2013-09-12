From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] wt-status: turn advice_status_hints into a field of
 wt_status
Date: Thu, 12 Sep 2013 05:52:07 -0400
Message-ID: <20130912095207.GA31493@sigill.intra.peff.net>
References: <1378890539-1966-1-git-send-email-Matthieu.Moy@imag.fr>
 <20130911183519.GA24251@sigill.intra.peff.net>
 <vpqeh8u1iip.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, javierdo1@gmail.com,
	jrnieder@gmail.com, judge.packham@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 12 11:52:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK3ZS-0005lH-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab3ILJwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:52:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:53544 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894Ab3ILJwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:52:13 -0400
Received: (qmail 10347 invoked by uid 102); 12 Sep 2013 09:52:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Sep 2013 04:52:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 05:52:07 -0400
Content-Disposition: inline
In-Reply-To: <vpqeh8u1iip.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234637>

On Thu, Sep 12, 2013 at 11:44:30AM +0200, Matthieu Moy wrote:

> That is clean, but a bit long and it is essentially duplicated between
> status and commit. I went another way: put all the similar code in a
> common function status_init_config:
> 
> static void status_init_config(struct wt_status *s, config_fn_t fn)
> {
> 	wt_status_prepare(s);
> 	gitmodules_config();
> 	git_config(git_status_config, s);
> 	determine_whence(s);
> 	s->hints = advice_status_hints; /* must come after git_config() */
> }

s/git_status_config/fn/, I assume.

> We could split the git_config call, but that would not bring much
> benefit IMHO. In any case, it can be done very simply on top of my patch
> if needed later, as there is now only one call site for git_config.

Yeah, I think that is fine. The other cleanup may or may not be worth
it, but should not be a blocker to your patch. With what you suggest
above, you are certainly not making anything worse with respect to the
code organization.

Thanks.

-Peff
