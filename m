From: Nicolas Pitre <nico@cam.org>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 11:47:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905201144040.3906@xanadu.home>
References: <4A136C40.6020808@workspacewhiz.com>
 <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
 <20090520032139.GB10212@coredump.intra.peff.net>
 <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
 <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
 <alpine.LFD.2.00.0905200853010.3906@xanadu.home>
 <96BC1064-EEEF-48BC-B79A-9D15C517CF47@wincent.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_yOc5avP4XAMzQNrcRyNcfg)"
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed May 20 17:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6o1V-00056T-A2
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 17:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbZETPr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 11:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbZETPr4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 11:47:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57632 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbZETPrz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 11:47:55 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KJY00J1997PV5B0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 May 2009 11:47:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <96BC1064-EEEF-48BC-B79A-9D15C517CF47@wincent.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119617>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_yOc5avP4XAMzQNrcRyNcfg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 20 May 2009, Wincent Colaiuta wrote:

> El 20/5/2009, a las 14:53, Nicolas Pitre escribió:
> 
> > On Wed, 20 May 2009, Wincent Colaiuta wrote:
> > 
> > > El 20/5/2009, a las 5:35, Nicolas Pitre escribió:
> > > 
> > > > Having a "trash" reflog would solve this unambiguously.  That could also
> > > > include your index example above.  However, in the index case, I'd
> > > > record a reflog entry only if you're about to discard a previously non
> > > > committed entry.  If you do:
> > > > 
> > > > 	$ git add foo
> > > > 	$ git add bar
> > > > 	$ git commit
> > > > 	$ hack hack hack
> > > > 	$ git add foo
> > > > 
> > > > then in this case there is nothing to be lost hence no additional entry
> > > > in the "trash" reflog.
> > > 
> > > That's true in the example you provide, but it doesn't really handle
> > > Jeff's
> > > initial example ("git add" twice on the same file), where it is possible
> > > to
> > > throw away intermediate state (by overwriting).
> > 
> > Did I disagree with Jeff's original example?
> 
> No, but I may have misinterpreted you; I understood that you said you wouldn't
> store intermediate index state after successive "git add" executions.

I wouldn't if those states don't discard data.  If you 'git add foo' and 
then 'git add bar' you don't lose anything.  If you do two 'git add foo' 
and the second one would discard the previous state of foo which is 
different from the new one _then_ it is worth adding a reflog entry for 
the otherwise about to be lost state. 


Nicolas

--Boundary_(ID_yOc5avP4XAMzQNrcRyNcfg)--
