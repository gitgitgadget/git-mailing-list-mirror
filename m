From: Gabe McArthur <gabriel.mcarthur@gmail.com>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 05:00:37 +0000 (UTC)
Message-ID: <loom.20090904T064602-511@post.gmane.org>
References: <4A9EFFB1.9090501@codeaurora.org> <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de> <20090903012207.GF1033@spearce.org> <2c6b72b30909030545y4465b5c8j4b2b5587a07762c0@mail.gmail.com> <20090903144227.GH1033@spearce.org> <2c6b72b30909030838q10b88705gb8c553f2c2d74379@mail.gmail.com> <20090903155219.GI1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 07:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjQzz-0003Iz-Bo
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 07:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbZIDFFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 01:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbZIDFFK
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 01:05:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:51567 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbZIDFFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 01:05:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MjQyu-0002z5-KM
	for git@vger.kernel.org; Fri, 04 Sep 2009 07:05:04 +0200
Received: from c-24-16-199-93.hsd1.wa.comcast.net ([24.16.199.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 07:05:04 +0200
Received: from gabriel.mcarthur by c-24-16-199-93.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 07:05:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.16.199.93 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.10 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127685>

 
Shawn O. Pearce <spearce <at> spearce.org> writes:

> 
> Please post patches; formatted with -M.  I do want to do this, I just
> don't have the patience and Maven-fu to write the new poms myself.
> 


Hey,
I'm a build engineer with a considerable amount of "Maven-fu" :).  I've actually 
generated a patch that does everything you want (and a bit more).  I'm not that 
familiar with git's command line yet, so it's a bit tricky to get the patch 
thing right.  However, here's a rough overview of what I did:

ROOT
====
README
/bin
  bash.env   -- A script that you can source from Bash that
                will add the 'jgit' executable and the other
                scripts in this 'bin' directory to your PATH
  build.sh   -- A general build script, that hides some
                Maven complexities for initiates.
  tag.sh     -- Ok, this is the only thing that will have to 
                be re-written.  It's too tied in with git commands for
                me to fully extract what it's supposed to do.
/docs
  LICENSE
  SUBMITTING_PATCHES
  TODO
pom.xml      -- A considerable amount of build logic has been
                centralized here.  It references 3 sub-module
                projects, listed below.
/sources
  /jgit-lib
    pom.xml
    /src/main/java....
    /src/test
      /java....
      /resources 
      /exttst   -- Don't know exactly where this goes, as it
                   doesn't seem to be doing much/being run 
                   currently.
  /jgit-pgm
    pom.xml     -- Does the work to do a 'jar-with-dependencies' 
                   so that org.spearce.jgit.pgm.build can be removed.
    /src/main/java....
  /jgit-exec
    pom.xml     -- Actually generates the 'jgit' executable and
                   installs it in ROOT/target/bin, so that it will
                   be on your path after sourcing 'bin/bash.env'
    /src/main/scripts/jgit

I'll try to submit a full patch later, using your conventions.

My appreciation to Shawn for pointing out this thread....
-Gabe
                
