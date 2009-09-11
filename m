From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] completion: Replace config --list with --get-regexp
Date: Fri, 11 Sep 2009 19:23:45 -0400
Message-ID: <20090911232344.GH2582@inocybe.localdomain>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	james bardin <jbardin@bu.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 01:24:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmFTO-0007QI-18
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 01:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150AbZIKXX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 19:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757129AbZIKXX5
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 19:23:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbZIKXX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 19:23:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 311EB2E20E;
	Fri, 11 Sep 2009 19:23:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=ZaFRUNFJeXujTjSpRdhGCkCqcuE=; b=lo0LYSG
	wXwCxwL/pbvn0URigHeU2RGVdJSrT5conwPWOZhVLZLUS8pIYqdUGSiYhEHbAAxL
	dIZZuFsVTfhi+9WZeGSUajcMgXMZSigOy2NxOK71LcjOW3dOHoiWydtYq/9Q2pti
	61GEVPAijEYW/VlUGJ/EaiLECKin7HEv8fSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=EzQlbJ6AH2JD6V5QVzfCcAf9NLbYSuNxR
	lpiRgCROBu9CTOKa3Z4V7N03darYwmc2sXAQ5kUBS1tJLNiALLRJuBoznP69sKea
	olGRMW1kSUMYFMNyQz+ClJk/+UDTl10egumbO7aYo0LJFi6/x1ctkEShYWrXuVla
	vn/Mb6EREU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E89C92E20C;
	Fri, 11 Sep 2009 19:23:53 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.9.179]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3ADCB2E209; Fri, 11 Sep
 2009 19:23:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090911150934.GB977@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 2BC1E542-9F2A-11DE-A321-A13518FFA523-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128229>

James Bardin noted that the completion spewed warnings when no git
config file is present.  This is likely a bug to be fixed in git config,
but it's also a good excuse to simplify the completion code by using the
--get-regexp option as Jeff King pointed out.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Jeff King wrote:
> On Fri, Sep 11, 2009 at 07:36:51AM -0700, Shawn O. Pearce wrote:
>
>>> instead of just using "git config --get-regexp 'remote\..*\.url'", which
>>> would be slightly more efficient, and also doesn't have this bug. ;)
>>
>> F'king oversight.  You are right, this should be --get-regexp.
>> There isn't a reason here, probably other than "I forgot about
>> --get-regexp when I wrote the original code".
>
> OK. I will leave a bash-completion patch for you (or somebody else
> interested) as I don't use it myself.

Something like this perhaps?  Perhaps the commit message could use
adjustment to reference your fix for 'config --list'?

 contrib/completion/git-completion.bash |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bf688e1..d668fc9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -318,13 +318,9 @@ __git_remotes ()
 		echo ${i#$d/remotes/}
 	done
 	[ "$ngoff" ] && shopt -u nullglob
-	for i in $(git --git-dir="$d" config --list); do
-		case "$i" in
-		remote.*.url=*)
-			i="${i#remote.}"
-			echo "${i/.url=*/}"
-			;;
-		esac
+	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
+		i="${i#remote.}"
+		echo "${i/.url*/}"
 	done
 }
 
@@ -605,13 +601,9 @@ __git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
 __git_aliases ()
 {
 	local i IFS=$'\n'
-	for i in $(git --git-dir="$(__gitdir)" config --list); do
-		case "$i" in
-		alias.*)
-			i="${i#alias.}"
-			echo "${i/=*/}"
-			;;
-		esac
+	for i in $(git --git-dir="$(__gitdir)" config --get-regexp "alias\..*" 2>/dev/null); do
+		i="${i#alias.}"
+		echo "${i/ */}"
 	done
 }
 
@@ -1769,13 +1761,9 @@ _git_remote ()
 		;;
 	update)
 		local i c='' IFS=$'\n'
-		for i in $(git --git-dir="$(__gitdir)" config --list); do
-			case "$i" in
-			remotes.*)
-				i="${i#remotes.}"
-				c="$c ${i/=*/}"
-				;;
-			esac
+		for i in $(git --git-dir="$(__gitdir)" config --get-regexp "remotes\..*" 2>/dev/null); do
+			i="${i#remotes.}"
+			c="$c ${i/ */}"
 		done
 		__gitcomp "$c"
 		;;
-- 
1.6.4.2

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
That men do not learn very much from the lessons of history is the
most important of all the lessons of history.
    -- Aldous Huxley Collected Essays, 1959
