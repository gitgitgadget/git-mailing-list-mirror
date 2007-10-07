From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 17:38:55 -0600
Message-ID: <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
	 <20071007213817.GJ31659@planck.djpig.de>
	 <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
	 <Pine.LNX.4.64.0710080018270.4174@racer.site>
	 <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com>
	 <Pine.LNX.4.64.0710080028301.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefiE-0006LU-Hh
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbXJGXi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbXJGXi4
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:38:56 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:4375 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbXJGXiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:38:55 -0400
Received: by rv-out-0910.google.com with SMTP id k20so607089rvb
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SXoxsFCm8S9mljXtp858o8Q7kQ0It4qKUEjsJc/fsEk=;
        b=fY5Qx8JdN79LGCWFFmwk1VSq7QQ97CjZbf7ACtb/mINEIk0lFXhARQX6Lyh21UW3Z+R67vz9DvCazdrfQRzPfIOf0uspDmhmxNRe9qJpQRJTdKjSvbm2q3bMeI9VXu13+kXENzvEpaVNZmZODAOmJvPgUTa0TIcYMYTaHGoKpnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jacBpzKdhPpPMkJIDQW4bDajUMgVVutbF0Ju652T5IRvi6xs4Q/eTPdY1/9Mq/rxq1J7DDA7c6fAcv6Pdg3el3meoTyK5SeI3c4s2JxVZi8gsFan9Kce2Tjiq4c7RjKyZsN2CB24tDFmi7G5ZznUxk/Y1suTuVZsufEAtg1P+aI=
Received: by 10.114.161.11 with SMTP id j11mr488343wae.1191800335212;
        Sun, 07 Oct 2007 16:38:55 -0700 (PDT)
Received: by 10.114.211.8 with HTTP; Sun, 7 Oct 2007 16:38:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710080028301.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60261>

Hi,

On 10/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 7 Oct 2007, Elijah Newren wrote:
<snip>
> > $ git clone test test2
> > <snip>
> > $ du -hs test
> > 11M     test
> > $ du -hs test2
> > 11M     test2
> >
> > Any other ideas?
>
> Yep.  Maybe it is necessary to run "git gc" in test2.

Sweet, finally solved!  That brings test2 down to 340K.

However, the solution seems somewhat involved...it requires running
git-filter-branch, git reset, removing the .git/refs/original/
directory, editing .git/packed-refs in some editor, running git reflog
expire, cloning the resulting repository, and running git gc yet
again.  It seems like there has to be an easier way.  (Anyone have
one?)

Oh, and git-filter-branch could really use some explanatory note about
how to actually complete rewriting the history.

Thanks,
Elijah
