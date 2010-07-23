From: Johannes Sixt <j6t@kdbg.org>
Subject: Which is wrong? diff or apply?
Date: Fri, 23 Jul 2010 21:03:08 +0200
Message-ID: <201007232103.08870.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 21:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcNXk-00083i-Gb
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 21:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277Ab0GWTEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 15:04:20 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:36960 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752678Ab0GWTET (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 15:04:19 -0400
Received: from bsmtp.bon.at (mta-out-vip.lix.bon.at [172.18.12.14])
	by lbmfmo03.bon.at (Postfix) with ESMTP id C53DBCED63
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 21:04:17 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7C8091000B
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 21:03:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1FA4C19F7AA
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 21:03:09 +0200 (CEST)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151567>

Today, I tried this in my git.git checkout:

  $ mv transport-helper.c wt-status.c
  $ git diff -B -M | git apply --cached
  error: wt-status.c: already exists in index

That is, I overwrote the tracked wt-status.c with a completly different file 
that is also tracked. Then I try to stage the change using git apply.

git diff -B -M reports this:

  diff --git a/transport-helper.c b/wt-status.c
  similarity index 100%
  rename from transport-helper.c
  rename to wt-status.c

Notice that there is no mention that the previously existing wt-status.c was 
removed. I wonder whether this is a bug.

Or is it the safety valve in git apply that does not allow to overwrite an 
existing file which should not trigger in this case?

-- Hannes
