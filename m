From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: commit a1f6baa5 (wrap long header lines) breaks my habit
Date: Wed, 25 May 2011 17:40:46 +0200
Organization: -no organization-
Message-ID: <20110525154046.GC7723@scotty.home>
References: <20110524160253.GA7723@scotty.home>
 <7vboys83nh.fsf@alter.siamese.dyndns.org>
 <20110524164616.GB7723@scotty.home>
 <20110524200716.GF584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 17:41:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPGCi-0000A4-76
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560Ab1EYPky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:40:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:54926 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab1EYPkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:40:53 -0400
Received: from scotty.home (port-92-196-31-162.dynamic.qsc.de [92.196.31.162])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MeOaJ-1Q0Kmn1ylL-00QACl; Wed, 25 May 2011 17:40:47 +0200
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-9.4) with ESMTP id p4PFelKT031844;
	Wed, 25 May 2011 17:40:47 +0200
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id p4PFekfT031842;
	Wed, 25 May 2011 17:40:46 +0200
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <20110524200716.GF584@sigill.intra.peff.net>
X-Mailer: Mutt 1.5.20 (2009-06-14) http://www.mutt.org/
X-Editor: GNU Emacs 23.2.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
 F986 E4FC D563
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97 at scotty
X-Virus-Status: Clean
X-Provags-ID: V02:K0:kUm0fFi8zbl0RDaX5d5oluJV588y6DSq6/4cfOMoB6A
 odp7OHuWY7Mur4hK4Ns4Te7ck2KbUI7pPDDB//t8ZMNXzfoMW6
 WGat1mTkiGRDyxyQAox9P3Tj+fkNKAPRwSqEwC8bfAzEIxb/TE
 pzOHCwwI1hzbMfn/PVNAPGABeIN45tD5xkUyrdJ5Q3ZBVjj149
 OXQIR9H37q2Aqoosl+6Lw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174416>

Mail von Jeff King, Tue, 24 May 2011 at 16:07:16 -0400:

Hello,

> > > >    git format-patch -k --stdout a..b | git am -k -3
> > > 
> > > Why -k to am?
> > 
> > Just first "-k", and "git am -3". Wrong in mind here at home before my
> > computer.

Wrong. I really typed the second "-k". (Local intelligence in
fingers.)

> Then it should preserve your long subject line just fine, as mailsplit
> (called by "am") will reassemble the folded line according to rfc822
> header folding rules.
> 
> With "am -k", it does keep the fold. This is an artifact of the original
> behavior, where the folds were literally included from a multi-line

Correct, I checked this, so with

   git format-patch -k --stdout a..b | git am -3
(no second -k)

all is as before. 

Thanks for your clarification, sorry for the noise.

Stefan

Perhaps a little clarification like this:

commit e8069848dffe72579aa7f2c542e39fde9eab84b1
Author: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
Date:   Wed May 25 17:33:03 2011 +0200

    format-patch: Clarify the behaviour of '-k'.
    
    Added clarification in documentation of of 'git format-patch'.
    
    When using 'git format-patch' together with 'git am' for rebasing,
    'git am' should be called without '-k' if long subject lines should be
    reassembled. This is neccesary, because a wrapping of long header lines
    was introduced with commit:
    
    commit a1f6baa5c97abc8b579fa7ac7c4dc21971bdc048
    format-patch: wrap long header lines
    
    Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index d13c9b2..4e62248 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -468,6 +468,16 @@ the current branch using 'git am' to cherry-pick them:
 ------------
 $ git format-patch -k --stdout R1..R2 | git am -3 -k
 ------------
++
+In this example the subject lines of the commits will be folded after
+78 characters and 'git am' will keep this folding.
++
+To preserve long subject lines, 'git am' will reassemble the folded
+lines according to rfc822 if called without '-k' like this:
++
+------------
+$ git format-patch -k --stdout R1..R2 | git am -3
+------------
 
 * Extract all commits which are in the current branch but not in the
 origin branch:

-- 
Stefan-W. Hahn                          It is easy to make things.
                                        It is hard to make things simple.
