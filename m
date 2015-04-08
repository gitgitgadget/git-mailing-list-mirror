From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [WIP/RFH/PATCH 3/3] t/lib-git-svn: adjust config to apache 2.4
Date: Wed, 8 Apr 2015 20:26:15 +0000
Message-ID: <20150408202615.GA12154@dcvr.yhbt.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
 <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 22:26:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfwYp-0008Ii-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 22:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbbDHU0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 16:26:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38482 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbbDHU0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 16:26:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 3734F200C6;
	Wed,  8 Apr 2015 20:26:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266971>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> The current config is tailored to apache 2.2. Apache 2.4 fails to start
> with it.
> 
> Adjust the config to apache 2.4.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

1/3 and 2/3 tested fine on Debian stable (wheezy).
You can add my Tested-by to 1/3 and my S-o-b to 2/3.

...but not this one.

> Notes:
>     This is WIP and RFH. Apache does not start without mpm, and the lock
>     mechanism has changed. It will run with these changes, but svn fails to
>     connect.
>     
>     Again, I'm wondering who is running these tests at all, but also:
>     Why do we leverage lib-httpd so little from lib-git-svn?

I'm only testing on Apache 2.2 (from Debian stable (wheezy)).

I doubt anybody here, myself included, likes dealing with SVN,
and would rather ignore the tests than try to fix them.

lib-git-svn predates lib-httpd, and it isn't very interesting work
to port and cleanup.

> +LoadModule mpm_prefork_module $SVN_HTTPD_MODULE_PATH/mod_mpm_prefork.so

I think you need an IfModule guard around this?

I have no mod_mpm_prefork.so file with the apache2-mpm-prefork
(2.2.22-13+deb7u4) package on Debian wheezy.
