From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: How git affects kernel.org performance
Date: Mon, 8 Jan 2007 18:18:12 -0800
Message-ID: <20070109021812.GE44262@sgi.com>
References: <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org> <45A24A65.1070706@garzik.org> <20070108170934.dafc5b81.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>, tytso@mit.edu, suparna@in.ibm.com,
	akpm@osdl.org, w@1wt.eu, torvalds@osdl.org, hpa@zytor.com,
	git@vger.kernel.org, nigel@nigel.suspend2.net, warthog9@kernel.org,
	randy.dunlap@oracle.com, pavel@ucw.cz,
	linux-kernel@vger.kernel.org, webmaster@kernel.org,
	linux-ext4@vger.kernel.org
X-From: linux-ext4-owner@vger.kernel.org Tue Jan 09 03:19:21 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H46a5-0002IA-8R
	for gcfe-linux-ext4@gmane.org; Tue, 09 Jan 2007 03:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbXAICTF (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Mon, 8 Jan 2007 21:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbXAICTF
	(ORCPT <rfc822;linux-ext4-outgoing>); Mon, 8 Jan 2007 21:19:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:37587 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750939AbXAICTB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Mon, 8 Jan 2007 21:19:01 -0500
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id l095A04R027834;
	Mon, 8 Jan 2007 21:10:00 -0800
Received: from classic.engr.sgi.com (classic.engr.sgi.com [150.166.2.36])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with ESMTP id l092I1bC78367927;
	Mon, 8 Jan 2007 18:18:02 -0800 (PST)
Received: from classic.engr.sgi.com (localhost [127.0.0.1])
	by classic.engr.sgi.com (SGI-8.12.11.20060308/8.12.11) with ESMTP id l092IEA8045083;
	Mon, 8 Jan 2007 18:18:14 -0800 (PST)
Received: (from jeremy@localhost)
	by classic.engr.sgi.com (SGI-8.12.11.20060308/8.12.11/Submit) id l092ICn0045079;
	Mon, 8 Jan 2007 18:18:12 -0800 (PST)
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20070108170934.dafc5b81.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36297>

On Mon, Jan 08, 2007 at 05:09:34PM -0800, Paul Jackson wrote:
> Jeff wrote:
> > Something I just thought of:  ATA and SCSI hard disks do their own
> > read-ahead.
> 
> Probably this is wishful thinking on my part, but I would have hoped
> that most of the read-ahead they did was for stuff that happened to be
> on the cylinder they were reading anyway.  So long as their read-ahead
> doesn't cause much extra or delayed disk head motion, what does it
> matter?


And they usually won't readahead if there is another command to
process, though they can be set up to read unrequested data in
spite of outstanding commands.

When they are reading ahead, they'll only fetch LBAs beyond the last
request until a buffer fills or the readahead gets interrupted.

jeremy
