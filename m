From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] CodingGuidelines: describe naming rules for configuration variables
Date: Wed, 28 Jan 2015 14:33:13 -0800
Message-ID: <1422484393-4414-4-git-send-email-gitster@pobox.com>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
 <1422484393-4414-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 02:12:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGdf2-0002lp-BH
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbbA2BMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:12:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752280AbbA2BM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:12:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E28533A98;
	Wed, 28 Jan 2015 17:33:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=b7ak
	P2eFNWXg3PLILPeDMDXbUho=; b=u8tCT2osoLhpIfvdYg07D8cgmJHx8pwkMoJ0
	blxZlqTCvni15Np2qoeSzOE//MIl10yA3hJyftekcPsQjBrKZRJ7Dco6u2tQZ1sP
	AKNlN4Wfefr9uBkA6njnqowFBfyFxJYreZEBCnr2iqLz6mxCxbvABtMxLO79M6Bn
	X1Erk60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UVvYL3
	3t08w2NftP8tgxhY2euffzQqgg4nNrr9ND2YJLT9MbHYFWxGL2gZUkUDmsIIWCZo
	hRKoQaGoiJkxo6ZRiJM0Y/L28Oe339cNWzXBsYW7hYtP5Wj+91IibB/+JpEm9jyM
	Ju4EXcqnK3zbLtMPjPkS1DE3w2iJE4+hleW8Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5595233A97;
	Wed, 28 Jan 2015 17:33:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5827633A93;
	Wed, 28 Jan 2015 17:33:19 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-149-gdd42ee9
In-Reply-To: <1422484393-4414-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A8BC2712-A73D-11E4-B344-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263126>

We may want to say something about command line option names in the
new section as well, but for now, let's make sure everybody is clear
on how to structure and name their configuration variables.

The text for the rules are partly taken from the log message of
Jonathan's 6b3020a2 (add: introduce add.ignoreerrors synonym for
add.ignore-errors, 2010-12-01).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 894546d..8fbac15 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -413,6 +413,31 @@ Error Messages
  - Say what the error is first ("cannot open %s", not "%s: cannot open")
 
 
+Externally Visible Names
+
+ - For configuration variable names, follow the existing convention:
+
+   . The section name indicates the affected subsystem.
+
+   . The subsection name, if any, indicates which of an unbounded set
+     of things to set the value for.
+
+   . The variable name describes the effect of tweaking this knob.
+
+   The section and variable names that consist of multiple words are
+   formed by concatenating the words without punctuations (e.g. `-`),
+   and are broken using bumpyCaps in documentation as a hint to the
+   reader.
+
+   When choosing the variable namespace, do not use variable name for
+   specifying possibly unbounded set of things, most notably anything
+   an end user can freely come up with (e.g. branch names), but also
+   large fixed set defined by the system that can grow over time
+   (e.g. what kind of common whitespace problems to notice).  Use
+   subsection names or variable values, like existing variables
+   branch.<name>.description and core.whitespace do, instead.
+
+
 Writing Documentation:
 
  Most (if not all) of the documentation pages are written in the
-- 
2.3.0-rc2-149-gdd42ee9
