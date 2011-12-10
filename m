From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Access to git repository through squid proxy: The remote end
 hung up unexpectedly
Date: Sat, 10 Dec 2011 19:37:53 +0400
Message-ID: <20111210193753.994055f2.kostix@domain007.com>
References: <CACjeFCA4h_w2UmYywMBV_P+YZcWAE=zRUz-z5eTfAO+oxWKPjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mathieu Peltier <mathieu.peltier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 16:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZP01-000853-48
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 16:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab1LJPh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 10:37:58 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:60792 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab1LJPh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 10:37:57 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id pBAFbqjQ025752;
	Sat, 10 Dec 2011 19:37:53 +0400
In-Reply-To: <CACjeFCA4h_w2UmYywMBV_P+YZcWAE=zRUz-z5eTfAO+oxWKPjw@mail.gmail.com>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186782>

On Sat, 10 Dec 2011 09:56:07 +0100
Mathieu Peltier <mathieu.peltier@gmail.com> wrote:

> Hi,
> I am trying to access a git repository (git:// URL) through a squid
> proxy.
> 
> squid allows CONNECT for port 9418:
[...]
> 2011/12/09 12:22:44 socat[21428] D shutdown()  -> 0
> fatal: The remote end hung up unexpectedly
> 
> I tried to use also nc but I get the same error.
> Any advice?
I think you have to verify the git-daemon (you did not say you're using
git-daemon, but it can be presupposed based on the port number) works
by itself before starting to wrap it into layers of complexity.
What happens if you try to clone a git repo directly, without any
tunneling?  If this is not possible, try to clone on the host running
git-daemon (use an URL like git://localhost/path/to/repo.git).
If it fails (I suppose it will), try increasing the daemon verbosity
(see git-daemon) manpage.
After all, may be it's as simple as forgetting to `touch` git-export-ok
file in the repository you're trying to clone.

P.S.
As a side note: why are you trying to implement such a strange setup?
Why not just use plain old SSH which just works and provides good level
of security (contrary to Basic HTTP authentication you might be using).
If you need a level of control about who can do what with the repository
you could look at https://github.com/sitaramc/gitolite
