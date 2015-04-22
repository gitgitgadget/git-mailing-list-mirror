From: Andreas Krey <a.krey@gmx.de>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 22 Apr 2015 08:54:05 +0200
Message-ID: <20150422065405.GB11889@inner.h.apk.li>
References: <552E628C.7040809@debian.org> <552E6D07.5030903@drmicha.warpmail.net> <552E732E.20107@debian.org> <0cf0485caae569a71a8bd1aa8d1033cb@www.dscho.org> <20150415153317.GA21768@tsaunders-iceball.corp.tor1.mozilla.com> <31749ad9ba57ada7f9c553191ffaddb3@www.dscho.org> <1429125944.16649.2.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Trevor Saunders <tbsaunde@tbsaunde.org>,
	Pirate Praveen <praveen@debian.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, git-owner@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 08:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkoYE-0007l6-3s
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 08:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbbDVGyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 02:54:21 -0400
Received: from continuum.iocl.org ([217.140.74.2]:57460 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933504AbbDVGyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 02:54:20 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t3M6s6k15788;
	Wed, 22 Apr 2015 08:54:06 +0200
Content-Disposition: inline
In-Reply-To: <1429125944.16649.2.camel@kaarsemaker.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267580>

On Wed, 15 Apr 2015 21:25:44 +0000, Dennis Kaarsemaker wrote:
...
> It does not and cannot work. The way mosh works, is that it uses ssh to
> log in and launch a mosh-server daemon. This daemon and the mosh client
> then communicate via a custom UDP protocol. The SSH connection is closed
> after the mosh-server has been launched as it is no longer needed.
> 
> The communication between the mosh client and server synchronizes
> terminal state, somewhat like what screen/tmux do.

I object to the 'can not' part a bit. There is (1) the terminal state
prediction and (2) the reliable-over-reconnects communication, and for
a noninteractive usage you'd need only (2).

Once upon a time I implemented a simple UDP server and client;
the client to be used as a ProxyCommand in ssh, and the server
just talks to the local ssh server. This pretty much does what
the OP wants, and it works just as a transport for ssh, so
all ssh features are there (but of course there is no
terminal prediction). Unfortunately it needs to be ported
to libev/libuv before it could be released. It's *much*
simpler than mosh, although the use-ssh-to-start-server
trick would be nice.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
