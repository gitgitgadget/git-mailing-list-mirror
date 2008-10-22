From: Nicolas Pitre <nico@cam.org>
Subject: Re: error: packfile while git fsck
Date: Wed, 22 Oct 2008 13:35:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810221323270.26244@xanadu.home>
References: <48FF337F.3050505@atmel.com>
 <alpine.LFD.2.00.0810221049340.26244@xanadu.home> <48FF4521.5070303@atmel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 19:37:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kshe8-0003vj-E1
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 19:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758007AbYJVRgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 13:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757762AbYJVRgI
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 13:36:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45987 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758005AbYJVRgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 13:36:06 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9500KM3I7ZSJXI@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Oct 2008 13:35:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <48FF4521.5070303@atmel.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98886>

On Wed, 22 Oct 2008, Nicolas Ferre wrote:

> Nicolas Pitre :
> > On Wed, 22 Oct 2008, Nicolas Ferre wrote:
> > 
> > > Hi all,
> > > (please cc me on response)
> > > 
> > > I am facing error during git status & git fsck on my tree.
> > > This tree is cloned from various linux kernel trees.
> > > 
> > > Here are a sample of the error I see :
> > > 
> > > $ git fsck
> > > error: packfile
> > > .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does
> > > not
> > > match index
> > > error: packfile
> > > .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack
> > > cannot be
> > > accessed
> > [...]
> > 
> > What git version?
> 
> $ git --version
> git version 1.5.3.7

OK.  Since this is not bleeding edge, it is pretty unlikely that the 
corruption is due to git itself.  Furthermore, the git packs are always 
read only once they've been created, meaning that if they weren't 
corrupted at some point then something outside of git caused the 
corruption.  You really should consider the possible causes for that 
(dying disk, pilot error, etc).

As to recovery... That really depends if you have personal work 
committed to your repository.  If not then the easiest solution is 
simply to recreate it by refetching from upstream.   If you have 
personal work in there then you could try to fetch your work branch into 
the newly created repository.  The latest git version could help with 
the extraction of non-corrupted objects out of a bad pack, but if the 
objects you are interested in are themselves corrupted then your only 
hope is to have a copy of those objects somewhere else.


Nicolas
