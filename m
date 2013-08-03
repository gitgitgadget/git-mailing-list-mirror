From: =?windows-1252?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: [bug] remotes-hg: timezones are transformed
Date: Sat, 3 Aug 2013 18:36:23 +0200
Message-ID: <EDA1C92E-6872-40D5-8C25-89C3FFF62F7A@joernhees.de>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 18:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ep7-0000qU-HQ
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 18:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab3HCQgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 12:36:39 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:36799 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208Ab3HCQgi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 12:36:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id 293A5E810CE;
	Sat,  3 Aug 2013 18:36:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTYWHc35TbNV; Sat,  3 Aug 2013 18:36:23 +0200 (CEST)
Received: from [192.168.2.12] (xdsl-78-34-213-232.netcologne.de [78.34.213.232])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id B7031E810CD;
	Sat,  3 Aug 2013 18:36:23 +0200 (CEST)
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231601>

Hi,

it seems that if you use the 1.8.3.4 remote-helpers/git-remote-hg to cl=
one a mercurial repo the timezone information of commits gets transform=
ed into your current timezone.
(command: git clone hg::=85)

I noticed this when a colleague in another timezone used Kiln to also e=
xport the same mercurial repo that i had cloned from git before.
=46etching from his git repo gives me a "second root tree" with all com=
mits duplicated.
A git show of two equivalent commit reveals that the Date: line of the =
commits changed.
Tracking this back into the original mercurial repo reveals that _his_ =
times are correct.

This will also make two or more clones from different timezones all usi=
ng the same hg remote repo incompatible!


Example:
Original mercurial commit (timezone: -7200 =3D -4h)
https://bitbucket.org/lipis/gae-init/commits/a43078f90e727a13767cf14c74=
0157763fb423b5/raw/

Lipis git export via Kiln: (-4h)
https://github.com/lipis/gae-init/commit/36b7cabf03fbba784cc41b63430433=
e9fc79ca8c

My export via git clone hg::ssh://hg@bitbucket.org/lipis/gae-init (+2h)
https://github.com/joernhees/git-hg-remote-bug_gae-init/commit/8341bf10=
f1f0a7a924717a8a2c1770f61acd51ae

Expected would be that the hashes of both git exports are the same. His=
 are correct as far as i can tell.


Cheers,
J=F6rn
