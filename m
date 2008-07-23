From: Pierre Habouzit <madcoder@debian.org>
Subject: Resubmit after a night of sleep
Date: Wed, 23 Jul 2008 12:15:31 +0200
Message-ID: <1216808133-31919-1-git-send-email-madcoder@debian.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 12:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbOf-0001Ja-3k
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbYGWKPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 06:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYGWKPg
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:15:36 -0400
Received: from pan.madism.org ([88.191.52.104]:54296 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbYGWKPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:15:36 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 038303A59A;
	Wed, 23 Jul 2008 12:15:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6B3A71426D2; Wed, 23 Jul 2008 12:15:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.153.ge8bf3
In-Reply-To: <1216774940-4955-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89623>

Okay, so after a (too short) night sleep, here is a way better series.
The first patch corrects a real bug, and should be applied to maint.
It's a one liner, the comment is self explanatory.

The second one is a twofold UI improvement wrt error messages that
git-checkout (if we abstract the issues from patch 1) already caught as
errors but with dreadful errors. And with respect to the case where
there is no '--' and that there is an ambiguity. We used to always favor
the interpretation where the first argument is understood as a
path (which is really horrible because it's the destructive choice: at
least if we favored the reference, user would never loose local
modifications), it now barfs.

I reckon I've not checked what git-checkout did when it wasn't a
builtin, so I don't know if the second part of this UI improvement comes
as fixing a regression (in which case the patch could be considered for
maint) or if it's an ambiguity that was here like forever, in which case
it's less urgent, but should IMHO be addressed because git-checkout is
porcelain: see http://gist.github.com/1402 for the user issue that made
me discover that, you'll see we want a desambiguation one way or the
other.
