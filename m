From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Notes on http-push
Date: Tue, 8 Nov 2005 00:46:21 -0800
Message-ID: <20051108084620.GA5830@reactrix.com>
References: <Pine.LNX.4.63.0511071926240.14149@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 09:47:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZP7i-00030w-Um
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 09:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVKHIqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 03:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVKHIq3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 03:46:29 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:32701 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932497AbVKHIq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 03:46:28 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA88kLk4007589;
	Tue, 8 Nov 2005 00:46:21 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA88kLif007587;
	Tue, 8 Nov 2005 00:46:21 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511071926240.14149@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11316>

On Mon, Nov 07, 2005 at 07:34:34PM +0100, Johannes Schindelin wrote:

> If you want to play with it yourself: A minimal setup using Apache needs 
> something like this in httpd.conf:

In the interest of testing push against another DAV server
implementation, I tried using Subversion's Apache DAV/DeltaV module.
It works if you enable autoversioning and authentication, which makes
for a slightly different minimal Apache setup:

LoadModule dav_module        modules/mod_dav.so
LoadModule dav_svn_module    modules/mod_dav_svn.so
LoadModule authz_svn_module  modules/mod_authz_svn.so
<Location /svn>
    DAV svn
    SVNPath /path/to/svn/repo
    SVNAutoversioning on
    AuthName "Subversion Repo"
    AuthType Basic
    AuthUserFile ....
    AuthGroupFile ....
    <LimitExcept GET>
        require ....
    </LimitExcept>
</Location>

While it's kind of useless to place immutable objects under version
control, it is sort of an interesting side effect that all the meta
files will have a history.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
