From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Question around git-shell usage in Everyday Git
Date: Wed, 1 Feb 2006 15:37:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602011530530.21884@g5.osdl.org>
References: <200602012301.56141.alan@chandlerfamily.org.uk>
 <7vy80u64xf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 00:38:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4RXx-0007qu-7z
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 00:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423035AbWBAXhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 18:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423036AbWBAXhy
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 18:37:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423035AbWBAXhy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 18:37:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11NbbDZ000629
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 15:37:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11NbaP2019417;
	Wed, 1 Feb 2006 15:37:36 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy80u64xf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15467>



On Wed, 1 Feb 2006, Junio C Hamano wrote:
> 
> Do you mean to reuse single directory /home/gitu/ for user A, B, C,
> and hang repositories /home/gitu/{X,Y,Z} for projects?  I'd
> imagine things could be arranged that way.  User A and B but not
> C may be in "projectX" group and /home/gitu/X is writable only
> by projectX group members and such...

That would work from a _git_ angle, but I don't think that was what Alan 
was talking about, and it would failr horribly from a "ssh" perspective 
(because "ssh" will want $HOME/.ssh/authorized_keys etc).

So I _think_ what Alan was describing was just a 

	/home/user-A/project.git
		     another-project.git
		     ya-project.git
	      user-B/myproject.git
	      user-C/..

setup, and then people can always just describe their own projects by just 
doing "git pull host:<projectname>", without ever caring _where_ their 
home directory is.

(And yes, "git pull user@host:project" also obviously works fine, in case 
your user name at the hosting site isn't the same as the user name on your 
local site).

However, to be truly useful for this kind of hosting schenario, 
"git-shell" still needs to be extended to be able to at a minimum create 
(and delete) projects.

It probably also makes a lot of sense to be able to pre-populate a 
project, so that you don't have to do a remote "git push" to push a big 
project over the network, when another version of that project already 
exists at the hosting site.

			Linus
