From: skillzero@gmail.com
Subject: Redundant merges?
Date: Wed, 30 Sep 2009 14:15:50 -0700
Message-ID: <2729632a0909301415p7fe0da44l9453fca70bd523ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 23:15:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt6Wi-0008B7-Vb
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 23:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbZI3VPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 17:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbZI3VPr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 17:15:47 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:52607 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbZI3VPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 17:15:47 -0400
Received: by iwn8 with SMTP id 8so3890647iwn.33
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=mEyaaM4dbQ2EK/E6WfMTE0C9TeO7UpO2zhXlVxXEYjc=;
        b=p9Ew/vXwAOzn6QZXFXd0sUr7TsFM1M23LcWtBHkK6wPi1ncM8IxX5Ak/JPiiWIbSU6
         H9FfnCYPe8u4rqS0oBTQBFNeK/2GZp29NOZ1B4TjVt3IIPKHrzu21ZblAWbpnQygzTsl
         ABnLEAkqqzxvSF4RAWPYeb0lwc/DSamxEqO5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=FGsUMEzkk0GQeuQ2Au9OLC5ScAEIxFVwQgyUy01W1Sg4B3bTENZ8BN/o405iTgbzma
         dO8gvpshHMnKYdeF2DBBl1SyeS3z6FhDSPKfk8f61Xj4CQVGEIWC4iFlUamOmAaXPPFE
         X0ZUiE/ky5SpRoQSFrDZfTl/vDb+VHBFhYQ/E=
Received: by 10.231.26.78 with SMTP id d14mr556885ibc.30.1254345350719; Wed, 
	30 Sep 2009 14:15:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129359>

Is there a way to avoid redundant merges when merging maint to master
if both maint and master have already merged in the same topic
branches? For example, assuming the git.git repository:

1. A bug was found and a topic branch (with a merge-base at or before
maint) is created with the fix.
2. The fix looks good so it's merged into master.
3. maint is already past the freeze date so the fix isn't merged into
maint (bug is not super critical).
4. maint is delayed for some reason and is accepting fixes.
5. Topic branch from step 1 is merged into maint.
6. maint is merged into master.

What I see is two merge commits that merge the same topic. I think I
understand why it's doing this (the merge commit is just another
commit so it merges it). But could it look at what the merge did and
realize that it already has the commit that the merge commit merged
and do nothing in this case?
