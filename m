From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 20:45:49 +0200
Message-ID: <20070524184549.GW942MdfPADPa@greensroom.kotnet.org>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
 <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
 <20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
 <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
 <20070520155407.GC27087@efreet.light.src>
 <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
 <20070521165938.GA4118@efreet.light.src>
 <20070521211133.GD5412@admingilde.org>
 <7viraixeme.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Martin Waitz <tali@admingilde.org>, Jan Hudec <bulb@ucw.cz>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 20:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIJv-0001iB-5k
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbXEXSpw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbXEXSpw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:45:52 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:48504 "EHLO smtp16.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbXEXSpv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 14:45:51 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIK006686SDBH@smtp16.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 20:45:50 +0200 (CEST)
Received: (qmail 6985 invoked by uid 500); Thu, 24 May 2007 18:45:49 +0000
In-reply-to: <7viraixeme.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48290>

On Thu, May 24, 2007 at 11:26:01AM -0700, Junio C Hamano wrote:
> How about doing something like this, instead?
> 
>  (1) superproject .gitmodules (in-tree) and .git/config (local
>      repository) use the three-level naming in $gmane/47567.
>      Namely, (1a) .gitmodules says which subdirectory has a
>      checkout of what project, and names the project in
>      logical/abstract terms, not with a URL (e.g. "kernel26");
>      (1b) .gitmodules also associates a set of suggested URLs
>      for each of the logical/abstract project name; (1c)
>      .git/config records which project are of interest.

What about the idea of considering any project that is already
present to be of interest by default ?

>  (2) In superproject .git/, we would have a bare repository for
>      each project used by the superproject.
> 
> 	.git/subproject/kernel26/{objects,refs,...}
> 
>      This is created by making a bare clone from the upstream
>      URL, decided by the user with the help from suggested URL
>      described in the superproject .gitmodules.

Do you mean a "pure" clone, i.e., without a working tree,
but with separate-remotes?

>      (4b) It has the same logical/abstract project checked out;
>      the commit recorded in the superproject tree may or may not
>      be the same as what its HEAD points at.  In this case we do
>      not have to worry about swapping the git repository at
>      kernel-src/ directory, although we would need to check out
>      the correct revision, and worry about what to do with any
>      local modification (I think the usual "don't lose local
>      modification but carry them forward" rule would be Ok in
>      this case).

We may also need to fetch from the remote subproject.
Should I do this with a "git fetch" during the checkout as I do now?

skimo
