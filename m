From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: Improve search code
Date: Wed, 22 Jun 2011 17:28:50 +0200
Message-ID: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 17:29:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZPMv-0002BZ-OY
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 17:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376Ab1FVP3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 11:29:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab1FVP3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 11:29:22 -0400
Received: by fxm17 with SMTP id 17so714045fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=z0vN83+EVBZtmSfLUlPjIpVjgx4QiUk+LPYtk/IDRIo=;
        b=Nl98NJQJI82rLOpx02DK+W2gGHDgbMHS+DVIc1ZJ+wzAGz3wHKLWcilfEM1WRnmoh1
         YhosGJlw8yLKGkfCtXTtLnlAF9bYCfVU9TpyuLBvJScyT/hj1T+oP+510Gt07VehsoAR
         SyOjYfPvZMmeZFrRBRX51R8BIH6XneoEiYvzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=F98+LxSzjpR1Q/jG3xm7nE2gGpsWJvn9KSDugQ0nzfFXhvRZ4/sVwfUqCbeYnN1blu
         OJmDXlfE2JHBlKmOylqKRhvXJjJQhGXuRLo24yZ60+7RyTut9B5na3+WqTFBwBpVnPT8
         xltJvA4L7dpz7hCcNxbvejZf0kQTSZRi1XW6I=
Received: by 10.223.13.10 with SMTP id z10mr1011981faz.69.1308756560258;
        Wed, 22 Jun 2011 08:29:20 -0700 (PDT)
Received: from localhost.localdomain (abuz77.neoplus.adsl.tpnet.pl [83.8.197.77])
        by mx.google.com with ESMTPS id l26sm400935fah.14.2011.06.22.08.29.18
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 08:29:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176241>

Originally I have intended to go with it further, and improve how
search results look like, for example by using 'log' view code to
display 'commit', 'author' and 'committer' search results, now managed
by git_search_message.

But then I realized that I would need committags machinery for that.
So what we are left with are some code refactoring and cleanups.

Not for 1.7.6 (not a regression fix).

Jakub Narebski (5):
  gitweb: 'pickaxe' and 'grep' features requires 'search' to be enabled
  gitweb: Check permissions first in git_search
  gitweb: Split body of git_search into subroutines
  gitweb: Clean up code in git_search_* subroutines
  gitweb: Make git_search_* subroutines render whole pages

 gitweb/gitweb.perl |  442 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 243 insertions(+), 199 deletions(-)


P.S. Another addition that I sometimes wanted git to have would be
'filename' or 'find' search: searching for file by name.

What do you think of it?
-- 
1.7.5
