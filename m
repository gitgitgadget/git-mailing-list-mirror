From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: git-check-ref-format returns 1 for valid branch names
Date: Thu, 22 Mar 2007 22:58:07 +0100
Message-ID: <dbfc82860703221458j690d1cafve01174eda8f149ee@mail.gmail.com>
References: <dbfc82860703221324k48690833g6731ef75562839d6@mail.gmail.com>
	 <7vejnht3x2.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0703221358420.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 22:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUVIT-00030W-9W
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 22:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbXCVV6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 17:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbXCVV6J
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 17:58:09 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:22478 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161123AbXCVV6I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 17:58:08 -0400
Received: by an-out-0708.google.com with SMTP id b33so1062758ana
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 14:58:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LpXMMOfN7beIhzfxWy1CSVhRssswobVgdU/kMycWyuv+IVRin//jrxRcknlXdGdb6HLz2UAtjikV5XeOcrCkXrsDYmT7qZ3dJEWQAbs4yOWO7JRhKaGgJmukDZXcQibZ+1/IeNsGgOYO39r5LU0hSv+Nnyint7gD+MLbzLnM/kA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BiMacg+jofTK9X7DtiHB5A916FTGMHUx39+1qjiwDukAHhRqI6DbSvjygA1AQzXfSeLnZjkHDFIPOq6Bu+PcTjh4IedpDirB3Rxc+tme6O1xckbCnZcRgIZTcQlAUdXwpu+swPuB4itmzI9Z5xrEs3sgLInv7hC2UKl2Ymel9q0=
Received: by 10.114.130.1 with SMTP id c1mr793348wad.1174600687072;
        Thu, 22 Mar 2007 14:58:07 -0700 (PDT)
Received: by 10.114.193.4 with HTTP; Thu, 22 Mar 2007 14:58:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0703221358420.6730@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 4b994b2acce3ce8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42884>

On 3/22/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 22 Mar 2007, Junio C Hamano wrote:
>
> > "Nikolai Weibull" <now@bitwi.se> writes:
> >
> > > I'm obviously doing something wrong, but in git 1.5.0.4
> > >
> > > % git check-ref-format abc
> > > % echo $?
> > > 1
> > >
> > > What am I missing here?
> >
> > If you are trying to see if abc is a valid branch name, try refs/heads/abc.
>
> .. and before anybody wonders why it wants the "fully qualified" name,
> it's because "abc" on its own is ambiguous. Is it a _tag_ called "abc", or
> a branch, or what? That explains why - if you really want to verify a
> ref-name, you need to give the full name..
>
> On the other hand, if you don't care, and you just want "is this a valid
> commit name", use
>
>         sha1=$(git rev-parse --verify "$name"^0) || exit

Thanks for the clarification.

What I was after was a way to verify that a name is a valid new name
of a branch, for the Zsh completion definition in the context of
git-checkout -b <new_branch>. [1]  After posting I realized that
perhaps checking out the sources for git-checkout would enlighten me,
which it did, as it uses git-check-ref-format "heads/$newbranch" to
verify that the new branch's name  is valid.

[1] It's not really going to try to complete anything here, but verify
that the new branch's name is valid while the user types it in. [2]
[2]  Hm, perhaps completing existing branch-names makes more sense,
allowing the user to create a new branch-name based on an old one.
