From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Date: Fri, 3 Jun 2011 00:35:24 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D2D2913@dbde02.ent.ti.com>
References: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
 <7voc2hh3t5.fsf@alter.siamese.dyndns.org>
 <B85A65D85D7EB246BE421B3FB0FBB593024D2D22DE@dbde02.ent.ti.com>
 <20110601191623.GA9836@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:05:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSDDF-000527-3G
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 21:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab1FBTFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 15:05:40 -0400
Received: from comal.ext.ti.com ([198.47.26.152]:47164 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab1FBTFj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 15:05:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p52J5Ri0029857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jun 2011 14:05:30 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p52J5P3h016425;
	Fri, 3 Jun 2011 00:35:25 +0530 (IST)
Received: from dbde02.ent.ti.com ([172.24.170.145]) by dbde70.ent.ti.com
 ([172.24.170.148]) with mapi; Fri, 3 Jun 2011 00:35:25 +0530
Thread-Topic: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Thread-Index: AcwgkX4AGWzzwWH8ShS1XxuTJDKj+AAwySSQ
In-Reply-To: <20110601191623.GA9836@elie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174970>

Hi Jonathan,

On Thu, Jun 02, 2011 at 00:53:57, Jonathan Nieder wrote:
> Nori, Sekhar wrote:
> > On Wed, Jun 01, 2011 at 22:44:30, Junio C Hamano wrote:
> 
> >> Also if it doesn't have to be a conscious act, what value does such a
> >> boilerplate have? Such a project may be better off not using sign-off at
> >> all to begin with.
> >
> > Its hard to argue against this. All I would say is it is probably
> > much safer to enable sign off by default when accepting a patch
> > than when preparing to send it. Yet, we have format.signoff but
> > no am.signoff. On any project with conscious sign-off rules, one
> > would never accept a patch without a sign-off from the original
> > developer.
> 
> In that case, just the first sign-off should be enough and there is no
> need to record the later ones, no?

Well, it is required to keep track of who was in the upstream
path. This way all relevant folks can be contacted in case
the patch introduces a problem.

> 
> In practice, with format.signoff hopefully people read the patches
> they are sending out before mailing them.  It is very easy to remove
> the sign-off in an MUA or by editing patch files before running
> "git send-email" if it was inappropriate.  On the contrary, importing
> patches en masse with "git am" is a common operation and I suspect
> looking over the new history in detail before a "git push" is rare, so
> the possibility of someone forgetting that an "[am] signOff" variable
> is in effect is much more dangerous.
> 
> That said, I am all for giving people rope as long as there is some
> legitimate use case documented to explain how not to hang themselves.
> Could you say more about the example that motivated this?  What
> benefit would this provide to motivate not using "git am -3sc" (which
> contains the -s on the commandline as a reminder)?

Okay, here is the issue that prompted me to work on this:

http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-May/022832.html

I think this option is useful for maintainers who usually do not
apply patches en-masse, but accept patches after review and want to
pass along to other upstream maintainers after adding their sign-off.

Granted you can always rely on -s option to be added, but people do
forget (like I did).

> > So, just making it easier to accept patches which are already
> > signed-off should be okay, I guess?
> 
> A related idea seems interesting: would a --check-sign-off option that
> prevents applying a patch unless the last sign-off matches the email
> sender be useful?  Unfortunately individual people sometimes use
> different addresses for the From and Signed-off-by lines in some
> projects (like git and the Linux kernel) so I don't think I'd use such
> a thing but in a more controlled environment I can imagine it might be
> nice.

If you received any patch with a sign-off, I think it is usually
safe to attach your own sign-off since then the origin of the
patch is already certified by someone else (you would be adding
your sign-off under Developer's Certificate of Origin 1.1 section
(c))

Thanks,
Sekhar
