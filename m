From: Edgar Toernig <froese@gmx.de>
Subject: Re: [Q] what to do when waitpid() returns ECHILD under
 signal(SIGCHLD, SIG_IGN)?
Date: Tue, 20 Jun 2006 18:09:21 +0200
Message-ID: <20060620180921.7bc1cb6c.froese@gmx.de>
References: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 20 18:09:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsinD-0003s3-LA
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 18:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWFTQJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 12:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWFTQJ2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 12:09:28 -0400
Received: from mail.gmx.de ([213.165.64.21]:55530 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751376AbWFTQJ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 12:09:27 -0400
Received: (qmail invoked by alias); 20 Jun 2006 16:09:26 -0000
Received: from p50900270.dip0.t-ipconnect.de (EHLO dialup) [80.144.2.112]
  by mail.gmx.net (mp017) with SMTP; 20 Jun 2006 18:09:26 +0200
X-Authenticated: #271361
To: git@vger.kernel.org
In-Reply-To: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22211>

Junio C Hamano wrote:
>
> Somebody I met last week in Japan reported that the socks client
> he uses to cross the firewall to connect to git:// port from his
> company environment seems to do signal(SIGCHLD, SIG_IGN) before
> spawning git.

Similar problems occasionally happen with SIGPIPE.  There are apps[1]
that spawn processes with SIGPIPE set to SIG_IGN giving unexpected
results, i.e. child processes that still try to produce output
(getting EPIPE on every printf, but who checks printf errors?) even
if the pipe-reader (e.g. their parent) is long gone.

Ciao, ET.

[1] i.e. KDE had this bug - don't know if it's still there.
