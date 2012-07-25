From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/4] allow recovery from command name typos
Date: Thu, 26 Jul 2012 00:16:18 +0800
Message-ID: <1343232982-10540-1-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:16:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4GW-00071v-Fu
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab2GYQQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:16:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55919 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab2GYQQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:16:42 -0400
Received: by pbbrp8 with SMTP id rp8so1628912pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Zc0B4WU2as8/2Wb92Uz2FNfd8wmC9mDue8r7VPPeQus=;
        b=HWufl7l/1sZkcHMTXzvX9DB1AMqScxGMZl1enn6CqC741QL1yGeIU2oOtAWCiKoOlq
         KPP/3/pWBnZxN+RTh1ug1UU5reI4hUEUkClRTXSghyr0Rv5tLuVUWYxDM7ocZzFiCEP8
         i1xVibRrlVTYyds/PyXH3JoR7RkrVWfo7hml7nA17KY05RCtYHuXRJHbrasb7kDG8M+N
         8QatI6gyPnA8bMYiHYoGHGDHlQ9OT0BYEM+tR48E04c1AdlL/h5TbEe3icrYQ/4/NfID
         dQoqC/Gr5zU3z5/ClxVn7nzNiGQ1u1arPE/dAT2bMyX4Mu2Gxr5Zhatfho5IHKV9OEzs
         xpQw==
Received: by 10.68.221.41 with SMTP id qb9mr54470338pbc.147.1343233002076;
        Wed, 25 Jul 2012 09:16:42 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm97.beta238.maxonline.com.sg. [116.86.238.97])
        by mx.google.com with ESMTPS id hw6sm14629418pbc.73.2012.07.25.09.16.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 09:16:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.116.g8228a23
In-Reply-To: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202168>

Patch 4 has the meat of this series.

While running valgrind to check that I didn't leak any memory, a couple
of leaks were spotted. Patches 1-3 address them.

Major change in v2: implement Thomas' idea [1] about using
help.autocorrect to configure this behaviour.

[1] <878vh4con4.fsf@thomas.inf.ethz.ch>

Jeff King (1):
  help.c::uniq: plug a leak

Tay Ray Chuan (3):
  help.c::exclude_cmds: realloc() before copy, plug a leak
  help.c: plug leaks with(out) help.autocorrect
  allow recovery from command name typos

 Documentation/config.txt | 30 ++++++++++++----
 advice.c                 |  2 ++
 advice.h                 |  1 +
 help.c                   | 94 ++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 110 insertions(+), 17 deletions(-)

-- 
1.7.11.1.116.g8228a23
