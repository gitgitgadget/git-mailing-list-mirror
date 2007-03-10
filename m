From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problems with autoCRLF?
Date: Fri, 09 Mar 2007 17:24:35 -0800
Message-ID: <7v8xe528mk.fsf@assigned-by-dhcp.cox.net>
References: <1173464102.6102.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 02:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPqKA-0004FL-Uw
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 02:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993156AbXCJBYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 20:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993159AbXCJBYh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 20:24:37 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52537 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993156AbXCJBYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 20:24:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310012436.JDBF748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 20:24:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YpQb1W00A1kojtg0000000; Fri, 09 Mar 2007 20:24:35 -0500
In-Reply-To: <1173464102.6102.18.camel@localhost> (Raimund Bauer's message of
	"Fri, 09 Mar 2007 19:15:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41832>

Raimund Bauer <ray007@gmx.net> writes:

> Is it really intended that with a setting core.autoCRLF=true textfiles
> are checked out with crlf-lineendings on linux-boxes?

Yes.  The implicit assumption with any setting to core.autoCRLF
is that you want to keep the git objects free of CRLF line
endings.

 - core.autoCRLF 'true' means that your tools that handle text
   files would be upset findign LF line endings, and they will
   leave text in CRLF line endings.  Checking out from git
   creates working tree files while adding CR before LF as
   needed, and checking in from working tree files to git strips
   CR before LF as needed.

 - core.autoCRLF 'input' means that your tools do not mind
   handling text files in LF line endings and they will leave
   text in CRLF line endings, so checking out from git creates
   working tree files by just giving what is stored in the
   repository, and checking in from working tree files to git
   strips CR before LF as needed.

So on sane platforms, you do not want to set that variable,
unless you are helping to test and improve that feature.
