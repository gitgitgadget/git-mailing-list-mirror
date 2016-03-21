From: Jeff King <peff@peff.net>
Subject: Re: When does git check for branch-X being uptodate with
 origin/branch-X?
Date: Mon, 21 Mar 2016 16:28:10 -0400
Message-ID: <20160321202810.GD32071@sigill.intra.peff.net>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:28:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6R1-0002WY-Jd
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525AbcCUU2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:28:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:35525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753736AbcCUU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:28:13 -0400
Received: (qmail 6488 invoked by uid 102); 21 Mar 2016 20:28:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 16:28:13 -0400
Received: (qmail 9174 invoked by uid 107); 21 Mar 2016 20:28:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 16:28:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2016 16:28:10 -0400
Content-Disposition: inline
In-Reply-To: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289455>

On Mon, Mar 21, 2016 at 08:21:46PM +0000, Thomas Adam wrote:

> Something I've seen a few times of late (although I doubt that's any
> indication that the code has changed in Git) is the reporting of
> branch-X being uptodate with origin/branch-X when it isn't.
> 
> When does git check to see if branch-X has a remote tracking branch
> and that it has changes on it?  Only, the output below is misleading:
> 
> % git checkout master
> Switched to branch 'master'
> Your branch is up-to-date with 'fvwmorg/master'.
> 
> [fvwm-cvs-to-git/docs]{10345}[0][master] % git pull
> remote: Counting objects: 26, done.
> remote: Compressing objects: 100% (12/12), done.
> remote: Total 26 (delta 18), reused 22 (delta 14), pack-reused 0
> Unpacking objects: 100% (26/26), done.
> From github.com:fvwmorg/fvwm
>    c029868..36cc898  master     -> fvwmorg/master
>    4f0c7ec..36cc898  ta/git-docs -> fvwmorg/ta/git-docs
> Updating c029868..36cc898
> Fast-forward
> [...]
> 
> Clearly, it's obvious that "Your branch is up-to-date with
> 'fvwmorg/master'." is misleading.  Note that in this case, there's no
> passwords or other hindrances to Git being able to work out that a
> branch is behind another.

The message from checking is looking only at your local
refs/remotes/fvwmorg/master branch, which is essentially a cache of what
is in the actual remote repository.

We never contact other repositories unless explicitly asked to by
fetch, pull, push, etc. If you want to have the most up-to-date value
without merging, you can just "git fetch" to update the tracking
branches.

-Peff
