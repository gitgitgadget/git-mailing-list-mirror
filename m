From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sat, 3 Feb 2007 22:47:22 -0500
Message-ID: <20070204034722.GA16766@spearce.org>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com> <20070203181329.GA10192@179.242.249.10.in-addr.arpa> <7v4pq358q4.fsf@assigned-by-dhcp.cox.net> <F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com> <7vabzv3qxi.fsf@assigned-by-dhcp.cox.net> <A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com> <7vlkje243u.fsf@assigned-by-dhcp.cox.net> <7vr6t6zq2d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 04:47:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDYLm-0007fT-6q
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 04:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXBDDr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 22:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXBDDr3
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 22:47:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50294 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbXBDDr2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Feb 2007 22:47:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDYLR-0002Ea-EV; Sat, 03 Feb 2007 22:47:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7072B20FBAE; Sat,  3 Feb 2007 22:47:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vr6t6zq2d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38642>

Junio C Hamano <junkio@cox.net> wrote:
> This is not to make any point but purely for my own education,
> but I wonder what would happen on HFS+ to the following
> sequence, which does not involve any git operation:
>=20
> Doesn't the grep fail to find the file that was successfully
> created in the previous step?

Indeed.  I stole the path "gitweb/test/M\303\244rchen" from git.git
and ran your script on Mac OS X:

  $ cat jt.sh; echo; sh jt.sh=20
  #!/bin/sh
  LANG=3DC LC_ALL=3DC
  export LANG LC_ALL
 =20
  rm -fr testrepo
  mkdir testrepo
  cd testrepo
 =20
  pathname=3D'M=C3=A4rchen'
  echo $pathname
  echo hello >"$pathname"
  /bin/ls | fgrep -e "$pathname" | wc -l
 =20
  pathname=3D'Mrchen'
  echo $pathname
  echo hello >"$pathname"
  /bin/ls | fgrep -e "$pathname" | wc -l
  M=C3=A4rchen
         0
  Mrchen
         1

The first pathname=3D line in the above script is the *exact* byte
sequence which appears in gitweb/test's tree.  I apologize if my
email chain screws up the line.

--=20
Shawn.
