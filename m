From: Deskin Miller <deskinm@umich.edu>
Subject: [ANNOUNCE] git-svn-bugfix script (Re: [PATCH] git-svn: Make
	following parents atomic)
Date: Sun, 7 Dec 2008 11:10:39 -0500
Message-ID: <20081207161039.GA21319@euler>
References: <1228665970-21204-1-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 17:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9MEp-0004jE-Hl
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 17:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbYLGQKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 11:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbYLGQKu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 11:10:50 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:57752 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbYLGQKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 11:10:49 -0500
Received: by yx-out-2324.google.com with SMTP id 8so323107yxm.1
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=gYY4l+tre5CkMVgH2TayuH1jsDklc47n3fuR80wReBs=;
        b=g9PfD+cdnmthYG4Tu8m2xf+0wL8LGls8mFdoygo6Ix+nSbs3HxniKUnzwZTIQ8fPIF
         Quz6hsrZboCmJUzFckBMhNxMY+QZJtOsiBw3qcPh/4otnQTIUFNLxTrukCQ9qSBO0GfK
         aN5ytcC83pgtc8Y454bF4s8gnVTQzHOjWvy9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=NmA1f3HVRZH3VoMiJo3btfp39NkVN+JfUhVZ0ulYsIJ+e5LS+IdesQfU31mJ9DH+dj
         WTy6SUUqhvW1KTEncDeTLHUQ2RIa+Qt0GbGz93LovXdpYKqO67A7qHPSe1SSyl2ter4y
         EhGAQq9FXR6hmpuOnzURbKk7rPb2sUpPMNeuI=
Received: by 10.65.225.17 with SMTP id c17mr1953982qbr.71.1228666247133;
        Sun, 07 Dec 2008 08:10:47 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id k27sm8122857qba.22.2008.12.07.08.10.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Dec 2008 08:10:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1228665970-21204-1-git-send-email-deskinm@umich.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102500>

git-svn has some bugs where it won't create identical commits in
different git-svn copies of the same svn history, despite all relevant
configuration being identical; oftentimes, the copies will diverge from
each other at some point.  My theory for a long time was that
interrupting git svn fetch could cause this, and it turns out I was
right in one case, but since it's not something I could easily interrupt
my normal workflow with to do forensics when it occurred, I ended up
writing a script to repeatedly fetch from a certain svn repository, and
compare refs to a supposedly pristine fetch until the refs diverged or
one fetched all the svn history; then, rinse and repeat the process from
the beginning.  It's available at

git://git.deskinm.fdns.net/git-svn-bugfix.git

Using this script, r3924 of SVN's svn repository flagged one bug
repeatedly, for which I've posted a patch.  I'm posting the repo because
there are other places where history diverges that I've not had a chance
to debug yet, so others should feel free to use the script to find and
fix them.  If anyone feels inclined, I'll gladly take patches to the
script, but I don't really care to handle data or bug reports you
generate with it (at least not at this point); I can generate plenty of
data myself.

Deskin Miller
