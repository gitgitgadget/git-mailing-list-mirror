From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/3] format-patch --attach/--inline use filename instead of 
	sha1
Date: Wed, 18 Mar 2009 12:51:11 -0700
Message-ID: <780e0a6b0903181251t58b15a3asc5f9cc50564e11d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 20:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk1ol-0007Jg-Vz
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 20:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbZCRTvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 15:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbZCRTvP
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 15:51:15 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:2495 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbZCRTvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 15:51:14 -0400
Received: by an-out-0708.google.com with SMTP id d14so171901and.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=rUTmqLww03VTebnl/eQDxufrJL5zjjOH2vCfdHrmTAE=;
        b=FlYTKujWCer9NAvzJ7HG06oEiHTZqRl1PFn2NElxFFEcfMD03K84m4y0GyLVEeQZQo
         i6/Q0oWxZ74236UPOCNbO38JTpuvtCIfOdqqb39lsw3/BDr4Bcz74jK3/uKOzXlsWEH9
         y2MsPV49aje9oPmjI9cf2jKyEBacd+R4Cm55E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=MnmrqKomweUOZ4AymWHm1qaYa+cBAgfpQS36WbtAwBlMrnD9nFUrtGiuu+6Qx3LKUU
         sMKp9YK4Gy5C5TbwkVdF/lfdQqVddHRqT8tFlTSt1T4ZVjCFnGfiTIUYPHN0GTbhrK21
         D6k0l3iLnT6o4JQWlc4iCe1C0qumKLAdagRh8=
Received: by 10.143.8.17 with SMTP id l17mr674928wfi.173.1237405871169; Wed, 
	18 Mar 2009 12:51:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113653>

This patch series modifies the behavior of format-patch when used with
the --attach or --inline command line settings. Current behavior names
the attached or inlined patches with the sha1 of the commit, which
isn't very friendly or easy for a human to use when downloading the
attachments. This series replaces the sha1 values with the filename
used by format-patch when it outputs the patches to files.

I don't know the guidelines to modifying the rev_info struct, so
hopefully adding the filename there is not bad.

Stephen Boyd (3):
  format-patch: remove unused total parameter from reopen_stdout()
  format-patch: create patch filename in get_patch_filename()
  format-patch: --attach/inline uses filename instead of sha1

 builtin-log.c                                      |   48 ++++++++++----------
 log-tree.c                                         |    8 ++--
 revision.h                                         |    1 +
 ....format-patch_--attach_--stdout_initial..master |   12 +++---
 ...format-patch_--attach_--stdout_initial..master^ |    8 ++--
 ...ff.format-patch_--attach_--stdout_initial..side |    4 +-
 ...tdout_--subject-prefix=TESTCASE_initial..master |   12 +++---
 ....format-patch_--inline_--stdout_initial..master |   12 +++---
 ...format-patch_--inline_--stdout_initial..master^ |    8 ++--
 ...ormat-patch_--inline_--stdout_initial..master^^ |    4 +-
 ...ff.format-patch_--inline_--stdout_initial..side |    4 +-
 11 files changed, 61 insertions(+), 60 deletions(-)
