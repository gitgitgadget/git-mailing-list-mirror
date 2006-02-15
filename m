From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 19:58:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141953081.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net>
 <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org> <Pine.LNX.4.64.0602141811050.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602141829080.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 04:58:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Do2-0000YX-UW
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 04:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWBOD6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 22:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWBOD6M
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 22:58:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422630AbWBOD6K (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 22:58:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1F3w4DZ022684
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 19:58:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1F3w3qB010736;
	Tue, 14 Feb 2006 19:58:03 -0800
To: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <Pine.LNX.4.64.0602141829080.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16207>



On Tue, 14 Feb 2006, Linus Torvalds wrote:
> 
> So in case people want to try, here's a third patch. Oh, and it's against 
> my _original_ path, not incremental to the middle one (ie both patches two 
> and three are against patch #1, it's not a nice series).
> 
> Now I'm really done, and won't be sending out any more patches today. 

Still true. I've just been thinking about the last state.

As far as I can tell, the output from git-merge-tree with that fix to only 
simplify subdirectories that match exactly in all of base/branch1/branch2 
is precisely the output that git-merge-recursive actually wants.

Rather than doing a three-way merge with "git-read-tree", and then doing 
"git-ls-files --unmerged", I think this gives the same result much more 
efficiently.

That said, I can't follow the python code, so maybe I'm missing something. 
Fredrik cc'd, in case he can put me right.

		Linus
