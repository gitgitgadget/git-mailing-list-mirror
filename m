From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/5] Allow push and fetch urls to be different
Date: Tue,  9 Jun 2009 18:01:33 +0200
Message-ID: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME3ls-00008m-0T
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbZFIQBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbZFIQBk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:01:40 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57331 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962AbZFIQBk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 12:01:40 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 6D50835BCEC;
	Tue,  9 Jun 2009 12:01:39 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 09 Jun 2009 12:01:39 -0400
X-Sasl-enc: xd2m9U2yjeGBQgspwB+wPR1nFbW153pz0j2W5BQOU1ck 1244563298
Received: from localhost (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9CB5B2F07F;
	Tue,  9 Jun 2009 12:01:38 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.278.gb6431.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121180>

This series implements a new config setting remote.${remotename}.pushurl
which allows the urls for fetch and push to be different. 

In http://permalink.gmane.org/gmane.comp.version-control.git/120726 the
feature was suggested, and an initital WIP/RFC was discussed. The patch
1/5 contains exactly that version amended with documentation.

If there is no pushurl then all values of remote.${remotename}.url are
used for pushes just like before. Otherwise, all values of
remote.${remotename}.pushurl are used for pushes. In any case, the
first value of remote.${remotename}.url is used for fetches.

1/5 implements the config setting, makes push obey it and documents it.
2/5 adds tests for the new setting.
3/5 updates the api doc.
4/5 makes "remote show ${remotename}" show the new push URLs, and makes
clear which ones are used for fetch and which ones for push.
5/5 brings the output of "remote -v" more in line with the output of the
above (it was out of sync even before 4/5).

1 through 3 apply on yesterday's next.

4 through 5 require tomorrow's next ;) More specifically, 4 requires
'builtin-remote: Make "remote show" display all urls' which I suggested
for applying to maint in 
http://permalink.gmane.org/gmane.comp.version-control.git/120924
because I think the current output is incomplete.
If that patch is not considered for separate inclusion in maint or
master I would suggest squashing it together with 4/5 of the above.

Michael J Gruber (5):
  Allow push and fetch urls to be different
  t5516: Check pushurl config setting
  technical/api-remote: Describe new struct remote member pushurl
  builtin-remote: Show push urls as well
  builtin-remote: Make "remote -v" display push urls
