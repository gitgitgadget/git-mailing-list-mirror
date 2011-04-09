From: Chris Webb <chris@arachsys.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Sat, 9 Apr 2011 09:11:08 +0100
Message-ID: <20110409081108.GE13750@arachsys.com>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
 <4D9EDCEA.9010903@drmicha.warpmail.net>
 <20110408185924.GA25840@elie>
 <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
 <20110408194548.GA26094@elie>
 <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org>
 <BANLkTi=3LPRzohnZStAogddpL5ZLehb97Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thorsten Glaser <tg@mirbsd.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 10:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8TQz-0008KH-D6
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 10:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab1DIIWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 04:22:16 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:41281 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab1DIIWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 04:22:15 -0400
X-Greylist: delayed 656 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Apr 2011 04:22:14 EDT
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Q8TGD-0002w8-Ev; Sat, 09 Apr 2011 09:11:14 +0100
Content-Disposition: inline
In-Reply-To: <BANLkTi=3LPRzohnZStAogddpL5ZLehb97Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171187>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> * In most cases I can think of, it would be preferable to track
> changes in metadata along with the actual files.
> 
> * It should be possible for other repositories to ignore this metadata.
> 
> * I am not sure if notes are suitable for this. Using notes.displayRef
> to hide those notes is an option, but it would force everyone to set
> this up locally. Else, it would be very spammy.
> 
> * .gitattributes is too important to fill with potentially thousands
> of lines, imo. Using it to define what metadata should be stored would
> make sense, though.
> 
> * would a .gitmetadata make sense for storage? Alternatively, a
> .git/objects/??/*.metadata per object could make sense.

One other possibility which occurs: would it be possible to store
permissions, attributes and so on in a header line (or header lines) in the
blob itself, which are stripped from the file and applied to the filesystem
by a smudge filter, and added back by a clean filter?

If it works sensibly, this is roughly equivalent to adding a .gitmetadata
file as you suggest above, except that the permissions and attribute data
are stored with each file, so the resulting diffs will be nicer and merges
should always be trivial without any special handling.

(Disclaimer: I've never tried using smudge filters; maybe they can't be used
in the way I describe!)

Cheers,

Chris.
