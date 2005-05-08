From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 23:43:20 +0200
Message-ID: <1115588600.8949.77.camel@pegasus>
References: <20050508152529.GU9495@pasky.ji.cz>
	 <1115566990.9031.108.camel@pegasus> <20050508155656.GV9495@pasky.ji.cz>
	 <1115568937.9031.129.camel@pegasus> <20050508171209.GX9495@pasky.ji.cz>
	 <1115572667.9031.139.camel@pegasus> <20050508173003.GY9495@pasky.ji.cz>
	 <1115574035.9031.145.camel@pegasus> <20050508175156.GA9495@pasky.ji.cz>
	 <1115578658.8949.9.camel@pegasus>  <20050508200334.GG9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 23:36:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUtRM-0000HQ-DA
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVEHVm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVEHVm7
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:42:59 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:5294 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262984AbVEHVm5
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 17:42:57 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48LiFWX006051
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 23:44:16 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508200334.GG9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> #/bin/sh
> 
> leading=1
> emptylines=0
> while read line; do
>         if ! [ "$line" ]; then
> 		[ "$leading" ] && continue
> 		emptylines=$(($emptylines + 1))
>         else
> 		leading=0
>                 while [ $emptylines -gt 0 ]; do
>                         echo ""
>                         emptylines=$(($emptylines - 1))
>                 done
>                 echo $line
>         fi
> done
> 
> or something? (Based on someone else's script since I was too lazy. ;-)

@@ -134,7 +134,7 @@
 else
        cat >>$LOGMSG2
 fi
-grep -v ^CG: $LOGMSG2 >$LOGMSG
+grep -v ^CG: $LOGMSG2 | sed '/./,${/./b;:a;$d;N;/\n$/ba;b;};d' >$LOGMSG
 rm $LOGMSG2
 
 
If you don't wanna squeeze then you can do it with a one-line in sed.

Regards

Marcel


