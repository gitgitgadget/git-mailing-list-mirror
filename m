From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: egit problem with sym linked eclipse project dirs
Date: Fri, 23 Jan 2009 22:33:59 +0100
Message-ID: <200901232233.59232.robin.rosenberg.lists@dewire.com>
References: <p0624081cc5928e2885fd@[192.168.1.114]> <p0624085fc592d385c7fb@[192.168.1.114]> <p06240812c59ed365d694@[192.168.1.106]>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:35:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQTgZ-0002r8-ND
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 22:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbZAWVeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 16:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbZAWVeI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 16:34:08 -0500
Received: from mail.dewire.com ([83.140.172.130]:24563 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755454AbZAWVeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 16:34:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 570D2147E6F7;
	Fri, 23 Jan 2009 22:34:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rRN7q12hwBJl; Fri, 23 Jan 2009 22:33:59 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id BAF2D8026F3;
	Fri, 23 Jan 2009 22:33:59 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <p06240812c59ed365d694@[192.168.1.106]>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106918>

fredag 23 januari 2009 02:56:16 skrev Stephen Bannasch:
> At 6:27 PM -0500 1/13/09, Stephen Bannasch wrote:
...
> >Done: http://code.google.com/p/egit/issues/detail?id=52
> >
> >Fxing this will make using Eclipse and Git together SO much nicer!
> 
> Robin and Shawn,
> 
> Can you suggest where in the egit code I should look to see if I can fix this?

There may be more than one place. 

Take a look at GitResourceDecorator. 

We map from resources using code like this:
	RepositoryMapping.getMapping(rsrc) // <-- prime suspect
	Repository.getRepoRelativePath(rsrc)
	Repository.getWorkDir
	Repository.isResourceChanged

I'm not entirely sure this is the correct way, but it probably has no
bearing on your problem.

	GitResourceDecorator decorator = getActiveDecorator();

It would be nice with a unit test for this. (Not necessarily the decorator,
but the methods used for it).

-- robin
