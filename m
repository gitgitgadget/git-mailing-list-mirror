From: Stephen Duncan Jr <stephen.duncan@gmail.com>
Subject: git-svn branches with revision id's in name
Date: Mon, 30 Jan 2012 14:42:46 -0500
Message-ID: <CAGYrzvwzrsZdHHnSBaMv-sD9mDGVQ-qFuks+JM6d-NQ9Wz9KwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 20:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrx8D-0000Pm-Ut
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab2A3TnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 14:43:08 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36289 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab2A3TnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:43:07 -0500
Received: by wics10 with SMTP id s10so3769972wic.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=k2Pf+KN9f5StBWM7oq3ELETOXYmzbO9PCpbM3q3Cxd8=;
        b=UVXN/GJsYPMJ/tRSQFx0t53y0WfifE2bv7Uwqi3yiVyPd/VA4F1qGHtlf3o1NGPtEJ
         Y2LJlIOJ9XKMtmHCmfnsRzJniCkI1Ghd2+yZ1pjUNsze9sRA5WSTO7Z13mARYY3RBdTp
         ACfnOo9bGIwV3pnw0Ro6Y+Me/gt7pYCIL2KYE=
Received: by 10.180.83.72 with SMTP id o8mr30075322wiy.22.1327952586353; Mon,
 30 Jan 2012 11:43:06 -0800 (PST)
Received: by 10.223.93.199 with HTTP; Mon, 30 Jan 2012 11:42:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189408>

A project I work on recently changed it's SVN structure, causing me to
do a new git svn clone.  The new structure is like this:

{project}/branches/
  /master
  /develop
  /qa
  /feature
    /feature1
    /feature2
  /release
    /release1
    /release2
  /hotfix
    /hotfix1
    /hotfix2

So I set up my svn-remote sections as follows:

[svn-remote "svn"]
  url = {url}
  fetch = {project}/branches/master:refs/remotes/trunk
  fetch = {project}/branches/develop:refs/remotes/develop
  fetch = {project}/branches/qa:refs/remotes/qa
  branches = {project}/branches/{feature,release,hotfix}/*:refs/remotes/*/*

This seems to have worked fine, for the most part, but unlike my
previous git-svn checkouts, it has created several branches with
revision numbers as part of the name:

$ git branch -a
* master
  remotes/develop
  remotes/develop@29271
  remotes/develop@32463
  remotes/develop@34103
  remotes/feature/xyz
  remotes/feature/xyz@26438
  remotes/feature/xyz@27542
  remotes/feature/xyz@35233

Why have these remote branches been created?  What impact does this
have on my checkout?  Can I remove safely remove them?  How?  I was
unable to figure out how to reference this behavior in order to search
for information on it.

--
Stephen Duncan Jr
www.stephenduncanjr.com
