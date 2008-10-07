From: astubbs <antony.stubbs@gmail.com>
Subject: git-svn reuses https connections? connection drops
Date: Tue, 7 Oct 2008 14:24:23 -0700 (PDT)
Message-ID: <1223414663924-1304824.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 23:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnK3v-00006X-RI
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 23:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbYJGVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756095AbYJGVYZ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:24:25 -0400
Received: from kuber.nabble.com ([216.139.236.158]:44507 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbYJGVYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:24:24 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KnK2Z-0006wv-U0
	for git@vger.kernel.org; Tue, 07 Oct 2008 14:24:23 -0700
X-Nabble-From: antony.stubbs@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97745>


I have a many many file commit that i'm trying to dcommit.
It runs, for about 2 minutes, and then the server just suddenly stops
responding.

looking at the traffic with ethereal, it seems that there is *a lot* of tls
handshaking going on.
perhaps the server's security is dropping the connections for 10 seconds or
something because there are too many connection requests?

Does git-svn actually re-use the connection? It doesn't appear to. Unfort
i'm not up to scratch so I haven't been able to figure that out for myself.

this is what i get:
astubbs@ASTUBBS-PC /c/workspaces/gizmo2/gizmo
$ git svn dcommit --rmdir
Committing to https://cccc.xxxx.sss.com/svn/sdfsdfsdf/smurfs/trunk ...
Authentication realm: <https://svn.xxxssad.com:443> Subversion repository
Password for 'sdfsfd':
RA layer request failed: PROPFIND request failed on
'/svn/sdfsdf/sdfsdf/trunk/core/wicket-1.3.4-portal-2.0/jdk-1.4/wicket/src/main/java
/org/apache/wicket/util/parse/metapattern': PROPFIND of
'/svn/sdfsdfsdf/sdfsdf/trunk/core/wicket-1.3.4-portal-2.0/jdk-1.4/wicket/src/main/
java/org/apache/wicket/util/parse/metapattern': could not connect to server
(https://svn.sc.componence.com) at C:/msysgit/bin/git-svn line 3
385

this happens every time, but not at exactly the same file every time.

the commit contains upwards of 2,000 file adds.

-- 
View this message in context: http://n2.nabble.com/git-svn-reuses-https-connections--connection-drops-tp1304824p1304824.html
Sent from the git mailing list archive at Nabble.com.
