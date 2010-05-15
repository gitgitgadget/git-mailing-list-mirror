From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 0/7] Make git log --graph looks better with -p and other diff options
Date: Sat, 15 May 2010 04:02:04 -0700
Message-ID: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:02:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF8U-0007jL-Rt
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab0EOLCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:02:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44331 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab0EOLCM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:02:12 -0400
Received: by pvh1 with SMTP id 1so973496pvh.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2No5xXMRvo7mPtL7YMwSedO41uV/HT9nUV735GcSXfs=;
        b=OAxnfGJxzk/k6Mhs2/RAHFNCtOSXAwclcUTPv2Hyp7jy0ev2A1YzC90t9w/TZcYwfz
         8FWVqNqR4FawbmWlsZmkEFvaum7GsnLg0+4VzE43c9c8FCyyef4kMA9mWVgB+NVQDa3+
         l3/GoKkYn3/2/+O6XUkQ4UtQEVn4z1svEOvDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MZHRLf8y4DPfi+FEgu3S+B0TtbvO2iRN9kSjGJrs7QNc4GlGBl2F+fP17C+mKQPK/G
         dBtbX1wmw7jW/hixPLkKoawyndefqXEtLKXklZRWuUB2FGTrXDTGlxn4skqYRugjEq/F
         mnMutAEzPPGeXofu8G31zWVmyLuzTnKQLNksk=
Received: by 10.114.188.31 with SMTP id l31mr2170630waf.32.1273921329036;
        Sat, 15 May 2010 04:02:09 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id d16sm28703988wam.12.2010.05.15.04.02.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 04:02:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147139>

When we run git log --graph with any other diff output function, such as '-p','--check','--numstat' or other diff optoins, the diff output area have no graph lines ahead of it. And this make the text graph looks strange.
The following 7 patches try to deal with this, and put the text graph columns before all the diff output lines.

Bo Yang (7):
  Add a prefix output callback to diff output.
  Change to call the new emit_line.
  Output the graph columns at the end of the commit message.
  diff.c: Output the text graph padding before each diff line.
  Emit a whole line once a time.
  Register a callback for graph output.
  Make --color-words work well with --graph.

 color.c    |   21 +++-
 color.h    |    3 +-
 diff.c     |  315 ++++++++++++++++++++++++++++++++++++++++++++----------------
 diff.h     |    5 +
 graph.c    |   22 ++++
 log-tree.c |    4 +
 6 files changed, 281 insertions(+), 89 deletions(-)
