From: Gili Pearl <gili.pearl@yahoo.com>
Subject: how to work in hirarchical git model?
Date: Tue, 16 Dec 2008 14:26:56 -0800 (PST)
Message-ID: <703400.93370.qm@web112210.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 23:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCiVE-0002to-Vm
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 23:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbYLPWdi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Dec 2008 17:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYLPWdi
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 17:33:38 -0500
Received: from web112210.mail.gq1.yahoo.com ([67.195.14.73]:47597 "HELO
	web112210.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751762AbYLPWdh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 17:33:37 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Dec 2008 17:33:37 EST
Received: (qmail 93747 invoked by uid 60001); 16 Dec 2008 22:26:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=NFCUnqd59js9hkIjT4OPc4wbhA6JTqSn2jsUPRA06zNqc35xL2v5x8HHIR/9DhnZrDFaSQ7BLgvKZ7B++exsF+2Ybb8129r2hMmUwMfHwjjCOP8nvMmxqJ78qps0z/vsFsL3x/0fkqRNXvO6r7evkexSqeOZEdDcYhTVDmeLoPE=;
X-YMail-OSG: LiXdhUsVM1lUZ1ZOKpxTxKnMGAaUgw7ZV7LpccQ0AKK5g4M.VzkZH7n8qHLue5w0aDnEEas6tsxbzkoUpsjp6xLzJz8U0rdWSbPyadydsaCquKSDFnyBPkkQP5DXKmOYfhTPjktKyloVkBs_60IYYjjputCU
Received: from [84.229.24.61] by web112210.mail.gq1.yahoo.com via HTTP; Tue, 16 Dec 2008 14:26:56 PST
X-Mailer: YahooMailRC/1155.45 YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103291>

[Not sure I'm posting to the right mailing list; sorry in advance]

I=E2=80=99m working in a small company with about 15 developers. So far=
 we were all=20
rebasing our local repos on a single main repo. When one had some new c=
ommits,=20
he rebased them on the main-repo/master and asked the main-repo maintai=
ner to=20
pull them in. So far so good, but we now considering moving into a thre=
e level=20
model, where we=E2=80=99ll have sub-maintainers that will handle local =
merges before=20
they hit the main-repo. I=E2=80=99m not sure I understand how this is s=
upposed to work=20
and I=E2=80=99d be thankful to get some advice.=20

Here is one problem I saw when trying to work in the three-level model.
At some point, I had the following setup:

top-level : A----B----C----D
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
mid-level1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 K----L----M
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
low-level1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X----Y

The maintainer of mid-level1 has decided that commits K L M are ready t=
o be=20
merged into the top-level repo. So he rebased on top-level before askin=
g 'please=20
pull', but after that the low-level was not able to rebase on the mid-l=
evel=20
any more.=20
I can understand that the problem is because commit L had become L', an=
d now=20
low-level1 cannot find L anymore, i.e. now it looks like this:

top-level : A----B----C----D
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
mid-level1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 K'----L'----M'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
low-level1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X----Y

=2E.. but I guess this is not how it should work. So what is the right =
working=20
flow for us?

Thanks.


     =20
