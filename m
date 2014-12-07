From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] git-svn: Support for git-svn propset
Date: Sun, 07 Dec 2014 09:00:12 +0100
Message-ID: <5484090C.8070101@web.de>
References: <20141206222942.GB91825@elvis.mu.org> <5483E968.6060708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Alfred Perlstein <alfred@freebsd.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 09:04:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxWpo-000396-4W
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 09:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbaLGIAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 03:00:42 -0500
Received: from mout.web.de ([212.227.15.14]:64375 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411AbaLGIAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 03:00:41 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M0R25-1XhVNQ2HZV-00ucrA; Sun, 07 Dec 2014 09:00:13
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <5483E968.6060708@web.de>
X-Provags-ID: V03:K0:pDU7GaahxYDU6dGzGRW53aeXOBD0wQgWXLeZL5ZAseG+Jh64Mru
 VYGPysSiCWwQG2gG1FeoAzQMV5W+G13AKpkeV0rcLRI950CHp388AAXYBtx2vHpkJ9i14ye
 B2jtJSTo6unUVukvB0C53VTL+qmndO3amtAzYwxRroQprY1cQGe1G3womggsDQUuPYb2X2G
 Sg3eKx6pjBsY/jykpBcqw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260975>

On 2014-12-07 06.45, Torsten B=F6gershausen wrote:
[]
>> +
>> +test_expect_success 'add multiple props' '
>> +	git svn propset svn:keywords "FreeBSD=3D%H" foo &&
>> +	git svn propset fbsd:nokeywords yes foo &&
>> +	echo hello >> foo &&
>> +	git commit -m "testing propset" foo &&
>> +	git svn dcommit
>> +	svn_cmd co "$svnrepo" svn_project &&
>> +	(cd svn_project && test "`svn propget svn:keywords foo`" =3D "Free=
BSD=3D%H") &&
>> +	(cd svn_project && test "`svn propget fbsd:nokeywords foo`" =3D "y=
es") &&
>> +	(cd svn_project && test "`svn proplist -q foo | wc -l`" -eq 2) &&
>> +	rm -rf svn_project
>> +	'
>> +
> Ah, another small thing:
> the "wc -l" will not work under Mac OS X.
> Please see test_line_count() in t/test-lib-functions.sh
>=20
My excuse:
I think I am wrong here and I need to correct myself after having looke=
d at other TC's.
The "wc -l" should work under Mac OS X.

Another small nit:

This=20
"`svn propget svn:keywords foo`" =3D "FreeBSD=3D%H")
can be written as
"$(svn propget svn:keywords foo)" =3D "FreeBSD=3D%H")

(if you want to use the "Git style" for command substitution)
