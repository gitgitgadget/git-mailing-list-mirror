From: Junio C Hamano <junkio@cox.net>
Subject: Re: Regarding: Debian: packaging updates.
Date: Wed, 09 Nov 2005 15:06:38 -0800
Message-ID: <7v7jbha0ap.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511081806320.18374@wbgn013.biozentrum.uni-wuerzburg.de>
	<4370EEF7.4060708@debian.org>
	<7vbr0vey42.fsf@assigned-by-dhcp.cox.net>
	<4370FE57.7010304@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:09:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZz1g-00086r-5w
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbVKIXGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbVKIXGl
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:06:41 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:14531 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751088AbVKIXGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 18:06:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109230543.COIV11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 18:05:43 -0500
To: Simon Richter <sjr@debian.org>
In-Reply-To: <4370FE57.7010304@debian.org> (Simon Richter's message of "Tue,
	08 Nov 2005 20:36:55 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11433>

Simon Richter <sjr@debian.org> writes:

> Junio C Hamano wrote:
>
>> Since you have debian.org e-mail address, perhaps you can feed
>> me patches to debian/ area and deb: rule in the main Makefile?
>
> Sure. I have also talked this over with a few people and am going to 
> make official uploads occasionally.

Simon, I've received a patch to do *.changes file from Carl
Baldwin, and with his permission I am forwarding it to you,
hoping that you could include it (or reject it with explanation
to Carl and me) when you feed me your debian/ updates.  Carl
says he wants to use dupload to populate his private apt-get
repository and the process wants the generated *.changes file.

Myself, I've been either installing with "dpkg -i" directly or
populating the apt-get repository by hand (yuck) but if dupload
is the preferred way to maintain private apt-get repository and
if having *.changes file helps that procedure, then...


---
diff --git a/Makefile b/Makefile
index bfdaf76..c1fcecb 100644
--- a/Makefile
+++ b/Makefile
@@ -452,8 +452,7 @@ rpm: dist
 deb: dist
        rm -rf $(GIT_TARNAME)
        $(TAR) zxf $(GIT_TARNAME).tar.gz
-       dpkg-source -b $(GIT_TARNAME)
-       cd $(GIT_TARNAME) && fakeroot debian/rules binary
+       cd $(GIT_TARNAME) && dpkg-buildpackage -rfakeroot -us -uc

 ### Cleaning rules

@@ -464,6 +463,7 @@ clean:
        rm -rf $(GIT_TARNAME)
        rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
        rm -f git-core_$(GIT_VERSION)-*.dsc
+       rm -f git-core_$(GIT_VERSION)-*.changes
        rm -f git-*_$(GIT_VERSION)-*.deb
        $(MAKE) -C Documentation/ clean
        $(MAKE) -C templates clean
