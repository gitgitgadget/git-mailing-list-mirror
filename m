From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] series headers
Date: Tue, 10 Jul 2007 02:14:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707100126250.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 08:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I88zM-00016m-EO
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 08:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbXGJGOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 02:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbXGJGOE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 02:14:04 -0400
Received: from iabervon.org ([66.92.72.58]:4478 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbXGJGOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 02:14:03 -0400
Received: (qmail 21460 invoked by uid 1000); 10 Jul 2007 06:14:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2007 06:14:00 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52046>

I'd like to be able to get format-patch to produce a [PATCH 0/N] message, 
with a message that's actually in my repository, plus various goodies 
generated either from diffing the ends of the series or by running through 
the log an extra time to pick up summary information.

The second best idea I have for this currently is to have a commit at the 
end of the series which specifies which has the same tree as its parent 
and has a message with a line "Since <sha1 of the first commit of the 
series>" and has the text. This goes at the end of the series, because it 
describes the state with all of the changes made, which is only a good 
description of a commit at the end of the series, not a commit at the 
start of the series. Making it [PATCH 0/N] is just because it belongs 
first in presentation, regardless of whether the other commits are 
presented with recent commits first or last.

The better idea I just had was to have format-patch notice if the "until" 
side is a tag object instead of a commit, and generate a [0/N] with the 
tag message.

As far as implementing this... would it be sane to make struct 
rev_info.commit_format a callback, so that the code to generate an email 
message can be somewhere that's easy to use to generate an email that 
isn't for a commit in the log? I don't *think* git's quite fast enough for 
the indirect jump to a callback instead of an if tree for an enum will 
actually hurt us.

	-Daniel
*This .sig left intentionally blank*
