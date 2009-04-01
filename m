From: David Aguilar <davvid@gmail.com>
Subject: git-{diff,merge} refactor round 2
Date: Wed,  1 Apr 2009 05:55:04 -0700
Message-ID: <1238590514-41893-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp006-0003nW-Hf
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764614AbZDAMzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758107AbZDAMze
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:34 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:5853 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758739AbZDAMzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:33 -0400
Received: by wa-out-1112.google.com with SMTP id j5so13652wah.21
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=skZxMgLx0YvrBdIqgBgY8cCLdISa95xkewMhDmrzeIU=;
        b=ghOVuy7Yl/cn2EZN2ConGflK4NjA341emiR+d19oeaFunAbFpZGpXFIaRk0HBorR2p
         RAZt8tphhl9RV14ttyV4zYFifuAmG2urDxzwvL3iBgA82apI5PAKpflH19gNJnc1cQcI
         RP0kMRIVSCAAb0DADr+yBuF5DKJVyCpWK/9Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Mwl04vSPEk+UaiRlo6j87+ZIAQNdopNGpISNJGmsHklo1qqNy0dQ8tToF6ue+GHxFa
         CU8Xs1I+l3m/jNjfoI+8dyKMzocQV7NyyxA43nil0lyTk2BbTiecQGOG5Ap8AZnsWCHf
         ILc7503dYzUoXrFQw5Po2Ap+Vr1+LG7W4W2+o=
Received: by 10.115.92.2 with SMTP id u2mr5191335wal.228.1238590530348;
        Wed, 01 Apr 2009 05:55:30 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v39sm7176892wah.40.2009.04.01.05.55.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115379>

Here's the 2nd round of refactoring.

This is based on Junio's pu branch.

I'm including the difftool.prompt patch in this series
because it is a dependency and including it here makes
that obvious.

I tried to keep the dependencies untangled while still being
able to manage the various command-line flags all in one
place.  Alas, this is shell so it can only be so elegant.

I went ahead and rolled in the "remove -o $MERGED" from
tkdiff for the diff mode case.


Still TODO:
incorporate the "add diffuse as a merge tool" patch.

Is there more that can be refactored?
Probably the part that sets up candidate mergetools,
replacing that with a function might be useful.

Here's what I've got so far.
