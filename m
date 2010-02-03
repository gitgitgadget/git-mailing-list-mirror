From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 14:53:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002031436490.1681@xanadu.home>
References: <ron1-32BD5F.10255403022010@news.gmane.org>
 <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com>
 <ron1-5F71CB.11234903022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:57:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclLr-0002BA-2M
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702Ab0BCT5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:57:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44880 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625Ab0BCT5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:57:21 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXA002IT78ZXR21@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 14:53:23 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ron1-5F71CB.11234903022010@news.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138878>

On Wed, 3 Feb 2010, Ron Garret wrote:

> So... how *does* git decide when two blobs are different blobs and when 
> they are the same blob with mods?  I asked this question before and was 
> pointed to the diffcore docs, but that didn't really clear things up.  
> That just describes all the different ways git can do diffs, not the 
> actual heuristics that git uses to track content.

Yes, those same heuristics are used to make the decision.

|The second transformation in the chain is diffcore-break, and is
|controlled by the -B option to the 'git diff-{asterisk}' commands.  
|This is used to detect a filepair that represents "complete rewrite" 
|and break such filepair into two filepairs that represent delete and
|create.
|[...]

|This transformation is used to detect renames and copies, and is
|controlled by the -M option (to detect renames) and the -C option
|(to detect copies as well) to the 'git diff-{asterisk}' commands.  
|[...]

Note that you may use the -B, -C, -M and --find-copies-harder arguments 
with log as well as diff commands even if there is no actual diff 
output.  So the explanation is really in that document even if simple 
rename detection is concerned only by a fraction of what is said there.

And Git can detect copied files too.

Those semantics are not stored in the repository so they can be improved 
or even changed after the facts.


Nicolas
