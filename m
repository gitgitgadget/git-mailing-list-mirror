From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: git commit vs. ignore-submodules
Date: Fri, 28 Mar 2014 00:36:00 +0100
Message-ID: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 00:36:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJqC-000348-8K
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 00:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbaC0XgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 19:36:02 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:43227 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbaC0XgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 19:36:00 -0400
Received: by mail-ob0-f169.google.com with SMTP id va2so5083292obc.14
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=093ZkRAI7DNhXoaHqSo7nihN+oBsSbw+pq4vSk2iWoo=;
        b=Jts7F/9SnfQ4xzekxspOHxb6Bmi3xSJ7kag7QWQso+ee+tXn+AUJEJ2h/PGDQ46c6u
         EiY0gKvT2NnSbl16as8KEzfDzxikd9ZjARtax1MqOaXny5qNjhj/9LRAS3m2T01px44O
         QExCMl4NDJKjHAqiR/17K69kTAL1VWpEemnfVLyRy0Y4uFTZ6ZfKgO7Iy7EvX0Qo3e4p
         UZkJQM9PNXRrO0P5y49PZJLBgZkvzAdH/D11ccZnjGlU464bqMcPIEOLMn8lF6nS6cGI
         33c0IMWqWm+DnlvqGkGHSc9+PeINm7ReXxGd17qQQDVYPjBsTeXf3x/mWW7DcsERKJVP
         6IjA==
X-Received: by 10.182.44.167 with SMTP id f7mr3799013obm.3.1395963360462; Thu,
 27 Mar 2014 16:36:00 -0700 (PDT)
Received: by 10.76.154.68 with HTTP; Thu, 27 Mar 2014 16:36:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245341>

Hello.

As this is my first post to this list, let me first thank all the
people involved in Git development - it's really a great tool.

Now to the point. Since Git 1.8 (I think), git commit command honours
the submodules' ignore settings, configured either in .gitmodules, or
in .git/config. That's very nice and certainly correct for "git commit
-a", but it's less clear if one explicitely stages an updated
submodule using git add. Git commit will ignore it anyway, if
ignore=all is configured in .gitmodules. Maybe that's correct too, I'm
not sure about that, but it's inconvenient in our use case, especially
combined with the lack of --ignore-submodule parameter to git commit,
as git status and git diff have.

We use submodules in such a way that normally we don't ever want to
see changes in them in output of git diff and git status. So we set
ignore=all in .gitmodules for each submodule. But occasionally, we
need to add a new submodule, and sometimes also commit changed
submodule. This got harder with Git 1.8, we have to "git config
submodule.<name>.ignore none" before the commit, and "git config
--unset ..." after.

I'd like to at least add an --ignore-submodules parameter to git
commit. I though about posting a patch, but as I looked into the
commit source file, I didn't see any straightforward way to implement
it. I don't have enough free time for a deeper analysis of the
sources, I'm sorry.

So please, let me first know, whether you could possibly accept such
patch, and if so, then I'd really appreciate some hints on how to do
it.

And also, I'd like to know git folks' opinion on whether it's OK that
git commit with ignore=all in .gitmodules ignores submodules even when
they are explicitely staged with git add.

Thanks in advance for any reply,
Ronald Weiss
