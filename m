From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/6] convert object type handling from a string to a number
Date: Tue, 27 Feb 2007 10:33:55 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702271029060.29426@xanadu.home>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
 <11725197613482-git-send-email-nico@cam.org>
 <11725197622423-git-send-email-nico@cam.org>
 <11725197633144-git-send-email-nico@cam.org>
 <11725197632516-git-send-email-nico@cam.org>
 <7vejobhor2.fsf@assigned-by-dhcp.cox.net> <20070227150126.GA3230@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4L2-0001bq-Gk
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXB0Pd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbXB0Pd4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:33:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9484 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbXB0Pd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:33:56 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE40022POKJ1CY1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 10:33:55 -0500 (EST)
In-reply-to: <20070227150126.GA3230@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40747>

On Tue, 27 Feb 2007, Shawn O. Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > I am wondering if "enum object_type" and signed comparison here
> > are compatible.  sha1_object_info() is of type "int" so that is
> > clearly signed, but are we safe assuming this would not result
> > in "type is unsigned and condition is always false"?
> 
> See my recent patch; I actually rewrote those hunks to use OBJ_BAD
> rather than < 0, as this cleans things up for my packv4.

I'd prefer if < 0 remained though.  That way we can use negative values 
for any kind of error status.  And for kernel hackers this is a pretty 
common idiom.  And it uses less line realestate.

Actually OBJ_BAD could be assigned the value -1 and OBJ_MAX used to 
verify the object number is within range.  That would unify things and 
make the code a bit more logical.


Nicolas
