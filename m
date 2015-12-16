From: David Greene <greened@obbligato.org>
Subject: (unknown)
Date: Tue, 15 Dec 2015 21:02:45 -0600
Message-ID: <1450234966-28796-1-git-send-email-greened@obbligato.org>
Cc: john@keeping.me.uk, sandals@crustytoothpaste.net, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 04:03:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a92My-0002FA-Ab
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 04:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965689AbbLPDDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 22:03:08 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:56222 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965679AbbLPDDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 22:03:07 -0500
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1a92Mr-0003Dd-KS; Tue, 15 Dec 2015 21:03:05 -0600
Subject: 
X-Mailer: git-send-email 2.6.1
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282529>


This patch isn't ready for prime-time yet but I wanted to get it out
for some discussion.

While cleaning up and enhancing git-subtree, I've come across the
need to have rebase behave nicely in the case of empty and redundant
commits.  There's a case in pick_one_preserving_merges where
git-cherry pick is used to process the rebase and if cherry-pick
fails, the rebase aborts.  This change does two things:

- If --keep-empty is specified, invoke cherry-pick with --allow-empty.

- If new option --keep-redundant is specified, invoke cherry-pick with
  --keep-redundant-commits.

This allows the rebase to go forward without intrruption in the
included tests.

I will also need a third option that has cherry-pick ignore redundant
commits and remove them from the history.  Unfortunately, I can't
make out exactly how to do that in commit.c, which is where I gather
the cherry-pick stuff happens.  I'll need some help with that if
there's general agreement that this is a useful enhancement.

During the course of developing this, I've encountered some
strange rebase behavior.  I'll send another message about that.

I'd appreciate feedback on this direction and any help with the
cherry-pick stuff.  Thanks!

                         -David
