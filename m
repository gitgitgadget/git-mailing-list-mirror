From: "Steve French" <smfrench@gmail.com>
Subject: Re: kernel.org git tree corrupt?
Date: Sun, 2 Mar 2008 21:43:39 -0600
Message-ID: <524f69650803021943i33ce6ddbo309f118cd0a77ac9@mail.gmail.com>
References: <524f69650803020749o469f2e48l125a55267b0b5d13@mail.gmail.com>
	 <alpine.LFD.1.00.0803021302070.17889@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>
To: git@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 04:44:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW1bA-0006Ky-22
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 04:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbYCCDnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 22:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756559AbYCCDnm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 22:43:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:36546 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656AbYCCDnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 22:43:41 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3225748nfb.21
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 19:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=985cvshtIM2v3gNzQdy20OCPsYCX1XIwcz20aXwe37g=;
        b=W0x4fsvM2YhanathMZOYXix0EGbxyACkKShr3tAz1bRtSdAb6JMRdt/G2dixghM5Y1C4fBUcV0mJIwNMieBcnfTVyVpNuDpXajJ4OLpsd9k921TWfjPb6/HmvOfAP656Y8WBH/bljrak2f3HYNuN+3x/CYk3mHF/UlNmlJCIKGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YppswvagIaHAhYE/QbKRwjO9V34/scIIvwzlWnh/nwGzXdLtHQNcSDxoMHo8cu4lAXy4sT2ek2JOzlwdydQPDq/MzFfhLcPjNWmHcGZ2+0oLMEbgq67P0v8zR33qchj1Y3D4XiSZ6zL28aAe+WmLKhAt6bL4W8DcWcRpXCwQoFc=
Received: by 10.78.176.20 with SMTP id y20mr17372975hue.1.1204515819956;
        Sun, 02 Mar 2008 19:43:39 -0800 (PST)
Received: by 10.78.172.19 with HTTP; Sun, 2 Mar 2008 19:43:39 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0803021302070.17889@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75880>

On Sun, Mar 2, 2008 at 3:16 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  On Sun, 2 Mar 2008, Steve French wrote:
>  >
>  > In preparation for a merge request I do
>  >     cg-diff -m -r origin: | diffstat -p1
>  > (git diff -m -r origin: shows the same problem) and
>  >     cg-log -m -r origin:
>
>  First off, you really should lay off the cogito thing
no problem

>   - look at your .git/config file to make sure that the remote branches are
>    sane. It should have something like this (and if it doesn't, add it):
>
>         [remote "origin"]
>                 url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>                 fetch = +refs/heads/*:refs/remotes/origin/*
>
>         [branch "master"]
>                 remote = origin
>                 merge = refs/heads/master
.git/config now includes

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = /pub/scm/linux/kernel/git/torvalds/linux-2.6.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master


>   - look at your "origin" branch, and make sure it's a *remote* branch, not
>    the old-style local one. Ie it should *not* show up when you do a
>    plain
>
>         git branch
now only shows "* master"

>    but it *should* show up (as both "origin/HEAD" and "origin/master")
>    when you do
>
>         git branch -a
Now "git branch -a" shows
* master
  origin/master

It is missing "origin/HEAD"
>   - now do "git log origin" an it should show something recent
git log origin and git log origin/master both return
"ambiguous argument 'origin': unknown revision"

I must be misunderstanding the syntax/manpage of git-log but "git diff
-m -r origin/master"
now works fine and displays exactly what I expect so things have improved.



>  Now your setup should be ok again. I *suspect* that what has happened is
>  that you got a local "origin" branch - probably through cogito - that hid
>  the remote one.
This seems plausible and


-- 
Thanks,

Steve
