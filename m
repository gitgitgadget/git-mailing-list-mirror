From: "Josh England" <jjengla@sandia.gov>
Subject: how to access working tree from .git dir?
Date: Thu, 06 Sep 2007 17:20:00 -0600
Message-ID: <1189120800.6203.23.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:19:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITQcl-0002wI-IF
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbXIFXSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 19:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXIFXSz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:18:55 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:3198 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbXIFXSy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 19:18:54 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Thu, 06 Sep 2007 17:18:43 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l86NIhEg028453 for
 <git@vger.kernel.org>; Thu, 6 Sep 2007 17:18:43 -0600
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.6.155422
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070906231844; SEV=2.2.2; DFV=B2007090620;
 IFV=2.0.4,4.0-9; AIF=B2007090620; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230362E34364530384144342E303038303A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007090620_5.02.0125_4.0-9
X-WSS-ID: 6AFE55593HO1571342-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57945>

In messsing around with hooks, I've discovered that not all hooks are
run in the same environment.  In particular, the current working
directory in the post-receive hook (maybe others as well) is the GIT_DIR
(.git) directory, instead of the root of the working tree (as in
pre-commit).

This wouldn't be so bad, but it seems that `git rev-parse --show-cdup`
does not show anything valid if your current working directory is inside
the .git dir.  This creates a scenario where there is no consistent way
to access the root of the working tree from within a hook.  To make
things worse, the behavior changes subtly whether $GIT_DIR is defined or
not.

I've got a patch that changes the current working directory before
calling the post-receive hook, but that's more of a workaround than a
fix.  I'd like to be able to run `git rev-parse --show-cdup` from with
a .git directory and have it produce a valid result.

So:  I'm poking around around and trying to find the right answer but
some things look weird.  If anyone knows the quick-and-easy answer here
please let me know.  Otherwise, I'll continue to poke around some more.

Thanks,

-JE
