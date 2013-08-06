From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add missing test file for UTF-16.
Date: Tue, 06 Aug 2013 10:24:20 -0700
Message-ID: <7veha6hgvv.fsf@alter.siamese.dyndns.org>
References: <1375550791-5823-1-git-send-email-sandals@crustytoothpaste.net>
	<CACsJy8CT3uxp99n9VUXDbL30WEDcuRreeJBaqBcx9Ujici67VA@mail.gmail.com>
	<7vtxj4kry1.fsf@alter.siamese.dyndns.org>
	<CACsJy8ACqB5qRLFCerACEQrK8QXH+n=tAxdutAGT6JeijDvJUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6l1B-00049j-8C
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab3HFRYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:24:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551Ab3HFRY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:24:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED7B536301;
	Tue,  6 Aug 2013 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tc7slX4JcqQbkoY5YoDv8hRT5g4=; b=X2qcNr
	HOMg+QH2J6FiNXmdT/q9LND1/n+gjpcGrfByutI9VIcohslySTk74+qzzhUsHGss
	rE960bOFk8B0GUPgX2BXfUABXU9XDm5+JpyGC9Quk0hZRZq2xyfHlLG163u6EEZe
	VmLNHf/VwS/4wN+AR+PybTWs4dI7hIJKDPIts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R+jBl1md7fAflVBO7TUe017wpQ/mHe3y
	jLPj2iJ2rPQDaZwfDKMmGWGYN73IqnA9Kd9lxN/mTBslaxR+6ZkSrhTiceXj/VcQ
	ffJo0EptDbYEKHXloTptfzWod8zYCRXJBHpaxNX9IQz497/vmSfvEvsgCuLdgG4i
	u8YTjdz0ncY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E06DA36300;
	Tue,  6 Aug 2013 17:24:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1FE9362FD;
	Tue,  6 Aug 2013 17:24:22 +0000 (UTC)
In-Reply-To: <CACsJy8ACqB5qRLFCerACEQrK8QXH+n=tAxdutAGT6JeijDvJUQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 6 Aug 2013 18:59:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 096636FA-FEBD-11E2-A3F1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231765>

Duy Nguyen <pclouds@gmail.com> writes:

> The intention was "UTF-16 is not supported yet but we want to". But I
> don't think we (at least I) will put any effort on that front to allow
> NUL in commit message, so the patch, as in "we do not support UTF-16",
> is fine.

Agreed.  Here is what I queued.

-- >8 --
Subject: [PATCH] t3900: test rejecting log message with NULs correctly

It is not like that our longer term desire is to someday start
accepting log messages with NULs in them, so it is wrong to mark a test
that demonstrates "git commit" that correctly fails given such an
input as "expect-failure".  "git commit" should fail today, and it
should fail the same way in the future given a message with NUL in it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3900-i18n-commit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index d48a7c0..a9e5662 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -34,9 +34,9 @@ test_expect_success 'no encoding header for base case' '
 	test z = "z$E"
 '
 
-test_expect_failure 'UTF-16 refused because of NULs' '
+test_expect_success 'UTF-16 refused because of NULs' '
 	echo UTF-16 >F &&
-	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
+	test_must_fail git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
 '
 
 
