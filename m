From: "Flavio Poletti" <flavio@polettix.it>
Subject: git-diff/git-format-patch safe for GNU (or POSIX) patch?
Date: Thu, 26 Jun 2008 12:27:39 +0200 (CEST)
Message-ID: <58230.213.203.159.164.1214476059.squirrel@upmail.polettix.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 12:15:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBoVN-0008RR-VY
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 12:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYFZKOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 06:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbYFZKOG
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 06:14:06 -0400
Received: from [195.130.249.251] ([195.130.249.251]:43454 "HELO desantix.it"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1752784AbYFZKOE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 06:14:04 -0400
Received: (qmail 26724 invoked by uid 511); 26 Jun 2008 10:27:39 -0000
Received: from localhost (HELO upmail.polettix.it) (127.0.0.1)
  by localhost with SMTP; 26 Jun 2008 10:27:39 -0000
Received: from 213.203.159.164
        (SquirrelMail authenticated user flavio@polettix.it)
        by upmail.polettix.it with HTTP;
        Thu, 26 Jun 2008 12:27:39 +0200 (CEST)
User-Agent: SquirrelMail/1.4.6
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86425>

Hi,

   I had to dig a problem in Glib ("base" library for GTK) in Debian Etch
recently and I decided to manage changes/diffs with git. It's just so
easy to use and avoids all the usual copy-the-tree-then-diff that I
used before.

When I was happy with the modifications, I used git-format-patch to
produce the message and the patch to send. I then saw that the format is a
little different with respect to what diff -u produces; in particular, I
noticed that there was an added line between the "diff --git..." line and
the one stating the "origin" file:

                   diff --git a/glib/gstrfuncs.c b/glib/gstrfuncs.c
*** this one ***   index 61d11ed..7786f10 100644
                   --- a/glib/gstrfuncs.c
                   +++ b/glib/gstrfuncs.c

Moreover, each chunk's header contained added stuff, like the
"g_ascii_strtoll..." stuff in the following example line:

    @@ -813,6 +813,8 @@ g_ascii_strtoll (const gchar *nptr,

Before sending the patch, I tried to "reverse" these "deviations" from the
normal diff output, but I was quite sure there was no need to do this. I
then tried to use GNU patch with the unaltered message, and it seemed
quite happy with all the extra stuff.

Just to be on the safe side, I tried to look for:
1. the "official" unified diff spec
2. a description of what patch is willing to consider valid input
3. some notes about how git-diff copes with patch compatibility
4. some hints to use git for working on projects that do not use any other
VCS, or for which one only wants to produce and send a quick patch
starting from a tarball.

I had no luck with the first two attempts, and a moderate luck with the
third: there is more than one email from Junio C. Hamano either stating
that git-diff strives to be nice with patch, or containing patches to
address possible conformance issues. I was also quite unluck with the
fourth attempt, even if this is surely due to my poor websurfing-fu.

Anyway, the messages from Mr. Hamano kind-of answer the question in the
subject, but in a somehow "implicit" way rather than explicitly. In
particular, I wonder if there is any document about how a "valid" unified
diff should look like (including optional valid extensions) that was used
as input and reference for git-diff development. Or had you just to figure
it out from diff/patch sources?

Thank you,

   Flavio.
