From: "Josh England" <jjengla@sandia.gov>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 15:26:51 -0600
Message-ID: <1187990811.6357.232.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
 <85ir75h2zb.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
 <86mywhfk17.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org>
 <1187979317.6357.155.camel@beauty>
 <alpine.LFD.0.999.0708241119140.25853@woody.linux-foundation.org>
 <1187981803.6357.173.camel@beauty>
 <7vfy28d5yl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 23:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOgfL-0006PN-Iu
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 23:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757085AbXHXV0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 17:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756999AbXHXV0A
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 17:26:00 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:1191 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921AbXHXVZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 17:25:59 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 24 Aug 2007 15:25:52 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [134.253.112.134] (sacv8030ee.sandia.gov
 [134.253.112.134]) by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id
 l7OLPoCc031884; Fri, 24 Aug 2007 15:25:51 -0600
In-Reply-To: <7vfy28d5yl.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.24.135622
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_800_899
 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070824212553; SEV=2.2.2; DFV=B2007082418;
 IFV=2.0.4,4.0-9; AIF=B2007082418; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230322E34364346344345302E303038363A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082418_5.02.0125_4.0-9
X-WSS-ID: 6AD1936A3HO282084-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56603>

On Fri, 2007-08-24 at 13:37 -0700, Junio C Hamano wrote:
> It would rather be more effective for the user action "I want to
> change the ownership of foo.c to root" to cause a direct
> manipulation of .gitattributes file.  For this, we can add a
> nice wrapper if there is a need, but the initial cut could be
> just running "${EDITOR-${VISUAL-vi}} .gitattributes", nothing
> more.
> 
> The user can say "git diff" to view .gitattributes changes, and
> if that is what he wants (maybe he wants to do "git add -i" to
> pick only the hunk about the ownership change for the next
> commit), the change to .gitattributes can be committed.

That sounds fine, and is certainly easier to implement.  The only catch
is that whatever wrapper is updating .gitattributes will have to walk
the working tree doing lstat() calls, which seems redundant (and costly)
to me.

-JE
