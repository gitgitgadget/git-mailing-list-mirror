From: =?KOI8-R?B?68nTxcyj1yDtwcvTyc0g4czFy9PFxdfJ3g==?= 
	<kiselevma@gmail.com>
Subject: stash -u deletes ignored files
Date: Sat, 7 Apr 2012 23:13:57 +0400
Message-ID: <CAGk-iSPYAV1HyK5e6n7E05reYBtLG2BiVsJuChxeCnm0DGjMrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 21:14:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGb5p-0005Na-Jl
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 21:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab2DGTOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 15:14:00 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62509 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab2DGTN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 15:13:59 -0400
Received: by lbbgg6 with SMTP id gg6so1240392lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=jahK7L0Yy+kqrSTxtkLsecCP/QVixIs9DU6scMcC+qU=;
        b=GFJ0JJmn40Ho24JUDi9knZIBjXRiKBUy8/llF13XhPtGGF6QoLIaMvfe0gJiQ/y6rE
         GCcgrbLXA08guXaaGcWnMg/zvRnR9BeJuNR7y1CdYzyEW3gJHUZQx7uWnz4LoMbXJwRk
         OiZv89QJuHpl7I9wMcOmrV9GOjQOGb/OfjoxstS9zmLeN6PRGHVZW7sg/kJXekC9o6AT
         hYdL78ve/QSFosKEii6cDT5h/JsFxJ9J0GZiD+Xf1wXlzAUuKbd98LaOXLSGGId/EVji
         92JnAirJUsjVOTbsU8os6BZu32hkBcO2WA51tH7wL3hXrX+YoX6fhPRwlBt/PiCY8BkV
         +SAQ==
Received: by 10.152.129.137 with SMTP id nw9mr3401252lab.48.1333826038005;
 Sat, 07 Apr 2012 12:13:58 -0700 (PDT)
Received: by 10.152.147.133 with HTTP; Sat, 7 Apr 2012 12:13:57 -0700 (PDT)
X-Google-Sender-Auth: gLuCv0MwbvpL8yDcJeP7Et0nvuo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194955>

There seems to a bug in git stash. Subfolders with ignored files are
deleted if the subfolders themselves are not ignored.

How to reproduce.
---
mkdir TestRepo
cd TestRepo
mkdir Ignored
echo " " > Ignored/Ignored.txt
echo "Ignored/Ignored.txt" > .gitignore
echo > File1.txt
git init
git add .
git commit --message="Initial commit"
echo "Test change" > File1.txt
git stash -u
git stash pop

Expected result:
Ignored/Ignored1.txt is present in the repository. It is either not
deleted after stash or at least restored after pop.

Actual result:
Ignored is deleted along with any files in it.

I use git version 1.7.9.msysgit.0

Sebastian Schuberth could reproduce this as well:

> I'm able to reproduce this with git version 1.7.10.msysgit.1 as well as
> on Linux, so please report this upstream to the git mailing list. Thank you.

Original discussion on msysgit mailing list:
https://groups.google.com/forum/?fromgroups#!topic/msysgit/FuAh7eXbPSw

-- 
Regards,
Max A. Kiselev
