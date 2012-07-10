From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 18/19] apply: document --3way option
Date: Tue, 10 Jul 2012 00:04:11 -0700
Message-ID: <1341903852-4815-19-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVb-0000bE-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab2GJHFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:05:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163Ab2GJHFE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:05:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D2CC7E06
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:05:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=v9Ul
	hFeMKc/PDjB+hdoqefmvPxM=; b=hVBXhux3C/SFlOd9I+2p4s0Xk6aFMmfThaei
	t8xo2QEs7qPpZJ75Yy2fVnSTyFzi/1GCkTAHkbqiIdiXva+ygokxC9eKmhq3KnyC
	lTuxbO1uAWty+6vYBTHmI56ke5KE1xgEIv5VuxS4A5cB9b+9M3iWFjfqn2NhDGMP
	bLPBTRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KP5t/4
	zfpIBBpFxBU+2onKd999UzrjjJNC940bQKpT6vttSKuS1yNJI3MqWTB97CWnxvv9
	0rG0MqZoL6dBC8c5sii0nQT784X8F9nrLC5+jzSEXzK3LWMJReuewEtMgD4xLvZq
	DsURXpUPMIzhKzIECxyoHq/GH/MfoN0mRI7OE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 944807E04
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:05:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9E6B7E03 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:05:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9161DD1A-CA5D-11E1-8041-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201252>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-apply.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index afd2c9a..634b84e 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,7 @@ git-apply - Apply a patch to files and/or to the index
 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index]
+'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
@@ -72,6 +72,15 @@ OPTIONS
 	cached data, apply the patch, and store the result in the index
 	without using the working tree. This implies `--index`.
 
+-3::
+--3way::
+	When the patch does not apply cleanly, fall back on 3-way merge if
+	the patch records the identity of blobs it is supposed to apply to,
+	and we have those blobs available locally, possibly leaving the
+	conflict markers in the files in the working tree for the user to
+	resolve.  This option implies the `--index` option, and is incompatible
+	with the `--reject` and the `--cached` options.
+
 --build-fake-ancestor=<file>::
 	Newer 'git diff' output has embedded 'index information'
 	for each blob to help identify the original version that
-- 
1.7.11.1.294.g68a9409
