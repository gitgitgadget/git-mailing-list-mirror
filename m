From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] Fix t9200 on case insensitive file systems
Date: Sun, 28 Oct 2012 16:28:19 +0100
Message-ID: <508D4F13.1090209@web.de>
References: <201210261818.25620.tboegi@web.de> <20121028111053.GC11434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org, bdwalton@gmail.com, bosch@adacore.com,
	brian@gernhardtsoftware.com, robin.rosenberg@dewire.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 16:30:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSUod-0006fy-2P
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 16:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab2J1P2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Oct 2012 11:28:24 -0400
Received: from mout.web.de ([212.227.17.11]:49924 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab2J1P2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 11:28:24 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MT8bi-1TsIsP3fvC-00RkgN; Sun, 28 Oct 2012 16:28:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121028111053.GC11434@sigill.intra.peff.net>
X-Provags-ID: V02:K0:JeQVZB0CRzfv5UkDDGKe4PpntYEaYm29p2HbT9CA+1y
 BFhDsFJZ/KqDXjcLpYmKf9xTyMQn/VTVgbVmegl4LSM35617lS
 CjhMutk+GJqX2yN8ZUJXQ96SnEPBOpxTl68o85D/7l1BXW+02V
 l1hRrQIaBbrYYx2K/K0b6j4rWjinPOLQ8w3e6GFsX1CZycq82k
 icDqhUVg3FlKSPJUY+LHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208549>

On 28.10.12 12:10, Jeff King wrote:
> On Fri, Oct 26, 2012 at 06:18:24PM +0200, Torsten B=C3=B6gershausen w=
rote:
>=20
>> t9200 defines $CVSROOT where cvs should init its repository
>> $CVSROOT is set to $PWD/cvsroot.
>> cvs init is supposed to create the repository inside $PWD/cvsroot/CV=
SROOT
>>
>> "cvs init" (e.g. version  1.11.23) checks if the last element of the=
 path is
>> "CVSROOT", and if a directory with e.g. $PWD/cvsroot/CVSROOT already=
 exists.
>>
>> For such a $CVSROOT cvs refuses to init a repository here:
>> "Cannot initialize repository under existing CVSROOT:
>>
>> On a case insenstive file system cvsroot and CVSROOT are the same di=
rectories
>> and t9200 fails.
>>
>> Solution: use $PWD/tmp/cvsroot instead of cvsroot $PWD/cvsroot
>=20
> Wouldn't tmp/cvsroot have the same problem, since the basename is sti=
ll
> cvsroot?
>=20
>> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportc=
ommit.sh
>> index b59be9a..69934b2 100755
>> --- a/t/t9200-git-cvsexportcommit.sh
>> +++ b/t/t9200-git-cvsexportcommit.sh
>> @@ -19,7 +19,7 @@ then
>>      test_done
>>  fi
>> =20
>> -CVSROOT=3D$PWD/cvsroot
>> +CVSROOT=3D$PWD/tmpcvsroot
>=20
> Ah, but here you do something different, which makes sense. Should I
> tweak the commit message?
>=20

Yes, please do so.

Thanks for spotting,
/torsten
