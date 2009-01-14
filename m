From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: ETA for release of gjit 0.4?
Date: Wed, 14 Jan 2009 04:14:35 +0100
Message-ID: <20090114031435.GA31274@diku.dk>
References: <49393BFC.6010606@wellfleetsoftware.com> <493D4CDB.2010100@wellfleetsoftware.com> <4946DFBB.6030300@wellfleetsoftware.com> <200812160517.33975.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Farrukh Najmi <farrukh@wellfleetsoftware.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 04:16:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMwEe-0003xs-2w
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 04:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbZANDOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 22:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbZANDOk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 22:14:40 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:42956 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186AbZANDOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 22:14:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id A272619BCD8;
	Wed, 14 Jan 2009 04:14:37 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02925-03; Wed, 14 Jan 2009 04:14:35 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 395F619BBED;
	Wed, 14 Jan 2009 04:14:35 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B61C56DF823; Wed, 14 Jan 2009 04:13:26 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 1F28B39A9FF; Wed, 14 Jan 2009 04:14:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812160517.33975.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105580>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote Tue, Dec 16, 2008:
> Jonas, could you help us on this:

Sorry for the long delay. I completely overlooked this. In case it is
still relevant ...

> [INFO] ------------------------------------------------------------------------                                                          
> [ERROR] BUILD ERROR                                                                                                                      
> [INFO] ------------------------------------------------------------------------                                                          
> [INFO] Error deploying artifact: Failed to transfer file: http://egit.googlecode.com/svn/maven/snapshot-repository//org/spearce/jgit/0.4.0/jgit-0.4.0.jar. Return code is: 401                                                                                                                                            
> 
> I added this (nah, naming it release-repository didn't work either)
> 
>         <repository>
>             <id>jgit-maven-release-repository</id>
>             <name>JGit Maven Release Repository</name>
>             <url>https://egit.googlecode.com/svn/maven/snapshot-repository/</url>
>             <uniqueVersion>true</uniqueVersion>
>         </repository>

This will end up mixing snapshots and releases ...
 
> (tried all combinations of dav/not-dav, http/https). Seems I don't have a dav provider, 
> but https should work, right?

Well, I don't know, but I would expect the "dav:" to be required. I used
the Google Maven Repository pom.xml[0] as a template, which should give
something like:

  <repository>
    <id>jgit-maven-repository</id>
    <name>JGit Maven Repository</name>
    <url>dav:https://egit.googlecode.com/svn/maven/repository/</url>
  </repository>

 [0] http://google-maven-repository.googlecode.com/svn/snapshot-repository/com/google/google/1-SNAPSHOT/google-1-20080826.150842-5.pom

> and to ~/.m2/settings.xml
> 
>   <servers>
>     <server>
>       <id>jgit-maven-snapshot-repository</id>
>       <username>tried both my project email and gmail email</username>
>       <password>nah, won't show you</password>
>     </server>
>   </servers>

Try:

  <servers>
    <server>
      <id>jgit-maven-repository</id>
      <username>robin.rosenberg</username>
      <password>Password from http://code.google.com/hosting/settings</password>
    </server>
  </servers>

Hope this helps.

-- 
Jonas Fonseca
