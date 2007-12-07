From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] Add a --nosort option to pack-objects
Date: Fri, 07 Dec 2007 17:20:59 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712071707250.555@xanadu.home>
References: <1197061832-8489-1-git-send-email-mh@glandium.org>
 <7v4peu19kr.fsf@gitster.siamese.dyndns.org>
 <20071207214627.GB13170@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:21:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0lZR-00031A-NP
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 23:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbXLGWVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 17:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbXLGWVB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 17:21:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61893 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbXLGWVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 17:21:00 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP001WWA2ZH650@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Dec 2007 17:20:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071207214627.GB13170@glandium.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67483>

On Fri, 7 Dec 2007, Mike Hommey wrote:

> As you can seen from my other message, I'm *actually* not sure this is
> really material for git as a VCS. I will add documentation unrelated to
> --nosort to pack-objects anyways.

Well, I have serious doubts about this patch in the first place.

I think it is simply unneeded.

If you want pack-objects not to change the sort order because you have 
some sorting of your own, externally implemented, then you simply have 
to run git-pack-objects feeding it the list of object SHA1s along with a 
tag of your own which will effectively impose the sorting you want, 
based on that tag.

Objects with the same tag will still be sorted amongst themselves which 
is still a good thing.

for example, you may have something like:

	git rev-list --all --objects |
	sed -e 's|foo/logs/.*|LOGS|' |
	git pack-objects ...

This will effectively cluster all foo/logs/* files together for delta 
compression regardless of their actual name.  Maybe that's what you 
really want?


Nicolas
