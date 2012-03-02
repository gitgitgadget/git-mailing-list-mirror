From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH (BUGFIX)] gitweb: Handle invalid regexp in regexp search
Date: Fri, 02 Mar 2012 19:44:39 +0000
Message-ID: <4F512327.3050504@ramsay1.demon.co.uk>
References: <20120228183919.26435.86795.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 20:47:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3YRQ-0006eO-4j
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 20:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab2CBTqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 14:46:50 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:45920 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756144Ab2CBTqt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 14:46:49 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1S3YRE-0007ip-Zk; Fri, 02 Mar 2012 19:46:48 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20120228183919.26435.86795.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192066>

Jakub Narebski wrote:
> When using regexp search ('sr' parameter / $search_use_regexp variable
> is true), check first that regexp is valid.
> 
> Without this patch we would get an error from Perl during search (if
> searching is performed by gitweb), or highlighting matches substring
> (if applicable), if user provided invalid regexp... which means broken
> HTML, with error page (including HTTP headers) generated after gitweb
> already produced some output.
> 
> Add test that illustrates such error: for example for regexp "*\.git"
> we would get the following error:
> 
>   Quantifier follows nothing in regex; marked by <-- HERE in m/* <-- HERE \.git/
>   at /var/www/cgi-bin/gitweb.cgi line 3084.
> 
> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> See "Re: gitweb: (potential) problems with new installation"
> http://thread.gmane.org/gmane.comp.version-control.git/191746

This patch solves the problem for me when using a regex search
(re checkbox checked), but *not* for a non-regex search.

If you have a leading '*' or '+', in the non-regex case, then you
still get the above complaint (and xml error page etc.), although
the line number has changed slightly from that given above.

ATB,
Ramsay Jones
