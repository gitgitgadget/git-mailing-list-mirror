From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] unpack-trees: use 'cuddled' style for if-else cascade
Date: Tue, 12 Aug 2014 17:00:45 -0700
Message-ID: <20140813000045.GF24621@google.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
 <1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
 <20140812235731.GD24621@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 02:00:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHLzo-0006Kv-SL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 02:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbaHMAAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 20:00:49 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:50576 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaHMAAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 20:00:48 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so13827557pad.21
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H59FcFJi/076oCs6zDtwrnIlJp4tClVd+xsmuReD2zY=;
        b=WVrtrIBaG1qav+nI6L7vW9MClgcUA8rEVJ5ohf4UYh2T0oJRIvtPaZxZddyHk78XPK
         9nMYOeosgOJJT5ft/c91Fb0rZ2DVm40SWxZ3mP+cjSNYRebH2GzZe/vxx2fE/A75T26e
         NZYbWd7/egOWR+dxIXbFwQ9MurJjkxNwd94AtRRzRssFSjNb6QfS/Uc2rPYZf3J9kn7Z
         vZfM/vYBIRLvY4dHswQprpNEX2nWhkL/mJF7ig1Vwm0PYaj54vXJqAVfK/WW5o+mBYLS
         QuS2gsUDeht2vpDY1eDENwIUS09J5rAgI007FzCvf5+0LyR/YDTWs9WdJdoME+qKyEVJ
         Djrg==
X-Received: by 10.68.139.74 with SMTP id qw10mr873460pbb.100.1407888047821;
        Tue, 12 Aug 2014 17:00:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b597:b557:1d91:6675])
        by mx.google.com with ESMTPSA id mj9sm731856pab.20.2014.08.12.17.00.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 17:00:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140812235731.GD24621@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255178>

Match the predominant style in git by following K&R style for if/else
cascades.  Documentation/CodingStyle from linux.git explains:

  Note that the closing brace is empty on a line of its own, _except_ in
  the cases where it is followed by a continuation of the same statement,
  ie a "while" in a do-statement or an "else" in an if-statement, like
  this:

	if (x == y) {
		..
	} else if (x > y) {
		...
	} else {
		....
	}

  Rationale: K&R.

  Also, note that this brace-placement also minimizes the number of empty
  (or almost empty) lines, without any loss of readability.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 unpack-trees.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f4a9aa9..187b15b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1771,8 +1771,7 @@ int twoway_merge(const struct cache_entry * const *src,
 					return merged_entry(newtree, current, o);
 			}
 			return o->gently ? -1 : reject_merge(current, o);
-		}
-		else if ((!oldtree && !newtree) || /* 4 and 5 */
+		} else if ((!oldtree && !newtree) || /* 4 and 5 */
 			 (!oldtree && newtree &&
 			  same(current, newtree)) || /* 6 and 7 */
 			 (oldtree && newtree &&
@@ -1781,17 +1780,14 @@ int twoway_merge(const struct cache_entry * const *src,
 			  !same(oldtree, newtree) && /* 18 and 19 */
 			  same(current, newtree))) {
 			return keep_entry(current, o);
-		}
-		else if (oldtree && !newtree && same(current, oldtree)) {
+		} else if (oldtree && !newtree && same(current, oldtree)) {
 			/* 10 or 11 */
 			return deleted_entry(oldtree, current, o);
-		}
-		else if (oldtree && newtree &&
+		} else if (oldtree && newtree &&
 			 same(current, oldtree) && !same(current, newtree)) {
 			/* 20 or 21 */
 			return merged_entry(newtree, current, o);
-		}
-		else
+		} else
 			return o->gently ? -1 : reject_merge(current, o);
 	}
 	else if (newtree) {
-- 
