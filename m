From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Add "--branches", "--tags" and "--remotes" options to
 git-rev-parse.
Date: Sun, 14 May 2006 20:07:39 -0400
Message-ID: <BAYC1-PASMTP079744DE4B299C5B567F30AEA30@CEZ.ICE>
References: <BAYC1-PASMTP0299DC98A51B55188BDF96AEAD0@CEZ.ICE>
	<7vd5ehu8og.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP043948149786B7EE06DED3AEA20@CEZ.ICE>
	<7v8xp4196e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 02:13:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfQi0-0003TN-AF
	for gcvg-git@gmane.org; Mon, 15 May 2006 02:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWEOANI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 20:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWEOANI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 20:13:08 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:64899 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751420AbWEOANH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 20:13:07 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 14 May 2006 17:16:17 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 78C40644C28;
	Sun, 14 May 2006 20:13:05 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060514200739.11c9d3a5.seanlkml@sympatico.ca>
In-Reply-To: <7v8xp4196e.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 May 2006 00:16:17.0718 (UTC) FILETIME=[C907AD60:01C677B4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 14 May 2006 16:24:57 -0700
Junio C Hamano <junkio@cox.net> wrote:

> I do not have problem with that, but somebody else's script
> might; Cogito seems not to mind.
> 
> Something like this perhaps?

That looks good.  If you accept the rev-parse patch, then i'd suggest the
patch below instead.

Sean


diff --git a/git-tag.sh b/git-tag.sh
index dc6aa95..a0afa25 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -25,14 +25,12 @@ do
 	force=1
 	;;
     -l)
-        cd "$GIT_DIR/refs" &&
 	case "$#" in
 	1)
-		find tags -type f -print ;;
-	*)
-		shift
-		find tags -type f -print | grep "$@" ;;
+		set x . ;;
 	esac
+	shift
+	git rev-parse --symbolic --tags | sort | grep "$@"
 	exit $?
 	;;
     -m)
