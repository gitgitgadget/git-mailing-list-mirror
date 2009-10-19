From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git add -e documentation: rephrase note
Date: Mon, 19 Oct 2009 01:04:56 -0400
Message-ID: <20091019050456.GA15706@coredump.intra.peff.net>
References: <20091014222628.GK6115@genesis.frugalware.org>
 <20091014230434.GB29664@coredump.intra.peff.net>
 <20091019000900.GV6115@genesis.frugalware.org>
 <20091019043418.GD7170@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 07:05:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzkQa-0006eo-55
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 07:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbZJSFEz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 01:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbZJSFEz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 01:04:55 -0400
Received: from peff.net ([208.65.91.99]:49417 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbZJSFEz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 01:04:55 -0400
Received: (qmail 14530 invoked by uid 107); 19 Oct 2009 05:08:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Oct 2009 01:08:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2009 01:04:56 -0400
Content-Disposition: inline
In-Reply-To: <20091019043418.GD7170@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130649>

On Mon, Oct 19, 2009 at 12:34:18AM -0400, Jeff King wrote:

> I still have a few comments, though.
> [...]
> (the spacing of which will hopefully not be destroyed in transit). In
> other words, the "+" list continuation makes the "it is a bad idea" t=
ext
> part of the "good idea" list, instead of continuing the definition of
> the "-e" option. I think we can fix it with an open block marker. I'l=
l
> see what I can do.

Hmph. Here is my attempt. The text is (I hope) more clear, but I am
still having trouble with the formatting. It looks fine in the HTML
version, and if I am reading the XML right, the XML is correct. But
docbook seems to screw up converting the XML to roff, giving this:

           =C2=B7   convert removal lines to context lines (don=E2=80=99=
t stage removal)
               Similarly, your patch will likely not apply if you:

           =C2=B7   add context or removal lines

Am I missing something, or is it really a docbook bug? Does it render
better for anybody else?

-- >8 --
Subject: [PATCH] docs: give more hints about how "add -e" works

The original text was not very descriptive about what you
can and can't do; let's try to enumerate all cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-add.txt |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 45ebf87..b0a8420 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -86,9 +86,25 @@ OPTIONS
 	edit it.  After the editor was closed, adjust the hunk headers
 	and apply the patch to the index.
 +
-*NOTE*: Obviously, if you change anything else than the first characte=
r
-on lines beginning with a space or a minus, the patch will no longer
-apply.
+The intent of this option is to pick and choose lines of the diff to
+apply, or even to modify the contents of lines to be staged. There are
+three line types in a diff: addition lines (beginning with a plus),
+removal lines (beginning with a minus), and context lines (beginning
+with a space). In general, it should be safe to:
++
+--
+* remove addition lines (don't stage the line)
+* modify the content of any addition lines (stage modified contents)
+* add new addition lines (stage the new line)
+* convert context lines to removal lines (stage removal of line)
+* convert removal lines to context lines (don't stage removal)
+--
++
+Similarly, your patch will likely not apply if you:
++
+* add context or removal lines
+* delete removal or context lines
+* modify the contents of context or removal lines
=20
 -u::
 --update::
--=20
1.6.5.1.123.gcaaf
