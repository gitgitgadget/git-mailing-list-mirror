From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 15:42:50 -0800
Message-ID: <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
	<Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
	<7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:42:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkp0-0007Ly-TU
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbXBLXmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbXBLXmx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:42:53 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42464 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030511AbXBLXmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:42:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212234252.YNJF1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 18:42:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nniq1W00q1kojtg0000000; Mon, 12 Feb 2007 18:42:51 -0500
In-Reply-To: <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 13 Feb 2007 00:24:55 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39460>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 12 Feb 2007, Junio C Hamano wrote:
>
>> I agree that we can assume editors can grok files with LF end-of-line 
>> just fine and we would not need to do the reverse conversion on checkout 
>> paths (e.g. "read-tree -u", "checkout-index").
>
> In that case, a simple pre-commit hook would suffice.
>
> No, the problem mentioned by Mark was a very real one: you _cannot_ rely 
> on Windows' editors not to fsck up with line endings. The worst case is if 
> the file contains _some_ CRLF and _some _LF_. Almost always I had the 
> problem that it now converted _all_ LFs to CRLFs. Even those which already 
> were converted.
>
> So, if we are to support text mode, it is not one-way. If we do one-way, 
> we really do _not_ support text mode, but pre-commit conversion to LF 
> style text. And in this case, core git does not need _any_ change.

Well I disagree in two counts.

 - I do not see how you propose to solve some CRLF and some LF
   case with both-ways conversion.

 - Pre-commit hook would not be sufficient.  In a edit, diff,
   test and then commit cycle, diff and test step needs to look
   at whatever the editor left on the filesystem, so the changes
   to populate-filespec is needed to make diff part work.


   
