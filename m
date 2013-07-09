From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/2] fix broken range_set tests and coalescing
Date: Tue,  9 Jul 2013 01:55:03 -0400
Message-ID: <1373349305-63917-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 08:03:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwR1e-0007Jz-MS
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 08:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab3GIGDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 02:03:43 -0400
Received: from mail-gh0-f170.google.com ([209.85.160.170]:33080 "EHLO
	mail-gh0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab3GIGDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 02:03:42 -0400
Received: by mail-gh0-f170.google.com with SMTP id z10so1930364ghb.29
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 23:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=JGe8CjZpdZvYHukU0PO7MUNr+hUfsjW8lUjmrOpbWwE=;
        b=ABlrKlLx0L5zbCWchEULF0NQtDayygwR5TXfN4DaZxEcHccu9Nh8YL9HqCUzBa+Wdd
         YliMN0VgW0miLSK2DRcHSoU5Qh5f2EQT6TRKy18JbhJ9feWHhzrXd28bvuh1JtSY7Tg5
         nHpI/oZGRkRHMy4jFKDEOlGSzYZJRLgtWaw3YpRok1ZwAeLrLKw69eSM4HoTD7P9wcX0
         JRqmCFpslud9HP6a7gwLY6FjdwOwSskKKX+q5vdmbqfK1zr1AOmRhT2A7+iT11Rsy9ss
         cDlZLQzC4lPUesM58bG1PmV/40Ujxf1IHtu+aW7nYKCXKIjrpK/NcoEQZgc0S+cwjkuG
         +Htg==
X-Received: by 10.236.116.2 with SMTP id f2mr14035656yhh.184.1373349321913;
        Mon, 08 Jul 2013 22:55:21 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id e69sm42754928yhl.3.2013.07.08.22.55.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 22:55:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229917>

This is a re-roll of a patch [1] which fixes the
line-log.c:sort_and_merge_range_set() coalescing bug.  This re-roll
inserts a new patch before the lone patch from v1.

patch 1/2: Fix broken tests in t4211 which should have detected the
    sort_and_merge_range_set() bug but didn't due to incorrect
    "expected" state. Mark the tests as expect-failure.

patch 2/2: Fix the sort_and_merge_range_set() coalesce bug. Same as v1
    but also flips the tests to expect-success.

[1]: http://article.gmane.org/gmane.comp.version-control.git/229774

Eric Sunshine (2):
  t4211: fix broken test when one -L range is subset of another
  range_set: fix coalescing bug when range is a subset of another

 line-log.c                       |   3 +-
 t/t4211/expect.multiple-superset | 134 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 133 insertions(+), 4 deletions(-)

-- 
1.8.3.2
