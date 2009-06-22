From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t3700-add: add a POSIXPERM prerequisite to a new test
Date: Mon, 22 Jun 2009 09:30:38 +0200
Message-ID: <4A3F331E.5080301@viscovery.net>
References: <1245316674-32377-1-git-send-email-bebarino@gmail.com>	<7vfxdxxzps.fsf@alter.siamese.dyndns.org> <4A3A8412.7070705@gmail.com> <7veitho0gu.fsf@alter.siamese.dyndns.org> <4A3A8E73.1010807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 09:30:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIdzV-0005w3-SP
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 09:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbZFVHas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 03:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbZFVHar
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 03:30:47 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:9933 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZFVHar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 03:30:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MIdzD-0007WO-4d; Mon, 22 Jun 2009 09:30:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D90DEC6C1; Mon, 22 Jun 2009 09:30:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A3A8E73.1010807@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122014>

From: Johannes Sixt <j6t@kdbg.org>

The new test does a 'chmod 0', which does not have the intended
effect on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Stephen Boyd schrieb:
> Junio C Hamano wrote:
>> Why do you need POSIXPERM for this?
> 
> I copied a previous test and it was doing chmod 0 foo2.
...
> +test_expect_success POSIXPERM '--no-ignore-errors overrides config' '
> +       git config add.ignore-errors 1 &&
> +       git reset --hard &&
> +       date >foo1 &&
> +       date >foo2 &&
> +       chmod 0 foo2 &&

I can only guess that you missed this 'chmod 0' despite Stephen's
explanation and dropped POSIXPERM when you applied the patch.

-- Hannes

 t/t3700-add.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 6ae5a2c..85eb0fb 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -223,7 +223,7 @@ test_expect_success POSIXPERM 'git add
 '
 rm -f foo2

-test_expect_success '--no-ignore-errors overrides config' '
+test_expect_success POSIXPERM '--no-ignore-errors overrides config' '
        git config add.ignore-errors 1 &&
        git reset --hard &&
        date >foo1 &&
-- 
1.6.3.2.1450.g146e1
