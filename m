From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Sat, 1 Nov 2014 06:13:14 +0000
Message-ID: <1414822394.95382.YahooMailBasic@web172305.mail.ir2.yahoo.com>
References: <20141101031352.GA17306@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Nov 01 07:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkRwC-0003Gq-ST
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 07:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbaKAGNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Nov 2014 02:13:16 -0400
Received: from nm20-vm5.bullet.mail.ir2.yahoo.com ([212.82.96.247]:47418 "EHLO
	nm20-vm5.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710AbaKAGNP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Nov 2014 02:13:15 -0400
Received: from [212.82.98.51] by nm20.bullet.mail.ir2.yahoo.com with NNFMP; 01 Nov 2014 06:13:14 -0000
Received: from [212.82.98.102] by tm4.bullet.mail.ir2.yahoo.com with NNFMP; 01 Nov 2014 06:13:14 -0000
Received: from [127.0.0.1] by omp1039.mail.ir2.yahoo.com with NNFMP; 01 Nov 2014 06:13:14 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 638506.79333.bm@omp1039.mail.ir2.yahoo.com
Received: (qmail 59875 invoked by uid 60001); 1 Nov 2014 06:13:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414822394; bh=mf/Vufgra5O6jk8Ry3p52fQp9McELs9uhqpnnvUU1kk=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=oi2o+TyNBjffH3a51d3mg4AmCMjGREyylGs89ZYF4lNTlbP5mf5z2bKz7Rl2+obrF16d/Bj1q6wloDjwF4OU14VeEYrPTgLLTjkkSGfzPSAZlrOoQe4jLuUnGXdGU06vKgqjpGsxTX3UQMNK+r2FZfDPwYoca0FVqj67GBtRRgQ=
X-YMail-OSG: AZLXgNcVM1ljEILHM6zBAjhNNwjaw6ekHR3EESxG_0Oo.Na
 0Js0hHMsgDhfoPgwep_14jAr2Owrn_xacfzt_ldvHEBMVu.aHCpdqpgbjqvl
 Wz3K1uXSp.awjTfQELiFwgEgnNGugm8XLjYfYPXWmYk7etQRfnDvl0mt4iRZ
 1IsRECgZD2UIpPqeaLrKr148Mc11bV3oswsFNSma3wOR.oTo7UEWL6O46GhE
 RbFgysoRHe7qUI86QOFPzXeQubtGUWJvh7yUryU0zZbSWKbKUwWNZDYihoTK
 TX5c6q4bJU9NdRuHcrw0raOLFIdEtPRBbFu1ZvdXnJvy0__DsqLDYgNb1NiW
 Gk5plQvyJ0fQhwV9sEpLYiP8Tt7FE47hYkXpkhS_Mnrt2Kwpr8SAbghho_Dw
 bm5cxRi30gRDfK2Jhge0DZETjMHPUJxWpNUdYbEIMoIfOPy.g5eDw7YCfTrt
 k7Vew16haFPmmPu02Bqszmm0i6vFeiNUA9wGHQCGzg64lGnjISXAc3IvGLDC
 kGYpOsJIyh3qBJWNs.tLzLObvrrzPWCAUPlci7YHSqOkbvItev2wgSm4ODGt
 qCTv_6386tfjy58C7y6YzRmOIBOAPRA78jXNQiBVuiNdbqJ3WgOVOpVD7Mpp
 FDx3MrQ8boSoGqdcH3g4Lsg--
Received: from [86.30.137.134] by web172305.mail.ir2.yahoo.com via HTTP; Sat, 01 Nov 2014 06:13:14 GMT
X-Rocket-MIMEInfo: 002.001,LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk9uIFNhdCwgMS8xMS8xNCwgRXJpYyBXb25nIDxub3JtYWxwZXJzb25AeWhidC5uZXQ.IHdyb3RlOg0KDQogSGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KIHdyb3RlOg0KPiA.IFdoaWxlIG15IDIuMTAgKyAxMSBwYXRjaGVzDQogY29udGludWUgdG8gZmV0Y2gsIHdoZXJlIGl0IHdhcyBzdHVjaywgbm93DQogPiBpdCBkb2VzICJDb3VsZG4ndCBmaW5kDQogcmV2bWFwLi4uIiAtIGFsc28sIHRoZSABMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <20141101031352.GA17306@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------------------------------------
On Sat, 1/11/14, Eric Wong <normalperson@yhbt.net> wrote:

 Hin-Tak Leung <htl10@users.sourceforge.net>
 wrote:
> > While my 2.10 + 11 patches
 continue to fetch, where it was stuck, now
 > it does "Couldn't find
 revmap..." - also, the single branch clone is doing
 > the 'trunk/branches/... thing - are
 these supposed to happen?
=20
> I'm afraid this is a problem with the vbox
 repo not publishing anything
 but trunk, but
 their svn:mergeinfo refers to non-public branches.
=20
> This shows only changes to
 trunk:
=20
> =A0=A0=A0 svn log -v http://www.virtualbox.org/svn/vbox
=20
> I do not know what their
 development process is like.=A0 From the looks of
 it, every change is made by a
 "vboxsync" user.=A0 I suspect that's driven
 by an automated export script, and the real
 development happens in a
 different (private)
 repo...
=20
They are Sun/Oracle technology so have that sort of style, I think.
(Think Java and everything to do with Java).

I did get a bit confused about that - their web code broswing interface
shows a number of merges and deleted branches.
