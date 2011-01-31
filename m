From: Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v2] Disallow empty section and variable names
Date: Mon, 31 Jan 2011 10:17:28 +0100
Message-ID: <20110131091728.GB24297@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110127145253.GD6312@fm.suse.cz> <20110130203445.GA9689@fm.suse.cz> <4D46694F.5070208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 10:17:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjptA-0004op-2e
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 10:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab1AaJRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 04:17:30 -0500
Received: from cantor2.suse.de ([195.135.220.15]:51173 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab1AaJR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 04:17:29 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 8B13C87104;
	Mon, 31 Jan 2011 10:17:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D46694F.5070208@viscovery.net>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165723>

On Mon 31-01-11 08:48:31, Johannes Sixt wrote:
> Am 1/30/2011 21:34, schrieb Libor Pechacek:
> > It is possible to break your repository config by creating an invalid key.  The
> > config parser in turn chokes on it.
> > 
> > $ git init
> > Initialized empty Git repository in /tmp/gittest/.git/
> > $ git config .foo false
> > $ git config .foo
> > fatal: bad config file line 6 in .git/config
> 
> Just a nit: Your example is misleading because it "only" shows that if you
> shove in junk, and ask for junk, you get breakage. However, the breakage
> is much more serious, and you could have demonstrated it, if you had
> written your example like this:
> 
> $ git config .foo false
> $ git config user.email
> fatal: bad config file line 6 in .git/config

Yes, that one is more persuasive.  Thanks for hint.

> > +	test_must_fail git config . &&
> > +	test_must_fail git config .foo &&
> > +	test_must_fail git config foo. &&
> > +	test_must_fail git config .foo. &&
> 
> Not a nit: These tests only show that 'git config' cannot be asked for
> junk, but they do not show that you cannot insert junk into the config
> file anymore using 'git config'.

This change builds on top of "Sanity-check config variable names" which makes
setting and getting values use the same key checking routine.  For the moment,
it does not matter if we test the "set" ot "get" path.

Yet, I accept the get/set operations can use different key checking routine in
the future (although I can't imagine the reson for it), and overall testing
the "set" path is in line with the idea of the patch.

Thanks for input, I'll send updated patch.

Libor
-- 
Libor Pechacek
SUSE L3 Team, Prague
