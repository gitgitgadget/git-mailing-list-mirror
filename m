From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Consecutive git gc fails on Windows network share
Date: Tue, 21 Jan 2014 00:25:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401210002080.14982@s15462909.onlinehome-server.info>
References: <d10603d6-7740-44f8-909f-7ba1ea77d3a2@googlegroups.com> <52D9701F.5070009@web.de> <11936e14-7442-4601-8e97-b2062894975b@googlegroups.com> <52DD59E0.4090301@web.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-2041389300-1390260322=:14982"
Cc: Jochen <zwanzig12@googlemail.com>, msysgit@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>,
	stefanbeller@googlemail.com
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 21 00:25:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5ODg-0003gI-SW
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 00:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbaATXZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 18:25:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:56471 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbaATXZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 18:25:24 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LqiJO-1VSBqy2nWU-00eOAP
 for <git@vger.kernel.org>; Tue, 21 Jan 2014 00:25:22 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <52DD59E0.4090301@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:aZJC22YQtu/9X0/E2APADqrlexZdmtkf/NGTakUozWZfW+cJTGK
 UGyeRUz9Ep4l/fyWkMEj59pTgOuSk+aHqSfGxThJI51mKLLpX4E+1IPrLF6D8nH5CODCiXI
 bXST3TGm9gnFHndhJGiy7Fs2vBZGObczoot4pXcn0hyesLV8WkKY+qe1t0esRr5Bu1eEa6E
 jLZ0PjPzZvrSgl3iVuO/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240735>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-2041389300-1390260322=:14982
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Mon, 20 Jan 2014, Torsten B=C3=B6gershausen wrote:

> (No top-posting, please see my comments below)

already very good! For extra brownie points, just edit the quoted part to
reflect the abridged version needed to understand the context.

> On 2014-01-20 15.02, Jochen wrote:
> >On 01/16/2014 10:55 AM, Jochen Haag wrote:
> > The rename command replaces a mv -f command of the original shell scrip=
t. Obviously the -f option can also override a read-only file but rename ca=
n not on a network share.
>=20
> I allowed me to=20
> a) reconstruct the original mail,

Please note that together with an exceedingly flakey internet connection,
not only having to scroll through the mail (most of which was actually not
relevant to your reply) and having to delete most parts again ate up my
complete Git time budget for today. Just something you might want to keep
in mind.

> b) add "+++" at the places where you added the stat() and chmod(),
> c) and to send the question "is this a good implementation ?" to upstream=
 git.
>
> I think your implementation makes sense.

As I said in my other reply, I think that the problem would be addressed
more generally in compat/mingw.c. It is to be doubted highly that upstream
wants to handle cases such as "rename() cannot overwrite read-only files
on Windows" everywhere they call rename() because the platforms upstream
cares about do not have that problem.

So we probably need just the same _wchmod we have in mingw_unlink also in
mingw_rename.

Ciao,
Johannes
--1784107012-2041389300-1390260322=:14982--
