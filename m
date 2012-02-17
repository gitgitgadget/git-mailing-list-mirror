From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/3] push: add 'prune' option
Date: Fri, 17 Feb 2012 21:12:34 +0200
Message-ID: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 20:13:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyTFZ-0001gS-BE
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 20:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab2BQTNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 14:13:39 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59289 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab2BQTNj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 14:13:39 -0500
Received: by lagu2 with SMTP id u2so4133709lag.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TzqerPbcPTQ50RaAHkw36aQqKR/drQqe8rxPj193Ves=;
        b=ob1NRGygGQAIjVbuAV4Y7SS1qSO+841teIZN5zevQtRzviHqI5MViBh0wb9NhjaDBV
         h88QajxKEJ6fH8v5DvyyxvBzluqlkJrdRA+aW6zLHXrZhqvUVRGdYq+9fK//mLouuu5P
         vH30AhgfULyamE/f73VK6uiKffrfZFrnvKces=
Received: by 10.152.145.135 with SMTP id su7mr6094599lab.5.1329506017800;
        Fri, 17 Feb 2012 11:13:37 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id fl2sm12793615lbb.4.2012.02.17.11.13.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 11:13:36 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190971>

Hi,

As mentioned in a previous thread[1], git is lacking some functionality to
synchronize completely with remote repositories.

As an example I put my use-case; I want to backup *all* my local branches to a
personal repository, and I want to remove branches that I have removed from my
local repository. git push personal 'refs/heads/*' mostly does the job, but it
doesn't remove anything, and that's where 'prune' comes from.

Do not confuse the remote branches with the upstream ones; you could have two
repositories where you want to synchronize branches to:
% git push --prune --force backup1 'refs/heads/*'
% git push --prune --force backup2 'refs/heads/*'

I still think a 'git remote sync' would be tremendously useful, but it can
actually use this --prune option.

I know, documentation and testing are missing, but perhaps there will be
comments on the code itself.

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/184990

Felipe Contreras (3):
  remote: use a local variable in match_push_refs()
  remote: reorganize check_pattern_match()
  push: add 'prune' option

 builtin/push.c |    2 +
 remote.c       |   91 +++++++++++++++++++++++++++++++++++--------------------
 remote.h       |    3 +-
 transport.c    |    2 +
 transport.h    |    1 +
 5 files changed, 65 insertions(+), 34 deletions(-)

-- 
1.7.9.1
