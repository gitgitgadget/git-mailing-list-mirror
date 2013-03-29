From: Phil Haack <haacked@gmail.com>
Subject: Minor bug in git branch --set-upstream-to adding superfluous branch
 section to config
Date: Fri, 29 Mar 2013 09:29:14 -0700
Message-ID: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 17:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULcBX-0004uu-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 17:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab3C2Q3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 12:29:15 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:46298 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab3C2Q3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 12:29:15 -0400
Received: by mail-ia0-f171.google.com with SMTP id z13so524512iaz.16
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=F192csHwgEIA1AA7M0s/1L6Gnyo9HDCLhvvSQKW1gQI=;
        b=fX09y9R369wKY3TSinmg7rlVd53j3dYClg/ciXOcusRl+Ly3ZmdbEvbmvIKGlSY01a
         BoxZUWDr9rqY12cTxLeQD2ZsETBVukh8YWGpISVRLHDqu3mWBbwHKzK82ZIl6GAXZE5z
         d19czAChOENY6ZQNiIcFyaLP+7I5PnMeWpI9HTdXxHbidsBSSwDn1sJiH8Xt1DsD7e+c
         SXTKJxXFCfkLksblZxOyPvbX3C2cQu4Op1ULkKN+pHubg0BXVkbWVOH4Z8aG24VquaZy
         P/E42wMmtrOsf3e/OORroYCNdJz8NCnwAqaUM1qCoCuf1FizZiizcyuAYN5SJhkyUthu
         eKKQ==
X-Received: by 10.50.12.133 with SMTP id y5mr3844igb.108.1364574554512; Fri,
 29 Mar 2013 09:29:14 -0700 (PDT)
Received: by 10.64.35.77 with HTTP; Fri, 29 Mar 2013 09:29:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219505>

Hello there! Please /cc me with responses as I'm not on the mailing list.

I'm using git version 1.8.1.msysgit.1 and I ran into a very minor issue. It
doesn't actually seem to affect operations, but I thought I'd report it in case
someone felt it was worth cleaning up.

If you run the following set of commands:

    git checkout -b some-branch
    git push origin some-branch
    git branch --set-upstream-to origin/some-branch
    git branch --unset-upstream some-branch
    git branch --set-upstream-to origin/some-branch

You get the following result in the .git\config file

    [branch "some-branch"]
    [branch "some-branch"]
        remote = origin
        merge = refs/heads/some-branch

My expectation is that the very last call to: git branch --set-upstream-to
would not add a new config section, but would instead insert this information
into the existing [branch "some-branch"].

In any case, from what I understand the current behavior is technically valid
and I haven't encountered any adverse effects. It was just something I noticed
while testing.

Thanks!
