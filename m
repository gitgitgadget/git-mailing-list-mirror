From: "Luiz Fernando N. Capitulino" <lcapitulino@gmail.com>
Subject: Re: [ANNOUNCE]: PyGit and libgit-thin
Date: Wed, 25 Jul 2007 17:55:51 -0300
Message-ID: <e28f90730707251355vc1fc47ftc7851324ddfad771@mail.gmail.com>
References: <e28f90730707230535q33658efevf665d795cf1df87c@mail.gmail.com>
	 <20070725195010.GA30277@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:56:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDntv-0001GJ-8K
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758333AbXGYUzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759580AbXGYUzy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:55:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:31618 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758333AbXGYUzx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:55:53 -0400
Received: by nz-out-0506.google.com with SMTP id s18so285202nze
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 13:55:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BtIS2qn1b3J7Mle2AWMRkJwbL7Y37Uax0eGP/qs2Rv3X/1lORqAlyn4pNF5MSH4XYNz9/yr33Su7ONxvD6UZrt2zoQjiF4wPPDlnXv8tLDbhztdM++XUwnlG95FLTumQ5NL1NtFUzWmBBKQKepSjAa8uaxQ4xqM9I8vQidbB9KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=okrGETpVaHIXzKIomV+fmC0PIKPCaKF6HfO/gbbMQzQtHdniWVoeoVkaszWHeKIfNhLXCVBpX+/LXyBAbZPhR+tYlwBWUuA3Lpp8pi5HZtjmLB3h1sH5dQ+yUF8pRtc5saG4ZBbRgT+lN9Pfyn6mhTm+H5iXptYbaD6fTrpxunI=
Received: by 10.114.177.1 with SMTP id z1mr1039074wae.1185396951534;
        Wed, 25 Jul 2007 13:55:51 -0700 (PDT)
Received: by 10.114.103.17 with HTTP; Wed, 25 Jul 2007 13:55:51 -0700 (PDT)
In-Reply-To: <20070725195010.GA30277@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53720>

Hi Yann,

On 7/25/07, Yann Dirson <ydirson@altern.org> wrote:
> On Mon, Jul 23, 2007 at 09:35:47AM -0300, Luiz Fernando N. Capitulino wrote:
> > Now I need to know whether this' really useful to other people and
> > if so, what would be missing for you to start using it.
>
> The python module would really be useful to StGIT.  Currently, an
> stgit commands typically has to fork several git commands at least,
> and using library calls instead would surely help with the
> performance.

 Cool.

> I had a quick look at the current pygit API (as described in the
> README), and I find the current revlist one somewhat confusing.  Why
> using post-contructor methods, and not using named args in the
> constructor itself ?
>
> That is, the example reading:
>
> >>> rv = repo.revlist()
> >>> rv.include('8d9107e8c50e1c4ff43c91c8841805833f3ecfb9')
> >>> rv.count = 10
> >>> rv.show_merges()
> >>> for commit in rv:
> ...  print commit.id()
> ...
>
>
> would be IMHO much nicer to use as:
>
> >>> rv = repo.revlist(include=('8d9107e8c50e1c4ff43c91c8841805833f3ecfb9'),
> ...                   count = 10,
> ...                   show_merges = true)
> ...
> >>> for commit in rv:
> ...  print commit.id()
> ...
>
>
> What do you think ?

 I think you're right, that'd be nicer.

 The problem is that the revlist operation accepts a lot of options,
and to change
all (or a big amount of them) would force one to build a very length list of
arguments.

 Currently we have just a few, but we'll add more in the future.

 Also, I think that it won't be that nice to play with include() and exclude(),
since you can call them more than once.

 I'm not sure whether in its current state the module (plus the library) is
useful for stgit.

 Please, feel to make questions and to ask for what'd be missing for you
to adopt it.

 I'm a quilt user and completely forgot that stgit is written in python. I'll
take a look.

 Thanks for your comments,

-- 
Luiz Fernando N. Capitulino
