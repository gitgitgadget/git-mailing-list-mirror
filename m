From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [RFC-PATCH v2 0/2] send-email: new --quote-email option
Date: Fri, 27 May 2016 19:11:40 +0200
Message-ID: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
Cc: jordan.de-gea@grenoble-inp.org, erwan.mathoniere@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, samuel.groot@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:12:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6LJ1-0007jZ-2p
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbcE0RML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:12:11 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:36134 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbcE0RMK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:12:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4BA4A2579;
	Fri, 27 May 2016 19:12:07 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PfrJLERv4r8g; Fri, 27 May 2016 19:12:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3ADCF2573;
	Fri, 27 May 2016 19:12:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 2C2E12077;
	Fri, 27 May 2016 19:12:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dcPGbkmslcbV; Fri, 27 May 2016 19:12:07 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-032034.grenet.fr [130.190.32.34])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 08A962055;
	Fri, 27 May 2016 19:12:07 +0200 (CEST)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295772>

Hello,

With the current send-email command, you can send a series of patches
"in reply to" an email.

This patch adds a new option to `git send-email`,
`--quote-email=<file>` which does two things:
	- set fields appropriately (To, Cc, Subject, In-Reply-To)
	- quote the given message

In this second patch, the new option `--quote-email=<file>` needs an
email file and does not manage non ascii characters.

There is still work in progress, including:

  1. An option `--quote-email-id=<message-id>` to download the message
     from any source, e.g. http://mid.gmane.org/<message-id>/raw.
     The server's address could be set in the repo's config file.

  2. There's also a discussion about whether this option should be
     integrated in the current `--in-reply-to` option or not

     * http://news.gmane.org/find-root.php?message_id=vpqh9dmfy5k.fsf@anie.imag.fr


  3. The code to parse the email headers is currently duplicated
     several times, we are refactoring it to help maintaining the
     code.

  4. Manage non ascii characters

Documentation/git-send-email.txt |   8 +++++++
git-send-email.perl              | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
t/t9001-send-email.sh            |  67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
3 files changed, 232 insertions(+), 3 deletions(-)
