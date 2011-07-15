From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 12:15:31 -0400
Message-ID: <1310746531.19224.32.camel@drew-northup.unet.maine.edu>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
	 <20110714183710.GA26820@sigill.intra.peff.net>
	 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
	 <20110714190844.GA26918@sigill.intra.peff.net>
	 <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
	 <20110714200144.GE26918@sigill.intra.peff.net>
	 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
	 <20110714203141.GA28548@sigill.intra.peff.net>
	 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
	 <m3fwm7aox1.fsf@localhost.localdomain>
	 <CANfMb_-ZxGGzpKDnhG46HK+DZ1UN+_kxccKuSrZtO41N0EFy6Q@mail.gmail.com>
	 <CANfMb_-cfAWBECGcUqQA3JCObRF+dSsx_Z2iCigYeKMdh7J7Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Geert Bosch <bosch@adacore.com>
To: "Long, Martin" <martin@longhome.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 15 18:18:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhl61-0006vs-DV
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 18:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab1GOQS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 12:18:28 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:39347 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1GOQS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 12:18:28 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p6FGFahr019279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 15 Jul 2011 12:15:41 -0400
In-Reply-To: <CANfMb_-cfAWBECGcUqQA3JCObRF+dSsx_Z2iCigYeKMdh7J7Zg@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-URT-Metrics: basalt.its.maine.edu 1060; Body=7 Fuz1=7 Fuz2=7
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p6FGFahr019279
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1311351382.35531@tsOo14xMvnTyy0zQ1d9LMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177202>


On Fri, 2011-07-15 at 16:33 +0100, Long, Martin wrote:
> >
> > Firstly, I presume the generation number would not form part of the
> > SHA1 calculation? No? Cool.
> 
> I suspect this may be where my suggestion falls down. Though I suspect
> there is a case for object metadata which doesn't form part of the
> SHA. Would generation number tampering be a concern?

If you take Jeff's perspective on the purpose of generation numbers
(representing metadata about the DAG in a more readily-available format)
then "tampering" is not really a concern as the metadata is merely local
(to the running instance of Git) ephemera that we can cache between runs
for the sake of efficiency. Linus' perspective on generation numbers
seems to be of a more hard and fast type of data.

So, are we really talking about [corpus] generation numbers (used to
describe the state of the DAG in the way one describes his known family
tree) or are we talking about _revision_numbers_ (used to describe the
commit, as Subversion does)? I think we've got two (or more) groups
talking about different things (and aims) and trying to use the same
words to do so.

> Caching offers the ability to store that metadata, to provide the same
> performance gain, but maintain the integrity of the SHA chain.
> However, it does still leave the generation number liable to
> tampering, meaning a generic non-SHA metadata solution might be
> better.

I'm not sure where you are going with this. I wouldn't think "tampering"
with _current_DAG-based ephemera would do much other than create a
performance hit. If you are really talking about a static
_revision_number_ then that belongs in the commit, where it cannot be
changed (and may be completely meaningless when taken out of context, as
SVN revision numbers are). What such a number may entail is probably up
for discussion, but perhaps in a different thread.

> TBH, there are few situations where historical generations are useful
> - finding gen numbers of tags is one of them. Most cases are going to
> be for new commits, and in that case, a few new commits at the tip of
> each branch will very quickly reduce the number of traversals. What
> use case would really create enough traversals that it should be a
> performance concern?

The answer to this is found in a previous thread
http://article.gmane.org/gmane.comp.version-control.git/176807

(remember, generation number vs. revision number...)

Also, please don't cull the CC list! (Added Geert Bosch)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
