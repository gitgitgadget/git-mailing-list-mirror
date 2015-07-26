From: Dangling Pointer <danglingpointer@outlook.com>
Subject: FeatureRequest: Build improvements for Windows
Date: Sun, 26 Jul 2015 06:23:02 +0000
Message-ID: <BAY169-W30CD27F2F7606F4DF52944A78F0@phx.gbl>
References: <BAY169-W8210AC5C69796A61AD2236A78F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 08:23:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJFL3-0002Vw-Pi
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 08:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbGZGXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 02:23:04 -0400
Received: from bay004-omc3s11.hotmail.com ([65.54.190.149]:61554 "EHLO
	BAY004-OMC3S11.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372AbbGZGXD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 02:23:03 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jul 2015 02:23:03 EDT
Received: from BAY169-W30 ([65.54.190.188]) by BAY004-OMC3S11.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Sat, 25 Jul 2015 23:23:02 -0700
X-TMN: [tinHCzhTem2NmdKOpvZ1lo4NyqULvM/V]
X-Originating-Email: [danglingpointer@outlook.com]
Importance: Normal
In-Reply-To: <BAY169-W8210AC5C69796A61AD2236A78F0@phx.gbl>
X-OriginalArrivalTime: 26 Jul 2015 06:23:02.0770 (UTC) FILETIME=[869E6520:01D0C76B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274639>

Hello,
 
In my understanding, the ratio between the mere consumers of git on Windows vs. people who compile git for Windows is 100,000 : 1. If there is a breaking change in the workflow of the latter set, who use Visual Studio to build git from source, I assume that is doable given a good reason, hence this post.
 
With VS 2015, C99 support is "finally" added with some C11 features as well. See this blog: http://blogs.msdn.com/b/vcblog/archive/2015/06/19/c-11-14-17-features-in-vs-2015-rtm.aspx. One of the edition of new VS is Community edition, which is like professional edition but is free (also much superior than Express edition) and meant for open source projects. VS2015 also has the ability to target compiler for Wind-XP. 
 
If all the instances of fallback code guarded by "#ifdef _MSC_VER" and "#if defined(_MSC_VER) && _MSC_VER < xxx" etc. are removed from git's source code in favor of VS2015, it will help the code maintainability in future and standard C code will thrive. The very few enthusiasts who were building Windows code can download the said free edition of VS2015 and build the project the same way as they were building before (I.e. using CLI .
 
Update to docs will look like: "To build on Windows, you need to use MinGW or VS2015 (community, express desktop, professional or enterprise editions)". I think this is choice for those few, who were building from source. Also, Clang and LLVM are also now available on Windows. So many options if someone is looking hard. What I am trying to say is dropping some century old version of VS support for a lazy user should not be an excuse for a deal-breaker anymore. World is moving at much faster pace to care about lazy. :)
 
In addition to Jenkins, there is also a free-for-OSS and easy-to-configure CI service called AppVeyor, which let you build using VS2015 and MInGW machineries (http://www.appveyor.com/updates/2015/07/21) and saves the artifacts for download or upload to somewhere. If git repo is configured with AppVeyor, it will automate the process of building releases for Windows, and there will be no version disparity like present (the current released version of git on Mac is v2.4.3 while that on misfortunate Windows is v1.9.5). 
 
In future if CMake (http://www.cmake.org/) is used in this repo to automate and unify all build systems, that is also available on AppVeyor, Jenkins, Travis etc.
 
Thank you for the patience and I hope someone will consider and approve these changes at some near point in future.
  		 	   		  