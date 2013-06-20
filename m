From: Francis Moreau <francis.moro@gmail.com>
Subject: Splitting a rev list into 2 sets
Date: Thu, 20 Jun 2013 12:14:22 +0200
Message-ID: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 12:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upbsp-0002UM-8V
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 12:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275Ab3FTKOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 06:14:23 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:47338 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965178Ab3FTKOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 06:14:23 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so7017863obc.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+NqdJV/yhyD7Xm5+YFifvh7urD41B7eTVQeC5YAqzMo=;
        b=xI+PDKvcipaFHng0JCDzIUxbourGRAB+9Ubjzagi2FcSykU7t4Eua8hOTo0ZkXEVZY
         nYwrxjpiEpVazQABSV0TcfLh1J98q9LcUIPQjlyidw25qHULANVW9LAFw1nkhHStyrHK
         YWVw2C3dC6FeVeC3WyDSIH1P5fTAoZ0rdkavVNhmqyr0vQF1D/EYPGT+mo6NVR/VNwJR
         f7aICHThgSByVRQmph9GFP8Nc9KwzE+s0T3mjX3YBMeURaw6p2yuQkPFxuXZGtruHtJ6
         K4RS78ZfvPLkxgY3z4kVw41T0ER7H9sN4MTUMovRN2Ctnpu+p7FG4F3vOCXIzN5Q9uES
         I04g==
X-Received: by 10.60.93.33 with SMTP id cr1mr4129269oeb.116.1371723262507;
 Thu, 20 Jun 2013 03:14:22 -0700 (PDT)
Received: by 10.182.200.169 with HTTP; Thu, 20 Jun 2013 03:14:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228476>

Hello,

I'd like to write a script that would parse commits in one of my repo.
Ideally this script should accept any revision ranges that
git-rev-list would accept.

This script should consider commits in master differently than the
ones in others branches.

To get the commit set which can't be reached by master (ie commits
which are specific to branches other than master) I would do:

  # "$@" is the range spec passed to the script
  git rev-list "$@" ^master | check_other_commit

But I don't know if it's possible to use a different git-rev-list
command to get the rest of the commits, ie the ones that are reachable
by the specified range and master.

One way to do that is to record the first commit set got by the first
rev-list command and check that the ones returned by "git rev-list $@"
are not in the record.

But I'm wondering if someone can see another solution more elegant ?

Thanks
--
Francis
