From: Shumkin Alexey <zapped@mail.ru>
Subject: git log --oneline and git log --pretty=format... give differrent
 outputs
Date: Fri, 22 Jul 2011 11:06:18 +0400
Message-ID: <20110722110618.10a62631@zappedws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 09:15:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk9wz-0000Z9-3B
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 09:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759Ab1GVHPB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jul 2011 03:15:01 -0400
Received: from fallback1.mail.ru ([94.100.176.18]:51873 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab1GVHPA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2011 03:15:00 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jul 2011 03:15:00 EDT
Received: from smtp17.mail.ru (smtp17.mail.ru [94.100.176.154])
	by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id D128740C3D64
	for <git@vger.kernel.org>; Fri, 22 Jul 2011 11:06:51 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:Message-ID:Subject:To:From:Date; bh=1GCeuyG2sf17FjdLpmlj8hBlt+uG1fKEE7cpwmzVScM=;
	b=KFcRh5rc0R15QQBXvvdwf5gqSppUaaCDCVMajkOV7bwPOfdNGJVzXDaFLclYhey+JAyL7JItyXemW+S2eku+YMdNFD2PGmVeFhjwMUJMIUevwGJ2/dLfq59siwQODa6V;
Received: from [91.77.47.90] (port=51002 helo=zappedws)
	by smtp17.mail.ru with psmtp 
	id 1Qk9oT-0008Hb-00
	for git@vger.kernel.org; Fri, 22 Jul 2011 11:06:22 +0400
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177634>

Hello everybody!

I have a repository. Basic development is on Windows platform (under
Cygwin). I have commit messages on Russian, so=20
i18n.commitEncoding =3D i18n.logOutputtEncoding =3D cp1251. It's ok.
I works fine on Windows.
When I run on Windows=20
git log --graph --oneline
and=20
git log --graph --pretty=3Dformat:'%C(yellow)%h %Creset%s'

I get two identical outputs which look like
*   ae0a70f merge v2.6.54 into v3.0
|\ =20
| * 581e071 + explicit changelog mail content-type (for claws-mail)...
| * 9bafb65 fixed: changelog does not recognize Mantis...
| * f417e91 fixed: #82 (=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C=
 =D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83 =D0=B2=D0=
=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE=D1=81=D1=82=D1=8C...
| * 8553efa fixed: #87 (2.6.53 =D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=
=D1=8C =D0=B4=D0=BB=D1=8F =D1=80=D0=B0=D1=81=D1=81=D1=8B=D0=BB=D0=BA=D0=
=B8 e-mail...
=2E...

But when I run the same commands (for the same repository and current
commit, of course) on Linux machine (ru_RU.UTF-8 locale; Guake,
xterm, gnome-terminal, etc ) I get different outputs

git log --graph --oneline
gives output identical to Windows (see above)
but
git log --graph --pretty=3Dformat:'%C(yellow)%h %Creset%s'
gives
*   ae0a70f merge v2.6.54 into v3.0
|\ =20
| * 581e071 + explicit changelog mail content-type (for claws-mail)...
| * 9bafb65 fixed: changelog does not recognize Mantis...
| * f417e91 fixed: #82 (<C4><EE><E1><E0><E2><E8><F2><FC>...
| * 8553efa fixed: #87 (2.6.53<C4><EE><E1><E0><E2><E8><F2><FC>...

i.e. non-UTF-8 characters are represented with their codes and not
converted to UTF-8 as they are for "git log --graph --oneline"

So, the question - why? I thought both commands use the same log output
mechanism.
As I can edit Git sources but I'm not familiar to C well, so one
more question "Where exactly in sources to fix it fast?"

Thanks
