From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
Subject: [PATCH 0/2] git subtree: properly handle remote refs
Date: Wed, 13 Mar 2013 17:17:30 +0100
Message-ID: <1363191452-28804-1-git-send-email-jeremy.rosen@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: greened@obbligato.org, pcampbell@kemitix.net, gitster@pobox.com,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 17:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFoQ0-0002sE-QC
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151Ab3CMQUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 12:20:14 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:33595 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610Ab3CMQUO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 12:20:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id D144E280AF;
	Wed, 13 Mar 2013 17:20:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z-4o798TFC8a; Wed, 13 Mar 2013 17:20:11 +0100 (CET)
Received: from pcrosen.daviel.openwide.fr. (unknown [193.56.60.160])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTPSA id 30294280A6;
	Wed, 13 Mar 2013 17:20:11 +0100 (CET)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218064>

One common use-case for git subtree is to use it only on taged commits =
from the remote project. however the current implementation of gi-subtr=
ee can not be used in that way. two orthogonal prevent this

the SHA used as the origin revision can be the SHA of a tag which isn't=
 available locally. This works correctly at merge time but will fail at=
 split time. The first patch uses the ^{} notation to make sure a corre=
ct commit SHA is used instead of the SHA given as a parameter

the checks for the correctness of the target ref to pull or add checks =
that the name matches a local ref (which is incorrect). The second patc=
h use ls-remote to validate the ref name given against the ones in the =
remote repository

J=C3=A9r=C3=A9my Rosen (2):
  git-subtree: make sure the SHA saved as ancestor is a commit
  git-subtree: use ls-remote to check the refspec passed to pull and
    add

 contrib/subtree/git-subtree.sh |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--=20
1.7.10.4
