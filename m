From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Is it possible to use git as a remote file storage without making 
	any local repos?
Date: Wed, 28 Oct 2009 14:33:34 -0400
Message-ID: <32541b130910281133nf79e03fy208b7f9fdb86bd05@mail.gmail.com>
References: <8496f91a0910280509p49447d6egd7c07b382657c375@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: matvejchikov@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 28 19:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3DLO-0003t7-Bk
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbZJ1Sdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbZJ1Sdv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:33:51 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:47134 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZJ1Sdv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:33:51 -0400
Received: by ywh40 with SMTP id 40so918855ywh.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=AEz5ncL4gAblsfr3qSV7r1Lw9sg7J8CFW03+xn8I5Rk=;
        b=CZ3kQIGO6sxe9PrbPh1JIWQL/ibY48KDJvugHOibAWAz7Mbi6c/GJwtFxJ/wZlFqJ0
         cKJ3UxBNs3cljJ0Sw2uSMbfk1iQh8aI+HepoH6B4Q9VetBMCtmdZU38ORpt9kGXxzJH4
         AmnyNf8FImzVyz7iqzfSt8VIDIyv1R/EoCnZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YlJ2aAGrxPNKB3ycqTf5WVM+3IrsPGO41LclD66ibnddWMRzdkq5uE0R6ASJWxcuu9
         jlLqDOVGY+HW1q25p1mcC7C4AZMdHsWYtZAbQ5wpEBCb7sJe1Xs7Gx4Ix6yBYqCeZLTj
         Lnn8oTGUUpnF1dHxmvVwvdTYoDuhxVu77L3uI=
Received: by 10.150.15.25 with SMTP id 25mr7251582ybo.276.1256754834075; Wed, 
	28 Oct 2009 11:33:54 -0700 (PDT)
In-Reply-To: <8496f91a0910280509p49447d6egd7c07b382657c375@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131494>

On Wed, Oct 28, 2009 at 8:09 AM, Matvejchikov Ilya
<matvejchikov@gmail.com> wrote:
> I have a remote storage server with a git-daemon running and I want to
> be able to put some data in that repo
> in a way like 'git hash-object -w <object>'. The general problem for
> me is that I don't want to create any local
> git repositories that is needed by 'pit push ...' etc.
>
> So, is it possible to use git for remote storage purposes without
> making local repository?

This functionality isn't built into git (and it might be considered a
security hole, strictly speaking, if a repository let you download any
object by default).  However, it would be pretty easy to create your
own server that does this.

For example, you could make one CGI script that dumps its POST data
into a pipe to "git hash-object --stdin -w"

I've written a service similar to this at work.  It's relatively
simple to do a basic version. Of course, as you get into more
complicated situations (what about multiple users updating the same
filename?  merges?  authentication?) it gets more complicated.  But I
think everybody would want this for a different reason, so it's
unlikely that there'll ever be a single "standard" solution.

Have fun,

Avery
