From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Mon, 18 Mar 2013 13:08:04 -0400
Message-ID: <20130318170804.GA15924@sigill.intra.peff.net>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 18:08:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHdY6-0005Ug-JE
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 18:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab3CRRIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 13:08:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56279 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab3CRRII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 13:08:08 -0400
Received: (qmail 19518 invoked by uid 107); 18 Mar 2013 17:09:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 13:09:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 13:08:04 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218430>

On Mon, Mar 18, 2013 at 10:28:59PM +0530, Ramkumar Ramachandra wrote:

> This has irritated me for a long time.  I often end up doing:
> 
>     $ git push master:master +pu:pu

Me too.

> Is there a reason for the remote not being optional, or are we just
> waiting for a patch?  The only problem I can foresee is very minor:
> there is a ref with the same name as a remote; in this case, we'd have
> to specify both the remote and the ref.

I think the ambiguity is a little more complex than that, because we
cannot enumerate the universe of all remotes. Keep in mind that we can
take either a configured remote or a URL (or ssh host). So what does:

  git push foo:bar

mean? Is it pushing "refs/heads/foo" to "refs/heads/bar" on "origin"? Or
is it using the default refspecs to push to the "bar" repo on the host
"foo" over ssh?

So you would need some heuristics based on whether something was a valid
refspec, or could be a valid remote name or URL.

-Peff
