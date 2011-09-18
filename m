From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/3] fast-import: fix pack_id corner cases
Date: Mon, 19 Sep 2011 01:01:45 +0600
Message-ID: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 20:55:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5MWq-0006E5-Os
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512Ab1IRSzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 14:55:36 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:58336 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab1IRSzf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 14:55:35 -0400
Received: by wyg8 with SMTP id 8so8212282wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CYG5MJKbSfnXBHm2PiG3OB8NJF4NCyY+hsODC4N6WhM=;
        b=vrhxm6OzVJsgxTvDvfZw51CN4AcCqcvkmP7medr5+MJokr5kpmLYrpEt6nsSnPHTnj
         L6FI6L6iuHw+nvVr4ja8zjh8xC8iZa9FL8kcDTBDN8S6siHu8Nv/wEyW6NJQXGmUDeF1
         5Jg5+APQfLGVzHsiWFdLNMKO8XoCIhSS49PLk=
Received: by 10.227.179.14 with SMTP id bo14mr1847195wbb.90.1316372134752;
        Sun, 18 Sep 2011 11:55:34 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id h20sm16877374wbo.22.2011.09.18.11.55.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 11:55:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181622>

[1/3] is just a precaution unlikely to happen as having 65536+ packs
produced in fast-import looks extremely rare.
[2/2] is more real bug. Shouldn't be too hard to reproduce, but I'm
currently too lazy to as it is quite rare and not likely to get broken
again.
[3/3] is pure cosmetic change while I'm on pack_id topic.

Dmitry Ivankov (3):
  fast-import: die if we produce too many (MAX_PACK_ID) packs
  fast-import: fix corner case for checkpoint
  fast-import: rename object_count to pack_object_count

 fast-import.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

-- 
1.7.3.4
