From: Alexey Shumkin <zapped@mail.ru>
Subject: [PATCH v2] pretty: user format ignores i18n.logOutputEncoding setting
Date: Fri,  9 Sep 2011 12:53:55 +0400
Message-ID: <1315558437-6295-1-git-send-email-zapped@mail.ru>
References: <7vwrf6qh49.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 10:54:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1wrA-0003OZ-3E
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 10:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941Ab1IIIye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 04:54:34 -0400
Received: from smtp19.mail.ru ([94.100.176.156]:46131 "EHLO smtp19.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932827Ab1IIIyd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 04:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Sender:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=k3x+hH/GT5CLHvTcJNIIsyCpzrdMDDstvdmztdQtOio=;
	b=yyqwg/tgQY/qx05sGK8KqWcxcyMN/8tnHYXmd1oui6jq2l9mVZfVn0nbZdIbowkGcUkiutkiKAcbtOVzKheehP4taiWhc58GbZPRcdKy6vgK/KUR4u1I9EeW8oxOlSck;
Received: from [91.77.44.195] (port=13553 helo=zappedws)
	by smtp19.mail.ru with asmtp 
	id 1R1wr1-0007pQ-00; Fri, 09 Sep 2011 12:54:31 +0400
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <zapped@mail.ru>)
	id 1R1wqV-0001f3-Bs; Fri, 09 Sep 2011 12:53:59 +0400
X-Mailer: git-send-email 1.7.6.1.g8f21c
In-Reply-To: <7vwrf6qh49.fsf@alter.siamese.dyndns.org>
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181037>

Ooops! previuos message haven't Cc-ed to Junio.
This one is CC-ed.
I discovered two more commands affected with this bug.
So I reroll this patch and tests for it.

>>(question) Does this change affect other commands, most notably  
>>format-patch, and if so how?
No, it does not affect format-patch

---

 builtin/rev-list.c               |    1 +
 builtin/shortlog.c               |    1 +
 log-tree.c                       |    1 +
 submodule.c                      |    3 +
 t/t4041-diff-submodule-option.sh |   44 +++++----
 t/t4205-log-pretty-formats.sh    |   22 ++++-
 t/t6006-rev-list-format.sh       |  192 +++++++++++++++++++++++---------------
 7 files changed, 167 insertions(+), 97 deletions(-)
