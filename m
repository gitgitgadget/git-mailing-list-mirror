From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/10] push: switch default from "matching" to "simple"
Date: Fri,  4 Jan 2013 22:52:58 -0800
Message-ID: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdV-0000vb-7g
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab3AEGxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3AEGxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB5D8CC7
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=t0WQkaLattKtIW2YzeIyUPjKwO8
	=; b=tVdogGGzF7U0ROKUWcmJqoRHSdRXjz5yq/bm0nAUUcIpEMkTmH9jzJqCZ7T
	DwToZHkrvekBrdxMtq+247Y63qRlbxRWoD4k8nD4RPXsaBLIfeeQxqET6Onf9uGv
	FZRPlz7MMDCbbZwD0g7WhMJOWihz3loO+f51569VCFCpJehY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Zsz0LXp85ai6ZQF71xezR5tbmbGMv
	D0X4vYVWP8KjaRFOz50qDDMQ4VOXgqOB+pIs/HViEsWhO/m+3pBqPgDJMDKCvsai
	EA8BFMmnvVVOEeNP04RLIZ4g0o0DktQVrp6Xirm2TjEnxtxbbGCXkdOkvcMYba52
	29jVoiVuoPjEhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A013F8CC6
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A5FA8CC5 for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:10 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
X-Pobox-Relay-ID: 912EF2F4-5704-11E2-BEB6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212668>

We promised to change the behaviour of lazy "git push [there]" that
does not say what to push on the command line from "matching" to
"simple" in Git 2.0.  Even though the top-level RelNotes symbolic
link points at 1.8.2, we can change our mind to tag 2.0 at the end
of this cycle.

This carries out the threat ;-)

Mmany tests have assumed that the long established default will
never change and relied on the convenience of the "matching"
behaviour.  They need to be updated to either specify what they want
from the command line explicitly, or configure the default behaviour
they would expect.  And then finally we can flip the default.

Junio C Hamano (10):
  t5404: do not assume the "matching" push is the default
  t5505: do not assume the "matching" push is the default
  t5516: do not assume the "matching" push is the default
  t5517: do not assume the "matching" push is the default
  t5519: do not assume the "matching" push is the default
  t5531: do not assume the "matching" push is the default
  t7406: do not assume the "matching" push is the default
  t9400: do not assume the "matching" push is the default
  t9401: do not assume the "matching" push is the default
  push: switch default from "matching" to "simple"

 Documentation/config.txt        |  6 +++---
 builtin/push.c                  | 31 +++++++------------------------
 t/t5404-tracking-branches.sh    |  2 +-
 t/t5505-remote.sh               |  2 +-
 t/t5516-fetch-push.sh           | 10 +++++-----
 t/t5517-push-mirror.sh          |  2 +-
 t/t5519-push-alternates.sh      | 12 ++++++------
 t/t5531-deep-submodule-push.sh  |  1 +
 t/t7406-submodule-update.sh     |  4 ++--
 t/t9400-git-cvsserver-server.sh |  1 +
 t/t9401-git-cvsserver-crlf.sh   |  1 +
 11 files changed, 29 insertions(+), 43 deletions(-)

-- 
1.8.1.299.gc73b41f
