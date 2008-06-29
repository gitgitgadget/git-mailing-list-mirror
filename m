From: Junio C Hamano <gitster@pobox.com>
Subject: Re: perl t9700 failures?
Date: Sun, 29 Jun 2008 13:23:27 -0700
Message-ID: <7vzlp47zy8.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Lea Wiemann <LeWiemann@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3SE-0002cS-LG
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbYF2UXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755196AbYF2UXk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:23:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbYF2UXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:23:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D1242D7F2;
	Sun, 29 Jun 2008 16:23:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 35FACD7F0; Sun, 29 Jun 2008 16:23:34 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 29 Jun 2008 12:52:00 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 421F0E98-4619-11DD-B5A6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86828>

I'll commit this (which is simpler than "Perlhaps this would suffice"
patch I sent earlier).  Thanks for noticing.

-- >8 --
[PATCH] t9700: skip when Test::More is not available

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9700-perl-git.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b2fb9ec..5dd32f4 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -6,6 +6,11 @@
 test_description='perl interface (Git.pm)'
 . ./test-lib.sh
 
+perl -MTest::More -e 0 2>/dev/null || {
+	say skip "Perl Test::More unavailable, skipping test"
+	test_done
+}
+
 # set up test repository
 
 test_expect_success \
-- 
1.5.6.1.102.g8e69d
