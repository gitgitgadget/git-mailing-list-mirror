From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] Makefile: introduce SANE_TOOL_PATH for prepending required elements to PATH
Date: Mon, 08 Jun 2009 09:41:49 -0700
Message-ID: <7v4ouq1xv6.fsf@alter.siamese.dyndns.org>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org>
	<67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHM
	fucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@cipher.nrlssc.navy.mil>
	<20090608114351.GA13775@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:42:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDhvA-0001eG-LY
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 18:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbZFHQlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 12:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbZFHQlt
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 12:41:49 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39582 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbZFHQls (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 12:41:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608164150.EVQO20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jun 2009 12:41:50 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1Uhp1c00E4aMwMQ03UhpN4; Mon, 08 Jun 2009 12:41:49 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=eHeNAW8JrFIA:10 a=xJNoKJ4AqmEA:10
 a=PKzvZo6CAAAA:8 a=x4xuNuYxkaAylD_TvfEA:9 a=DnhRj5v-z8PuForq_aoA:7
 a=CrtDkiNWBsZpc6B5fEPputLVQusA:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090608114351.GA13775@coredump.intra.peff.net> (Jeff King's message of "Mon\, 8 Jun 2009 07\:43\:51 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121085>

Jeff King <peff@peff.net> writes:

> On Fri, Jun 05, 2009 at 06:36:15PM -0500, Brandon Casey wrote:
> ...
>> So provide a mechanism to prepend elements to the users PATH at runtime so
>> the modern binaries will be found.
>
> So this bit me already, and it's only been in next for a day. :) I
> _already_ have /usr/xpg4/bin in my PATH before /usr/bin, but with this
> patch, I get it stuck at the _beginning_ of my PATH automagically. Which
> overrides, against my wishes, the "even more sane than /usr/xpg4/bin"
> part of my PATH that comes at the beginning.
>
> Specifically, I have "~peff/local/bin" at the beginning of my PATH which
> contains a 'vi' that points to vim. Running "git rebase -i" now puts
> /usr/xpg4/bin at the beginning of the PATH (before ~peff/local/bin),

In git-sh-setup, we do "unset CDPATH" ourselves to help and protect
clueless people, even though "people should have a sane environment".
Even though I suspect that anybody who is using Solaris for anything real
would not be using /usr/bin tools themselves (i.e. it should not be
necessary for us fixing their PATH), there may be people who do not know.
I think helping them with path munging falls into the same category, but
at the same time, the remedy looks worse than the disease.

We could further uglify the patch like this.

 Makefile        |    5 +++--
 git-sh-setup.sh |   28 +++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3890a0e..c678cc0 100644
--- a/Makefile
+++ b/Makefile
@@ -881,7 +881,8 @@ endif
 -include config.mak
 
 ifdef SANE_TOOL_PATH
-BROKEN_PATH_FIX = s|^. @@PATH@@|PATH=$(SANE_TOOL_PATH)|
+SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
+BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
 BROKEN_PATH_FIX = d
@@ -1288,7 +1289,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
-	    -e '/^# @@PATH@@/$(BROKEN_PATH_FIX)' \
+	    -e $(BROKEN_PATH_FIX) \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7802581..80acb7d 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -11,7 +11,33 @@
 # exporting it.
 unset CDPATH
 
-# @@PATH@@:$PATH
+git_broken_path_fix () {
+	case ":$PATH:" in
+	*:$1:*) : ok ;;
+	*)
+		PATH=$(
+			SANE_TOOL_PATH="$1"
+			IFS=: path= sep=
+			set x $PATH
+			shift
+			for elem
+			do
+				case "$SANE_TOOL_PATH:$elem" in
+				(?*:/bin | ?*:/usr/bin)
+					path="$path$sep$SANE_TOOL_PATH"
+					sep=:
+					SANE_TOOL_PATH=
+				esac
+				path="$path$sep$elem"
+				sep=:
+			done
+			echo "$path"
+		)
+		;;
+	esac
+}
+
+# @@BROKEN_PATH_FIX@@
 
 die() {
 	echo >&2 "$@"
