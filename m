From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/5] verify-commit: verify commit signatures
Date: Mon, 23 Jun 2014 09:05:46 +0200
Message-ID: <cover.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:06:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyyKK-0000dg-S0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 09:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbaFWHFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 03:05:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36240 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121AbaFWHFy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2014 03:05:54 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1C06C20DD9
	for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:05:52 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 23 Jun 2014 03:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=GJCtpvFYYUiMvygZemEAtd/JR
	E8=; b=kQA4tTJDXGautzjcDg2TglmRlZn8T83+yd+ZtBYlkU1zFKoxgxV/OaxZ1
	zQlfyS6DUdpGMN1xz8Nkmn0X9dRjbP1gHV5S88w5peYmQW/fJdr6noNZvUwBbx4o
	1FiANZRiDdgJRlZTyghbtdXgigh0mYXDbrbiC81sctm/7rVmXw=
X-Sasl-enc: sot0CV4qdwlv0hEauELWL/+1vwMlnOXaC32dPZyAMX4U 1403507152
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7CC15C0000C;
	Mon, 23 Jun 2014 03:05:52 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252319>

This incorporates all remarks about the test coding guidelines and
rearranging the series.

Open questions:
- There was some debate about (optionally) verifying more than what
git-verify-{commit,tag} currently do, or going for a generic git-verify command.
The former would require both to be changed (in order to treat similar cases similarly),
the latter would need a deprecation for git-verify-tag.

- I haven't looked yet at what happened over the weekend.

Michael J Gruber (5):
  gpg-interface: provide clear helper for struct signature_check
  gpg-interface: provide access to the payload
  verify-commit: scriptable commit signature verification
  t7510: exit for loop with test result
  t7510: test verify-commit

 Documentation/git-verify-commit.txt | 28 +++++++++++
 Makefile                            |  1 +
 builtin.h                           |  1 +
 builtin/merge.c                     |  5 +-
 builtin/verify-commit.c             | 93 +++++++++++++++++++++++++++++++++++++
 command-list.txt                    |  1 +
 commit.c                            |  1 +
 git.c                               |  1 +
 gpg-interface.c                     | 14 ++++++
 gpg-interface.h                     |  2 +
 pretty.c                            |  3 +-
 t/t7510-signed-commit.sh            | 24 ++++++++--
 12 files changed, 165 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-verify-commit.txt
 create mode 100644 builtin/verify-commit.c

-- 
2.0.0.426.g37dbf84
