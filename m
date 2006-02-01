From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 13:09:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
 <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 22:09:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4PEV-0007Rb-To
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 22:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbWBAVJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 16:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBAVJl
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 16:09:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932453AbWBAVJk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 16:09:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11L9KDZ025667
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 13:09:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11L9JTA027341;
	Wed, 1 Feb 2006 13:09:19 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15448>



On Wed, 1 Feb 2006, Junio C Hamano wrote:
> 
> How about this:
> 
>  - "git commit --also fileA..." means: update index at listed
>    paths (add/remove if necessary) and then commit the tree
>    described in index (the current behaviour with explicit paths).

I'd suggest "--incremental" instead of "--also".

>  - "git commit fileA..." means: create a temporary index from the
>    current HEAD commit (or empty index if there is none), update
>    it at listed paths (add/remove if necessary) and commit the
>    resulting tree.  Also update the real index at the listed
>    paths (add/remove if necessary).  In the original index file,
>    the paths listed must be either empty or match exactly the
>    HEAD commit -- otherwise we error out (Linus' suggestion).

Yes.

>  - "git commit" means: update index with all local changes and
>    then commit the tree described in index (current "-a"
>    behaviour).

No. Please no. "git commit" should continue to do what it does now. 
Otherwise you can't do the two-stage thing in any sane way.

Requiring "--incremental"/"--also" is very confusing.

If somebody doesn't know about the index, he normally will never have 
index changes _anyway_, except for the "git add" case. In which case "git 
commit" does the right thing for him: it will either commit the added 
files, or it will say "nothing to commit".

		Linus
