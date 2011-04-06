From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Bug Report: git add
Date: Wed, 6 Apr 2011 11:22:04 +0530
Message-ID: <20110406055200.GA12547@kytes>
References: <4D9BA35E.6040204@dcook.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Darren Cook <darren@dcook.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 07:53:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Lg3-0002ZR-CQ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 07:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab1DFFxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 01:53:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61629 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab1DFFxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 01:53:03 -0400
Received: by iwn34 with SMTP id 34so1110927iwn.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 22:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RdOKL7FBuvhrHDMkESyBmY54/4Nhl23svxv3zMbQVoY=;
        b=RWdvJy5keZIv7FydZQxx1i+Wv0oeIWx3vAL3C7cd/Q4MPzdlHrCsl0Tew0/aKgNdbY
         97OplJAbeKw1Iv/FNicEpxpIP0hXOqzRDO9q5sV5lhY3albmxfSyzmttxEKO/Y3ItfTY
         1KBtcu7SVEkknn9owiffoAv7dE9JftQcBxAA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Y16UcavdWyUG3zTH+fvFD3l+njihn5JjTzGfVQobUabj6Vf+WclmYRGkFntP6mBPB/
         PPo2vsavu9D8WxWV/aiWRdch4TKvilm0tnGaEfH2946VUs8pkXzcxb16wz97tl7eoR1F
         kt4lEuz1SDAn+HeXJbWzhLmyRK1xl+pHUVdvo=
Received: by 10.42.148.194 with SMTP id s2mr970348icv.126.1302069182143;
        Tue, 05 Apr 2011 22:53:02 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id uf10sm114146icb.5.2011.04.05.22.52.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 22:53:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9BA35E.6040204@dcook.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170952>

Hi Darren,

Darren Cook writes:
> (Apologies if there is a proper place to report bugs; but I could not
> find one.)

There is no bugtracker, so this is the right place to report it.
Thanks for reporting.

> PROBLEM: "git add" adds sub-directories without checking to see if there
> is already a git repository already there.
> 
> WHY BAD: This causes files to be in two repositories (leading to a mess
> if you don't notice for a while...)
> 
> ONE SOLUTION: When adding files from a directory (except root of the
> repository, of course) look for a .git subdirectory, and complain if
> found. Allow --force to override this.

This is a good suggestion.  It already has a way to handle gitlinks
(for submodules), so this seems like a very reasonable feature.

> MORE SOPHISTICATED:
>  1. Offer to merge in all that history, followed by removing that old
> .git subdirectory.

Hm, I don't like this one -- there are too many ways to "merge" the
history, and I can't see a sane default (or even a sane subset of
defaults).

>  2. Look inside the .git subdirectory to see if the file being added is
> actually under control there. If not, no need to complain.

I don't like this one either.  Tangling up two Git repositories like
this is not a good idea -- the user should use submodules or similar.

Next steps: Me (or someone else who has the time) will post a patch
fixing this shortly.

-- Ram
