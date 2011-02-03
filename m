From: Anders Kaseorg <andersk@ksplice.com>
Subject: git log --summary outputs extra newlines inconsistently
Date: Thu, 3 Feb 2011 18:33:52 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1102021842550.12561@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 04 00:34:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl8gb-0008Vj-Av
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 00:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab1BCXd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 18:33:57 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44227 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab1BCXdz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 18:33:55 -0500
Received: by vws16 with SMTP id 16so1075453vws.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 15:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ksplice.com; s=google;
        h=domainkey-signature:date:from:x-x-sender:to:subject:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=DMQfmSL6oNGr+YAtbbIFcGn8SK1/CkxBOvHE0oq8N/c=;
        b=VeDYw9I5BeGuRLSMIyOA60LNVH2WzIKlglTfD/sf6o9jDHKVx7sEfqn+Oc84tsDqWF
         XzagCudkJ5GQ7ocHst/JSz/yMPrnkJyWi2jFX7V+9l0cH+Qb7azOyUoeZBzeVa8N10Yh
         /hhrHMbDp59aQYJtS4myRHBDEELalO7fyUCBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=ksplice.com; s=google;
        h=date:from:x-x-sender:to:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=EAZK1c//LPSPjty118N5c+wu2S6oWN0NLBuXXdfUCMMad6jvTPm3qV+stEchYyOmkC
         KNS1lyyCVLutoZoXVhPGYD+CVQ+QYa3ptBhN2GQztKU/NWNUR6hUn6Hw6FXuxK0RjRr7
         IdYTDeK73BYd6yauvgbiPFdvqC1K5XR5aqRCM=
Received: by 10.220.180.10 with SMTP id bs10mr2984413vcb.90.1296776034115;
        Thu, 03 Feb 2011 15:33:54 -0800 (PST)
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
        by mx.google.com with ESMTPS id b5sm48253vcx.28.2011.02.03.15.33.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 15:33:53 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166010>

=E2=80=98git log --summary=E2=80=99 seems to output a newline after eve=
ry non-merge=20
commit.

  $ git log --summary --pretty=3Dformat:'%h %s'
  3c0eee3 Linux 2.6.37
 =20
  65f4288 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net=
-2.6
  9fc3bbb ipv4/route.c: respect prefsrc for local routes
 =20
  8a87694 remove trim_fs method from Documentation/filesystems/Locking
 =20
  989d873 Merge master.kernel.org:/home/rmk/linux-2.6-arm
  d9a1abe arch/mn10300/kernel/irq.c: fix build
 =20
  867c202 ima: fix add LSM rule bug

  =E2=80=A6

Oddly, those newlines show up even with -z!

  $ git log --summary --pretty=3Dformat:%h -z
  3c0eee3
  ^@65f4288^@9fc3bbb
  ^@8a87694
  ^@989d873^@d9a1abe
  ^@867c202
  =E2=80=A6

This makes the output annoying to parse in both cases.

(I=E2=80=99m using Git 1.7.4-rc2.)

Anders
