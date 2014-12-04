From: Guilherme <guibufolo@gmail.com>
Subject: git add <single file> and git add <list of files> behave differentely
 for ignored files
Date: Thu, 4 Dec 2014 10:06:23 +0100
Message-ID: <CAMDzUtzQJoEi17OfX8FPOV6SDJ_ytJSH-YTKx2DtUON35-EVSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 10:07:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwSNb-000791-92
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 10:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbaLDJHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 04:07:13 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:55671 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaLDJHI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 04:07:08 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so22061827wgg.35
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 01:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=c8YNQYc/cLjC9FI0N6KLSFclZYTXsa/qsMT2DJSp1YY=;
        b=fEuZIVEIitnKaB2vZCh3Qm7Y935LAXANgnJKpr2YMNbXB3vX/r/HX82uYlmKui4Xc6
         q1jFia8mgmTQJ+mGMElW3wEPLnXNqVD3Do6F9/vXzPdeg+zXBKbn6rlk72GY7ZzWc4Sg
         tigIENHjdkUS3yByQe6Z3HkJVOSVlSB8TkeZwLxzE65O7YNEWRlJqTX7d7a4KMJcid/W
         MtuHglAPvqr6UbfFMSJZhNCKa8AiFDvotYIY124yrKcpBMcT29I/H9mAUMF6w/uedppU
         XGWVTKbuGVyZit/roxrwFkNf+LRgxQpNWJpfzwDdshPL6AFdpEtum0vOF2rff7FZ4IjP
         8u/A==
X-Received: by 10.181.13.242 with SMTP id fb18mr23503334wid.1.1417684025065;
 Thu, 04 Dec 2014 01:07:05 -0800 (PST)
Received: by 10.27.54.80 with HTTP; Thu, 4 Dec 2014 01:06:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260748>

Hello,

I reported this issue on the git-user mailing list and they redirected me here.

The problem I have observed is that with a ignored path `git add
<single file>` behaves differently then `git add <list of files>`.

I my git/info/excludes file i have

/COM/config
!COM/config/Project.gny

The file COM/config/Project.gny has already been added to the
repository via `git add -f`.

When doing

    git add -- COM/config/Projec.gny

git will not complain but when doing

    git add -- COM/config/Project.gny otherfiles.c

it will report:

    The following paths are ignored by one of your .gitignore files:
    COM/config
    Use -f if you really want to add them.
    fatal: no files added

This odd behaviour is also present in `git check-ignore`.

Before adding the file `git check-ignore` correctly reports the file
as ignored. After having added it via `git add -f` it won't report it
as ignored anymore.

Even if not a bug this behaviour is inconsistent and might want to be
addressed as it makes scripting a little bit harder.

Thank you.
