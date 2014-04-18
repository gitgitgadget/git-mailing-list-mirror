From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] Update SVN.pm
Date: Fri, 18 Apr 2014 08:48:17 +0200
Organization: <)><
Message-ID: <20140418064817.GB19647@camelia.ucw.cz>
References: <20140416141605.GA9692@camelia.ucw.cz> <xmqq61m9gka6.fsf@gitster.dls.corp.google.com> <20140417052438.GA13907@camelia.ucw.cz> <xmqqwqenety2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Belinsky <belinsky.roman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 18 08:48:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb2b3-0006y4-HP
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 08:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbaDRGsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 02:48:21 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51292 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaDRGsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 02:48:19 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 3FAC51C00A2;
	Fri, 18 Apr 2014 08:48:18 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3I6mHaW019724;
	Fri, 18 Apr 2014 08:48:17 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3I6mHd8019723;
	Fri, 18 Apr 2014 08:48:17 +0200
Mail-Followup-To: git@vger.kernel.org,
	Roman Belinsky <belinsky.roman@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqqwqenety2.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246463>

Hello,

cc'ing Roman, the original author.  (I should have done that
in the first post, sorry.  I have also forwarded him another
mail from this thread, asking him for author's sign off.)

On Thu, Apr 17, 2014 at 10:39:49AM -0700, Junio C Hamano wrote:
> Stepan Kasal <kasal@ucw.cz> writes:
> 
> > On Wed, Apr 16, 2014 at 12:13:21PM -0700, Junio C Hamano wrote:
> >> Interesting.  What other strange forms can they record in their
> >> repositories, I have to wonder.  Can they do
> >>     2014-01-07T5:8:6.048176Z
> >> for example?
> >
> > Roman Belinsky, the author of this fix, witnessed after large scale
> > conversion that the problem happens with the hour part only.
> 
> Is this "large scale conversion" done from a SVN repository that is
> created by bog standard SVN, or something else?

I don't know.  Roman?

> How certain are we that this "hour part is broken" is the only kind
> of breakage in timestamps we would encouter?

I would say we can be certain, as Roman said that the same PC
that inserts the timestamp with one-digit hours does not misformat
minutes.  (Still cited from the same discussion
https://github.com/msysgit/git/pull/126#discussion_r9661916 )

We do not have code review for that bug, as far as I know, but this
is a natural bug:  a reasonably looking time "5:08:09.048176" is
used in format "%sT%s"

> [...] and by being slightly more lenient than necessary to cover
> one observed case that triggered the patch, we can cover SVN
> repositories broken in a similar but slightly different way.

I second that, in general.
But my guess is that this particular "similar but slightly
different" breakage will never appear, so the self-documenting
original fix wins for me.

> Especially given that this regexp matching is not used for finding a
> timestamp from random places [...]

I agree that the broader regexp is not dangerous in this context.  So
it seems to be no big issue either way.

Thanks for taking this so carefully,
	Stepan
