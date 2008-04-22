From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 01:13:48 +0800
Message-ID: <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804220659j66dea3fehc2a9bdcdc0371025@mail.gmail.com>
	 <200804221655.11914.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:15:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoM5V-0005WW-54
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762471AbYDVRNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762408AbYDVRNx
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:13:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:57087 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762027AbYDVRNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:13:50 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1296017wra.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=t5Vuhqs1shjZ8Cl2uxU8zCp+QTE5jahAFwpP8HTSxz8=;
        b=GidjmPxpJKW1kn0BkgL9o/ImMKZwCYmZ9fXRgUH17/qoam4qFquUeWi1cnLGMckqm5TddVJIYTP+p5q8hCrLWqImTp2ADrkPHxOL9AV0EAgkkVWWwOTQKFvwmGNAdjFGRP7gMG+qvh+vsnVXVh+R7x1KM/BXz/juirVVBSwYWD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bC+xg/6GxDZpdSycT7xCp7xhumGg62p5u8/SDdga9WB21PPWBtkdxXbdkvJpW8QfBmC+ZWwQ4rfVDRRZUXspGO6Wdnm6y9tGSF2cDBypokUowviohiqc48Z9JpkdiYK1KhRLC3Al7KJOVZB+38qKPY25iWuiIgGJtp/bvq9DTZU=
Received: by 10.100.205.9 with SMTP id c9mr783461ang.51.1208884428264;
        Tue, 22 Apr 2008 10:13:48 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 10:13:48 -0700 (PDT)
In-Reply-To: <200804221655.11914.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80144>

On Tue, Apr 22, 2008 at 10:55 PM, Josef Weidendorfer
<Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 22 April 2008, Ping Yin wrote:
>  > On Tue, Apr 22, 2008 at 6:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> > >  It does not help motivating me reviewing the series that the overall tone
>  > >  of it is to ignore .git/config more and make .gitmodules take more active
>  > >  role, either.  I have already said number of times why that is not a good
>  > >  idea and why it is against the overall submodule design.
>  >
>  > I summarize junio's points that says $GIT_DIR/config is authoritative.
>  >
>  > [...]
>  >
>  > Any others?
>
>  A reason you did not mention is security:
>  You never want your .git/config to be changed behind your back, which
>  effectivly is the case when using the versioned .gitmodules information
>  (similar problem as with a .gitconfig in-tree).

As discussed in another thread about in-tree .gitconfig, security
issues only arise on limited configuration entries. However, there are
no entries in .gitmodules falling into any of these entries.

>
>  Another one:
>  From a design point of view, submodule URLs are project meta information
>  unrelated to source history. So, actually, I think it was wrong to put
>  submodule URLs (even hints only) into the versioned .gitmodules files (*).

But now it actually acts as hints and we don't find a better way. I
just propose that the hints become the good default.

>
>  The main reason for .gitmodules is to store submodule information which
>  has to be in sync with commits, such as a submodule name related to some
>  path where the submodule happens to be checked out in a given commit, and
>  also related to some config entry holding the URL to allow for fetch/pull.
>  The idea is that submodules have an identity in the supermodule (in contrast
>  to files in git), such that related configuration keeps valid when moving
>  submodules around. This needs simultanous adjusting the path attribute in
>  .gitmodules when a submodule is moved.

If we go back to a old HEAD or switch to another branch with changed
path for a submodule,  what should 'git submodule update' do?
I think entries in .gitmodules should take precedence.

So url in $GIT_DIR/config is authoritative, and path in .gitmodules is
authoritative.




-- 
Ping Yin
