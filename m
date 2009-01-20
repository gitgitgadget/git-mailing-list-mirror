From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Few Questions
Date: Tue, 20 Jan 2009 12:04:18 +0100
Message-ID: <vpqljt6jl1p.fsf@bauges.imag.fr>
References: <726600.29783.qm@web35708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: m.arya@yahoo.com
X-From: git-owner@vger.kernel.org Tue Jan 20 12:21:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPEfg-0003XU-9E
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 12:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758100AbZATLUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 06:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758030AbZATLUE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 06:20:04 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:62897 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757968AbZATLUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 06:20:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n0KBGbJu002757;
	Tue, 20 Jan 2009 12:16:44 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LPEP4-00064F-8n; Tue, 20 Jan 2009 12:04:18 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LPEP4-0008OA-4u; Tue, 20 Jan 2009 12:04:18 +0100
In-Reply-To: <726600.29783.qm@web35708.mail.mud.yahoo.com> (Manish Kumar Arya's message of "Tue\, 20 Jan 2009 02\:38\:49 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 20 Jan 2009 12:16:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106470>

"Arya, Manish Kumar" <m.arya@yahoo.com> writes:

> Hi,
>
>    I am new to Git. Earlier I have configured svn with LDAP auth and svnwebclient.
>
> I want to have following with Git
>
> - LDAP and ssh authentication.

AFAIK, there isn't any authentication mechanism built into Git.
Instead, Git relies on existing (proven, reliable, ...) mechanisms.
SSH authentication is what you get when accessing a repository with
e.g. git clone ssh://host.com/path/to/repo (either you have a full
ssh shell access on the server, or you can restrict the access with
git-shell to allow only basic git operations on the server).

There's probably a way to let your server use LDAP for authentication
when using SSH, but that's independant from Git (and I'm helpless
here).

> - checkin and checkout using web interface and ssh

Gitweb for the web interface. "checkin" and "checkout" have different
meanings depending on the tool, so I'm not sure I understand the
question correctly.

In Git, the equivalent of "checkout" for centralized VCS would be
"clone" (i.e. get a local working tree for a remote repository, but
Git also duplicates the history), see above, it works straigtforwardly
through SSH. I don't think you can do it from a web interface, but I
don't understand what would be the point in doing it.

> - when ever someone checkin something then a email should be send to
> a email address (a mailing list)

With a hook. You probably don't want to have this as the commit hook,
since the advantage of Git is to make "commit" a local, somehow
private operation, and to distinguish it from "push" (which somehow
means "publish", "show to the rest of the world"). So sending email
when some server receives the new revisions is sensible, this is the
post-receive hook.

These can help:

http://git.kernel.org/?p=git/git.git;a=blob;f=contrib/hooks/post-receive-email;h=28a3c0e46ecf9951f3f42a025a288a65c70e0424;hb=HEAD
http://source.winehq.org/git/tools.git/?a=blob;f=git-notify;hb=HEAD

-- 
Matthieu
