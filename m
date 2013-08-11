From: Aaron Schrab <aaron@schrab.com>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 20:06:54 -0400
Message-ID: <20130811000654.GA23413@pug.qqx.org>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com>
 <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 11 02:07:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8JC6-00011b-K1
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 02:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072Ab3HKAG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 20:06:57 -0400
Received: from pug.qqx.org ([50.116.43.67]:54887 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3HKAG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 20:06:56 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 7405C1DC1A; Sat, 10 Aug 2013 20:06:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <52060EF9.2040504@alum.mit.edu>
User-Agent: Mutt/1.5.21+184 (ge45f29a) (2012-12-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232116>

At 11:59 +0200 10 Aug 2013, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>I intentionally don't set user.email in my ~/.gitconfig because I use
>different identities (on the same machine) depending on what project I
>am committing to (open-source vs. work).  After I clone a repo, I *rely*
>on Git reminding me to set user.email on my first commit, because I
>invariably forget to set it myself.  And for me, *any* universal,
>heuristically-determined email address would be wrong for me for at
>least some repos.

I was in a similar situation for awhile.  Except in my case I had $EMAIL 
set for other reasons, so I didn't get the reminder even if git wasn't 
configured.

The solution I came up with was to use a template directory to have the 
following script installed as a pre-commit hook in all new repos:

  #!/bin/sh
  git config user.email > /dev/null && exit
  echo 'Set email address with `git config user.email` first' >&2
  exit 1
