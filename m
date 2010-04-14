From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Update on SoC proposal: git-remote-svn
Date: Wed, 14 Apr 2010 22:52:02 +1000
Message-ID: <E7EBCCD4-418B-4573-A70A-B7E06D6C6D50@cordelta.com>
References: <1271136573-sup-5613@kytes> <F0CD5B83-2D28-47E1-A336-5C88E2803CBE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 14:52:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O224k-0001Ew-To
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 14:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab0DNMwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 08:52:09 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:4486
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754582Ab0DNMwI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 08:52:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEANFXxUvLWHsF/2dsb2JhbACbWHG0S4hGhQ0E
X-IronPort-AV: E=Sophos;i="4.52,204,1270389600"; 
   d="scan'208";a="166542820"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 14 Apr 2010 22:52:03 +1000
Received: (qmail 29690 invoked from network); 14 Apr 2010 22:52:03 +1000
Received: from d122-109-106-179.mit3.act.optusnet.com.au (HELO ?192.168.1.8?) (122.109.106.179)
  by node2.alpha.aussiehq.net.au with SMTP; 14 Apr 2010 22:52:03 +1000
In-Reply-To: <F0CD5B83-2D28-47E1-A336-5C88E2803CBE@gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144868>

Hi Steve,

> In reading this I wondered how a svn dump of one of the
> repositories monitor would size.  If I were to check out the svn
> root of that repository, I would use well over 3TB of disk space
> to have that checked out, I filled my 750GB drive with about a
> third of it checked out.  About 256MB of code with thousands
> of tags and hundreds of branches.

I encountered this issue with my first attempt to validate the output of 
my dump conversion tool. My case wasn't as dire, 350GB would
have sufficed but I was working in a 160GB partition.
Checking out tags side by side is a sure way to fill your disk.

> It looks like svnadmin dump defaults to dumping all data.
> Fortunately it has a delta option, which looks like it would be
> needed to dump this repository I am speaking of without filling
> up many hard drives.

The svn dump format is not quite that silly, even without deltification
it doesn't output blobs that are just an unaltered copy from a
previous revision.
Handling deltified dumps will greatly increase the complexity of the
import process. Blob content would have be computed from existing
blobs rather than simply passed through.

> This might also be helped if the dumps are chunked into ranges
> for many thousands of commits as well, this would keep the files
> more manageable

Being able to handle a dump stream reassembled from such
piecewise dumps is an important feature which I haven't finished
implementing yet.

> Just food for thought.

Thanks for the feed.

--
David Barr
