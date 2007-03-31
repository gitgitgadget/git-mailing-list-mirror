From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Sat, 31 Mar 2007 11:18:06 +0200
Message-ID: <20070331091806.GA12442@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703280158.54929.jnareb@gmail.com> <20070328210301.GA57@auto.tuwien.ac.at> <200703310155.14452.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 11:18:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXZj5-0007tb-Kd
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 11:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbXCaJSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 31 Mar 2007 05:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbXCaJSK
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 05:18:10 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43946 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbXCaJSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 05:18:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 5A55A73B995A;
	Sat, 31 Mar 2007 11:18:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FhClq11LoD+A; Sat, 31 Mar 2007 11:18:06 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id E0CE773B993F; Sat, 31 Mar 2007 11:18:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200703310155.14452.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43540>

On Sat, Mar 31, 2007 at 01:55:14AM +0200, Jakub Narebski wrote:
> Second is detecting file as binary (for text files we always return
> HTML), and content type set. Gitweb checks mimetype of a file (based
> on extension, mainly) by default using /etc/mime.magic, and if it is
> neither text/* nor HTML images (png, jpg, gif) it uses "blobdiff_plai=
n"
> view. Perhaps instead of just calling git_blob_plain($mimetype) we
> should do a redirect (but then how to pass detected mimetype?). It lo=
oks
> like there is an error with mimetype detection: could you tell me the
> line with "application/vnd.mif" in your /etc/mime.types?

The system is a Debian system. /etc/mime.types is part of mime-support:
$dpkg -l mime-support
Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Installed/Config-files/Unpacked/Failed-config/Half-insta=
lled
|/ Err?=3D(none)/Hold/Reinst-required/X=3Dboth-problems (Status,Err: up=
percase=3Dbad)
||/ Name                         Version                      Descripti=
on
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  mime-support                 3.28-1                       MIME file=
s 'mime.types' & 'mailcap', and support programs

$ grep vnd.mif /etc/mime.types
application/vnd.mif           mif

As it's a config file, this line could be added by an other package.

The context of this entry is:
application/vnd.koan
application/vnd.lotus-1-2-3
application/vnd.lotus-approach
application/vnd.lotus-freelance
application/vnd.lotus-notes
application/vnd.lotus-organizer
application/vnd.lotus-screencam
application/vnd.lotus-wordpro
application/vnd.mcd
application/vnd.mediastation.cdkey
application/vnd.meridian-slingshot
application/vnd.mif           mif
application/vnd.minisoft-hp3000-save
application/vnd.mitsubishi.misty-guard.trustweb
application/vnd.mobius.daf
application/vnd.mobius.dis
application/vnd.mobius.msl
application/vnd.mobius.plc
application/vnd.mobius.txf
application/vnd.motorola.flexsuite
application/vnd.motorola.flexsuite.adsi
application/vnd.motorola.flexsuite.fis
application/vnd.motorola.flexsuite.gotap

Hope, it helps.

mfg Martin K=F6gler
