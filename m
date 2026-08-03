Received: from smtp-1a.his.com (dc-17.his.net [108.56.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7627707
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.56.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718201; cv=none; b=Ski5Mo0fAHNQW/1H5VgA30HUasu1erwxpSiRzIgr6ZChoKXwB1yatCiXWyBGuFOcu2h8Bc1R5XI3nYgdkfcsrisSRz66UUxpo/OHrPTpe1gzpT+POiEg93fUDdUje2HBFj7l4KOY1Wrq3jL+WVXRRggZBI4nO+YbIubh3JPwGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718201; c=relaxed/simple;
	bh=FP2BamldoU87S/eUs1t4vXvBCn7cl6gu2JbMiCrAXWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2+ekL4I/yXdWKQrFAlk/A+Ow+HtVVQsSyoD0jbQZ3VLtBq4hZkE57tXqI9aKOQ6aLGeGWSrjnw8c8L6GZq2DGPr6LJVBpQaqn1bZDgF4GylM+cavK166w/U0kUGxXpk87LRb73pO/n6ueZqEMtQJ1qTJ+Q2MCfXPn9i8fcAhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com; spf=pass smtp.mailfrom=his.com; arc=none smtp.client-ip=108.56.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=his.com
Received: from proxmail101.his.com (pgh-217.his.com [75.149.19.217])
	by smtp-1a.his.com (Postfix) with ESMTPS id 4602B186;
	Sun,  2 Aug 2026 20:41:18 -0400 (EDT)
Received: from proxmail101.his.com (localhost.localdomain [127.0.0.1])
	by proxmail101.his.com (Proxmox) with ESMTP id CB6BABC0DBE;
	Sun,  2 Aug 2026 20:41:17 -0400 (EDT)
Received: from smtp-4a.his.com (dc-25.his.net [108.56.65.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by proxmail101.his.com (Proxmox) with ESMTPS id 40718BC0BD1;
	Sun,  2 Aug 2026 20:41:17 -0400 (EDT)
Received: from mail1.his.com (ec2-3-148-140-11.us-east-2.compute.amazonaws.com [3.148.140.11])
	by smtp-4a.his.com (Postfix) with ESMTPS id CFE4F62;
	Sun,  2 Aug 2026 20:41:16 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail1.his.com (Postfix) with ESMTP id AA66621306;
	Mon,  3 Aug 2026 00:41:16 +0000 (UTC)
Received: from mail1.his.com ([127.0.0.1])
 by localhost (mail1.his.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id q7JK_Ze_MzI5; Mon,  3 Aug 2026 00:41:16 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail1.his.com (Postfix) with ESMTP id 6A21D2130D;
	Mon,  3 Aug 2026 00:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at his.com
Received: from mail1.his.com ([127.0.0.1])
 by localhost (mail1.his.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 2i7Fdk76B9TL; Mon,  3 Aug 2026 00:41:16 +0000 (UTC)
Received: from wings.localdomain (unknown [69.53.104.42])
	by mail1.his.com (Postfix) with ESMTPSA id 02BCD21306;
	Mon,  3 Aug 2026 00:41:15 +0000 (UTC)
From: Kenneth Lorber <keni@his.com>
To: git@vger.kernel.org
Cc: Kenneth Lorber <keni@his.com>,
	redoste <redoste@redoste.xyz>,
	Fabian Stelzer <fs@gigacodes.de>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 0/1] t7528: fix failure under csh
Date: Sun,  2 Aug 2026 20:41:02 -0400
Message-ID: <20260803004105.36913-1-keni@his.com>
X-Mailer: git-send-email 2.55.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SPAM-LEVEL: Spam detection results:  0
	AWL                     0.130 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DMARC_PASS               -0.1 DMARC pass policy
	KAM_DMARC_STATUS         0.01 Test Rule for DKIM or SPF Failure with Strict Alignment
	SPF_HELO_NONE           0.001 SPF: HELO does not publish an SPF Record
	SPF_PASS               -0.001 SPF: sender matches SPF record
	URIBL_DBL_BLOCKED_OPENDNS  0.001 ADMINISTRATOR NOTICE: The query to dbl.spamhaus.org was blocked due to usage of an open resolver. See https://www.spamhaus.org/returnc/pub/ [test-lib.sh,t7528-signed-commit-ssh.sh]

The test suite fails at t7528 when run in an account with tcsh as
the login shell due to $SHELL being "/bin/tcsh"; similar behaviour
is expected under other csh-like shells.

From ssh-agent(1):
-s      Generate Bourne shell commands on stdout.  This is the  default
               if SHELL does not look like it's a csh style of shell.

This patch explicitly tells ssh-agent to use Bourne shell syntax, thus
removing a spurious test failure for users with csh style shells.

An alternative change would be to have test-lib.sh clear $SHELL; this
was rejected as potentially hiding additional similar errors.  There
are no such additional errors evident currently.

No additional tests are added as the error is in the setup for
testing, not an error in git itself.

Kenneth Lorber (1):
  t7528: fix failure under csh

 t/t7528-signed-commit-ssh.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.43.0


