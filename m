From: "Pat Maddox" <pergesu@gmail.com>
Subject: Re: How do I set the committer with cherry-pick? (or is there a better way to get changes from someone?)
Date: Sat, 5 Apr 2008 17:58:33 -0700
Message-ID: <810a540e0804051758j5daea9a8vfe36396ecbb36a08@mail.gmail.com>
References: <810a540e0804051642r79dc10a7h2a231561062b13ea@mail.gmail.com>
	 <7vhcefvoeg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 02:59:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiJEH-0000Tz-Mc
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 02:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbYDFA6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 20:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYDFA6f
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 20:58:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:3969 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbYDFA6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 20:58:34 -0400
Received: by wa-out-1112.google.com with SMTP id v27so664085wah.23
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 17:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oo43mqLMy8CRSPgHznvotBV8IxDwPDPb+B5Yvu1WdVI=;
        b=wuW1b5NCA7r8P+xYyhAlbAa9C4ZlcXfgPTxQUDIgVQNyJFpQrJgzVbsXYlyUhZD30VN3e+yw55hpCNwxtGNWcZyiHK2bEJWrrExjQXm/KLWBrdBpvNW8RtRMv7MuVeXYKWQfOnzCGe53sKBlXGWYgkFoIPliW3LZQ7pn4HxO9Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U8orit+3f1oHPG536rpOyGJbgmhD8d8GDQytAcVaOJG3tmKa31DOv0Hhuw5or4HyeM4ezoKfzHbvgDLtlrCwgT8O8XUEFF9xjLkLJctB8vXjkgvctZj+xtOatRZZNzvL8xhIjLWMxVL9d3ZiQOWU9GmnyzKNqxrxB3oKse8KBsE=
Received: by 10.115.92.8 with SMTP id u8mr1209756wal.180.1207443513614;
        Sat, 05 Apr 2008 17:58:33 -0700 (PDT)
Received: by 10.114.146.5 with HTTP; Sat, 5 Apr 2008 17:58:33 -0700 (PDT)
In-Reply-To: <7vhcefvoeg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78873>

On Sat, Apr 5, 2008 at 5:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Pat Maddox" <pergesu@gmail.com> writes:
>
>  > At this point the commits are in the repo, but they only have author
>  > information.  I'd like to specify that I'm the one who committed this
>  > change now.  How can I do that?
>
>  You've already done that.  They are not what you _wrote_ so your name
>  won't be on "Author:" lines, but you made into commits in the final
>  history, and your name would appear on "Committer:" lines.
>
>  Try "log --pretty=fuller".

Ah, okay.  I see.  Thanks.


>  > And finally, is this a good way to incorporate changes from other
>  > devs?  Is there a better way?
>
>  A _better way_, especially because you are already pulling from them,
>  would be just "pull", without having to cherry-pick to clean-up the
>  history.
>
>  The reason you are being forced to cherry-pick is probably _their_
>  histories you pulled are suboptimal and full of garbage commit, containing
>  irrelevant changes you do not want to include in the mainline you
>  maintain.  Have _THEM_ clean their act and prepare clean history that
>  consists only of relevant commits.  Shift as much burden as possible to
>  the contributors; otherwise the central integrator will become the
>  bottleneck in the process.

That makes sense.  So let's say somebody made some changes of their
own that I don't want in the repository.  Would the best thing for
them to do be to create a new branch off of my main line, and then
cherry-pick their commits in themself.  Then they send me the url
along with the branch, so that when I pull from them it's only the new
commits applied to the main line.

And finally, when I experimented with doing a pull instead of
cherry-pick, it listed the original author as the committer instead of
myself.  I think you're absolutely right that the burden should be on
them, so I can tell them to create a clean commit branch and just pull
from it, but I still need to be listed as the committer.

Pat
