From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/8] rebase.autostash completed
Date: Fri, 10 May 2013 19:56:37 +0530
Message-ID: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:25:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoG4-0006yW-L3
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab3EJOZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:11 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:45351 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237Ab3EJOZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:10 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa7so2819634pbc.11
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=nCfrr87eGzSrgBmNWlpnH1ZeUijvyp0tNJiOQM4oVi4=;
        b=uJkLG8+fwFDN3rdZGBw41GzG1qYJyIchmOXRJ7up9nqYU95HpTVAuG+uKV0kbBKfgO
         PTFvhgEeOkN29Sendf1IPOmhlF0ROJ+44mdog26eqFBeggjkP76arnL6XknLpOPmoXm0
         T/ygWuMNjjLo7Lv6mBXO2NrYCfo78150Yl2KdWTNGp1dsuJJ6JahLCJY9S4ZKaCh+yLY
         wtfOkVLdsM3sT6xpo8nsyVmbbNXU9HOQZ1QdwV1LHFIeRYKhV7mn4gkX/vI3NZ+Hp85L
         WtERERgSuEggEPb+ayF3kuDtrbCG2hRdDEMjpXnyYRymEu94o6E0+jc04qbf9W7+Fvlz
         4xJQ==
X-Received: by 10.66.230.164 with SMTP id sz4mr17994040pac.124.1368195909492;
        Fri, 10 May 2013 07:25:09 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223839>

Hi,

The feature is finished with documentation and tests in this
iteration.  I've written an extensive t3420 which proves that the
feature works flawlessly.  Further, I've made every attempt to
actually explain what I'm doing: I've taken care to inspect all the
return values.

Overall, I'm elated with the design and interface.  I think it is most
intuitive, while not trading off power/ flexibility.

One subtle detail that you might disagree with: I report success if
the rebase succeeds but the stash application fails.  Are we okay with
this?

Also, does t3420 exercise all the cases sufficiently?  Have I missed
anything?

Enjoy reading and reviewing this.

Ramkumar Ramachandra (8):
  am: suppress error output from a conditional
  rebase -i: don't error out if $state_dir already exists
  am: tighten a conditional that checks for $dotest
  rebase: prepare to do generic housekeeping
  am: return control to caller, for housekeeping
  rebase -i: return control to caller, for housekeeping
  rebase --merge: return control to caller, for housekeeping
  rebase: implement --[no-]autostash and rebase.autostash

 Documentation/config.txt     |   8 +++
 Documentation/git-rebase.txt |  10 +++
 git-am.sh                    |  15 +++--
 git-rebase--am.sh            |   8 +--
 git-rebase--interactive.sh   |  11 ++--
 git-rebase--merge.sh         |   5 +-
 git-rebase.sh                |  46 +++++++++++++-
 t/t3420-rebase-autostash.sh  | 148 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 233 insertions(+), 18 deletions(-)
 create mode 100755 t/t3420-rebase-autostash.sh

-- 
1.8.3.rc1.52.gc14258d
