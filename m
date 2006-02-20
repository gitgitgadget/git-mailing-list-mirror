From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Should we support Perl 5.6?
Date: Mon, 20 Feb 2006 11:10:12 -0800
Message-ID: <20060220191011.GA18085@hand.yhbt.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 20:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGQY-0004TE-1w
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 20:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWBTTKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 14:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWBTTKP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 14:10:15 -0500
Received: from hand.yhbt.net ([66.150.188.102]:9916 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932634AbWBTTKO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 14:10:14 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id B6FC02DC03A; Mon, 20 Feb 2006 11:10:12 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16498>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> I just had a failure when pulling, because since a few days (to be exact, 
> since commit 1cb30387, git-fmt-merge-msg uses a syntax which is not 
> understood by Perl 5.6.
> 
> It is this:
> 
> 	open $fh, '-|', 'git-symbolic-ref', 'HEAD' or die "$!";

This is just 5.8 shorthand for the following (which is 5.6-compatible,
and probably for earlier versions, too):

	my $pid = open my $fh, '-|';
	defined $pid or die "Unable to fork: $!\n";
	if ($pid == 0) {
		exec 'git-symbolic-ref', 'HEAD' or die "$!";
	}
	<continue with original code here>

All of the Perl code I've written uses this method.

> I know that there was already some discussion on this list, but I don't 
> remember if we decided on leaving 5.6 behind or not.
> 
> Somebody remembers?

IIRC, there was no clear decision.

I still have some Debian Woody machines/chroots with 5.6 around in some
places.  I don't use git on them, but I may someday, but upgrading to
Sarge is more likely on those.

-- 
Eric Wong
