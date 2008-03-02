From: Jeff King <peff@peff.net>
Subject: Re: How to "git add ." when some files are not accessible
	(permission denied)?
Date: Sat, 1 Mar 2008 20:19:00 -0500
Message-ID: <20080302011900.GC22843@coredump.intra.peff.net>
References: <47C95E34.1050306@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 02 02:19:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVcrf-0005Vz-KB
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 02:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbYCBBTG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2008 20:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYCBBTF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 20:19:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3461 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbYCBBTE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 20:19:04 -0500
Received: (qmail 13495 invoked by uid 111); 2 Mar 2008 01:19:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 20:19:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 20:19:00 -0500
Content-Disposition: inline
In-Reply-To: <47C95E34.1050306@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75713>

On Sat, Mar 01, 2008 at 02:46:28PM +0100, Dirk S=C3=BCsserott wrote:

> The question is: is there a way to tell "git add ." to add all files =
but
> ignore those that cannot be added due to lack of authorization?

No, there isn't. Under Linux, I would come up with a list of files I wa=
s
interested in and then pipe it to "xargs git-add", which is probably
unhelpful for Windows.

But I think more fundamentally, you probably _do_ want to come up with =
a
list of files that you can't access and add them to your .gitignore (or
your .git/info/exclude file if they are purely a local matter). That is
the official way to tell all git commands "I really don't care about
these files".  Otherwise they will keep getting brought up when you do,
e.g., a git-status.

> Or, more generally spoken: can I tell "git add" to add only those fil=
es =20
> it can handle and ignore the rest? The "-f" switch doesn't work and s=
ome
> exclude lists on a per file basis are not applicable for my purpose a=
s I
> don't know the files in advance.

The only reason I can think of to not want to generate such an ignore
list is if you are frequently and automagically doing a "git add ." to
pick up new files. For that reason, a "try to continue even if we can't
look at some files" option to git add might make some sense.

-Peff
