From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: [PATCH resend] perl/Makefile.PL: teach makefiles about possible old Error.pm files
Date: Thu, 22 May 2008 12:43:00 -0400
Message-ID: <20080522164300.GA19765@foursquare.net>
References: <20080517011614.GA11029@foursquare.net> <20080521222150.GA29696@foursquare.net> <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org> <20080521235647.GA21340@foursquare.net> <alpine.DEB.1.00.0805221245240.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 22 18:44:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzDu1-0006SA-V8
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 18:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbYEVQnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 12:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754706AbYEVQnh
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 12:43:37 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:59458 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbYEVQng (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 12:43:36 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4MGh06p024261;
	Thu, 22 May 2008 12:43:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805221245240.30431@racer>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.723, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00, TW_XJ 0.08)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82638>

On Thu, May 22, 2008 at 12:46:12PM +0100, Johannes Schindelin wrote:
> I do not see how it is _Git_ that breaks itself by repeated installs.  It 
> detects that there is an Error.pm.  Fine.  You _remove_ it while 
> installing Git.  Not fine.  Not Git's error.

I guess I take the view that anything _installed_ by git is a part of git.
If git installs Error.pm, it can't expect the user to keep it around
if he uninstalls that version of git.

The user can do the following, and not have any warning that he'll be
bitten, and won't know what he did wrong.  In fact, when I first saw this
error, I thought it was a bug that was fixed in a point release.

	(slightly abbreviated for clarity, version numbers arbitrary)

	tar xjf git-1.5.4.3.tar.bz2
	cd git...  && ./configure --prefix=/usr/local/stow/git-1.5.4.3
	make && make install
	stow git-1.5.4.3

	tar xjf git-1.5.4.4.tar.bz2
	cd git... && ./configure --prefix=/usr/local/stow/git-1.5.4.4
	make	# git is built assuming git-1.5.4.3 will always exist
	make install

	stow -D git-1.5.4.3
	stow git-1.5.4.4

The user now has a broken git, and has no idea why.  I don't consider the
above to be unusual or user error.

- Chris
