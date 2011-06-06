From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: Jabber, question on push,pull and --tags, and no help but jabber
Date: Mon, 6 Jun 2011 23:46:39 +0200
Message-ID: <20110606214639.GA38620@sherwood.local>
References: <20110606130205.GA41674@sherwood.local>
 <4DECE4D6.9000204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 23:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QThdP-0001SJ-SW
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 23:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897Ab1FFVqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 17:46:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57738 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab1FFVqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 17:46:49 -0400
Received: by bwz15 with SMTP id 15so3674862bwz.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RLDjUnLXSTDMDSIQoDLvcBd3/pmiy1BRdlxOE70qOUU=;
        b=Ou7p+hDZzJvTyWDHSA5UdgubS2Frb7ew7wKBHbklDIFkczToDnQH72aLsPWVhfZo8C
         KNUOD4qAnuZV6so0sc3SVVqSNS13NCaLQXTfp2yqxvNmApT5TEYrg/z4rHn6jYONUIqr
         cuBovCNeesmCdAuIcfh9El4e9/ui1YpwP+IQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JCNaG66OweTclVzGaRZwx/CX6UKjtK3i2fLQYFDuDQ9hKBwkBjN4KUgQo/etababcH
         G7wlf7S4WG5cAgIW2rr/Nr+3OxTEy21JClPnvxtDk8wrp2bIhEX+ORkyEs7Cm7tJTMtM
         Lv4LqOjVumlVBhVWjzpdbyDpuIJTd4LuGdofk=
Received: by 10.204.80.223 with SMTP id u31mr561357bkk.121.1307396808159;
        Mon, 06 Jun 2011 14:46:48 -0700 (PDT)
Received: from sherwood.local ([89.204.153.245])
        by mx.google.com with ESMTPS id x13sm3654458bkj.17.2011.06.06.14.46.43
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 14:46:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DECE4D6.9000204@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175172>

@ Michael J Gruber <git@drmicha.warpmail.net> wrote (2011-06-06 16:31+0200):
> "git tag" and "git verify-tag" call out to "gpg". That could be easily
> adapted to call out to "openssl smime", or put your S/MIME signatures in
> a note.
> 
> Cheers
> Michael

Hum.  It will indeed be possible to place a wrapper script 'gpg'
in the path on my box (and catch '--verify' - or sign otherwise).

But in the meanwhile i've found out that git(1) is heavily
developed, stale .git_vtag_ files of an 1.7.3? version are no
longer produced by 'git version 1.7.6.rc0' to which i've updated
after i've seen those.  So maybe there is hope that the hardcoded
gpg invocation will be replaced by configuration options in the
future, too?

I still don't understand the design with pull and --tags.
Because, if i do 'git log' it'll display the relationship as in

    commit fd040fb[...] (tag: refs/tags/v0.3.0, refs/remotes/origin/master)

So i'll push this commit object as part of pushing a branch, and
the tag refers to *it*.  I don't want to be impertinent though,
and it's better that explicit way than implicitely pushing some
distressing stuff.  Still i would have appreciated a note in the
docu, because it took a look at the mentioned webspace to realize
the situation.  I'll append a short diff to be able to provide
something useful.  (No attachments allowed here i guess.)

I'll try to be less tiny from the start the next time.
--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments

--
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 88acfcd..da4a71a 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -69,7 +69,7 @@ nor in any Push line of the corresponding remotes file---see below).
 
 --all::
 	Instead of naming each ref to push, specifies that all
-	refs under `refs/heads/` be pushed.
+	refs under `refs/heads/` be pushed explicitely.
 
 --mirror::
 	Instead of naming each ref to push, specifies that all
@@ -98,7 +98,7 @@ nor in any Push line of the corresponding remotes file---see below).
 --tags::
 	All refs under `refs/tags` are pushed, in
 	addition to refspecs explicitly listed on the command
-	line.
+	line.  Note that tags are not pushed automatically.
 
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
