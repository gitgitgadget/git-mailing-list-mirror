From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn and migration
Date: Wed, 19 Dec 2007 12:54:47 -0500
Message-ID: <20071219175447.GB15898@dervierte>
References: <320075ff0712190849u2c40cc46pf01fa2a75f557482@mail.gmail.com> <320075ff0712190850r35263bcfv1d8f84e699208e15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 18:55:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J538S-00088A-Jg
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 18:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbXLSRyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 12:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbXLSRyu
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 12:54:50 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:10593 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbXLSRyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 12:54:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4851650wah.23
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=Vp1uE0HXaCrANQ8ZX0ZOB7Ife4HK8qt7/d8Amv0pT2A=;
        b=fMRRVUz899uKBGcZVPaTDWmJBNGoT7PiVSGEKRyRtSNz30PRfgY4bWBk/Scewm1ZgwIK7bQq+mXfMkioazHDdsaY5OIEHgajjQlactqrJK/IJkCreyevHW6tozKsGvWi7avcG4TQMgEwpQ5F5NmB6gEhF1oytvC1QWCCDBkqXCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=XeCTcpX8q3MhJcaou63XSSLbbcivQqGsYut8AlR07SeE9yApYN7qPpacangjRhB0yRbJYYYnUqIEu+XPVckZ6zzr5U9LwuTOk5pMcKNrn7dNe23i3Te1jQhQPfawQNzrTYJoBlGqpqbV3iugssVUaUXi8M5kg/if/shQQWQtPSE=
Received: by 10.140.133.10 with SMTP id g10mr2708876rvd.151.1198086888912;
        Wed, 19 Dec 2007 09:54:48 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 9sm20030707wrl.2007.12.19.09.54.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2007 09:54:47 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 2B1EBDF7B25; Wed, 19 Dec 2007 12:54:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <320075ff0712190850r35263bcfv1d8f84e699208e15@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68926>

On Wed, Dec 19, 2007 at 04:50:30PM +0000, Nigel Magnay wrote:
> Has anyone got any tips as I'm sure it's a path trodden before? I've
> seen examples of keeping a read-only svn, but that's not really what
> I'm after. I'm considering whether to have a central git repo
> regularly pull from svn so that it's up to date, and having us
> possibly push to svn (or git if it's not merged to trunk) as an
> interim step..

Using a central git repo that is kept uptodate with svn is the approach
I've used.  git-svn isn't especially keen on this mode of operation,
however.  After every fetch, you have to reset refs/remotes/trunk to
origin/master, which it turn puts .git/svn out of date (you can blow it
away and run "git svn fetch" to regenerate it).

I wrote a script that automates most of this stuff (including doing
incremental additions to git-svn's revdb/revmap).  If there's interest,
I can see about cleaning it up for general consumption.
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
