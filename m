From: Stephen Bash <bash@genarts.com>
Subject: Re: SVN -> Git *but* with special changes
Date: Wed, 28 Sep 2011 13:10:52 -0400 (EDT)
Message-ID: <16808473.33899.1317229852319.JavaMail.root@mail.hq.genarts.com>
References: <1317227849979-6840904.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Abscissa <bus_nabble_git@semitwist.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 19:11:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8xf9-00076L-3r
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 19:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab1I1RLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 13:11:09 -0400
Received: from hq.genarts.com ([173.9.65.1]:56593 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753025Ab1I1RLI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 13:11:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 7F93BEA2313;
	Wed, 28 Sep 2011 13:11:02 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J+T7z4Nof5Tb; Wed, 28 Sep 2011 13:10:52 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 75014EA23AC;
	Wed, 28 Sep 2011 13:10:52 -0400 (EDT)
In-Reply-To: <1317227849979-6840904.post@n2.nabble.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182347>

----- Original Message -----
> From: "Abscissa" <bus_nabble_git@semitwist.com>
> To: git@vger.kernel.org
> Sent: Wednesday, September 28, 2011 12:37:29 PM
> Subject: SVN -> Git *but* with special changes
>
> I have a couple big projects in SVN that I'd like to convert to Git.
> Being in SVN, they've operated under a couple assumptions that are 
> not true under Git. These assumptions are:
> 
> 1. Directories can exist even if there's nothing in them (just like
> any filesystem).

What requires the empty directories to exist?  The build system?  Can you just let them go away in Git and fix it downstream in the user's working copy?
 
> 2. Keeping binary files in version control isn't a big deal because
> the whole repo doesn't get copied to everyone's system or use up 
> people's GitHub storage space.

I'd eliminate these on the SVN side before converting to Git.  If you have svnadmin access to the SVN repo svnadmin dump, svndumpfilter, svnadmin load is a pretty easy process.

> The SVN repos have been relying on those, but both are false under
> Git, so I need to do a "modified" conversion, rather than just a 
> straight one.
> 
> So, how can I convert an SVN repo to Git, and have the conversion add
> dummy files to empty directories and exclude specific files? (Also, 
> there are tags and branches to be converted too, in the SVN-standard 
> "tags" and "branches" directories.)

To do the actual conversion, svn-fe and git fast-import are by far the quickest way to get the data into Git.  Filtering into tags and branches is a bit of a trick though [1].  git-svn has (IMO) a good branching UI, but can be very slow for large repositories.

[1] http://thread.gmane.org/gmane.comp.version-control.git/158940/focus=159151 : note this thread is almost a year out of date now, and even I know much better ways to go about this now -- but the scripts are not written.

HTH,
Stephen
