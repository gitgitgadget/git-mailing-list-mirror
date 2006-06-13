From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Wed, 14 Jun 2006 10:55:06 +1200
Message-ID: <46a038f90606131555m7b1fa744g9770140c87598b7b@mail.gmail.com>
References: <87irn5ovn6.fsf@rho.meyering.net>
	 <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>
	 <1150224411.20536.79.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Jim Meyering" <jim@meyering.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Yann Dirson" <ydirson@altern.org>, "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 00:55:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqHn0-0001ru-6B
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 00:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWFMWzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFMWzJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 18:55:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:50456 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750919AbWFMWzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 18:55:07 -0400
Received: by wr-out-0506.google.com with SMTP id i20so1472141wra
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 15:55:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nblbH9Nam7qdMW8DNvKWcMkel3BPboq5lhP7ArkqMly/JWBRhUTDuyXgCCzqohj6inOBFc0wad0VzXtLIG+Vvn/GB+Xtoi44znngQI/+fEYyGdbWkknUg4zdwfjKiQUS2S0RnMgh4FTW7XlInMaC5IuLPwQkOF/W2ysMD8zrFJI=
Received: by 10.54.128.1 with SMTP id a1mr12699wrd;
        Tue, 13 Jun 2006 15:55:06 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Tue, 13 Jun 2006 15:55:06 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1150224411.20536.79.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21817>

On 6/14/06, Keith Packard <keithp@keithp.com> wrote:
> cvs rlog is designed to 'represent' the history of the repository to
> users. Cvsps was built as a software analysis tool, and is used by
> putative software engineering researchers. Basing a supposedly lossless
> repository conversion system on this pair seems foolish to me,
> notwithstanding the heroic efforts to make it work.

Yes, cvsps is relying on the wrong things. I am looking at parsecvs
and the cvs2svn tool and wondering where to from here.

In terms of history parsing, parsecvs and cvs2svn are similar. I like
cvs2svn "many passes" approach better, though the Python source is
really messy. A good thing about cvs2svn is that it is a lot more
conservative WRT memory use.

So far, I have been relying on parsecvs for initial imports, and for
cvsps+git-cvsimport for incrementals on top of that initial import.
But parsecvs falls over with large repos.

I am starting to look at what I can do with cvs2svn to get the import
into git. It seems to get very good patchsets, and it yields an easily
readable DB. I'll either learn Python, or read the DB from Perl
(probably from git-cvsimport).

The main problem, however, is that it doesn't do incremental imports,
so this would be a roundabout way of fixing parsecvs's
memory-bound-ness. We still need cvsps :(


martin
