From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] format-patch: introduce option to suppress commit hashes
Date: Sun,  6 Dec 2015 22:16:34 +0000
Message-ID: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 23:17:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5hc7-0005Lt-Fm
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 23:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbbLFWQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 17:16:55 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60832 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754460AbbLFWQy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2015 17:16:54 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3128F2808C;
	Sun,  6 Dec 2015 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1449440211;
	bh=KGsc8o631s6JS4d/LoQ8JSudhwgvFxSm/EKTdfBtbcc=;
	h=From:To:Cc:Subject:Date:From;
	b=oCNSNelLwoIvcuwFPRtVNQIXiiwwFLqovAkiJA/GjwoKK00ACCRcc6DkagduOZTZN
	 jIZZPGQfVKsnf+vR5asRANjzP6jBr5VF9tL1aPnCHTtdYlsDPlFYf/E2ocpSXjcCSJ
	 NuiVAqhSd+AURkdqJGRlRDMQF0f3KlgmJfbrla0wGeLNsAEPElQhL+7r4czfwBUZH6
	 2OSoFIzYhE8IDuVv1vr6HhReCUQWMV2JSzGYY+6OAI9opShj9tFuAr99xfrGiRzG5J
	 5h244UXNtV2fqjWn6jpC+PFz8sxXFM7WSuGg0/LT69j/xew0ndoSdCZrrmgS9DSYaf
	 D8nNTOB5VndVlN83t5lanfpyB5Ov75wq/PkQDH7Y3BW2Mm42kmBAhKjtdDGKfObtlz
	 AQ+AmrOAHMEwIo0/Y0RGijdCFGSeinUQpg1yRBwJUI2iahtJ3NRF2URTYUssnIc16v
	 5aQ7vIer+z+3dFpeCA7ZvndyiEUyXM1gZYIKvHmABUVoSNeQMUI
X-Mailer: git-send-email 2.6.2.409.gb049f0a
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282069>

git format-patch is often used to create patches that are then stored in
version control or displayed with diff.  Having the commit hash in the
"From " line usually just creates diff noise in these cases, so this
series introduces --no-hash to set that to all zeros.

The idea for this series came from Dominic Hargreaves in Debian bug
#635663.

This series is based off of next so as not to conflict with the
conversion of struct object to struct object_id.

Careful readers will note that this option is referred to by both
"no_hash" and "zero_commit".  I felt that the latter made more sense as
an option in struct rev_info, as it's strictly more accurate, while the
former is less accurate but more friendly to humans.  Of course, this
can be changed if reviewers feel it to be undesirable.

brian m. carlson (2):
  Introduce a null_oid constant.
  format-patch: add an option to suppress commit hash

 Documentation/git-format-patch.txt | 4 ++++
 builtin/log.c                      | 5 +++++
 cache.h                            | 1 +
 log-tree.c                         | 3 ++-
 revision.h                         | 1 +
 sha1_file.c                        | 1 +
 t/t4014-format-patch.sh            | 6 ++++++
 7 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.6.3.658.g85d7f57
