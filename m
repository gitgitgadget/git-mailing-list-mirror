From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Optionally parse author information
Date: Sat, 15 Jan 2011 20:57:07 -0600
Message-ID: <20110116025707.GB28452@burratino>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
 <201101120830.47016.wjl@icecavern.net>
 <20110113032300.GB9184@burratino>
 <AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com>
 <20110114080554.GA1735@kytes>
 <20110114082931.GC11343@burratino>
 <F0299861-B36C-459C-972E-856212A92615@kth.se>
 <20110114101636.GA22970@kytes>
 <AANLkTi=ddJYT8YiUDYy80xobkxJnvuREN-09=464P_vB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Love =?utf-8?Q?H=C3=B6rnquist_=C3=85strand?= <lha@kth.se>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Joe Corneli <holtzermann17@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 03:57:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeIo9-0001Ol-IS
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 03:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab1APC5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 21:57:20 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62635 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab1APC5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 21:57:19 -0500
Received: by gxk9 with SMTP id 9so1575546gxk.19
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 18:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kWuO4duYmi9e/hFzH4YLOhb5GPwyx7PQaXNurydyrLY=;
        b=rIDmcu3kQeM7MtUQ+7bWH3A6VsavOQ65Kj0yRruciv0oB5KaOIbZf+6vgWnoPhZdlc
         uiOP/0RCqYNyloFzTn4IMtoQTUJcSGiNMyF1A7LHzAkTUwPidP3OQWnI+gAFYUTtYAmi
         pA1dE+KBF9DwTpG7+KVGOqXn+5alKG+qoAixM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fyr3TMzJKBzfqjK4oD8EMpqgkgZuhEJyMWgAyaDtLxHwKOGSVSpibAUDsFzi1I0r3n
         X0FVHKFRPVbFCeLlJxO597ADZHsupxtRQ5S7ZBaLSOi0VyB4Qc85DwBOeDILj7fwO8km
         U8lNp11347oLeY6xr0UIUG2hpWbfo4n9NsUkw=
Received: by 10.151.101.12 with SMTP id d12mr3120825ybm.14.1295146639219;
        Sat, 15 Jan 2011 18:57:19 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id u10sm1351735yba.1.2011.01.15.18.57.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 18:57:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ddJYT8YiUDYy80xobkxJnvuREN-09=464P_vB@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165157>

Joe Corneli wrote:

> I tested it, and it seems to use email handle instead of author name
> (perhaps that's intentional, though in my case it's not so desirable)

Good point.  Presumably git2svn is using the local part of the email
address to mimic svn's default behavior of using one's username.

Other possibilities:

 - email address (e.g., majordomo@planetmath.org, as in most google
   repositories)
 - display name (e.g., "Joe Corneli").  I don't know if svn-related
   tools or scripts assume that svn:author doesn't contain spaces.
 - full ident string (e.g., "Joe Corneli <majordomo@planetmath.org>")
 - whatever the operator wants (mapping specified in authors file).

My guess: an "authors file" facility would be needed to cover all
cases, but whichever rule you want to implement short of that could
also be useful.

> but, quite critically, it gets the dates wrong:
> 
> ~/pmhistory.svn$ svn log -l 5
> ------------------------------------------------------------------------
> r53127 | majordomo | 2011-01-10 18:31:58 -0500 (Mon, 10 Jan 2011) | 1 line
[...]
> ~/pmhistory.git$ git log -5
> commit 411b8698e494ee12799300611fed0c8029e76ad3
> Author: milogardner <majordomo@planetmath.org>
> Date:   Thu Dec 16 14:11:57 2010 +0000

Maybe it is using the committer date (as shown by "git log --format=fuller")
and someone rebased recently.  If you don't care about svn's '{date}'
construct working (meaning out-of-order dates are ok) then author date
might be more suitable.  Presumably the important thing is for it to
be consistent.

Hope that helps,
Jonathan
