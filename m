From: =?windows-1250?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
Subject: Branch renaming not updating the configuration correctly.
Date: Mon, 28 Jul 2008 15:36:09 +0200
Message-ID: <g6ki09$81c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 15:37:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNSug-0004Vn-4H
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 15:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbYG1NgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 09:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbYG1NgV
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 09:36:21 -0400
Received: from main.gmane.org ([80.91.229.2]:45797 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbYG1NgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 09:36:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNSte-0003AQ-JA
	for git@vger.kernel.org; Mon, 28 Jul 2008 13:36:18 +0000
Received: from 87.252.133.29 ([87.252.133.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 13:36:18 +0000
Received: from jurko.gospodnetic by 87.252.133.29 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 13:36:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.133.29
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90458>

   Hi.

   I noticed that the .git/config file is not updated completely in cas=
e=20
you create two branches aaa and bbb, set the repository up so it=20
automatically merges changes from bbb into aaa and then rename the bran=
ches:

   Here is an exact list of commands and config file contents=20
illustrating the problem:

   > git branch aaa
   > git branch bbb
   > git config --add branch.aaa.remote .
   > git config --add branch.aaa.merge bbb

-- .git/config: --
[branch "aaa"]
	remote =3D .
	merge =3D bbb
------------------

   > git branch -m aaa patched
   > git branch -m bbb original

-- .git/config: --
[branch "patched"]
	remote =3D .
	merge =3D bbb
------------------

   And as you can see above, the branch.patched.merge configuration=20
setting did not get updated and still holds the old branch name 'bbb'.

   Hope this helps.

   Best regards,
     Jurko Gospodneti=E6
