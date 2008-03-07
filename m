From: Tommi Komulainen <tommi.komulainen@iki.fi>
Subject: Re: git-svn breaks on gtk+ import
Date: Fri, 07 Mar 2008 22:19:42 +0200
Message-ID: <fqs80v$98n$1@ger.gmane.org>
References: <alpine.DEB.1.00.0803071844510.27175@master.birnet.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 21:27:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXj8Z-00010G-5d
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 21:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761258AbYCGUZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 15:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761162AbYCGUZM
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 15:25:12 -0500
Received: from main.gmane.org ([80.91.229.2]:56149 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760508AbYCGUZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 15:25:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JXj7m-0008Sc-Dy
	for git@vger.kernel.org; Fri, 07 Mar 2008 20:25:02 +0000
Received: from jumbo180.adsl.netsonic.fi ([81.17.197.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 20:25:02 +0000
Received: from tommi.komulainen by jumbo180.adsl.netsonic.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 20:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: jumbo180.adsl.netsonic.fi
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.DEB.1.00.0803071844510.27175@master.birnet.private>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76520>

Tim Janik wrote:
> hi Eric.
> 
> with git-svn from git 1.5.4.3, imports of the Gtk+ repository fail:
> 
>   git-svn clone -T trunk -b branches -t tags -r 19001 
> http://svn.gnome.org/svn/gtk+
>   Using existing [svn-remote "svn"]
>   Using higher level of URL: http://svn.gnome.org/svn/gtk+ => 
> http://svn.gnome.org/svn/gtk%2B/http:
>   No such file or directory: PROPFIND request failed on 
> '/svn/gtk%252B/http%3A': Could not open the requested SVN filesystem at 
> /usr/bin/git-svn line 1352

> looks like the '+' in the the http://svn.gnome.org/svn/gtk+ repository
> name isn't handled correctly.

I had somewhat similar problem with git-svn fetch to a repository 
created with 1.5.3.something failing issuing REPORT. I've tracked down 
the problem to commit f5530b8833bcaa423cd53d133d3de3fa0173fbf3 to git, 
reverting it seems to fix git-svn fetch for me. YMMV.

I tried to follow where/how URL escaping happens / isn't happening 
(there are issues like 'if (<unescaped url> eq <escaped url>)' around - 
mostly because repos_root is escaped) but couldn't get things working. :-/


-- 
Tommi Komulainen                                 tommi.komulainen@iki.fi

