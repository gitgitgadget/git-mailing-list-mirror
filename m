From: "Josh England" <jjengla@sandia.gov>
Subject: Re: metastore
Date: Mon, 17 Sep 2007 13:46:36 -0600
Message-ID: <1190058396.6094.39.camel@beauty>
References: <Pine.LNX.4.64.0709151507310.28586@racer.site>
 <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org>
 <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
 <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161054380.5298@iabervon.org>
 <Pine.LNX.4.64.0709161346150.24221@asgard.lang.hm>
 <Pine.LNX.4.64.0709161715090.5298@iabervon.org>
 <Pine.LNX.4.64.0709161507130.24221@asgard.lang.hm>
 <20070917133000.GD16773@lapse.madduck.net>
 <Pine.LNX.4.64.0709171011160.1558@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "martin f krafft" <madduck@madduck.net>, git@vger.kernel.org,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	"Francis Moreau" <francis.moro@gmail.com>,
	"Nicolas Vilz" <niv@iaglans.de>,
	"David =?ISO-8859-1?Q?H=E4rdeman?=" <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Sep 17 21:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXMXc-0002LO-5y
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 21:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbXIQTpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 15:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755551AbXIQTpK
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 15:45:10 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:4163 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbXIQTpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 15:45:08 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Mon, 17 Sep 2007 13:44:59 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8HJiw90028126;
 Mon, 17 Sep 2007 13:44:58 -0600
In-Reply-To: <Pine.LNX.4.64.0709171011160.1558@asgard.lang.hm>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.17.122524
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_900_999
 0, __CP_MEDIA_BODY 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070917194459; SEV=2.2.2; DFV=B2007091715;
 IFV=2.0.4,4.0-9; AIF=B2007091715; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230362E34364545443933422E303037353A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007091715_5.02.0125_4.0-9
X-WSS-ID: 6AF006B13HO2618701-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58472>

I'd like to point out the following two posts, as I think they are
relevant to this thread:

[PATCH] example hook script to save/restore file permissions/ownership
http://marc.info/?l=git&m=118953004817642&w=2

[PATCH] post_merge hook, related documentation, and tests
http://marc.info/?l=git&m=118953004730496&w=2

The hook script above runs in a pre-commit hook to write out file
metadata to a file in the repository.  It can then be run from the
post-merge hook (patch above) to restore permissions.  Running it from a
post-checkout hook may be more appropriate, but post-merge seems to work
well for my purposes.  The script handles merge conflicts and (in my
testing) does the right thing.  I'm using it now to track metadata for
not just /etc, but an entire linux image.

It will handle merge conflicts by recognizing that the metadata file had
a conflict, and will direct the user to resolve the conflict and reset
working dir perms before allowing a commit.

-JE
