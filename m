From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn doesn't like !! in the url
Date: Mon, 7 Jan 2008 02:30:40 -0800
Message-ID: <20080107103040.GA28557@soma>
References: <EA596F68-D87B-49AD-9DEF-2C2E07127BDE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Michael J. Cohen" <michael.joseph.cohen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 11:31:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBpGA-0003FA-6Q
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 11:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbYAGKan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 05:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbYAGKan
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 05:30:43 -0500
Received: from hand.yhbt.net ([66.150.188.102]:32940 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbYAGKan (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 05:30:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 61D242DC08B;
	Mon,  7 Jan 2008 02:30:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <EA596F68-D87B-49AD-9DEF-2C2E07127BDE@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69781>

"Michael J. Cohen" <michael.joseph.cohen@gmail.com> wrote:
> I think it needs to urlencode the items before it passes it back to  
> the server.
> 
> W: Ignoring error from SVN, path probably does not exist: (175007):  
> HTTP Path Not Found: REPORT request failed on '/wowace/!svn/bc/100/ 
> trunk/!!!LeaveMeAloneLibraries': '/wowace/!svn/bc/100/trunk/!!! 
> LeaveMeAloneLibraries' path not found
> 
> works fine with svn co.

Hi,

That was just a warning message (hence "W:").  If the path you're
tracking did not have a revision between r0 - r100 in the repository;
then it'll spew that warning once (it used to spew it a lot more).

git-svn looks at old history in chunks starting at the beginning of the
repository to avoid pulling (potentially) hundreds of thousands of
revisions + filenames into memory all at once.

As long as git-svn started importing revisions when the project started,
everything should be alright.



I just dug up cfbe7ab333d68790eb37341e30f040f99cef6af7 and that
should've escaped everything that needs to be urlencoded for HTTP(S).
(you were also the one that noticed the need for that one, too :).

I also just noticed that changeset didn't make it into 1.5.3.7 nor
maint, however...

Junio: if there are plans for 1.5.3.8, could you please add
cfbe7ab333d68790eb37341e30f040f99cef6af7 to it?  Thanks.

-- 
Eric Wong
