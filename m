From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: core.autocrlf considered half-assed
Date: Mon, 8 Mar 2010 20:15:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003082011440.14277@intel-tinevez-2-302>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de> <20100307092701.GC31105@dpotapov.dyndns.org> <alpine.LFD.2.00.1003071538350.30214@localhost.localdomain> <20100308185719.GQ2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	gitster@pobox.com
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 20:17:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoiSL-0004zV-5c
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 20:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab0CHTR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 14:17:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:45354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753458Ab0CHTR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 14:17:27 -0500
Received: (qmail invoked by alias); 08 Mar 2010 19:15:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp035) with SMTP; 08 Mar 2010 20:15:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iTKYx3deiOBUNP7viw8mtHgKnxvaFD5TJClpc9T
	vOzZxJI2fmeEkK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100308185719.GQ2480@ece.pdx.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141779>

Hi,

On Mon, 8 Mar 2010, Tait wrote:

> > I do agree. It would probably have been a good idea to mark the CRLF 
> > status in the index, but we didn't...
> 
> We already have .gitattributes for tracking information about files. 
> Maybe add an attribute to describe the in-repository line endings? The 
> default would be LF, as now, and a new attribute could change the 
> checked-in format to be CRLF.

No.

The problem is not the description of the line endings in the repository. 
The information what line endings are used can be easily extracted from 
every blob, by a simple inspection.

The problem is that the core.autocrlf code blindly assumes that Unix line 
endings are the only thing you would ever commit. And worse, the mistake 
is repeated when updating the index. Git converts the DOS line endings 
into Unix line endings, then compares with what it has in the repository 
and says: "Ooops, it is different!" even if it just checked the files out.

And I demonstrated with the "html" example that even long-time Gitsters 
sometimes commit DOS line endings as-are, unconverted.

Ciao,
Dscho
