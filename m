From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Rebasing published branches?
Date: Wed, 7 Nov 2012 09:53:00 +1100
Message-ID: <CAH5451=ur1GGS7H+U9Tk-2-smrEd7xbJsL2hQibO8JBeFGNiUg@mail.gmail.com>
References: <20121106201822.GE28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Josef Wolf <jw@raven.inka.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 23:53:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVs1W-0003PT-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 23:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab2KFWxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 17:53:22 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:39712 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab2KFWxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 17:53:21 -0500
Received: by mail-qa0-f46.google.com with SMTP id n12so96815qat.19
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 14:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=Jg6iKZNcaw++fhzWkncDUV8B4Ubu0trpwMvkwRo4iRs=;
        b=j1iqKJM5R21wfgXf5YjsZn+kYtBn0BJH3Ss+SUrr6CyTQNsdKIpmfJXEnBUJzpkCfZ
         lZ7IeuLsFSUKnVgP6wtpVf2vwdyYclnblywSsN6vY302kaqHh/2d0ItL4d0C5glgDR56
         eFVtew9rosErc7oThiCds3kCknLm2jcmo3Y2AkAPzioiNSg+u6tLgldpv5JZZQbSzl9c
         F49H44PlwWXo0hPF+brnIrLXwgZvCXA015lqN/LW1gbTL4vemWb6f0ynbine/TOM3vxZ
         34443pBkuuFdoWu2D1b0OhauypYfE6nhAl6iPOO9IosyivG7CqfuZpYy7VD9J8qoOmkV
         9M/g==
Received: by 10.49.28.231 with SMTP id e7mr4634813qeh.49.1352242400857; Tue,
 06 Nov 2012 14:53:20 -0800 (PST)
Received: by 10.49.58.225 with HTTP; Tue, 6 Nov 2012 14:53:00 -0800 (PST)
In-Reply-To: <20121106201822.GE28437@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209126>

Hi Josef,

On 7 November 2012 07:18, Josef Wolf <jw@raven.inka.de> wrote:
>
> Hello,
>
> I know, I should never rebase published branches. But...
>
> I frequently work on different computers and would like to share my private
> branches across them. When done and the feature is in a good shape, I'd like
> to rebase to clean up history before I make it available to other people.
>
> I guess rebasing such branches would be OK as long as I can reliably remember
> to delete those branches on _all_ the clones I ever created.
>
> But waht if I ever make a mistake? How would one recover from such rebase
> disasters? Anybody knows a good description how such a recover would be done?


The only real problem you should encounter is not knowing which
repository holds the 'true' feature branch, that is the one which you
want to publish.

The reason why rebasing public branches (where 'public' means somebody
_else_ is tracking your branch) is bad is that you are rewriting
somebody else's history. This can cause headache and pain for them if
they have based work off what you have already published.

In your situation, you are the only one working on these feature
branches, and you know that you plan to rebase them. There is little
risk of you rewriting someone else's history, and even if you did it
is clear that these branches were always meant to be rebased so you
should surprise anyone.

As a practical note, you'll probably find it easier to keep track of
the current state of your feature if you use one repository as your
own 'blessed' repository. After working on a clone somewhere, always
push to the blessed repository, and sync from it before you start
work. This way you will always have the correct version of your
feature branch.

If worse comes to worse (somehow) remember that rebasing does not
delete the old commits, just recreates them and points the branch at
the recreated versions. The old versions of these commits should be
available in the reflog, at least for a few weeks after the rebase.

Regards,

Andrew Ardill
