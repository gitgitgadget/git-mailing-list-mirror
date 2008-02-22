From: "Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch>
Subject: unexpected behavior of 'git rebase'
Date: Fri, 22 Feb 2008 16:10:47 +0100
Message-ID: <1203693047.6429.11.camel@pc6411.psi.ch>
Reply-To: "Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/pgp-signature";
	micalg=pgp-sha1;
	boundary="=-uKQV+Xgpx1wJG683KEiB"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:28:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSZoS-0001VW-O9
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 16:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYBVP1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 10:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbYBVP1J
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 10:27:09 -0500
Received: from mailsend01.psi.ch ([129.129.191.53]:58275 "EHLO
	MAILSEND01.psi.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYBVP1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 10:27:08 -0500
X-Greylist: delayed 977 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2008 10:27:08 EST
Received: from MAILBOX0A.psi.ch ([129.129.190.193]) by MAILSEND01.psi.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 16:10:47 +0100
Received: from 129.129.206.141 ([129.129.206.141]) by MAILBOX0A.psi.ch ([129.129.190.181]) via Exchange Front-End Server mail.psi.ch ([129.129.191.54]) with Microsoft Exchange Server HTTP-DAV ; Fri, 22 Feb 2008 15:10:47 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from pc6411 by mail.psi.ch; 22 Feb 2008 16:10:47 +0100
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: unexpected behavior of 'git rebase'
Thread-Index: Ach1ZRo1lYIa+0DFRsSIIPHIvij9Mw==
X-OriginalArrivalTime: 22 Feb 2008 15:10:47.0764 (UTC) FILETIME=[1A8CC940:01C87565]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74728>


--=-uKQV+Xgpx1wJG683KEiB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi,

i found that 'git rebase' does not include stashed stuff. in the
following my work flow in details.
i work on branch 'topic' and stash some things away.

[alxneit@pc6411]$ git stash

gitk --all shows my stashed things on 'topic'.


                  index on topic: ...        =20
                 /   \=20
      B'---C'---D'---WIP on topic: ...    (topic with stashed thing)
     /
A---B---C  (master)


i decide to rebase 'topic'.

[alxneit@pc6411]$ git rebase master topic

i would have expected to get


                      index on topic: ...        =20
                     /   \
          B'---C'---D'---WIP on topic: ...    (topic with stashed thing)
         /
A---B---C    (master)


i.e. 'topic' including the stashed things are rebased. however, i the
result (as revealed by 'gitk --all') is


                  index on topic: ...        =20
                 /                        \
      B'---C'---D'---WIP on topic: ... ---stash    (gitk shows
     /                                              no branch name
A---B---C  (master)                                  anymore)
         \
          B'---C'---D'    (topic)



the old 'topic' branch (including the stashed things) is left behind as
an unnamed branch. only commits B', C', and D' have been rebased as
branch 'topic'.

is this the intended behavior?

thanks in advance

p.s.=20
[alxneit@pc6411 ]$ git --version
git version 1.5.4.2.1.gef98

p.p.s:
please cc me. i am not subscribed to the list

--=20
Dr. Ivo Alxneit
Laboratory for Solar Technology   phone: +41 56 310 4092
Paul Scherrer Institute             fax: +41 56 310 2688
CH-5232 Villigen                   http://solar.web.psi.ch
Switzerland                   gnupg key: 0x515E30C7

--=-uKQV+Xgpx1wJG683KEiB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHvuX0Ad7CE1FeMMcRAlOsAKCfqUukhtfa2NXMqQ1jTds8VoG9OQCgrQ6d
yf3VnOwsyz7y9PF8VPjOZAU=
=Hke6
-----END PGP SIGNATURE-----

--=-uKQV+Xgpx1wJG683KEiB--
