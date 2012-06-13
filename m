From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/19] apply: document --3way option
Date: Wed, 13 Jun 2012 12:32:59 -0700
Message-ID: <1339615980-19727-19-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetKG-00010Q-5z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab2FMTdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 103E98760
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dkLF
	IB8o9/ffxLkkSyu3JW/xnAs=; b=J7cW+Ki3EOU96Gc8OkmY/AymmQpy0g08YTPY
	VrK/QEsuSNjg/NJwAhrv7X0jGzta2WVvJvr6rEUbW8O//bmXd2feq+fqOdW3kEs1
	XSC6xJB5w/A6txu4di0HL65lpoXl46LFf4amX1ODxvv9iZJZFlL/eL5ek144P28i
	WmMsDtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vLozFP
	b3Z5GRpYEBs27DyNJd3+LgQhLbhtWRYkyYwWkYji7Ez+ULorzOPQRi5KxNUmoaCv
	Him+VLKlBkgiK8/DVAS8PwgCEpJyDlVtBXKmBSyJdzo2kbUwUyyDb+QakxtbKOFU
	XyNFlIc1DDanS44IpaMY/rqTnYQgnDR3Emk+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 077A2875F
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E629875E for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AB8C9876-B58E-11E1-91F7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199931>

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
1.7.11.rc3.30.g3bdace2
