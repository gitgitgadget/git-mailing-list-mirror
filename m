From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Mon, 3 Mar 2008 22:52:00 +0000
Message-ID: <20080303225200.GA8145@hashpling.org>
References: <20080303221159.GA6875@hashpling.org> <200803032333.29426.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWJWa-0004L2-Od
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 23:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbYCCWwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 17:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYCCWwJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 17:52:09 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:50705 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbYCCWwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 17:52:09 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1JWJVu-0002yE-J5; Mon, 03 Mar 2008 22:52:06 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m23Mq0dZ008534;
	Mon, 3 Mar 2008 22:52:00 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m23Mq0iX008533;
	Mon, 3 Mar 2008 22:52:00 GMT
Content-Disposition: inline
In-Reply-To: <200803032333.29426.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: ae599e3f92ee9ac66dcfee64f4552097
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75992>

On Mon, Mar 03, 2008 at 11:33:28PM +0100, Jakub Narebski wrote:
> Charles Bailey <charles@hashpling.org> writes:
> > 
> > The untabify function seems the sensible place to make the change. As
> > untabify is called once per line from various different locations it
> > also makes sense to cache the result of the config lookup in a package
> > variable, though this makes the change slightly less neat.
> 
> Since b201927 (gitweb: Read repo config using 'git config -z -l')
> repository config is cached in %config hash (per repository), so
> I don't think global / package variable $tabstop_width is really
> needed...

Fair point, although we still save the cost of some 'is the config
variable overrideable and if so is it overriden' logic.  Untabify is a
once per line call which is more frequesnt than most gitweb config
checking calls.

> > This change should have a minimal impact on performance but it would
> > appreciate some more eyes and ideally some performance testing on
> > heavier systems than my own. 
> 
> ...but it would be better if you have checked at least on your system
> if it does affect performance or not.
> 

Not noticeably (on an old AMD Duron 900MHz), but my tests have been
unscientific.

> [...]
> 
> +our $tabstop_width;
> 
> I think I would write "our $tabstop_width = 8;" here.

Currently, I use the fact that it is initially 'undef' to know that I
haven't checked the config yet. The config is then checked on the
first time through untabify.

Charles.
