From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Why not clone to a remote directory over SSH
Date: Wed, 23 Nov 2005 17:04:09 -0800
Message-ID: <20051124010409.GQ3968@reactrix.com>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <20051123230838.GN3968@reactrix.com> <4384F7F6.10404@op5.se> <20051123232829.GO3968@reactrix.com> <Pine.LNX.4.63.0511240043300.11106@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 02:05:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef5XE-0000Pv-RL
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 02:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbVKXBEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbVKXBEW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 20:04:22 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:63406 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030574AbVKXBEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 20:04:21 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAO149tQ012273;
	Wed, 23 Nov 2005 17:04:09 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAO149a0012271;
	Wed, 23 Nov 2005 17:04:09 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511240043300.11106@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12668>

On Thu, Nov 24, 2005 at 12:45:18AM +0100, Johannes Schindelin wrote:

> BTW, is it possible to convince git-http-push to store packs on the 
> server?

Certainly, I'm not sure what conditions make sense for using packs
though.

When pushing changes to the server, there's an advantage to using loose
objects in that there is no way to resume a failed transfer.  So if the
network barfs 99% of the way through, you'll be much less annoyed if
you need to retransmit the one object rather than a whole pack.

The same problem exists if you decide to pack loose objects on the
server since the pack would have to be generated locally and then sent
to the server.  At least in this case, other remote clients would still
be able to fetch loose objects while packs were in transit.

> For that matter, is it possible to generate the file(s) needed for a dumb
> server on the client side?

Which files are those?  I've been working on a way to update info/refs
and eventually objects/info/packs.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
