From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] bundle doc: 'verify' is not about verifying the bundle
Date: Wed,  2 Mar 2016 12:32:38 -0800
Message-ID: <1456950761-19759-2-git-send-email-gitster@pobox.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 21:32:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abDRy-0006vC-6T
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 21:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915AbcCBUcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 15:32:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755863AbcCBUcq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 15:32:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6F0648072;
	Wed,  2 Mar 2016 15:32:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qX+f
	usTlJOncJM/10QP/yqxInqg=; b=tM2YcgTSh1koGUPMuiL+51AE61/pNqdPDzYB
	i1eEFDFV2NnDd6/Y15dsqptiZ5RwUr+VySapIp+LsL/Q/rt7u8llbX7aPiMlu9jl
	hoFI7hIlodu91mw36qYirAYTi+MxGku3PnKB8KXJLHmtbtuA0zLH+Yfqlsni0N4U
	O3NTy2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CXTR4k
	H4itXI7ZZKBx5/67+qxDilHO5S4G2aVB2EESRV64FaAEiDFIw82euJt+a22Z1rdS
	+wzgV8xDD+tBntvaikRmmo3PfHIDtAfcze91qQi5iqrPD0bFsUbHjhxq7+HabeRh
	1Z5PMQC3v+GtfxPmgaTcF8Jaa5Uj4IW6TAn+g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE4DD48070;
	Wed,  2 Mar 2016 15:32:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E810E4806E;
	Wed,  2 Mar 2016 15:32:43 -0500 (EST)
X-Mailer: git-send-email 2.8.0-rc0-114-g0b3e5e5
In-Reply-To: <1456950761-19759-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EAEAF5DE-E0B5-11E5-B449-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288149>

Even though the command does read the bundle header and checks to
see if it looks reasonable, the thin-pack data stream that follows
the header in the bundle file is not checked.

The documentation gives an incorrect impression that the data
contained in the bundle is validated, but the command is to validate
that the receiving repository is ready to accept the bundle, not to
check the validity of a bundle file itself.

Rephrase the paragraph to clarify this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-bundle.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3a8120c..c0113a8 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -38,11 +38,10 @@ create <file>::
 	'git-rev-list-args' arguments to define the bundle contents.
 
 verify <file>::
-	Used to check that a bundle file is valid and will apply
-	cleanly to the current repository.  This includes checks on the
-	bundle format itself as well as checking that the prerequisite
-	commits exist and are fully linked in the current repository.
-	'git bundle' prints a list of missing commits, if any, and exits
+	Verifies that the given 'file' has a valid-looking bundle
+	header, and that your repository has all prerequisite
+	objects necessary to unpack the file as a bundle.  The
+	command prints a list of missing commits, if any, and exits
 	with a non-zero status.
 
 list-heads <file>::
-- 
2.8.0-rc0-114-g0b3e5e5
