From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit PATCH] Remove most ASSERT warnings in Git::setStatus
Date: Sun, 20 May 2007 16:23:29 +0200
Message-ID: <e5bfff550705200723i7b4e21ebi6a2c51d66659b388@mail.gmail.com>
References: <200705201401.35991.barra_cuda@katamail.com>
	 <e5bfff550705200553q757c334el7aa5aed393052616@mail.gmail.com>
	 <200705201558.53546.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Michael <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun May 20 16:23:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpmK9-0005zf-Ud
	for gcvg-git@gmane.org; Sun, 20 May 2007 16:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbXETOXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 10:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755475AbXETOXb
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 10:23:31 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:16961 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbXETOXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 10:23:30 -0400
Received: by nz-out-0506.google.com with SMTP id z3so62041nzf
        for <git@vger.kernel.org>; Sun, 20 May 2007 07:23:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QKJQHq1t+yYuZxPRAJyeEpEvgJCoT9T9NnGyM6Ev6rGrtIZkpWXvlGuC2HnDZJl081TM9ooC9XEqxN+1DvrL29mxkAkhu2cnKuGBRG52SaXSjBRlEY/ilyW6I7Ms+XQ8PuwWkYCsGGs7GwrVkmabp+P2igQF28zQQlQjWu1sRkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P8zr5WI8i3cq3/pNzub0gZZWzayVNA+Jjuku0rs2udM10HSH3bORvBVk+P02RwdrfOuv3jQUqHDzOGOiTG/izCmAC1xf28ot9qHVldHqMxdZfFbxHGbgVjp7Yim+Ph8fVi1vEW+u7vQnCeN8NNUWW8vjDQThVQwz4YR6ydpKNBg=
Received: by 10.114.201.1 with SMTP id y1mr2028521waf.1179671009621;
        Sun, 20 May 2007 07:23:29 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 07:23:29 -0700 (PDT)
In-Reply-To: <200705201558.53546.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47840>

On 5/20/07, Michael <barra_cuda@katamail.com> wrote:
> "Marco Costalba" <mcostalba@gmail.com>:
> > On 5/20/07, Michael <barra_cuda@katamail.com> wrote:
> > > Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> > > ---
> > >
> > > ...is this correct?
> > >
> > >  src/git_startup.cpp |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/src/git_startup.cpp b/src/git_startup.cpp
> > > index a99edba..17312f9 100644
> > > --- a/src/git_startup.cpp
> > > +++ b/src/git_startup.cpp
> > > @@ -329,7 +329,7 @@ void Git::parseDiffFormatLine(RevFile& rf, SCRef line, int parNum) {
> > >
> > >                 // TODO rename/copy is not supported for combined merges
> > >                 appendFileName(rf, line.section('\t', -1));
> > > -               setStatus(rf, line.section(' ', 6, 6).left(1));
> > > +               setStatus(rf, line.section('\t', -2, -2).right(1));
> > >                 rf.mergeParent.append(parNum);
> > >         } else { // faster parsing in normal case
> > >

>From diff-format.txt we have that an output line is formatted this way:

------------------------------------------------
in-place edit  :100644 100644 bcd1234... 0123456... M file0
copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
create         :000000 100644 0000000... 1234567... A file4
delete         :100644 000000 1234567... 0000000... D file5
unmerged       :000000 000000 0000000... 0000000... U file6
------------------------------------------------

That is, from the left to the right:

. a colon.
. mode for "src"; 000000 if creation or unmerged.
. a space.
. mode for "dst"; 000000 if deletion or unmerged.
. a space.
. sha1 for "src"; 0\{40\} if creation or unmerged.
. a space.
. sha1 for "dst"; 0\{40\} if creation, unmerged or "look at work tree".
. a space.
. status, followed by optional "score" number.
. a tab or a NUL when '-z' option is used.
. path for "src"
. a tab or a NUL when '-z' option is used; only exists for C or R.
. path for "dst"; only exists for C or R.
. an LF or a NUL when '-z' option is used, to terminate the record.

So I rather would prefer something like

  line.section('\t', 0, 0).section(' ', -1, -1).left(1)

because we could have more then one file separated by a tab, so

 line.section('\t', -2, -2).right(1)

it seems to me a little bit fragile. What do you think?

Also I don't understand why you consider the right most (right(1)),
instead of the left most character as the status.


Thanks
Marco
