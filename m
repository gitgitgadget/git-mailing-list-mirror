From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 0/6 v2] Make git log --graph looks better with -p and other diff options
Date: Thu, 20 May 2010 03:25:32 -0700
Message-ID: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 12:25:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF2wq-0006ff-Eh
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab0ETKZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:25:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40491 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab0ETKZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:25:46 -0400
Received: by pva18 with SMTP id 18so1448192pva.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=CuQD+VWsbU/2wVpNF1jMjSwfEqt+gVmCAgY5+krl/5E=;
        b=kjBzuUUC1yTuesAuAlW4gmdEfCgR6SGCmQ7kIJaze/1/GPr9fUs8+ZGv5FS+jqoKUc
         k02Xy+gTKaa1EKidITi2wapUrvjDuPHbO+doDbGU57CD8Xkero5OZJU16+1PAniEZIcm
         Irn39ernuIgndihYLaCtnJp9Lrrk5pnRoTXtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hP/hTyIDO2EQ/lcKvgSMJIABZX0Z3CyiXvsX8CPcjkmE04VNwLBV2FphoYKeNrsAwY
         vFNwclwESnApvGhW+Ctnm8uiYSVSVvz0UB5Ejw/G0XsUgLrLLFwoRMweh26g+xvdauWk
         3odDdcnqTxkRlOp8Vd2445P4UILIlaHSVCFRw=
Received: by 10.115.20.18 with SMTP id x18mr8547263wai.50.1274351144971;
        Thu, 20 May 2010 03:25:44 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n32sm76160636wae.22.2010.05.20.03.25.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 03:25:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147373>

When we run git log --graph with any other diff output function, such as '-p','--check','--numstat' or other diff optoins, the diff output area have no graph lines ahead of it. And this make the text graph looks strange.
The following 7 patches try to deal with this, and put the text graph columns before all the diff output lines.


Bo Yang (6):
  Add a prefix output callback to diff output.
  Output the graph columns at the end of the commit message.
  diff.c: Output the text graph padding before each diff line.
  Emit a whole line once a time.
  Register a callback for graph output.
  Make --color-words work well with --graph.

 color.c    |   21 +++-
 color.h    |    3 +-
 diff.c     |  339 +++++++++++++++++++++++++++++++++++++++++++++---------------
 diff.h     |    5 +
 graph.c    |   19 ++++
 log-tree.c |    6 +
 6 files changed, 303 insertions(+), 90 deletions(-)
