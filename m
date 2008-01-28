From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config.c: Expand $HOME and tilde character in
 core.excludesfile
Date: Mon, 28 Jan 2008 22:28:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801282225540.23907@racer.site>
References: <y7a9aaem.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 23:29:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJcU8-0007dC-8B
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 23:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbYA1W3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 17:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbYA1W3Q
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 17:29:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:42266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751684AbYA1W3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 17:29:15 -0500
Received: (qmail invoked by alias); 28 Jan 2008 22:29:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 28 Jan 2008 23:29:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aYEFBLK/aqOPV2CVhpLgKXagn4XoEOK9YYvYx3X
	uFP0wfS9eK0eXj
X-X-Sender: gene099@racer.site
In-Reply-To: <y7a9aaem.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71904>

Hi,

On Mon, 28 Jan 2008, Jari Aalto wrote:

> c* str_replace(): New function. Generic replace command.
> * str_replace_home(): New funtion. Substitute $HOME and tilde(~) in string.
> * git_default_config(): Pass core.excludesfile to str_replace_home().

I don't like it.  Not only do you fail to provide an example where this 
could be useful, you also introduce a memory leak for every excludes 
setting.

Besides, there is a more fundamental reason to reject this patch: it sets 
a path for an excludes file for everybody, but to a file which usually 
does not exist.

So either the user creates that file, in which case you can expect her to 
adjust ~/.gitconfig, too, or it is not created, in which case the setting 
in /etc/gitconfig is useless.

There is also a third option: there is a file created for every user from 
/etc/skel, but then there can also be a ~/.gitconfig.

Ciao,
Dscho
