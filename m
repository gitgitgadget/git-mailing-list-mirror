From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 0/3] interactive git clean
Date: Fri,  3 May 2013 11:49:52 +0800
Message-ID: <cover.1367551846.git.worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 03 05:50:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY70l-0000b0-8a
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 05:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760356Ab3ECDuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 23:50:12 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:52905 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827Ab3ECDuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 23:50:11 -0400
Received: by mail-pd0-f169.google.com with SMTP id 14so699923pdc.0
        for <git@vger.kernel.org>; Thu, 02 May 2013 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=+YpMblIHZ8EGxklsGURSD4CnINJ2dUuTmDekKDW4lBU=;
        b=hLvpF3TTUkzejVNpxsvUuNwtlmOGMVwvi8g1TGBXUIesE6WFUhdYnyE8g0/McZrfQZ
         w38oijDt38xB+tZg0dtUIBl/M+9K4O6Ty1cmOkVGty7hypbqvGGnsqyL6HoLsbA95B2A
         1xni5HXVYp9Fo2yftilt1S+lTmeVfwr10lBXKAestGYUpStuIpQETVrVpmeB/o2x8KNa
         7L+vEVv/B/CK8Sd6w6fWEhMeH/xTIYtdtbPG4ZHu1Fl0IH/eyaJ9jE3Ptvu2JAESbUm0
         m46fy1SdPWmTOc1O7PIeCPSkEOvQcwhQczRB0/wXOJM36Xu7uFCFTUAG5Q7IyqFpcOte
         Vesg==
X-Received: by 10.68.134.163 with SMTP id pl3mr12145558pbb.101.1367553011405;
        Thu, 02 May 2013 20:50:11 -0700 (PDT)
Received: from localhost.localdomain ([114.246.126.106])
        by mx.google.com with ESMTPSA id qb1sm9819651pbb.33.2013.05.02.20.50.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 20:50:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.364.g6e54870
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223271>

The interactive git clean combines `git clean -n` and `git clean -f`
together to do safe cleaning, and has more features.

First it displays what would be removed in columns (so that you can
see them all in one screen). The user must confirm before actually
cleaning.

    WARNING: The following items will be removed permanently. Press "y"
    WARNING: to start cleaning, and press "n" to abort the cleaning.
    WARNING: You can also enter the "edit" mode, and select items
    WARNING: to be excluded from the cleaning.

      What would be removed...    What would be removed...
      What would be removed...    What would be removed...
    
    Remove (yes/no/Edit) ? 

In this confirmation dialog, the user has three choices:

 * Yes: Start to do cleaning.
 * No:  Nothing will be deleted.
 * Edit (default for the first time): Enter the edit mode.

When the user chooses the edit mode, it would look like this:


    NOTE: Will remove the following items. You can input space-seperated
    NOTE: patterns (just like .gitignore) to exclude items from deletion,
    NOTE: or press ENTER to continue.
    
      What would be removed...    What would be removed...
      What would be removed...    What would be removed...
    
    Input ignore patterns> 


The user can input space-separated patterns (the same syntax as gitignore),
and each clean candidate that matches with one of the patterns will be
excluded from cleaning.

When the user feels it's OK, presses ENTER and back to the confirmation dialog.

    WARNING: The following items will be removed permanently. Press "y"
    WARNING: to start cleaning, and press "n" to abort the cleaning.
    WARNING: You can also enter the "edit" mode, and select items
    WARNING: to be excluded from the cleaning.

      What would be removed...
    
    Remove (Yes/no/edit) ? 

This time the default choice of the confirmation dialog is "YES".
So when user press ENTER, start cleaning.

Jiang Xin (3):
  Add support for -i/--interactive to git-clean
  Show items of interactive git-clean in columns
  Add colors to interactive git-clean

 Documentation/git-clean.txt |  15 ++-
 builtin/clean.c             | 295 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 291 insertions(+), 19 deletions(-)

-- 
1.8.3.rc0.364.gc6aefbf
