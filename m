From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/3] rev-list and friends: --min-parents, --max-parents
Date: Mon, 21 Mar 2011 11:14:04 +0100
Message-ID: <cover.1300702130.git.git@drmicha.warpmail.net>
References: <4D870157.2070309@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 11:14:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1c7s-0007Ec-6Z
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab1CUKOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:14:09 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36129 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704Ab1CUKOI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 06:14:08 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BB3AB205DD;
	Mon, 21 Mar 2011 06:14:07 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 21 Mar 2011 06:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=2Ja21+xzC9Xt5yxECapyQo6woDs=; b=CpLf/B9XheUZc2qcNOIjH8DOe11kD4mQVF2PwdkWcM6Y83aVWhf0dKXz0pr6UFY7zzoRGQHtsvGrkRZMAuS1/2xpnKmMzLMJCToJUHizv2v5zVh3TSo018FWklZpVWSIPnWQJnOm5fdVlaU+r45XzD6BBk3Sd8EhWqUv2kGsKlU=
X-Sasl-enc: DIlxQgISQRjnde2stdcsxL9plPTUgydHANrDIPG+ovgz 1300702447
Received: from localhost (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1C121443D26;
	Mon, 21 Mar 2011 06:14:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <4D870157.2070309@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169574>

In v2, based on the input from Jeff, Junio and Jonathan, I switched to
ordinary signed integers for --min-parent and --max-parent. Negative
parameters to the latter mean infinity. (Thus, no more range/macro magic.)

Also, I optimized the tests and made the structure clearer (hopefully).

Lastly, I rearranged the tests so that the unrelated cleanup comes first.

Based on mg/rev-list-one-side-only (in next) to save Junio a build conflict
resolution.
Michael J Gruber (3):
  t6009: use test_commit() from test-lib.sh
  revision.c: introduce --min-parents and --max-parents
  rev-list --min-parents,--max-parents: doc and test and completion

 Documentation/git-rev-list.txt         |    2 +
 Documentation/rev-list-options.txt     |   17 +++++-
 builtin/log.c                          |    2 +-
 builtin/rev-list.c                     |    2 +
 builtin/rev-parse.c                    |    2 +
 contrib/completion/git-completion.bash |    1 +
 revision.c                             |   24 ++++++--
 revision.h                             |    4 +-
 t/t6009-rev-list-parent.sh             |   97 ++++++++++++++++++++++++++++----
 9 files changed, 128 insertions(+), 23 deletions(-)

-- 
1.7.4.1.511.g72e46
