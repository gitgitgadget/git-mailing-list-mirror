From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Tue, 25 Sep 2007 10:41:13 -0600
Message-ID: <1190738473.6078.102.camel@beauty>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
 <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
 <1190654052.6078.14.camel@beauty>
 <7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
 <1190662396.6078.63.camel@beauty>
 <7vejgnai1z.fsf@gitster.siamese.dyndns.org>
 <1190671558.6078.87.camel@beauty>
 <7vfy138vql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 18:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaDRW-0000xh-LW
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 18:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbXIYQjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 12:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbXIYQjT
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 12:39:19 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:4918 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbXIYQjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 12:39:17 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 25 Sep 2007 10:39:05 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8PGd4H5000703;
 Tue, 25 Sep 2007 10:39:04 -0600
In-Reply-To: <7vfy138vql.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.25.91730
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070925163906; SEV=2.2.2; DFV=B2007092511;
 IFV=2.0.4,4.0-9; AIF=B2007092511; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230312E34364639333941392E303036303A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092511_5.02.0125_4.0-9
X-WSS-ID: 6AE7E6233HO3387021-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59147>

On Mon, 2007-09-24 at 16:54 -0700, Junio C Hamano wrote:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> > On Mon, 2007-09-24 at 14:07 -0700, Junio C Hamano wrote:
> > ...
> >> If you want to spacial case 
> >> 
> >>         $ git checkout otherbranch path.c
> >> 
> >> it raises another issue.  Which commit should supply the
> >> "extended attribute description" for path.c?  Should it be taken
> >> from the current commit (aka HEAD), otherbranch, or the index?
> >
> > This already is a special case and your question is valid but not one
> > that git should necessary care about.  Since extended attributes are not
> > built into git the only way to handle them is through hooks.  A such, it
> > is up to the hook to worry about these kinds of issues.
> 
> The fear I have is that that kind of thinking would necessitate
> your hook to be called after the user edits paths.c in any other
> way not to confuse users.
> 
> What I am questioning is where we should stop, in order to keep
> things simpler to explain, and I happen to think that it is far
> easier if we can teach that "git checkout other path.c" is
> equivalent to "git cat-file blob other:path.c >path.c" followed
> by "git add path.c", than saying "checkout is magical and if you
> have external hook it can do far more than editing the file
> yourself to arrive at the same contents".
> 
> But I am obviously not the one who is interested in tracking
> extended attributes attached to git contents, and I do not feel
> too strongly about one way or the other.  I am Ok with it if you
> think "checkout is magical" is easier to teach [*1*].
> 
> I just wanted to make sure we know what semantics this is
> bringing in, and get it clearly documented.  That's all.

OK.  I'll try to come up with some good wording for the documentation.

So this leads to my next question:  Should the post-merge patch be
brought in under this same umbrella to form a single post-checkout hook,
or should it stay a separate hook?

-JE
