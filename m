From: Nicolas Pitre <nico@cam.org>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 11:42:38 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
 <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 17:43:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqrzV-0004m9-DA
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 17:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbYD2Pmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 11:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbYD2Pmr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 11:42:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55335 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbYD2Pmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 11:42:46 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0300LP2FN2W6M0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 Apr 2008 11:42:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <481733A3.4010802@op5.se>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80692>

On Tue, 29 Apr 2008, Andreas Ericsson wrote:

> But they won't, because it's impossible to add two objects with the same
> SHA1 hash key to a git repository, since it will lazily re-use the
> existing one. In practice, this means that in the case of an "innocent"
> hash-collision, git will actually break by refusing to store the new
> content.

I'd also like to point out that Git usually receive "untrusted" new 
objects via the Git protocol through 'git index-pack'.  If you look at 
sha1_object() in index-pack.c, you'll see that active verification 
against hash collision is performed, and the fetch will abruptly be 
aborted if ever that happens.

Yes, writing a test case for this was tricky.  :-)


Nicolas
