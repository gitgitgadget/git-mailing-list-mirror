From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 2/4] Abstract a PatchSet object out of Series.
Date: Thu, 14 Jun 2007 23:56:47 +0100
Message-ID: <b0943d9e0706141556w1fb280dbu12e55dc91f6d5941@mail.gmail.com>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
	 <20070611003330.4736.69293.stgit@gandelf.nowhere.earth>
	 <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com>
	 <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 00:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyyFH-0001Zu-E0
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 00:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbXFNW4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 18:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXFNW4u
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 18:56:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:12178 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbXFNW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 18:56:49 -0400
Received: by wr-out-0506.google.com with SMTP id 76so650393wra
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 15:56:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s+5Y0FxW3LaIfEkUyqMWknOaLGjrRd8er5uAMJaj3lBM1E5Uq6o0UyDU94S7OEFf4VCuSrlTYaRSIw+hu3JfmavdJNTISsAA5cC8c+r8m5Mr4lpa0y9BuK28tzJcGxv+I8dgMyXnVkE7Ze/jKZfh6TCpuQqjJKvARs4X4ZNDsKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MSXXb5a6IDBqfMJ9BKOJzT0HhltrZ5OKrUkKTghonWdyNWGvEGW4j0IFyzdDtyB957lAQvqyrCPHv6HVhC92taVk40YUfWfTMQPMN4bOz4haAsU/Jaagnb8vfiTMIxE4xo4g9OzLl6JflNVVXuSrYYRHQbOrVpkK4OjkjSGGQRo=
Received: by 10.78.178.5 with SMTP id a5mr990220huf.1181861807573;
        Thu, 14 Jun 2007 15:56:47 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Thu, 14 Jun 2007 15:56:47 -0700 (PDT)
In-Reply-To: <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50224>

On 13/06/07, Yann Dirson <ydirson@altern.org> wrote:
> I have started to work on a Hydra class (available at [1], but be
> aware it doesn't do much more than creating an octopus, and breaking
> many current StGIT assumptions), with a testcase to demonstrate its
> use), which binds together a set of stacks with an octopus, to allow
> keeping related patches together, and allow people to pull from one
> topic stack without getting unrelated work.

If it works, it would be really useful. Do the stacks need to be
independent? I can group my patches easily (and I was thinking about
"collapse/expand" commands for better viewing) but one stack might
still depend on patches from a different one. It would be nice if one
could also set the base of a series in this kind of hydra structure
(unless it makes it difficult to understand).

> > The HEAD in my repository fails the test suite. Do you have any
> > additional patches pending (some patches were not applied in order as
> > I had to manually fix the conflicts). Anyway, please check my
> > repository for any missing patches.
>
> Oh, I had not noticed you had applied
> bd69feaf7c3c94b6e7e216ea8091064af9cdfa97.  Sorry, I was not explicit
> enough when posing this, only the cover mail included "RFC" in the
> subject.

OK, they were left as unread in my inbox and thought they were new.

> As described in that mail, there are problems both with the
> original approach (Karl's test failing), and with that new one (that
> exisiting test failing).
>
> Do you have any idea on how we could overcome the problem ?  In the
> meantime, we could possibly just comment that testcase out (or add
> support for continuing the testsuite even with a failure) - the
> problem it exhibits is probably less common than the one that was
> fixed.

I am happy with only 2 modes - one using ORIG_HEAD for people using
StGIT in combination with plain GIT and the other overriding the base
without checks. The second mode is for people not mixing StGIT with
plain GIT. For the first mode, they have to deal with conflicts as
with the standard GIT.

> BTW, a02ba4077f12578fe31c99d903488804a656e1c4 has a slight problem: it
> is a patch by Karl, which I re-sent in the same group since it was
> exhibiting the problem (and with the intent of adding a signed-off-by
> line, but my way of adding them trough a buggy template showed its
> limits and the commit now have 2 signed-off-by lines with Karl's
> name).  However, it was applied with myself as author, which is quite
> wrong: could that be a but in "stg import" ignoring the Author field ?

It's not a bug. The import command just uses the e-mail sender or a
"From:" line before the patch description (see the default mail
template). It doesn't check the sign lines (it is following the kernel
patch submission guidelines).

I would drop both the above commits for release 0.13. Are you OK with this?

-- 
Catalin
