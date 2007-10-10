From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] mergetool: support setting path to tool as config
 var mergetool.<tool>.path
Date: Wed, 10 Oct 2007 18:03:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101759080.4174@racer.site>
References: <11919632613176-git-send-email-prohaska@zib.de>
 <Pine.LNX.4.64.0710101526060.4174@racer.site> <FBE79360-4B3A-4C92-B8AA-76989D933009@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tytso@mit.edu, frank@lichtenheld.de, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 19:04:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifeyw-0001OI-Fi
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 19:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbXJJRER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbXJJREQ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 13:04:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:41750 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754898AbXJJREQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 13:04:16 -0400
Received: (qmail invoked by alias); 10 Oct 2007 17:04:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 10 Oct 2007 19:04:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BzIpTxbeBaGI7emaE9Btm1ACSOcbf84SuW5NVbJ
	y8onWBIc2Ohe2z
X-X-Sender: gene099@racer.site
In-Reply-To: <FBE79360-4B3A-4C92-B8AA-76989D933009@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60520>

Hi,

On Wed, 10 Oct 2007, Steffen Prohaska wrote:

> On Oct 10, 2007, at 4:33 PM, Johannes Schindelin wrote:
> 
> > On Tue, 9 Oct 2007, Steffen Prohaska wrote:
> > 
> > > This commit adds a mechanism to provide absolute paths to the 
> > > external programs called by 'git mergetool'. A path can be specified 
> > > in the configuation variable mergetool.<tool>.path. The 
> > > configuration variable is similar to how we name branches and 
> > > remotes. It is extensible if we need to specify more details about a 
> > > tool.
> > 
> > Okay, let's step back a bit.
> > 
> > What does mergetool do?  It calls different merge helpers, each with its
> > own convention how to call it.  For example, tkdiff is called either as
> > 
> > 		tkdiff -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"
> > 
> > or as
> > 
> > 		tkdiff -o "$path" -- "$LOCAL" "$REMOTE"
> > 
> > depending if there is a base or not.  Another example is gvimdiff:
> > 
> > 		gvimdiff -f -- "$LOCAL" "$path" "$REMOTE"
> > 
> > which seems not to care if there is a base.
> > 
> > Now, would it not be much better if we had a way to specify the tool 
> > and the convention indepentently?  Like
> > 
> > merge.tkdiff.path = C:\bla\blub\wish.exe C:\blub\bleh\tkdiff.tcl
> > merge.tkdiff.options = -o %p -- %l %r
> > merge.tkdiff.optionsWithBase = -a %b -o %p -- %l %r
> > 
> > and have defaults for the tools we have in git-mergetool.sh _already_?
> 
> If you provide a generic mechanism to call an external tool, there's no 
> need to name the tool. A single mechanism (let's call it external) would 
> be sufficient, like
> 
> mergetool.external.path = c:\any\path\merge.exe
> mergetool.external.arg2way = %l %r --merge2 --to=%p
> mergetool.external.arg3way = %b %l %r --merge3 --to=%p
> 
> But this places the burdon on the user to figure out the command line syntax
> and specify it correctly using git-config.

Guess why I did not want to  have a single mechanism.  I did _not_ propose 
to place the burden on the user to figure out the command line.

Besides, I do not want to do away with the automatic detection of the 
tool, which _implies_ having a list of defaults for the command line 
syntax, which in turn _commands_ having the name instead of "external".

While your solution is an obvious short term fix, I maintain that my 
proposal is the Right Thing in the long run.

Ciao,
Dscho
