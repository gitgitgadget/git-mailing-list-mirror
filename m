From: Nicolas Pitre <nico@cam.org>
Subject: Re: Better value for chunk_size when threaded
Date: Thu, 06 Dec 2007 20:27:44 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712062014060.555@xanadu.home>
References: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 02:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0S0c-0005CH-PI
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 02:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbXLGB1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 20:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbXLGB1q
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 20:27:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22760 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbXLGB1q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 20:27:46 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSN00HTXO29T930@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Dec 2007 20:27:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67364>

On Thu, 6 Dec 2007, Jon Smirl wrote:

> I tried some various ideas out for chunk_size and the best strategy I
> found was to simply set it to a constant. How does 20,000 work on
> other CPUs?

That depends on the object size.  If you have a repo with big objects 
but only 1000 of them for example, then the constant doesn't work.

Ideally I'd opt for a value that tend towards around 5 seconds worth of 
work per segment, or something like that.  Maybe using the actual 
objects size could be another way.

> I'd turn on default threaded support with this change. With threads=1
> versus non-threaded there is no appreciable difference in the time.

Would need a way to determine pthreads availability from Makefile.

> Is there an API to ask how many CPUs are in the system? It would be
> nice to default the number of threads equal to the number of CPUs and
> only use pack.threads=X to override.

If there is one besides futzing with /proc/cpuinfo I'd like to know 
about it.  Bonus points if it is portable.


Nicolas
