From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git p4: Use git diff-tree instead of format-patch
Date: Fri, 22 Nov 2013 18:12:45 -0500
Message-ID: <20131122231245.GA30589@padd.com>
References: <528E2467.4030900@gmail.com>
 <xmqqa9gx4jv6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Crestez Dan Leonard <cdleonard@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 23 00:23:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk03v-0006uU-7R
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 00:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab3KVXWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 18:22:55 -0500
Received: from honk.padd.com ([74.3.171.149]:50799 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755786Ab3KVXWy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 18:22:54 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2013 18:22:54 EST
Received: from arf.padd.com (unknown [50.105.7.175])
	by honk.padd.com (Postfix) with ESMTPSA id 278577095;
	Fri, 22 Nov 2013 15:12:48 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8F7BC208D7; Fri, 22 Nov 2013 18:12:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqa9gx4jv6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238221>

gitster@pobox.com wrote on Thu, 21 Nov 2013 11:47 -0800:
> Crestez Dan Leonard <cdleonard@gmail.com> writes:
> 
> > The output of git format-patch can vary with user preferences. In
> > particular setting diff.noprefix will break the "git apply" that
> > is done as part of "git p4 submit".
> >
> > Signed-off-by: Crestez Dan Leonard <cdleonard@gmail.com>
> > ---
> >  git-p4.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-p4.py b/git-p4.py
> > index 31e71ff..fe988ce 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -1308,7 +1308,7 @@ class P4Submit(Command, P4UserMap):
> >              else:
> >                  die("unknown modifier %s for %s" % (modifier, path))
> >  
> > -        diffcmd = "git format-patch -k --stdout \"%s^\"..\"%s\"" % (id, id)
> > +        diffcmd = "git diff-tree -p \"%s\"" % (id)
> >          patchcmd = diffcmd + " | git apply "
> >          tryPatchCmd = patchcmd + "--check -"
> >          applyPatchCmd = patchcmd + "--check --apply -"
> 
> I do not do p4 myself, but from a cursory reading it looks like the
> right thing to do.  Thanks.
> 
> The output of "git shortlog --no-merges --since=1.year git-p4.py"
> tells me that Pete should be the person much more familiar with the
> code than myself, so I'll Cc him just in case...

This looks great, and passes all my tests.

Acked-by: Pete Wyckoff <pw@padd.com>

Thanks,

		-- Pete
