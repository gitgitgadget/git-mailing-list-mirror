From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [GUILT]  [PATCH 7/7] Drop unneeded git version check.
Date: Tue, 15 Jan 2013 18:31:44 -0800
Message-ID: <20130116023144.GP12524@google.com>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvInS-00069M-2f
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758121Ab3APCbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:31:49 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:61307 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758115Ab3APCbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:31:49 -0500
Received: by mail-pb0-f54.google.com with SMTP id wz12so424002pbc.13
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5R77SXo5cl/kTRPyQ+w6XB9KL6CyQ3iNYS4jGh5viJI=;
        b=sCTr9rFLYRw1/L0/c1tcb5qtrMYE/l9WJHx7ciNzSwpVx4ZUroI+HyL887JaTIh6AI
         KVH3FXascYIJkFgnHKxQIxcLSFEnQY5zwCMJ2P6UKUD9VMWp2iCJljuXRtqI6PdR4N7t
         MetjkGv2tbkxAOx/YU0M5rNFVkiPP5ovS0uyy/TB8UydlICHr7QUtI6EedYUdg7VrXac
         b+SGtfW3NXpQbcwiChYpeLU/1mx7dvcI4PWRUwH7/0dV4bYEdi+vvl2blMOLbRyBf8kq
         bfG5MEI+ijyReqNnRFoxUWvgpP2ZoFhlMdif5I5hodj8dInXZwBgLP0vupdL8e9kwvJT
         +uMw==
X-Received: by 10.68.226.71 with SMTP id rq7mr270522746pbc.60.1358303508667;
        Tue, 15 Jan 2013 18:31:48 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id gj1sm11299307pbc.11.2013.01.15.18.31.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:31:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213715>

Git's compatibility record is pretty good, so there's no need to worry
that newer versions of git will break the "git config" command.

Without this change, guilt errors out for git 1.8.  With it, all tests
pass.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 guilt | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/guilt b/guilt
index 66a671a..6cb43e3 100755
--- a/guilt
+++ b/guilt
@@ -26,17 +26,6 @@ SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
 
 #
-# Git version check
-#
-gitver=`git --version | cut -d' ' -f3 | sed -e 's/^debian\.//'`
-case "$gitver" in
-	1.5.*)	;; # git config
-	1.6.*)	;; # git config
-	1.7.*)	;; # git config
-	*)	die "Unsupported version of git ($gitver)" ;;
-esac
-
-#
 # Shell library
 #
 usage()
-- 
1.8.1
