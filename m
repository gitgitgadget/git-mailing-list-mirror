From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/5] Improve guessing of repository names
Date: Mon, 10 Aug 2015 17:48:20 +0200
Message-ID: <1439221705-20336-1-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:48:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOpJW-0002Pq-6u
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 17:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbbHJPsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 11:48:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44807 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754437AbbHJPsb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 11:48:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9275420A29
	for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:48:30 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 10 Aug 2015 11:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=u8Py
	FZZg9nDeM3zekLMNyQosU3I=; b=WyTpIERyZOHu7eRH836rKKXaUEj+8SVv8Oau
	P015WJYPwrvEUwusoPG8pxTfptxz0MprHmG3CWkbm/h8QEdjjhli8au6GF6CefN6
	UELe71f0ug0mMqzWaByXxYrWuUlAOJ49IvauuIuctbfT9f7dI3qShjeecPdoCAUb
	v2ruRm0=
X-Sasl-enc: S8a1XDZqm2zB84yK8SybyTic/odJj+Ba90hnSbVHurJ3 1439221710
Received: from localhost (x5ce1243b.dyn.telefonica.de [92.225.36.59])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2418E68019C;
	Mon, 10 Aug 2015 11:48:30 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1437997708-10732-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275626>

This is version 5 of my patch series which aims to improve
guessed directory names in several cases.

This version now includes the patches from Jeff which were
previously a separate patch series. Besides fixing behavior when
cloning a repository with trailing '.git' suffix they also add a
new test suite that verifies guessed directory names. I've
amended 'clone: add tests for output directory' to add additional
tests (as proposed by Junio).

Changes to my own patches include improved commit messages
detailing why certain changes are done the way they are done and
a change to authentication-data-stripping, such that we now strip
greedily until the last '@' sign in the host part (proposed by
Junio, as well).

Jeff King (2):
  clone: add tests for output directory
  clone: use computed length in guess_dir_name

Patrick Steinhardt (3):
  clone: do not include authentication data in guessed dir
  clone: do not use port number as dir name
  clone: abort if no dir name could be guessed

 builtin/clone.c          |  65 +++++++++++++++++++++++++-----
 t/t5603-clone-dirname.sh | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 11 deletions(-)
 create mode 100755 t/t5603-clone-dirname.sh

-- 
2.5.0
