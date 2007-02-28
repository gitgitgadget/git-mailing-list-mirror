From: Nicolas Pitre <nico@cam.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 14:40:25 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702281439410.29426@xanadu.home>
References: <17893.42063.186763.291346@lisa.zopyra.com>
 <20070228155412.GC5479@spearce.org>
 <17893.43522.511785.121778@lisa.zopyra.com>
 <17893.44181.129918.669187@lisa.zopyra.com>
 <20070228163256.GD5479@spearce.org>
 <118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
 <20070228164922.GB5924@spearce.org>
 <17893.46083.869042.467318@lisa.zopyra.com>
 <20070228170641.GC5924@spearce.org>
 <17893.47007.136145.112498@lisa.zopyra.com>
 <20070228174339.GE5924@spearce.org>
 <17893.54640.150106.294218@lisa.zopyra.com>
 <17893.54980.672279.633902@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUfB-0007Xs-Hi
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbXB1Tk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbXB1Tk1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:40:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34042 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbXB1Tk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:40:26 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE600HL3UND8S10@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Feb 2007 14:40:25 -0500 (EST)
In-reply-to: <17893.54980.672279.633902@lisa.zopyra.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40996>

On Wed, 28 Feb 2007, Bill Lear wrote:

> On Wednesday, February 28, 2007 at 13:18:08 (-0600) Bill Lear writes:
> >
> >% ls -l objects
> >total 88088
> >drwxr-xr-x  2 rael  software     4096 Feb 28 13:05 info/
> >drwxr-xr-x  2 rael  software     4096 Feb 28 13:05 pack/
> >-rw-------  1 rael  software 90099505 Feb 28 13:06 pack_eZwOnG
> 
> I should have added:
> 
> % ls -l ~/devel/fusion/.git/objects/pack/pack-fe532a54e5d549f1cfc70a4ab2c5f4eaac8897a5.pack
> -r--r--r--  1 rael software 90099525 Feb 27 21:36 /home/rael/devel/project/.git/objects/pack/pack-fe532a54e5d549f1cfc70a4ab2c5f4eaac8897a5.pack
> 
> That's 20 bytes of difference.

That is actually OK.  This is the temporary pack file the fetch received 
but which final SHA1 has not been written yet.  Normally, after the 
delta resolution has finished (the part that requires the pread() calls) 
then the final SHA1 is written and the pack is moved to its final 
location under an appropriate name.  But in your case index-pack bailed 
out on the failing pread() and left its incomplete temporary pack there.


Nicolas
