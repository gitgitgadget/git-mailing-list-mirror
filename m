From: Johan Herland <johan@herland.net>
Subject: Re: Problems with large compressed binaries when converting from svn
Date: Thu, 8 Jan 2009 11:01:52 +0100
Message-ID: <200901081101.52650.johan@herland.net>
References: <c09652430901060455l5179888ep3c51ff4e3dd5a6ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?iso-8859-1?q?=D8yvind?= Harboe" <oyvind.harboe@zylin.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 11:47:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKsQa-0000fk-MZ
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 11:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbZAHKq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 05:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZAHKq2
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 05:46:28 -0500
Received: from mail10.copyleft.no ([195.159.105.140]:62290 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZAHKq1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 05:46:27 -0500
X-Greylist: delayed 2671 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jan 2009 05:46:27 EST
Received: from mail.mailgateway.no ([82.117.37.108])
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1LKri5-000KR0-PO; Thu, 08 Jan 2009 11:01:53 +0100
Received: from cm-84.215.102.95.getinternet.no ([84.215.102.95] helo=alpha.herland)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1LKri5-000MAe-AS; Thu, 08 Jan 2009 11:01:53 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <c09652430901060455l5179888ep3c51ff4e3dd5a6ef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104913>

On Tuesday 06 January 2009, =D8yvind Harboe wrote:
> I'm converting from svn and I've run into a
> problem with tar.gz and tar.bz2 compressed files.
>
> (This is a separate but only slightly related to previous post).
>
> In subversion we committed large tar.bz2/gz files. These files would
> change relatively rarely, but only very slightly.  The trouble with t=
he
> tar.bz2 format is that if the first byte changes, then the rest of th=
e
> file will also be different. .zip does not have this problem, but .zi=
p
> isn't a very friendly format for our purposes.
>
> Later on the tar.bz2/gz files started to change fairly often, but
> harddrives get bigger much more quickly than the .svn repository grow=
s so
> we just kept doing things the same way rather than reeducate and
> reengineer the procedures.
>
> With .git we need to handle this differently somehow.
>
> Does git have some capability to store diffs of compressed files
> efficiently?
>
> The only other alternative I can think of is to commit uncompressed
> .tar files which is a bit of a bump in the road, but I suppose could =
be
> made to work.

Git can automate this for you. Take a look at the gitattributes(5) man =
page,=20
specifically the "filter" attribute. You should be able to set up filte=
r=20
drivers for .tar.gz files that use "clean=3Dgunzip" and "smudge=3Dgzip"=
 (and a=20
similar filter driver for .tar.bz2 files).

If I've understood this right (I haven't used this myself) your checkou=
ts=20
should now have .tar.gz and .tar.bz2 files, even though Git only=20
stores .tar files internally (thus improving compression across version=
s=20
dramatically).


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
