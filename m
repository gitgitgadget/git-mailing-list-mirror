From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/18] "rerere" preparatory clean-up
Date: Fri, 17 Jul 2015 15:24:22 -0700
Message-ID: <1437171880-21590-1-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:24:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE3j-00042Y-7U
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbbGQWYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:24:43 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:32871 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246AbbGQWYm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:42 -0400
Received: by pdbqm3 with SMTP id qm3so68132143pdb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=cY0UNjXN0KoaUbdo/ycCNml6XBOKRw7n7WTkfP3Ltp0=;
        b=utdv1Ynq8VAxokaggM0BYIeQ64y9VcG75KpCQM04N1AgcUtRC4+4570Z5opcpUKkAK
         QpAi5gYpBn8VEqHBSJ2Fe/JcZuO5ZWgFja0cs1Xs9GpR8EhYvqiCEMIM31lH+1xkPgC4
         +HSOZtDyfnP20A9K4KfaMch92zlCRY0vURyaN6oZ92WZtrodJxeYC6oO7gMO76w07VZ8
         zlhEk73xW1lKd0XSJ/C9WemP6FuexPd1sB14jCNcDyYc4T5uWoo3XtJjRRnp7c83p9AI
         GI7fq1eD1hLI/IfavJl8h21sPmHR8UZ45f/303ufOYh4tgAbLofVpJ1WAoD95FqWw4uJ
         71eA==
X-Received: by 10.70.129.162 with SMTP id nx2mr33853053pdb.167.1437171881880;
        Fri, 17 Jul 2015 15:24:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id bq3sm12370520pdb.14.2015.07.17.15.24.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274110>

This is a resend of v2:

    http://thread.gmane.org/gmane.comp.version-control.git/273117

plus 5 new changes.  I have a few more real-fix changes that build
on top, but they are not sufficiently polished to be published yet
compared to these early clean-up bits.

Junio C Hamano (18):
  rerere: fix an off-by-one non-bug
  rerere: plug conflict ID leaks
  rerere: lift PATH_MAX limitation
  rerere: write out each record of MERGE_RR in one go
  rerere: report autoupdated paths only after actually updating them
  rerere: drop want_sp parameter from is_cmarker()
  rerere: stop looping unnecessarily
  rerere: explain the rerere I/O abstraction
  rerere: explain MERGE_RR management helpers
  rerere: explain the primary codepath
  rerere: explain "rerere forget" codepath
  rerere: explain the remainder
  rerere: refactor "replay" part of do_plain_rerere()
  rerere: further de-dent do_plain_rerere()
  rerere: further clarify do_rerere_one_path()
  rerere: call conflict-ids IDs
  rerere: use "struct rerere_id" instead of "char *" for conflict ID
  rerere: un-nest merge() further

 builtin/rerere.c |   4 +-
 rerere.c         | 544 ++++++++++++++++++++++++++++++++++++++++---------------
 rerere.h         |  12 +-
 3 files changed, 407 insertions(+), 153 deletions(-)

-- 
2.5.0-rc2-340-g0cccc16
