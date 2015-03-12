From: Brian Koehmstedt <bkoehmstedt@berkeley.edu>
Subject: git-svn: Fetch svn branches only and have git recognize them as branches?
Date: Thu, 12 Mar 2015 15:30:04 -0700
Message-ID: <CAMMCKnc9AKjuwQ_RNxD_g3tn=xFQkbO1i-U=rP2VLWPi7qizGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 23:30:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWBcI-0001pu-Us
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 23:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbbCLWaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 18:30:06 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33561 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbCLWaF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 18:30:05 -0400
Received: by iecvj10 with SMTP id vj10so62200598iec.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 15:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=0HIZ30BNgZwTZGJ7l6zL9kE2wVWvYVioT9X85dyWGgg=;
        b=cmTWYIyn1MxFObSm+2/kMu2Dzrd+bm5jKq7UvoqM69hQU+HQm/a14NQh/czkI64t5d
         mhwGLRx4SphyKEDtwXwkxi+xG5n03o9CJB2oSOw0iJ/quZ8X77z/Kyw1Dj6ur6l037ix
         o3GjcTHcHvjJtkGV5RFqyrsbZp4VJeBGKUiGRM9TX2GkJSBB0gMGtGZlEj7lWH5AcrIU
         lv0w3S94NLvTUADnT+nzTegCoGbqIHVeDWmNd3zqYLlOeeE7S14ja1dr+RCoWZC8Upw/
         Sls5UToUZcH/m66aDqdx0AcbZx0fBM3N6u0BHQKC6LwyAyFJX9/N9uwdQcEpi0UIAM27
         X4Rw==
X-Gm-Message-State: ALoCoQnOQkRBpfX947D2ZIq6C1RfxkLYGuuaRB9L2+cjAeoczMrkNiB5cCKspFLG/mZ1f0okyO18
X-Received: by 10.43.13.71 with SMTP id pl7mr49456646icb.31.1426199404166;
 Thu, 12 Mar 2015 15:30:04 -0700 (PDT)
Received: by 10.50.56.232 with HTTP; Thu, 12 Mar 2015 15:30:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265376>

I'm trying deal with a project where the server is disallowing access to
the root URL on the subversion server.

i.e.,
Doesn't allow access: http://abc.com/repo
Does allow access: http://abc.com/repo/trunk, http://abc.com/repo/branches,
http://abc.com/repo/tags

I know I can git-svn to clone each separately and get three separate git
repositories, which isn't really what I want (Ideally I want one, with the
branches and tags recognized).

But neverminding that for a second, even if I end up with three git
repositories, I'd also like to figure out how to get git-svn to clone
http://abc.com/branches and recognize all the top-level directories as a
branch in git, rather than it treating it all as separate directories on
one branch.

Same would be true for tags.

Is this possible with .git/config editing?

My latest failed attempt was this:

[svn-remote "svn"]
        url = http://abc.com/repo/branches
        fetch = :refs/remotes/svn/branches
        branches = *:refs/remotes/svn/*

git svn fetch svn
This fetched all the branch directories as one branch.
