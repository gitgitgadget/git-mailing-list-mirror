From: Phil Lawrence <prlawrence@gmail.com>
Subject: git push doesn't honor .git/config
Date: Wed, 31 Mar 2010 09:54:28 -0500
Message-ID: <h2x530ac78e1003310754v88853e2bj6d59d835025ec140@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 16:54:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwzJT-00038s-AU
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 16:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab0CaOya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 10:54:30 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:42578 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab0CaOy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 10:54:29 -0400
Received: by qyk9 with SMTP id 9so175409qyk.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=3O/EnMqjXMScZuZwZBUfdkI31lxyfC0WlXb+dyUx3uQ=;
        b=J5IZqqQqh2wPB1gHKt5Y4u58l1Zvlay5Pqt172rAo2cBJqKjJNzNNYnit0cyk9Mx1K
         ervkPYHW8kzGJnxVV6+ihS+SKy3YSTS9oZLnAthxCYmtgzgKs3AliS50c6bhJ1POcnCA
         fQlz/eClXH435MYtjOXLmIRNGWQ1EdxbjmHhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=r1ZNG54EgnXE7qsWp1+EcQ8nPD6qVq/cf8bKbmC9o0g5M03xOpZiHHFmh+SL+urfk1
         LKPpw6SdaSTlRTWfIYxlSkagiKMWd8kRiif+Bz0FsTbdltRTzIRG4anSBLaxRyDwHC5c
         FOEUEFTGkDTxqn6Ql0RFhPZbRhgIkMTL1Yw2o=
Received: by 10.229.241.202 with HTTP; Wed, 31 Mar 2010 07:54:28 -0700 (PDT)
Received: by 10.229.230.65 with SMTP id jl1mr260691qcb.7.1270047268154; Wed, 
	31 Mar 2010 07:54:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143678>

I renamed a local branch from MIS-59 to MIS-59_project, and did the following:
  git branch --set-upstream MIS-59_project origin/MIS-59
  git push --set-upstream origin MIS-59_project:MIS-59

However, .git/config is not being honored by git push; I have to
supply all the parameters to actually push changes.

(MIS-59_project)$ git branch -v
  MIS-38_labor_cat    cab4fe6 [MIS-38] Create Master Labor Category import SQL
  MIS-39_org          02f9e2f [MIS-39] Create Unanet's Organization export SQL
  MIS-40_approval_grp 7c3b5ec [MIS-40] Create Unanet Approval Groups import SQL
  MIS-41_location     8bd55ab [MIS-41] Create Unanet Master Locations import SQL
  MIS-42_person       9fb1901 [MIS-42] Create SQL for Unanet's Person import
* MIS-59_project      ed3acc9 [ahead 1] [MIS-59] Switch to using
get_project_type_unanet()
  MIS-65_task         651a05b [MIS-65] Switch to using get_project_type_unanet()
  master              e98c105 Retired OTL
(MIS-59_project)$ grep -A2 MIS-59_project .git/config
[branch "MIS-59_project"]
        remote = origin
        merge = refs/heads/MIS-59
(MIS-59_project)$ git push
Everything up-to-date
(MIS-59_project)$ git branch -v
  MIS-38_labor_cat    cab4fe6 [MIS-38] Create Master Labor Category import SQL
  MIS-39_org          02f9e2f [MIS-39] Create Unanet's Organization export SQL
  MIS-40_approval_grp 7c3b5ec [MIS-40] Create Unanet Approval Groups import SQL
  MIS-41_location     8bd55ab [MIS-41] Create Unanet Master Locations import SQL
  MIS-42_person       9fb1901 [MIS-42] Create SQL for Unanet's Person import
* MIS-59_project      ed3acc9 [ahead 1] [MIS-59] Switch to using
get_project_type_unanet()
  MIS-65_task         651a05b [MIS-65] Switch to using get_project_type_unanet()
  master              e98c105 Retired OTL
(MIS-59_project)$ git push origin MIS-59_project:MIS-59
Counting objects: 11, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (6/6), 498 bytes, done.
Total 6 (delta 2), reused 0 (delta 0)
=> Syncing Gitorious... [OK]
To git@gitorious.burnsmcd.com:~plawrence/mis/plawrences-ora-apps.git
   1fbf2e0..ed3acc9  MIS-59_project -> MIS-59
(MIS-59_project)$

Did I miss something, or is this incorrect behavior?  BTW, I'm running
msysgit 1.7.0.2-preview20100309 on Windows XP.

Thanks,
Phil Lawrence
