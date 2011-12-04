From: Venkatesh Srinivas <vsrinivas@dragonflybsd.org>
Subject: Bug: git bus error (stack blowout)
Date: Sun, 4 Dec 2011 17:50:19 -0500
Message-ID: <CAAcG=3NfvYSjhHDNb8aZ=_O4661bV7jkZBpmc77ZVCFDQQdHJw@mail.gmail.com>
Reply-To: vsrinivas@ops101.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 23:51:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXKty-0007A7-Fk
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 23:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab1LDWvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 17:51:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61699 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab1LDWvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 17:51:00 -0500
Received: by dadv6 with SMTP id v6so3486421dad.19
        for <git@vger.kernel.org>; Sun, 04 Dec 2011 14:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:sender:from:date:x-google-sender-auth
         :message-id:subject:to:content-type;
        bh=Kvd5CT5l3vHxmTFuMJEWJj7YZX10CZCkeDpanMKqBaU=;
        b=Y414FYfBdEVquq6c4s2oDqt9wgfOBnO9kVUDUuWnDzbCqkdZsuePj6yGUBkEXbpu4x
         jlIR3dXVd61w8Qt4xy6QbFMx0E7iO7NEmxtrIqm8PggSRQTGBMgMcHYRHJzerZ+jw3/k
         fpYq067l9QgulrzYWpSxYKjz/9RP8zl3+wWFw=
Received: by 10.68.72.73 with SMTP id b9mr17692433pbv.74.1323039060223; Sun,
 04 Dec 2011 14:51:00 -0800 (PST)
Received: by 10.143.12.11 with HTTP; Sun, 4 Dec 2011 14:50:19 -0800 (PST)
X-Google-Sender-Auth: jU6Av72rgRPoqsiXpzb0WnWL9fw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186275>

Hi,

When using git 1.7.6.3 from NetBSD's pkgsrc, on this git tree:
http://gitweb.dragonflybsd.org/pkgsrcv2.git, I got a bus error when
switching from the pkgsrc-2011q3 branch to the master branch. I have a
core file and the git binary if it'd be helpful; it looks like
mark_parents_uninteresting() was called recursively entirely too many
times (>60,000), originally from prepare_revision_walk(), from
stat_tracking_info(), from format_tracking_info(),
update_revs_for_switch(), from cmd_checkout().

Thanks,
-- vs;
