From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] git clone depth of 0 not possible.
Date: Mon,  7 Jan 2013 19:06:35 +0100
Message-ID: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: schlotter@users.sourceforge.net, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 19:15:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsHEQ-0004r4-La
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 19:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab3AGSPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 13:15:09 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:61772 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab3AGSPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 13:15:08 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2013 13:15:07 EST
Received: by mail-ea0-f173.google.com with SMTP id i13so7707372eaa.4
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 10:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=b+5mpqVLaP+QLmqAa6kYA4RKixdFYhlUGuNm7Ao0JHM=;
        b=QTusjhtrFEIeU+0zD9JqNJd9Loc5iV7AdCMsEmuWD1rhmPSpBYMxvHaj+0sRoWQznK
         //BWoDARTI2MbO8TKMZiwS/kSpfCzIe4ygdjOISj2ldMrXURJzfZxk/c/s0MZOZ/rTb0
         lyvam7ZQ7Ver95OaRWn3iRWF8CtAsonOXiNsqt+UI8DEbEYClKfx9O4TGWxocz759R9m
         GcGtfyIaRnO5Uin2Y3ck6oAOTCpdYOJdFCaucUqBQDCK/ciKiY1ZOOKnNng6m7Wee/SE
         zyFF7PXvw+6UJhZnOPKbT8bckZdtz6m3GNnSNmnouKWyDl3yy4KNKP3dUHch14dei34u
         nFEw==
X-Received: by 10.14.203.2 with SMTP id e2mr166482335eeo.20.1357582019620;
        Mon, 07 Jan 2013 10:06:59 -0800 (PST)
Received: from localhost (ip-109-91-111-92.unitymediagroup.de. [109.91.111.92])
        by mx.google.com with ESMTPS id 46sm130449692eeg.4.2013.01.07.10.06.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Jan 2013 10:06:58 -0800 (PST)
X-Mailer: git-send-email 1.8.1.80.g3e293fb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212912>

Currently it is not possible to have a shallow depth of
just 0, i.e. only one commit in that repository after cloning.
The minimum number of commits is 2, caused by depth=1.

I had no good idea how to add this behavior to git clone as
the depth variable in git_transport_options struct (file transport.h)
uses value 0 for another meaning, so it would have need changes at
all places, where the transport options depth is being used 
(e.g. fetch)

So I documented the current behavior, see attached patch.

Stefan Beller (1):
  Documentation on depth option in git clone.

 Documentation/git-clone.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.1.80.g3e293fb.dirty
