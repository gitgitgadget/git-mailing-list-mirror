From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Why not clone to a remote directory over SSH
Date: Fri, 25 Nov 2005 12:26:40 -0800
Message-ID: <20051125202640.GS3968@reactrix.com>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <20051123230838.GN3968@reactrix.com> <4384F7F6.10404@op5.se> <20051123232829.GO3968@reactrix.com> <Pine.LNX.4.63.0511240043300.11106@wbgn013.biozentrum.uni-wuerzburg.de> <20051124010409.GQ3968@reactrix.com> <Pine.LNX.4.63.0511241136370.12985@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 21:28:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfkAR-0002IT-TI
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 21:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbVKYU0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 15:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbVKYU0x
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 15:26:53 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:20569 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751476AbVKYU0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 15:26:53 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAPKQfFC022357;
	Fri, 25 Nov 2005 12:26:41 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAPKQeqh022355;
	Fri, 25 Nov 2005 12:26:40 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511241136370.12985@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12749>

On Thu, Nov 24, 2005 at 11:36:58AM +0100, Johannes Schindelin wrote:

> > > For that matter, is it possible to generate the file(s) needed for a dumb
> > > server on the client side?
> > 
> > Which files are those?  I've been working on a way to update info/refs
> > and eventually objects/info/packs.
> 
> These I meant.

Yes - it should be straightforward to generate those files on the client
side.  A PROPFIND request for the remote directory with Depth: 1 will
return a list of files in the directory, so refs and objects/packs can
be crawled to generate the contents of the server info files.  That's
assuming that packs and tags are being pushed of course.

Come to think of it, PROPFIND is probably a more efficient way to check
for the existence of an object in the remote repo as well.  That would
make it feasible to remove the --complete option and always verify the
full history.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
