From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH/WIP] Repair DF conflicts during fetch.
Date: Fri, 29 Nov 2013 11:57:37 -0600
Message-ID: <1385747858-29343-1-git-send-email-jackerran@gmail.com>
Cc: Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 29 18:57:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmSK8-0007lr-3p
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 18:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab3K2R5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 12:57:48 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:42192 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3K2R5r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 12:57:47 -0500
Received: by mail-yh0-f47.google.com with SMTP id 29so6837759yhl.20
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eCiL3m+dpgU6/FVnd6Im7pfCs+RTPUQBvEHSx86rdN8=;
        b=ksNy+BJQIPApCd1YHcCAYmeJtgUEwfbghnnh0B4Sqf6UVdpF7gCRmiYhz/5jHsmaoU
         lfYTtqGbt/MVTvWDwjU9fmiS4VwJlHLzby4Sq+V9OupgnuuWrAU9AgjWJRbb7B3E2TeK
         mZnYQIVo36dH5ANqX6SkS8izDn+BlChGGLaw5KKylyqH5iGbx+dpSk1LbNf43ZCmdbBS
         Mk5cLWh/QhH03LYLAaUjXMmbkWG7VM/RMnHFKVPrkFGWlhytdcXI3OeCs9sKOSjHQdkt
         bPKUJyAHBelB2l9yW8QOFC21y1S/Wcv8V3jP9Fg9Tn29HdBWp15RD7JqKRdv8/GRSgTT
         rdPQ==
X-Received: by 10.236.86.42 with SMTP id v30mr3354674yhe.92.1385747864548;
        Fri, 29 Nov 2013 09:57:44 -0800 (PST)
Received: from gf-tmiller.home (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id g25sm21564767yhg.6.2013.11.29.09.57.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 29 Nov 2013 09:57:44 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238530>

I encountered a directory/file conflict when running `git fetch --prune
origin`.  I figured passing --prune would automatically fix DF conflicts. After
looking in the code I found that prune is called after fetching. It seemed to
be intentional according historical commits. I made this patch to change it,
which seems to work as I expected it to. This patch doesn't have any tests and
it breaks the output when it does prune branches. I'm looking for guidance to
help with fixing the broken output. I tried to figure out a way to do it on my
own but I realize that I don't have the expertise with the codebase or C.

Thanks, for any help that I may recieve in advaned this is my first time
posting. If I have submitted this wrong I applogize and look forward to any
advice that I may recieve in correcting my mistakes.

Tom Miller (1):
  Repair DF conflicts during fetch.

 builtin/fetch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
1.8.5.rc3.dirty
