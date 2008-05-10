From: Kevin Ballard <kevin@sb.org>
Subject: Re: git-instaweb should 'just work' on Mac OS X
Date: Sat, 10 May 2008 17:49:12 -0500
Message-ID: <D1BFDAC1-A959-44BD-A562-D787A68612B1@sb.org>
References: <B41867BF-1635-4611-9656-04F8C375BE61@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nathan spindel <nathans@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 00:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juxte-0005hM-Ah
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 00:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbYEJWtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbYEJWtf
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 18:49:35 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:46796
	"EHLO randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752183AbYEJWte (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2008 18:49:34 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 8A77CAF8B6;
	Sat, 10 May 2008 15:49:33 -0700 (PDT)
In-Reply-To: <B41867BF-1635-4611-9656-04F8C375BE61@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81712>

On May 10, 2008, at 2:27 PM, nathan spindel wrote:

> I've investigated what it would take for git-instaweb to 'just work'  
> on
> Mac OS X 10.5 when running the command with no arguments. This would  
> be
> of benefit to many Mac git users since they shouldn't be expected to
> troubleshoot this problem. Here are the current issues at play:
>
> - lighttpd does not come with Mac OS X by default, so git-instaweb
>   currently exits with "lighttpd not found...".
>
> - git-instaweb doesn't fallback to using other web servers on the  
> system
>   if the default command doesn't exist.
>
> - Mac OS X does come with webrick and 'git-instaweb -d webrick'  
> _does_ just
>   work. It's probably slower than Apache though (?).
>
> - Mac OS X also comes with mongrel, which is a great alternative, but
>   git-instaweb doesn't support it.
>
> - Mac OS X's Apache installation is different than what git-instaweb
>   expects in a couple areas:
>   - the Apache binary is called 'httpd', not 'apache2', and git- 
> instaweb
>     only looks for the latter.
>   - the modules on Mac OS X live in /usr/libexec/apache2 but by  
> default
>     git-instaweb looks for /usr/lib/apache2/modules.
>   - Apache attempts to create its 'accept serialization lock file' at
>     /private/var/run/ but that path is only writeable by root (a  
> workaround
>     is to add a LockFile directive to the conf file that places it
>     in $fqgitdir/gitweb/tmp).
>
> I'm interested in fixing this to make the experience smoother for  
> Mac users.
> What is the community's preferred avenue of fixing this?

If I were to fix this, I'd suggest making apache2 work properly. I  
patched the git-svn tests to do this a while back, so you could look  
at what's I did there (3644da7214).

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
