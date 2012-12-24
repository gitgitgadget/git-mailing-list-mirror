From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Mon, 24 Dec 2012 14:52:38 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121224195238.GA29663@thyrsus.com>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
 <20121224133649.GA1400@padd.com>
 <20121224153257.GA28213@thyrsus.com>
 <7v7go7nu1f.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 20:53:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnE5c-0000Eu-IF
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 20:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab2LXTxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 14:53:07 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:36441
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab2LXTxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 14:53:07 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 122514411F; Mon, 24 Dec 2012 14:52:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v7go7nu1f.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212117>

Junio C Hamano <gitster@pobox.com>:
> > Should I resubmit, or do you intend to fix these while merging?
> 
> I'd appreciate a re-roll, perhaps in a few days after the dust
> settles.

You'll get it.

It will take a little longer than it otherwise might have because I'm
in the middle of straightening out the mess around cvsps and git-cvsimport,
which is deeper and nastier than I realized.

It turns out that one of the options git-cvsimport depends on, -A, has
been broken (leading to incorrect conversions of branchy repos) since
2006 if not earlier; I'm removing it outright.

Thus, the version of git-cvsimport in the git-tree will die with an
error calling cvsps 3.x - but since what it was doing before was actually
mangling users' repositories this is no great loss.

I'm going to have to shoot the existing implementation of
git-cvsimport through the head and rewrite it. This won't be
difficult; I already have a proof-of-concept in 126 lines of Python,
which is a big improvement over the 1179 lines of Perl in the existing
version.  Most of the vanished bulk is CVS client code for fetching
logs and files, which is now done better and faster inside cvsps.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
