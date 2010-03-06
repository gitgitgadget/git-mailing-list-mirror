From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v4 0/5] Apply blanks at EOF
Date: Sat, 06 Mar 2010 15:30:09 +0100
Message-ID: <4B9266F1.5040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 21:59:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No1Zk-0006gS-Ho
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab0CFOaN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 09:30:13 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:3142 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab0CFOaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 09:30:12 -0500
Received: by ey-out-2122.google.com with SMTP id 25so693598eya.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 06:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ELEvCmT0zFEIw1umdkiWzHRohJPcyiurHBxwbkKaRo8=;
        b=Gp2sKa6Nyt0n9SdJ9N+cWYL61m+TAjT3I9kINx8n+GTcVKgJ+UI7Pz+rkPpsCJuP6q
         64sYc3fB/pJtkEg67bhpcX3ZyKtSIv5UubkTh5/xul7r7/QeFklTnSJyGxDLmxb6lTki
         6mnJC4J0GJwAPbwalmSrvmcqxOATUXerzcYjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=rc3MrK5/Jp31ciTzdgz7QhRKP9t/XQ/lTbun+DjoiXl4p63VMvc6TP6uKH9bovS4LG
         IHtBW+HSiqN81lAmP9KKKt8CUUhFmOV8U0dIvOeug1l9ijzW6qyeBNQ8mzWI8TGGgQLc
         NBIWs/+N7ArYfBcMw9mE71fEnjiv3h/yPWlzc=
Received: by 10.213.107.143 with SMTP id b15mr1558072ebp.72.1267885810748;
        Sat, 06 Mar 2010 06:30:10 -0800 (PST)
Received: from [10.0.1.10] (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm1066559eyh.7.2010.03.06.06.30.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 06:30:10 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141615>

Another re-roll to fix --ignore-space-change in combination with=20
--whitespace=3Dfix when the patch has CR-LF line endings.

Bj=C3=B6rn Gustavsson (5):
  apply: Don't unnecessarily update line lengths in the preimage
  apply: Remove the quick rejection test
    No change.

  apply: Allow blank context lines to match beyond EOF
    The fix and an updated commit message.

  t4124: Add additional tests of --whitespace=3Dfix
    One test case split into two and two new test cases.

  t3417: Add test cases for "rebase --whitespace=3Dfix"
    No change.

 builtin-apply.c                  |  187 +++++++++++++++++++++++++++++-=
-------
 t/t3417-rebase-whitespace-fix.sh |  126 +++++++++++++++++++++++++
 t/t4104-apply-boundary.sh        |    9 ++
 t/t4124-apply-ws-rule.sh         |  170 ++++++++++++++++++++++++++++++=
++++
 4 files changed, 451 insertions(+), 41 deletions(-)
 create mode 100755 t/t3417-rebase-whitespace-fix.sh
