From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [RFC-PATCH 0/2] send-email: new --quote-mail option
Date: Mon, 23 May 2016 21:30:27 +0200
Message-ID: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:31:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vZF-0002UW-GZ
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbcEWTbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:31:04 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:48284 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbcEWTbD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:31:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6C958254A;
	Mon, 23 May 2016 21:30:59 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lVnnB2YW8d82; Mon, 23 May 2016 21:30:59 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5C9972549;
	Mon, 23 May 2016 21:30:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 56FAC2077;
	Mon, 23 May 2016 21:30:59 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7d5vDU2MUWM; Mon, 23 May 2016 21:30:59 +0200 (CEST)
Received: from ux-305.numericable.fr (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 21C782066;
	Mon, 23 May 2016 21:30:59 +0200 (CEST)
X-Mailer: git-send-email 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295377>

Hello,

With the current send-email command, you can send a series of patches "in reply
to" an email.
This patch adds a new option to `git send-email`, `--quote-mail=<file>`, to
quote an email in the cover letter in your series of patches.

The "To", "Cc" and "Subject" fields will be filled appropriately and the message
given quoted in the cover letter for the series of patches.

In this first patch, the new option `--quote-mail=<file>` needs an
email file and does not manage accents.

There is still work in progress, including:

  1. An option `--quote-mail-id=<message-id>` to download the message
     from any source, e.g. http://mid.gmane.org/<message-id>/raw.
     The server's address could be set in the repo's config file.

  2. The proper documentation for `--quote-mail=<file>` and
     `--quote-mail-id=<message-id>` as soon as their definitive
     behavior is approved by the community.

  3. The code to parse the email headers is currently duplicated several
     times, we should refactor it to help maintaining the code.

  4. More tests on the features described above.


git-send-email.perl   | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
t/t9001-send-email.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
2 files changed, 141 insertions(+), 1 deletion(-)
