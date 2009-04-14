From: Nicolas Pitre <nico@cam.org>
Subject: Re: On Tracking Binary Files
Date: Tue, 14 Apr 2009 15:42:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904141532160.6741@xanadu.home>
References: <7efce40a0904140741w28da9b54ucfe4b54bf48b0844@mail.gmail.com>
 <7efce40a0904140742i48aad41ds66de5dfe368f3b16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Patrick Berkeley <patrickberkeley@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 21:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtoXt-00030m-6U
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 21:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbZDNTmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 15:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZDNTmP
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 15:42:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34394 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbZDNTmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 15:42:15 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KI3004ORW27R8H0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 14 Apr 2009 15:42:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7efce40a0904140742i48aad41ds66de5dfe368f3b16@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116560>

On Tue, 14 Apr 2009, Patrick Berkeley wrote:

> Does Git track the deltas on binary files?

Yes.  And actually git's delta storage doesn't care at all whether a 
file is text or binary.

> Someone in #git mentioned that if the binaries change too much Git no 
> longer just stores the changes. If this is the case, what is the 
> breaking point where Git goes from storing the deltas to the entire 
> new file?

If two versions of the same file are simply too different to make delta 
compression worth it, then no deltas are used.  It is still possible 
that a third version of the same file would produce a nice delta against 
either the first or second version though, in which case that third 
version will be stored as a delta.  And so on.

A sophisticated set of euristics is applied to the list of objects as a 
whole to determine the best delta arrangement possible.  So there is no 
such thing as a simple "breaking point".


Nicolas
