From: "Rick Liu" <rickliu@broadcom.com>
Subject: RE: standarize mtime when git checkout
Date: Tue, 9 Jul 2013 15:45:52 +0000
Message-ID: <7D0754FFADBD2D4785C1D233C497C47B209B07D1@SJEXCHMB06.corp.ad.broadcom.com>
References: <7D0754FFADBD2D4785C1D233C497C47B209AF2BC@SJEXCHMB06.corp.ad.broadcom.com>
 <51DB8966.2060308@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jul 09 17:46:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwa7G-0004K8-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 17:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab3GIPqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 11:46:06 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:2778 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab3GIPqE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 11:46:04 -0400
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 09 Jul 2013 08:39:58 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from SJEXCHCAS03.corp.ad.broadcom.com (10.16.203.8) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 9 Jul 2013 08:45:52 -0700
Received: from SJEXCHMB06.corp.ad.broadcom.com (
 [fe80::65ea:1de7:41c4:e948]) by SJEXCHCAS03.corp.ad.broadcom.com (
 [::1]) with mapi id 14.01.0438.000; Tue, 9 Jul 2013 08:45:52 -0700
Thread-Topic: standarize mtime when git checkout
Thread-Index: Ac58IbYJXUCbF7y1RXWD8zNuu6I1/QAAZkzwABvVzgAAChrAgA==
In-Reply-To: <51DB8966.2060308@lsrfire.ath.cx>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.16.203.100]
X-WSS-ID: 7DC2F1441R042322332-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229963>

Thanks Ren=E9~
I'll use "git archive" command to create the tarball.

Rick

-----Original Message-----
=46rom: Ren=E9 Scharfe [mailto:rene.scharfe@lsrfire.ath.cx]=20
Sent: Monday, July 08, 2013 8:54 PM
To: Rick Liu
Cc: git@vger.kernel.org
Subject: Re: standarize mtime when git checkout

Am 08.07.2013 23:39, schrieb Rick Liu:
> Hi,
>
> Currently when doing "git checkout" (either for a branch or a tag),
> if the file doesn't exist before,
> the file will be created using current datetime.
>
> This causes problem while trying to tar the git repository source fil=
es (excluding .git folder).
> The tar binary can be different
> even all of file contents are the same (eg. from the same GIT commit)
> because the mtime for the files might be different due to different "=
git checkout" time.
>
> eg:
> User A checkout the commit at time A and then tarball the folder.
> User B checkout the same commit as time B and then tarball the folder=
=2E
> The result tarball are binary different
> even though all of tarball contents are the same
> except the mtime for each file.
>
>
> Can we use GIT's commit time as the mtime for all of files/folders wh=
en we do "git checkout"?

That would break tools like make which rely on a files mtime to build=20
them.  They wouldn't be able to detect switching between source file=20
versions that are older than the latest build.

You can use "git archive" to create tar files in which all entries have=
=20
their mtime set to the commit time.  Such archives only contain tracked=
=20
(committed) files, though.  And different versions of git can create=20
slightly different archives, but such changes have been rare.

Ren=E9
