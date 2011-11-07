From: Jeff King <peff@peff.net>
Subject: Re: BUG. Git config pager when --edit
Date: Mon, 7 Nov 2011 11:42:50 -0500
Message-ID: <20111107164250.GC27055@sigill.intra.peff.net>
References: <20111107172652.0faade61@ashu.dyn.rarus.ru>
 <CAH6sp9Ox+6p4RkjCZ0j3tXG9F4u7SPuwbSrOWmLSXic9DxSKiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 17:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNSHh-0002ov-F8
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 17:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab1KGQmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 11:42:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35810
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab1KGQmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 11:42:52 -0500
Received: (qmail 27591 invoked by uid 107); 7 Nov 2011 16:42:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 11:42:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 11:42:50 -0500
Content-Disposition: inline
In-Reply-To: <CAH6sp9Ox+6p4RkjCZ0j3tXG9F4u7SPuwbSrOWmLSXic9DxSKiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184994>

On Mon, Nov 07, 2011 at 02:43:41PM +0100, Frans Klaver wrote:

> > As far as my config is large enough to be paged I set pager.config=less
> > setting. But since that moment when I run
> > $ git config --edit
> > I get
> > Vim: Warning: Output is not to a terminal
> > And some messed config output
> >
> > The same happens if to run
> > $ vim .git/config | less
> 
> So git is trying to tell vim to pipe its output to less. vim can't do
> that because it needs a terminal, as it's the only way vim is usable.
> 
> Should pager.config then only be used with --list?

Yes, but it can't, because it is not the config command, but the git
wrapper that respects "pager.config". We have similar issues with
setting "pager.tag" (you want it for listing, but not for tag creation)
and others.

I should probably polish and submit the patch here:

  http://thread.gmane.org/gmane.comp.version-control.git/182238/focus=182475

-Peff
