From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Wed, 11 Apr 2007 10:42:57 +0200
Message-ID: <81b0412b0704110142l377231d7j85285a87ef73ce41@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
	 <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
	 <20070411083236.GG21701@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Martin Waitz" <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:13:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbYPu-00060R-2x
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbXDKIm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXDKIm7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:42:59 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:35413 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbXDKIm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:42:58 -0400
Received: by an-out-0708.google.com with SMTP id b33so116328ana
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 01:42:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fsIpnP6uuv46zMWF5FYDEdFjXLBHnUo0C2OkYHKnHMol5kEY0saaUoAbSbfLh1oTb1VhRnrM2YVbvUiKCoogBOnx/p0miWwAW8FjxR5G3Ds3AhlrirD5dlFrwxIyngvVyjSjXvR24uKAsuR3Y8byjpStvYu+OaEi7ceVocwwqVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rg49PeoxvIw8FMOkg8vIzkoF9Xvjxzs1ztS3nWY7EVJy9p51DRzEM5OBBbTyQ/tCZ8aN21V68unsZvqxu2XAUZo/hB6QMaTB2A5pI5bLpdRNYSoN27mhQKqFbWoch/qbZWfKiK0eQ81XCWXkNAt7g8v/4xeaagLRmV8Ks/KFrVk=
Received: by 10.100.10.20 with SMTP id 20mr245339anj.1176280977242;
        Wed, 11 Apr 2007 01:42:57 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Wed, 11 Apr 2007 01:42:57 -0700 (PDT)
In-Reply-To: <20070411083236.GG21701@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44224>

On 4/11/07, Martin Waitz <tali@admingilde.org> wrote:
> > The other thing which will be missed a lot (I miss it that much)
> > is a subproject-recursive git-commit and git-status.
>
> git-status should really point out if a subproject has any changes,

Only if I want it to. HEAD change check (which is cheap enough
to be done unconditionally) can be done always.

> But for commit it really does not make any sense.  The commit in the
> submodule is totally independent to the commit in the supermodule.

Right. Perhaps not a commit in submodule but a recursive check
for working directory changes in submodules. So that you can
make that you don't make a superproject commit which cannot
be resolved to what you had in all the working directories:

  git commit -a --check-clean-subprojects
