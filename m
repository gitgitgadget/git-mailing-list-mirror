From: Axel Freyn <axel-freyn@gmx.de>
Subject: Re: How to recovery a corrupted git repo
Date: Mon, 21 Feb 2011 11:04:54 +0100
Message-ID: <20110221100454.GM22168@axel>
References: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSdm-0004OB-7L
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab1BUKFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 05:05:06 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:37588 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754544Ab1BUKFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 05:05:05 -0500
Received: (qmail invoked by alias); 21 Feb 2011 10:05:01 -0000
Received: from LN-mac29.grenoble.cnrs.fr (EHLO axel) [147.173.67.29]
  by mail.gmx.net (mp062) with SMTP; 21 Feb 2011 11:05:01 +0100
X-Authenticated: #5679941
X-Provags-ID: V01U2FsdGVkX19FK+w60NxFu3DmpphwWtv+JBDc/dGORUyMiVKWav
	G94Gr3snzLnwpX
Mail-Followup-To: git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167453>

Hi,
On Mon, Feb 21, 2011 at 03:50:09PM +0800, Ping Yin wrote:
> I have a corrupted git repo, with "git fsck", it shows
> 
> missing blob b71eb55f2dbc97dafd4a769fc61f346e69a5e0af
> missing blob 282035f3ae964e1e288f352c370be8edd11d3078
> missing tree 3c20f556eecc476e3542cc522d46a62a4461fec6
> missing blob f321b578edeb452358497e832815d6cae6b36886
> missing commit 6d23f5084c975be637f7d748db82116bf84d3872
> 
> And i also have a good backup repo. How can i recover the corrupted
> repo with the backup repo?
> 
> I can do a rsync or fresh "git clone", however, is there any git
> related commands to incrementally do this?
I don't know whether there is a single git command to do it, but you can
copy those 5 objects "by hand": in your backup, you should have a
directory .git/objects, where you have the files
   b7/1eb55f2dbc97dafd4a769fc61f346e69a5e0af
   28/2035f3ae964e1e288f352c370be8edd11d3078
   3c/20f556eecc476e3542cc522d46a62a4461fec6
   f3/21b578edeb452358497e832815d6cae6b36886
   6d/23f5084c975be637f7d748db82116bf84d3872

It should be sufficient to just copy those files into the corrupted
repo.

However if you packed the git-files in the backup (e.g. by running "git
gc"), those objects might be found in a pack in .git/objects/pack.
The easiest ist probably to use git-unpack-objects to unpack the
objects, and then copy the 5 missing objects.

Axel

PS: Well, I'm using git and I like it -- but I'm no specialist; so first
do a backup, before you follow my proposal ;-)
