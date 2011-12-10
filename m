From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Access to git repository through squid proxy: The remote end
 hung up unexpectedly
Date: Sun, 11 Dec 2011 02:58:19 +0400
Message-ID: <20111210225818.GM2525@localhost.localdomain>
References: <CACjeFCA4h_w2UmYywMBV_P+YZcWAE=zRUz-z5eTfAO+oxWKPjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mathieu Peltier <mathieu.peltier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 23:59:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZVsd-0003l9-Hh
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 23:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab1LJW63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 17:58:29 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:34302 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab1LJW62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 17:58:28 -0500
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id pBAMwMXd014542;
	Sun, 11 Dec 2011 02:58:23 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id EAC26B230CD; Sun, 11 Dec 2011 02:58:20 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <CACjeFCA4h_w2UmYywMBV_P+YZcWAE=zRUz-z5eTfAO+oxWKPjw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186795>

On Sat, Dec 10, 2011 at 09:56:07AM +0100, Mathieu Peltier wrote:

[...]
> 2011/12/09 12:22:44 socat[21428] I setting option "proxyport" to "8080"
> 2011/12/09 12:22:44 socat[21428] I setting option
> "proxy-authorization" to "user:pass"
> ...
> 2011/12/09 12:22:44 socat[21428] I sending "CONNECT
> git.server.org:9418 HTTP/1.0\r\n"
> ...
> 2011/12/09 12:22:44 socat[21428] I proxy_connect: received answer
> "HTTP/1.1 403 OK\r\n"
> 2011/12/09 12:22:44 socat[21428] E CONNECT git.server.org:9418: OK
> 2011/12/09 12:22:44 socat[21428] N exit(1)
> 2011/12/09 12:22:44 socat[21428] I shutdown(3, 2)
> 2011/12/09 12:22:44 socat[21428] D shutdown()  -> 0
> fatal: The remote end hung up unexpectedly
[...]

HTTP 403 means "access denied" or "forbidden".
IIRC, a proxy (or any other HTTP-speaking server) should respond with
the 401 code when a client first requests a protected resource, and the
client is then supposed to retry its request but this time it should
provide an authentication info (and the auth mech selected).
You have an ellipsis in your debug output in the place that exchange is
supposed to be happening so I'm unable to dig deeper.

Looks like either your socat supplies incorrect credentials or proxy
does not ask socat to actually authenticate and just denies the request.
