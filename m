From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Buggy (or undocumented) handling of terminal \r in .gitignore
 patterns
Date: Wed, 03 Dec 2008 18:42:11 +0100
Message-ID: <4936C4F3.70501@drmicha.warpmail.net>
References: <loom.20081203T152511-351@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aaron Harnly <git@lists.harnly.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:43:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7vl6-0007Xp-1k
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 18:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbYLCRmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 12:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbYLCRmP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 12:42:15 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44643 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295AbYLCRmP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 12:42:15 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0CAEB1C9EB1;
	Wed,  3 Dec 2008 12:42:14 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 03 Dec 2008 12:42:14 -0500
X-Sasl-enc: DFlPB+9nTlOdF2plPrOibMtyazBt2d3Wh64tO+p9Oqw9 1228326133
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 71A3F22C7B;
	Wed,  3 Dec 2008 12:42:13 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <loom.20081203T152511-351@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102273>

Aaron Harnly venit, vidit, dixit 03.12.2008 16:46:
> This is with git 1.5.6.3 on Ubuntu and Mac OS X.
> 
> Overview: .gitignore patterns ending in \r do not work as expected, apparently
> because the terminal \r is assumed to be part of the newline.
> 
> Steps to Reproduce:
> (NB ^M is the control-M sequence, not a literal caret-M)
> 
> 1. Create an empty repository.
> 2. Create a file named Icon\r (aka Icon^M).
> 3. Add the following pattern to the .gitignore:
> 
> Icon^M
> 
> Expected behavior:
> 
> The file is ignored.
> 
> Actual behavior:
> 
> The file is not ignored.
> 
> Discussion:
> 
> It appears that the parsing of .gitignore files tries to be graceful in allowing
> the file to have CRLF endings, or indeed mixed LF / CRLF endings.
> 
> This is well and good, but poses a bit of a problem for ignoring files whose
> name ends in \r. In particular, Mac OS X's icon files are named Icon\r. Yes,
> this is sick and annoying on the part of Apple.
> 
> I understand the rationale for this behavior, but it probably should be
> documented somewhere. In the meantime, a workaround that does allow the ignoring
> of these files is the pattern:
> 
> Icon^M^M
> 
> where again, the terminal \r seems to be ignored as part of the newline, but the
> penultimate \r gets picked up as part of the pattern.
> 
> Any thoughts on whether:
> 1. this behavior should be left as it is
> 2. there is actually documentation somewhere that I didn't see
> 3. terminal \r in an otherwise all-LF file should be assumed to be part of the
> pattern
> 4. some other alternative?

5. spank Apple
