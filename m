From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Tue, 7 Oct 2014 00:51:32 +0100
Message-ID: <1412639492.85440.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Tue Oct 07 01:51:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbI42-0006k7-To
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 01:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbaJFXvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2014 19:51:35 -0400
Received: from nm20-vm5.bullet.mail.ir2.yahoo.com ([212.82.96.247]:37044 "EHLO
	nm20-vm5.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751213AbaJFXve convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Oct 2014 19:51:34 -0400
Received: from [212.82.98.52] by nm20.bullet.mail.ir2.yahoo.com with NNFMP; 06 Oct 2014 23:51:32 -0000
Received: from [212.82.98.88] by tm5.bullet.mail.ir2.yahoo.com with NNFMP; 06 Oct 2014 23:51:32 -0000
Received: from [127.0.0.1] by omp1025.mail.ir2.yahoo.com with NNFMP; 06 Oct 2014 23:51:32 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 667678.6104.bm@omp1025.mail.ir2.yahoo.com
Received: (qmail 87739 invoked by uid 60001); 6 Oct 2014 23:51:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1412639492; bh=RRRc1mUbwnGd+yRi4F/1wVu0p+DMxaK6rDgAz6vUKzE=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=KAM8wjQWHUv99sVCaoS4xRX+lHxCcE/ClTDbfWmzyFMt3qHTmlfu6+VjA7j1CERdPG0ngJ4qy6LcAo88Oo9iBoYrMM4Rtd9q7eqzMBWEmBHznzI4ZEdkLqX3P5DJybYooc5a1AuEIxfYYNf6oXpNGbU+pmtaq2GHQFEO2YehiGY=
X-YMail-OSG: uvzJKA4VM1lr4AKxYGmrTPs_vtKaX8K3n7BofCgTP_2roUJ
 OGoNbzFThQC9rL8cyd_Tuk0X3CU5DIii7VqzbKFPnicme6i1nBjZ3e_KHlvz
 EXcNi2mfVZqTK0R3YUGLZydwdX_PUmKQfhWDBrQ9MI0IwWGpgdhfUMV2BeRM
 Heog2a9t5lLe09IhWctf5S8ynQyzGX4tYq.OJOcvezJpziQcJXhptOOsVHr_
 LSjddNskJdvNcb6wMOo3KkZIFjN6J0eyg08i7fOgfBo0.KMFLxq0Tx5D5hw0
 FibcEMwpYXOVkFrX.61E5g81QquHuEIQOyTj3rUzPlV.tuRS2px9Px2xra6u
 eXCTPj4zpavjnzcFDjfD0YgO1H2sPr.o.CKDSfw.sS.b6cWT3yMSLptfJ0_1
 Y7F7v6qHO92A1VdT7zl4Fl.TBbHcfuvpFMDgy1BEIDQzRX9SLVjKnUGedZTA
 _s1d_Ut11pmQB0X.LxGrWB2jUZl0fdXyxK80e5j0NtqcM0gepEj.iLP3uRwe
 Yi4dDrVb9jKxtCnf7aJorx.YuxtFKafyTRmfjzMhsnMAEK6WXADo4Klc4KjI
 er4dfwvvXkPagFnmrhI7OIhwKqrpIaZ5RooxRD6ffsr7lPR62U88BmHejYYL
 4jXL8N7yNoQ--
Received: from [86.30.137.134] by web172306.mail.ir2.yahoo.com via HTTP; Tue, 07 Oct 2014 00:51:32 BST
X-Rocket-MIMEInfo: 002.001,LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBTdW4sIE9jdCA1LCAyMDE0IDAyOjAyIEJTVCBFcmljIFdvbmcgd3JvdGU6DQoNCj5FcmljIFdvbmcgPG5vcm1hbHBlcnNvbkB5aGJ0Lm5ldD4gd3JvdGU6DQo.PiBKYWtvYiBzZW50IHNvbWUgcGF0Y2hlcyBhIGZldyBtb250aHMgYWdvIHdoaWNoIHNlZW0gdG8gYWRkcmVzcyB0aGUNCj4.IGlzc3VlLsKgIFVuZm9ydHVuYXRlbHkgd2UgZm9yZ290IGFib3V0IHRoZW0gOngNCj4NCj5IaW4tVGFrOiBoYXZlIHlvdSB0cmllZCBKYWtvYidzIHBhdGNoZXMBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/799 YahooMailWebService/0.8.203.696
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257918>

------------------------------
On Sun, Oct 5, 2014 02:02 BST Eric Wong wrote:

>Eric Wong <normalperson@yhbt.net> wrote:
>> Jakob sent some patches a few months ago which seem to address the
>> issue.=A0 Unfortunately we forgot about them :x
>
>Hin-Tak: have you tried Jakob's patches?=A0 I've taken another look,
>signed-off and pushed to my master.
>
>> Can you take a look at the following two "mergeinfo-speedups"
>> in my repo?=A0 (git://bogomips.org/git-svn)
>>=20
>> Jakob Stoklund Olesen (2):
>>=A0 =A0 =A0=A0=A0git-svn: only look at the new parts of svn:mergeinfo
>>=A0 =A0 =A0=A0=A0git-svn: only look at the root path for svn:mergeinf=
o
>>=20
>> Also downloadable here:
>>=20
>> http://bogomips.org/git-svn.git/patch?id=3D9b258e721b30785357535
>> http://bogomips.org/git-svn.git/patch?id=3D73409a2145e93b436d74a
>>=20
>> Can you please give them a try?

Apologies - I applied them on top of 2.1.0 earlier today, and the svn r=
epo just
hasn't been changed much recently to show any interesting behavior
with 'git svn fetch --all', so I thought about whether I should wait to=
 report. Then
I changed my mind, and decided what the hell, let's clone the whole
thing again :-). So I made a new directory, run 'git init', just copy
=2Egit/config from the old reop and am doing 'git svn fetch --all' in t=
he new empty
directory again.

So far it seems to be good. But I am only at revision 35700-ish at the =
moment,
and the whole thing is 66700-ish. Oh, I forgot to mention that the stra=
nge
pauses seem to be followed by messages like these:

W:svn cherry-pick ignored (/branches/R-2-12-branch:52939,54476,55265) -=
 missing 492 commit(s) (eg 9bf20dca6a8b05dff28e6486b1613f10825972c9)
W:svn cherry-pick ignored (/branches/R-2-13-branch:55265,55432) - missi=
ng 231 commit(s) (eg 9290cf6ce2d7f6cca168cf326eed6e9fe760895f)
W:svn cherry-pick ignored (/branches/R-2-15-branch:58894,59717) - missi=
ng 405 commit(s) (eg ed84a373b33f728949edf3371829fc3414c343a8)
W:svn cherry-pick ignored (/branches/R-3-0-branch:62497) - missing 154 =
commit(s) (eg 9e4742d201771c9658417c2d2f83838e550e3162)
W:svn cherry-pick ignored (/trunk:

So presumably I'd only see interesting behavior when there are a number=
 of branches.
It seems the first branches are around revision 48000-ish, so I might h=
ave
to wait a bit.

So far, the new clone hasn't created ".git/svn/.caches/" yet; and memor=
y consumption seems
okay also.
