From: axel.ml@laposte.net
Subject: Re: REMOTE_USER value propagation through http push
Date: Wed, 13 Apr 2011 15:39:32 +0200 (CEST)
Message-ID: <22124707.170284.1302701972329.JavaMail.www@wwinf8403>
References: <4DA57183.6040308@laposte.net>
 <m3sjtm2z8e.fsf@localhost.localdomain>
 <5222475.65704.1302693678918.JavaMail.www@wwinf8226>
 <m3oc4a2tzf.fsf@localhost.localdomain>
Reply-To: axel.ml@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA0IF-00005c-SG
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 15:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab1DMNjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 09:39:35 -0400
Received: from out4.laposte.net ([193.251.214.121]:53705 "EHLO
	out3.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753132Ab1DMNje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 09:39:34 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8306.laposte.net (SMTP Server) with ESMTP id 62DD970000A9;
	Wed, 13 Apr 2011 15:39:32 +0200 (CEST)
Received: from wwinf8403 (unknown [10.98.50.223])
	by mwinf8306.laposte.net (SMTP Server) with ESMTP id 5268D70000A3;
	Wed, 13 Apr 2011 15:39:32 +0200 (CEST)
X-ME-UUID: 20110413133932337.5268D70000A3@mwinf8306.laposte.net
To: Jakub Narebski <jnareb@gmail.com>
To: Axel <axel.ml@laposte.net>
In-Reply-To: <m3oc4a2tzf.fsf@localhost.localdomain>
X-Originating-IP: [82.247.209.197]
X-Wum-Nature: EMAIL-NATURE
X-WUM-FROM: |~|
X-WUM-CC: |~|
X-WUM-REPLYTO: |~|
X-me-spamlevel: not-spam
X-me-spamrating: 35.799999
X-me-spamcause: OK, (-105)(0000)gggruggvucftvghtrhhoucdtuddrfeduiedrfeejucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenjhgvucdlqdehmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171458>


> Could you explain in more detail _what_ behavior would you like to
> see? Gitweb does display author and comitter (though in 'log' and
> 'shortlog' only author is visible).
>=20

I understand well your explanations about git mechanisms.

Though git is decentralized, we still use a "central" repository on whi=
ch gitweb is installed, mainly for pratical reasons (you may tell "then=
 you don't need git!" :) ) because not only developers browse the commi=
ts history.
At this moment we use HTTP authentication more for tracing purposes (kn=
owing who pushed data to the repo) than for allowing or not push access=
=2E

If i m not wrong, the AUTHOR field displayed in gitweb comes from the g=
it client configuration ($GIT_AUTHOR_NAME).

I would go further : HTTP authentication (for in-house organisation of =
course, not internet-wide access) usefulness is unclear since the crede=
ntials do not pop up anywhere in git repository. We have to trust the c=
lient-side configuration. The way to know who pushed something is to br=
owse Apache access.log and cross the date/time with the git log.

What I d like to see is that the push authentication credentials overwr=
ite an eventually defined author name at the client side in order to be=
 displayed while browsing git log.

Even better, in the case of LDAP authentication (I m not sure if it wou=
ld be possible for htaccess authentication), email and fullname could b=
e extracted from LDAP directory, stored in environment variables by Apa=
che, and given to git-http-backend (as is the REMOTE_USER variable).

Though I dont know if this request is relevant, I guess that if git-htt=
p-backend was looking for GIT_AUTHOR_NAME & GIT_AUTHOR_EMAIL environmen=
t variables that Apache could have defined, it could replace the client=
-side values defined. (Note that I absolutly don't know if it would be =
technically possible to overwrite those variables or even if their valu=
es are in the push payload).


Une messagerie gratuite, garantie =C3=A0 vie et des services en plus, =C3=
=A7a vous tente ?
Je cr=C3=A9e ma bo=C3=AEte mail www.laposte.net
