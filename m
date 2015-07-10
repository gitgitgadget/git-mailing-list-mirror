From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Merge after rename
Date: Thu, 9 Jul 2015 20:52:56 -0700
Message-ID: <CA+P7+xqzYjj6K=ws7nBN5RiMvYfQhCCZJCNvPPqBsbHkizqBng@mail.gmail.com>
References: <559EDD33.50906@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 05:53:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDPNK-0007yW-Dx
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 05:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbGJDxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 23:53:18 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35590 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbbGJDxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 23:53:16 -0400
Received: by igcqs7 with SMTP id qs7so4604005igc.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=52W2oHWDdr5HeG+GU4oTUzlUICUjk6GlGu6BriraDLs=;
        b=Am/KKtPm/H01ADnTSs+UphwXTkqIcoILeoZ9P/CEzNpBOY6I3EHMX7l0/mKtcvRJ/h
         AO0tdN2XKhYw7rw/qjYnkqd7ttNkbNOWni0nMzwnnHgsnq8ZAwcGmSpG08j5+raPGe0m
         /7Xcz/42xsup+2WZNBg3EwFVAirxYlSLQvQtccx8yFVV+q8E+/7dG+wf0CA/s4JuvJLr
         3i2fzVX8UtThISRrxg4S6PVNi5F7Yp+TMTha8B1UX5srhWUHES9fZPk+saUgZ7R0LSTW
         j6cZYWum0yP1IaU4OFCyB2I9X2/Sv3chl8Gm5uJTAvwd6pvMp8iJzT0EZvITNR8yvbP7
         JU5g==
X-Received: by 10.50.28.43 with SMTP id y11mr1080720igg.8.1436500396138; Thu,
 09 Jul 2015 20:53:16 -0700 (PDT)
Received: by 10.107.157.75 with HTTP; Thu, 9 Jul 2015 20:52:56 -0700 (PDT)
In-Reply-To: <559EDD33.50906@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273799>

On Thu, Jul 9, 2015 at 1:44 PM, Phil Susi <psusi@ubuntu.com> wrote:
> I'm trying to cherry pick an old change from an old branch onto the current
> master, and since the old change, the directory structure was altered and
> the modified files were moved.  Instead of detecting the new location of the
> file and applying the changes to it, git is re-adding the old file at the
> old location in its entirety.  How can I get it to correctly notice the
> rename and merge the changes in at the file's new location?
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi Phil,

One way is to format-patch the original commit, and run it through a
program like filterdiff, or edit the applied locations by hand. You
might also be able to use the merge subtree option.
https://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging is where I
would start.

For example, I would try something like

git cherry-pick -X subtree=path/to/strip -X subtree=path/to/add <commit>

You might also have success with

git cherry-pick --strategy=subtree

which attempts to guess. Hopefully this helps!

Regards,
Jake
