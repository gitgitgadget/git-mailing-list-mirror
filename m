From: =?UTF-8?B?SsO2cmc=?= Schaible <joerg.schaible@swisspost.com>
Subject: Re: git svn clone fails
Date: Fri, 14 Aug 2015 15:47:15 +0200
Organization: Swiss Post Solutions
Message-ID: <mqkrh4$7cf$1@ger.gmane.org>
References: <mpa8th$m80$1@ger.gmane.org> <mppsku$h97$1@ger.gmane.org> <mqk6mb$qi8$1@ger.gmane.org> <55CDA784.7080809@web.de> <mqkgee$ju3$1@ger.gmane.org> <55CDD713.1050205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 15:48:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQFKz-0006Qe-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 15:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbbHNNrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2015 09:47:45 -0400
Received: from plane.gmane.org ([80.91.229.3]:53568 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225AbbHNNro (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 09:47:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZQFKa-00062T-2t
	for git@vger.kernel.org; Fri, 14 Aug 2015 15:47:36 +0200
Received: from 62.154.225.82 ([62.154.225.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:47:36 +0200
Received: from joerg.schaible by 62.154.225.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:47:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62.154.225.82
User-Agent: KNode/4.14.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275903>

Hi Thorsten,

there's more fun though. GIT (2.4.6) fails differently if I add additio=
nally=20
the "--no-minimize-url":

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[...]
W: -empty_dir: trunk/src/test/serialization/com/elsagsolutions
r40223 =3D 7983efa910e6cd606cc63a6b6b365048df1e11a9=20
(refs/remotes/origin/trunk)
        M       src/main/java/com/scalaris/commons/lang/util/ArrayUtils=
=2Ejava
r40261 =3D ecf4747a88073353c9731e6e69c079d66e7aac2d=20
(refs/remotes/origin/trunk)
        M      =20
src/test/java/com/scalaris/commons/lang/util/ArrayUtilsTestCase.java
r40262 =3D 96eda7427de3f1c082e88c23458be197a3b20a7a=20
(refs/remotes/origin/trunk)
        M       changes.xml
        A       src/main/java/com/scalaris/commons/lang/net/MimeTypes.j=
ava
r41127 =3D 00d0a652e5ef20c18b9d4764dd70383c1d10177b=20
(refs/remotes/origin/trunk)
        M       changes.xml
=46ailed to strip path=20
'src/main/java/com/elsagsolutions/commons/lang/io/.gitignore' ((?^:^tru=
nk(/|
$)))
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

the error in the Perl module happens only without that option. Both err=
ors=20
do not occur without option "--preserve-empty-dirs".


Torsten B=C3=B6gershausen wrote:

> On 2015-08-14 12.38, J=C3=B6rg Schaible wrote:
>> Any idea how to proceed?
>=20
> Git itself doesn't version empty directories at all, only files
> (and soft links, sub modules....).

I know, but "git svn clone" creates a .gitignore file in such a case.

> Git creates a directory as a "side effect" to be able to store files
> there.
>=20
> May be I am off-topic, but would it be possible to fill the empty
> directories with a dummy file ".empty" ?

That does not help when converting the Subversion history. It's failing=
 long=20
before HEAD of trunk.

> Add those to svn and force Git to create a nearly empty directory.

That's what GIT normally does by default on its own. However, I cannot=20
change the Subversion history. GIT has to deal with it while converting=
 (and=20
normally it does, as my test proofed with the demo Subversion project).

Cheers,
J=C3=B6rg
