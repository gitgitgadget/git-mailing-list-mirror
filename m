From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 17:08:27 -0500
Message-ID: <20110427220748.GA19578@elie>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se>
 <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net>
 <7vwrif5q93.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:08:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFCuW-0001oM-Gt
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 00:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab1D0WIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 18:08:35 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55848 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab1D0WIe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 18:08:34 -0400
Received: by iyb14 with SMTP id 14so1729241iyb.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mFUjDafQDDtPOsFfCcXtyUnKGorEw32GZ09GRtrBWCk=;
        b=IjAzUeq3u3/QIgsYVN+h3g4++uSIgqOxFoBrWKZYvQigHI5m5+fAAA+2GWvbLQieQ3
         4nOlCg+/8nDz7ObzT227WjNX8YVLXxB/thUGvp/fJVkAbtQjhCnB4yuhYCBG3+odbcmZ
         3JdHntm21QWHBXqXCSpE5eHyTLPjIHCgDTK1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DJw6KjmNpQuTMzkyel34xrlls8xLvhv+bvnsntQ9S1tOPxvDz21HV6oqBESJQwjdlu
         1ZX7qDYPfkfkaomP0hLkZ6eam7IPnGVL/GPeu6D76LNjUADdaQzuQ8rLCQjERvaxx1PP
         4fymr7VdkZSL+3LOjwn92WIqC3sxeGHwcVeJA=
Received: by 10.42.150.66 with SMTP id z2mr3294244icv.462.1303942114023;
        Wed, 27 Apr 2011 15:08:34 -0700 (PDT)
Received: from elie (adsl-69-209-61-200.dsl.chcgil.ameritech.net [69.209.61.200])
        by mx.google.com with ESMTPS id f28sm451965ibh.50.2011.04.27.15.08.31
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 15:08:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrif5q93.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172280>

Junio C Hamano wrote:

> For example, on my primary development box, I do not have any git
> installed from distribution, but I do have git on my $PATH.  For such
> users, "make install" should be able to find out that the right place to
> install git-work.1 is in $HOME/some/where/man/man1 directory.

Sorry to be dense, but: isn't the right place to install git-work.1
one of

	/usr/local/share/man
	/usr/share/man
	/opt/man
	$HOME/man
	$prefix/man

depending on where the git-work binary was installed?  In the $prefix
case, the same snippet in .profile that adds $prefix/bin to the $PATH
would also say

	MANPATH=$prefix/man:$(manpath)

Or is the idea to blindly install (a symlink to) git-work to $(git
--exec-path)/ rather than a place on the $PATH?  In this case, I would
be a little worried.  How will the helper deal with uninstallation and
with namespace conflicts?  (On the $PATH, these are expected problems
and I'd expect each user has some way of dealing with them already.)
