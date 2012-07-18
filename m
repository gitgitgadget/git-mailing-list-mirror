From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Find .pm files automatically (was Re: Fix git-svn tests for SVN
 1.7.5.)
Date: Tue, 17 Jul 2012 18:41:09 -0700
Message-ID: <50061435.1090900@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005EFC5.8060105@pobox.com> <20120718000120.GG25325@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 03:41:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrJGy-0005YT-Ot
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 03:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906Ab2GRBlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 21:41:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab2GRBlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 21:41:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47D729885;
	Tue, 17 Jul 2012 21:41:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=RO0uPmFxajL9
	6qlZZiQ7QxRy++E=; b=l2ruo+KtM2I9dh7xPcpudbW4HJZrTEgUN5OPHddxrnEV
	z2k6/uDyJNgONT+RVmpEo9nM6e2H+WtKsgAxMqpWlJDGBkTOSixl6MIv/nv1oUYH
	2j43w29rUMw0eS5Lwgxht3QjjbsH5CPa/T3YsbfjglHDBYr+PdKAQEvqqt6ifKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N8UHH6
	SDvoAHu0voYF10LttTuUdgup4D556XUZo7TrWYthLdjtQkdgBvouXbJj5gLBxr54
	26X5KS1PxmlqAmBqNhsHpRGbgnOApUY+ddkpnGfXVtkTuty9N3qwn2cr8mC4Pf9+
	V3Esn7JvL7IXemQ28tHYRaoXSwYV2xn8624rw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34DF39884;
	Tue, 17 Jul 2012 21:41:09 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 439309883; Tue, 17 Jul
 2012 21:41:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120718000120.GG25325@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: A5BD74FA-D079-11E1-8A83-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201642>

On 2012.7.17 5:01 PM, Jonathan Nieder wrote:
>> It also moves Error.pm into a bundle directory.  This both makes it just
>> another directory to scan (or not scan), but it also makes it possible to
>> bundle additional modules in the future.  ExtUtils::MakeMaker uses this
>> technique itself.
> 
> This is not so much "also" as "as an example to demonstrate the
> technique", no?  I guess I'd prefer it to be in a separate patch, but
> this way's fine, too.

I wrote the MakeMaker system so I was just cribbing off that.  It made more
sense to build a list of directories to scan and then scan them than to add
individual file exceptions later.  I could put it in a separate patch, but it
would require some bending.


> You'll probably hate this.  Because we have a bunch of patches to
> incorporate, I think it's worth spending the time to make that go as
> smoothly as possible for later patches.

Sorry.  I have lots of experience with git but very little with the email
submission tools.  I've always either just done everything via repositories or
used Github.

It sounds like I should figure out the git-send-email tool and do this very
slowly.


> The word "bundles/" left me a little nervous, because I (ignorantly)
> imagined that this might be some specialized facility like Python eggs
> or Ruby gems.

Nope, just copy .pm files in.


> Is the intent that this directory contains CPAN modules
> we want to be able to depend on?

Yes.


> Is there really any intention of having more of them than Error.pm?

No idea, this is my first look at the code, but now it's possible.  In my
experience, if there's a barrier to using CPAN modules then people won't use
them.  They'll rewrite the functionality poorly.


> Before this patch, in the default case (with MakeMaker), "make
> install" wrote a manpage in <mandir>/man3/private-Error.3pm.  Does it
> still do so after the patch?  Will people who have installation
> scripts that expected that manpage have to change them, and if so, is
> the new behavior better to make up for that effort?

The man page is now man3/bundles::Error::Error.3 which is equally as incorrect
as man3/private-Error.3.  It is possible to correct that so it's man3/Error.3,
but that's going to require some effort.  Basically its in the same boat as
PM.  Once you have to change one you have to change them all.

Why do install scripts have specific code to look for that man page?

If it's going to be trouble I can put Error.pm back.  It's just something I
did in passing.


>> +# Don't forget to update the perl/Makefile, too.
>> +# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
> 
> Now the reader will have no reason to be looking at this file, so
> these comments are pretty much useless.  In an ideal world, "make
> test" in the MakeMaker build would automatically "grep perl/Makefile"
> to catch modules that are not listed there, but that can wait, I
> imagine.
> 
> Alternatively, maybe there could be a perl/modules.list that both
> makefiles read?  That way, if I drop in an unrelated .pm file for
> reference while coding the build system would not be confused by
> it, and since both build systems would use the same module list
> there would be no risk of it falling out of date.

Ideally, that second Makefile would go away.  Parallel build systems are extra
work and generate bugs.

The log suggests it might have something to do with people wanting to build
with an ActiveState Perl on Cygwin or something?  MakeMaker builds different
Makefiles depending on the OS, so it may be as simple as telling Makefile.PL
what flavor of make you're using.


-- 
emacs -- THAT'S NO EDITOR... IT'S AN OPERATING SYSTEM!
