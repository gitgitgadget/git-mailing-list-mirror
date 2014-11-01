From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Sat, 1 Nov 2014 02:19:06 +0000
Message-ID: <1414808346.73568.YahooMailBasic@web172303.mail.ir2.yahoo.com>
References: <20141031232222.GA30046@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Nov 01 03:19:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkOHb-0007cO-18
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 03:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286AbaKACTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2014 22:19:09 -0400
Received: from nm28-vm5.bullet.mail.ir2.yahoo.com ([212.82.97.65]:57794 "EHLO
	nm28-vm5.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753636AbaKACTI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 22:19:08 -0400
Received: from [212.82.98.50] by nm28.bullet.mail.ir2.yahoo.com with NNFMP; 01 Nov 2014 02:19:06 -0000
Received: from [212.82.98.76] by tm3.bullet.mail.ir2.yahoo.com with NNFMP; 01 Nov 2014 02:19:06 -0000
Received: from [127.0.0.1] by omp1013.mail.ir2.yahoo.com with NNFMP; 01 Nov 2014 02:19:06 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 565924.67635.bm@omp1013.mail.ir2.yahoo.com
Received: (qmail 45016 invoked by uid 60001); 1 Nov 2014 02:19:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414808346; bh=vwUYPGQoY9jRVuECp35bSMZC/Agpzemg8uRe7ny40lE=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=FpIPdvaMn8ecf5JkyIRdeKGAJ8xXVChtqtrQ/wSVqn5r85Z26OqZ/orDRtjvZn1bgLXwlySTulFuLqpLzIkWM1btBP/qs61tKxX5rI7LEBpQD6to/VhMOZvbo0s/hE7aOd3OmLUF/dKjm7zUcKmqrWuGqhnH7ebB3Up+Toe4ek0=
X-YMail-OSG: HTfC5.gVM1mgONtZ2K0lVHTzmCdBtH0sGtHLI4nJu6VIl9Q
 LLvWxRcWGDFlYB.iPhc2wmAYLqMBgPcyg.4zeAP36DJdS7r_6BNlv4StezkK
 dDwDrVxJOks3IdUx5bum_HvhzsPeGnvFnJFnWWdm8rq4T0Mjs.uj9J9iBdr8
 SskfR5eOXpH43hSWGyJAd9N8dCL1lSvNgmSgKctb8w7UnhuftCYVDAnqpckW
 zSjiXizlozr1dg.pF3hLUMwUNyHLDal2YDi1mtfu7LGF1yX5iBJO2Nn75ZwW
 bjEGkqHaHjrc58twdgZQO_zcuXNDR_atwV.WE8eKiG_7QwtgAcwgCu_W_Knh
 Ao44QDoFfz3Bn2LtMhceMHOUOI0X7X9W98xpJflOjeTcKBsC7LfMFfPpBKuR
 Id9tD5zPKSApMVETlizpTnQyscVjmoWWmBFUpZVqdF9dWpIAxHXJL_JaQ6Aa
 1_asbMM0gR2K31l5BRL5CuqKY.cihw64hnj9VhpadLQOgg099mpEMgGtog0k
 Q.jiJQyZzJsyXOM6eVWiYL3zbVJBk71Fn1sTdAIWJaFiuSft7gBwBgtOSK_H
 6M1VDfn2_RIzntgfZjYOQxzMWDJUXBQy_MM92Ro9eOFiGN0WRzOGD2_xoQCq
 1KrQJ1SlQAC2Y2PUDbqOBySg6itnrWSN3mKTx_FTMkMt.ZtWXh7qR_EpQPIw
 BB1KrS9ai3pNIGC8r_oSqFk74VrSR6T9nrwyEYAuCOD3QFhd1tkU2meJG1d0
 lyyroS5LEiKFtXlUZ2yHL0A76CZfIbw--
Received: from [86.30.137.134] by web172303.mail.ir2.yahoo.com via HTTP; Sat, 01 Nov 2014 02:19:06 GMT
X-Rocket-MIMEInfo: 002.001,DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KT24gU2F0LCAxLzExLzE0LCBFcmljIFdvbmcgPG5vcm1hbHBlcnNvbkB5aGJ0Lm5ldD4gd3JvdGU6DQogDQogSGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KIHdyb3RlOg0KPiA.IFRlc3RlZC1ieTogSGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KID4gDQogPiBPa2F5LCB0aGlzIG9uZSBvbg0KIHRvcCBvZiBteSAiZ2l0IDIuMS4wICsgMTAgcmVjZW50IGdpdCABMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <20141031232222.GA30046@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--------------------------------------------
On Sat, 1/11/14, Eric Wong <normalperson@yhbt.net> wrote:
=20
 Hin-Tak Leung <htl10@users.sourceforge.net>
 wrote:
> > Tested-by: Hin-Tak Leung <htl10@users.sourceforge.net>
 >=20
 > Okay, this one on
 top of my "git 2.1.0 + 10 recent git svn improvement
 patches"
 > allow me to fetch
 further.
 >=20
 > I
 suspect the problem must be elsewhere though, and this just
 band-aided
 > over it.
 >=20
 > For me, reverting
 the additional patches and just use git 2.1.0 also allow
 > me to fetch further, so the problem appear
 to me to be associated with
 > the
 additional patches.
=20
 > Junio
 already pulled all of those git-svn patches into git
 2.2.0-rc0:
=20
> http://mid.gmane.org/xmqq7fzgt0q4.fsf@gitster.dls.corp.google.com
=20
> Can you give that a try?=A0
 I've been able to complete the vbox
 fetch without problems.

While my 2.10 + 11 patches continue to fetch, where it was stuck, now
it does "Couldn't find revmap..." - also, the single branch clone is do=
ing
the 'trunk/branches/... thing - are these supposed to happen?

--stdlayout:

$ git svn fetch --all
Index mismatch: d6c75bc195b1daad647322e2cc025bd31265c6b9 !=3D 3927d05f6=
ab037fcf2b4d964c9633efade037d1b
rereading a65b5fc0077c2fa80a344833b65ac19ff4ae88b6
	M	src/VBox/Main/HostImpl.cpp
Checking svn:mergeinfo changes since r28923: 1 sources, 1 changed
Couldn't find revmap for http://www.virtualbox.org/svn/vbox/branches/VB=
ox-3.0
r28924 =3D 4e01065451e00c725c88113584461ee3284e3952 (refs/remotes/origi=
n/trunk)

without --stdlayout:

$ git svn fetch --all
Index mismatch: d6c75bc195b1daad647322e2cc025bd31265c6b9 !=3D 3927d05f6=
ab037fcf2b4d964c9633efade037d1b
rereading a65b5fc0077c2fa80a344833b65ac19ff4ae88b6
	M	src/VBox/Main/HostImpl.cpp
Checking svn:mergeinfo changes since r28923: 1 sources, 1 changed
Couldn't find revmap for http://www.virtualbox.org/svn/vbox/trunk/branc=
hes/VBox-3.0
r28924 =3D 4e01065451e00c725c88113584461ee3284e3952 (refs/remotes/git-s=
vn)
=20
