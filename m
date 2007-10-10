From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] mergetool: support setting path to tool as config
 var mergetool.<tool>.path
Date: Wed, 10 Oct 2007 15:33:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101526060.4174@racer.site>
References: <11919632613176-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tytso@mit.edu, frank@lichtenheld.de, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 16:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfcdJ-0007Am-Mg
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 16:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbXJJOdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 10:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbXJJOdV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 10:33:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:51710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753918AbXJJOdU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 10:33:20 -0400
Received: (qmail invoked by alias); 10 Oct 2007 14:33:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 10 Oct 2007 16:33:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OdBpi5TSOCBNHeDN6xidKm/9UuLH21xMybU4k7k
	PfMTnEPKIiyRGv
X-X-Sender: gene099@racer.site
In-Reply-To: <11919632613176-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60504>

Hi,

On Tue, 9 Oct 2007, Steffen Prohaska wrote:

> This commit adds a mechanism to provide absolute paths to the external 
> programs called by 'git mergetool'. A path can be specified in the 
> configuation variable mergetool.<tool>.path. The configuration variable 
> is similar to how we name branches and remotes. It is extensible if we 
> need to specify more details about a tool.

Okay, let's step back a bit.

What does mergetool do?  It calls different merge helpers, each with its 
own convention how to call it.  For example, tkdiff is called either as

		tkdiff -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"

or as

		tkdiff -o "$path" -- "$LOCAL" "$REMOTE"

depending if there is a base or not.  Another example is gvimdiff:

		gvimdiff -f -- "$LOCAL" "$path" "$REMOTE"

which seems not to care if there is a base.

Now, would it not be much better if we had a way to specify the tool and 
the convention indepentently?  Like

merge.tkdiff.path = C:\bla\blub\wish.exe C:\blub\bleh\tkdiff.tcl
merge.tkdiff.options = -o %p -- %l %r
merge.tkdiff.optionsWithBase = -a %b -o %p -- %l %r

and have defaults for the tools we have in git-mergetool.sh _already_?

Ciao,
Dscho
