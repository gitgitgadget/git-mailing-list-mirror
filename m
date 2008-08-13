From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: TOPGIT: [PATCH] Use standard prefix and DESTDIR rather than
 explain
Date: Wed, 13 Aug 2008 09:04:49 +0200
Organization: lilypond-design.org
Message-ID: <1218611089.7561.11.camel@heerbeest>
References: <1218545670.7264.2.camel@heerbeest>
	 <36ca99e90808120934h6d86a7cbpeca8a6c85ba3bce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 12:18:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTDQm-0007e7-11
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 12:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYHMKRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 06:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYHMKRL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 06:17:11 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:40217 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbYHMKRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 06:17:10 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id C86C36778E;
	Wed, 13 Aug 2008 12:17:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 4998EDC08A;
	Wed, 13 Aug 2008 12:17:08 +0200 (CEST)
In-Reply-To: <36ca99e90808120934h6d86a7cbpeca8a6c85ba3bce2@mail.gmail.com>
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92204>

On di, 2008-08-12 at 18:34 +0200, Bert Wesarg wrote:

> On Tue, Aug 12, 2008 at 14:54, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> > First an install nitpick.
> > +       install -d -m 755 "$(DESTDIR)$(bindir)"
> > +       install -d -m 755 "$(DESTDIR)$(bindir)"
> duplicate

Now I see: we both fixed that.  I did not see the merge conflict, should
have looked better.  New try:

[Why is it so difficult for a SCM to detect such duplicates?  Of course,
once in a 1000 years you'd want two identical lines, but wouldn't it be
nice if by default git would help you would not to mess up]

Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 Makefile |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 6eade1e..af46399 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,7 @@
-# Set PREFIX to wherever you want to install TopGit
-PREFIX = $(HOME)
-bindir = $(PREFIX)/bin
-cmddir = $(PREFIX)/libexec/topgit
-sharedir = $(PREFIX)/share/topgit
+prefix = $(HOME)
+bindir = $(prefix)/bin
+cmddir = $(prefix)/libexec/topgit
+sharedir = $(prefix)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
@@ -31,14 +30,14 @@ $(help_out): README
 	./create-help.sh $$CMD
 
 install:: all
-	install -d -m 755 "$(bindir)"
-	install tg "$(bindir)"
-	install -d -m 755 "$(cmddir)"
-	install $(commands_out) "$(cmddir)"
-	install -d -m 755 "$(hooksdir)"
-	install $(hooks_out) "$(hooksdir)"
-	install -d -m 755 "$(sharedir)"
-	install -m 644 $(help_out) "$(sharedir)"
+	install -d -m 755 "$(DESTDIR)$(bindir)"
+	install tg "$(DESTDIR)$(bindir)"
+	install -d -m 755 "$(DESTDIR)$(cmddir)"
+	install $(commands_out) "$(DESTDIR)$(cmddir)"
+	install -d -m 755 "$(DESTDIR)$(hooksdir)"
+	install $(hooks_out) "$(DESTDIR)$(hooksdir)"
+	install -d -m 755 "$(DESTDIR)$(sharedir)"
+	install -m 644 $(help_out) "$(DESTDIR)$(sharedir)"
 
 clean::
 	rm -f tg $(commands_out) $(hooks_out) $(help_out)
-- 
1.6.0.rc0.44.g67270



-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
