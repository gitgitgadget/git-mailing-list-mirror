From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Clueless bisect error message
Date: Wed, 11 Oct 2006 14:50:28 +0700
Message-ID: <fcaeb9bf0610110050h4c3a56fbge19607ff0bc094af@mail.gmail.com>
References: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com>
	 <7vpsczuxj9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 09:50:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXYrN-0000wN-KK
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 09:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWJKHua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 03:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030677AbWJKHua
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 03:50:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:50542 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030352AbWJKHu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 03:50:29 -0400
Received: by wx-out-0506.google.com with SMTP id s14so139427wxc
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 00:50:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gbk24rjiwp19j2psXQlYTCP0kS1Z/L9V6H+YNOaYSlgGle4p9Pq4nR5jh52LLvUz2YdNjc2hZAlQxWEObV8Ees5Ws+M2ioS80I0sCVQWebawWFG8mIk5BUPUfWpzye4HBxGUAvi20VPoHzDtVZlb9xrp7mMuNhr+y0oFVItUAkU=
Received: by 10.70.49.12 with SMTP id w12mr165392wxw;
        Wed, 11 Oct 2006 00:50:28 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Wed, 11 Oct 2006 00:50:28 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpsczuxj9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28699>

On 10/11/06, Junio C Hamano <junkio@cox.net> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > $ git bisect start
> > won't bisect on seeked tree
> >
> > It complained because .git/head-name contained 't' which had been
> > deleted before. git-bisect reset works. However I'd request git-bisect
> > to inform more useful messages. At first, I was completely stunned:
> > "what is a seeked tree? how can I fix that?"
>
> Interesting.  There is certainly something clueless but I am not
> sure if it is git-bisect.
>
> Other git-core tools never create $GIT_DIR/head-name unless
> bisect is in effect, and you end your bisect session by doing
> "bisect reset" (otherwise there is no easy way to get back to
> your original branch head).  How did head-name got 't' in it,
> and how was branch 't' removed?
Well, I probably removed it myself. It's one of my temporary branches
IIRC. Perhaps I forgot  to do "bisect reset".

>
> If the answer to the first question is because earlier you
> created a temporary branch 't' to run a bisect, and the answer
> to the latter is because you ended your bisect session by saying
> "git checkout -f someotherbranch && git branch -D t", then we
> should be able to fix that by removing head-name upon branch
> switching with "git checkout".
That might be the case. I used bisect on this repo a long ago. I'm not
sure what actually happened.

>
> By looking at commit 810255f, however, I suspect that fix would
> break Cogito.  The wording of the message actually comes from
> Cogito nomenclature.
Ah. I forgot to say I'm using git 1.4.2.1. My only wish is not a fix
(unless it's a trivial fix) but that bisect should explain the
situation better and guide people to fix it. I had grepped bisect man
page for "seeked tree" and was still clueless.
-- 
Duy
