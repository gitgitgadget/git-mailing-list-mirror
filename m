From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 17:01:11 -0400
Message-ID: <20120913210111.GA16956@sigill.intra.peff.net>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org>
 <7va9wt9377.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGXO-0001dV-FX
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758833Ab2IMVBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:01:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43767 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758828Ab2IMVBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:01:16 -0400
Received: (qmail 7931 invoked by uid 107); 13 Sep 2012 21:01:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 17:01:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 17:01:11 -0400
Content-Disposition: inline
In-Reply-To: <7va9wt9377.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205421>

On Thu, Sep 13, 2012 at 11:40:12AM -0700, Junio C Hamano wrote:

> > More than one people explicitly said that they do not want to see
> > this in Klingon.  Even if the system is fully internationalized,
> > these "... (+), ... (-)" should never be localized, just like we
> > will never localize "diff --git", "index f00f..abcd", etc.
> 
> Nah, I was being silly.  People complaining on Klingon on _this_
> list does not argue for this to be in "C"; it just means the
> i18n.projectlang for this project is "C".

Right, I think that is the case.

> How about _not_ reverting it and doing something like this instead?
> [...]
> +static int project_lang_config(const char *var, const char *value, void *cb_data)
> +{
> +	if (!strcmp(var, "i18n.projectlang")) {
> +		setenv("LANG", val, 1);
> +		setenv("LC_ALL", val, 1);
> +	}
> +	return 0;
> +}

Doesn't that mean that anyone working on git.git will never get to see
their localized language, even when it is not likely to be communicated
to the rest of the project? I am OK with that as a native speaker, but I
wonder what others would have to say.

I suspect we will end up with people not setting i18n.projectlang, and
getting Klingon diffstats on the list.

-Peff
