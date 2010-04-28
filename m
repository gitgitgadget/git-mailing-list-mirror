From: Eugene Sajine <euguess@gmail.com>
Subject: how to fix the problem correctly?
Date: Wed, 28 Apr 2010 12:54:33 -0400
Message-ID: <w2t76c5b8581004280954r436c1be1g8d6e415bf3596f4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 28 18:54:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7AX2-0006DI-TP
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 18:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab0D1Qyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 12:54:36 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:49889 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175Ab0D1Qyf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 12:54:35 -0400
Received: by qyk9 with SMTP id 9so21545210qyk.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=oRuxYgk3H5KCH+jnvbjU2HlVmmoLM1H4MqSoM/057H0=;
        b=hHUBTo/vug2gy9V2GN3vCn61npbrOls74khVlZbGrTzy/ISmj9jJeoUuq6pa7lbKMl
         53Asowkc4W6i4aWO1g8Vk/t0HUbokc5S7R/rlVbu8XyYGxVwjhDiPqnAZ9xyl+Gf7etl
         Ijy/jfuBaMSFYEpJIGOTvDOfx271bPSPmvWvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=QmgzkhC5XAj5OlZVog8ZtSMcGVnoudXPjN7/MtOv6y8To6aCSQZJLvR+XS0c0UKLXW
         iVgmK0FooLs18TH+6UUiD6mmHMVTeMaH71X1rRlZ1aDwX9d47281eNT/EGGTX0hBbC7n
         fWfR529KvNGuFRjsabGdothn+dVCsmhnkeI2I=
Received: by 10.229.225.73 with SMTP id ir9mr9842206qcb.22.1272473673879; Wed, 
	28 Apr 2010 09:54:33 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Wed, 28 Apr 2010 09:54:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145999>

I have a following situation (in dev branch):

3 files:
1.txt, 2.txt, 3.txt

A -> B -> C -> D -> E
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
=C2=A0 =C2=A0Master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 de=
v

Between B and C the version of file 1.txt was screwed up (let=E2=80=99s=
 say it
was copied into git repo from other location where it was in state A
(CVS) and then committed by mistake in C, effectively reverting the
change of this file in commit B)
Commit C also had changes to files 2 and 3.
After this commits D and E did not have changes for file 1.txt, only 2
and 3 were touched.

When we tried to revert commit C =E2=80=93 this lead to the code comple=
tely
messed up, with conflicts =E2=80=93 so this seems to be not an option.
Rebase also doesn=E2=80=99t seem to help here

Only two variants I saw:
1. Do =E2=80=9Cgit co A 1.txt=E2=80=9D and commit the change as F
2. Do =E2=80=9Cgit reset =E2=80=93soft master=E2=80=9D and recommit all=
 changes once again

Is there a better way?

PS interesting enough =E2=80=93 CVS keywords helped us to notice the pr=
oblem
as master state was imported from CVS.
In commit A file 1.txt had version ID 1.5 in commit B it was 1.6 ,
commit C was changing the line back to 1.5
Is there a way for git to help me to recognize this kind of issue if
there are no keywords?

DISCLAIMER: I don=E2=80=99t like keywords, and I don=E2=80=99t want the=
m to be
implemented in git.


Thanks,
Eugene
