From: Jim Garrison <jim.garrison@nwea.org>
Subject: git svn clone reprocessing old commits many times?
Date: Wed, 30 Oct 2013 18:47:10 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E273041FD4F8F@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 19:47:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbane-0002kr-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 19:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab3J3SrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 14:47:22 -0400
Received: from gwo2.mbox.net ([165.212.64.22]:34434 "EHLO gwo2.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3J3SrW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 14:47:22 -0400
Received: from gwo2.mbox.net (localhost [127.0.0.1])
	by gwo2.mbox.net (Postfix) with ESMTP id 3d8zDT1QcjzfsTSC
	for <git@vger.kernel.org>; Wed, 30 Oct 2013 18:47:21 +0000 (UTC)
X-USANET-Received: from gwo2.mbox.net [127.0.0.1] by gwo2.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 566RJdsvq6496Mo2; Wed, 30 Oct 2013 18:47:16 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB6.EXCHPROD.USA.NET [165.212.120.254] by gwo2.mbox.net via smtad (C8.MAIN.3.93K) 
	with ESMTPS id XID181RJdsvR9047Xo2; Wed, 30 Oct 2013 18:47:16 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB6.EXCHPROD.USA.NET
X-USANET-MsgId: XID181RJdsvR9047Xo2
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.33]) by
 S1P5HUB6.EXCHPROD.USA.NET ([10.120.223.36]) with mapi id 14.03.0158.001; Wed,
 30 Oct 2013 18:47:11 +0000
Thread-Topic: git svn clone reprocessing old commits many times?
Thread-Index: Ac7Vn50kzSLr5fDsSSq/+E4Ssw+tqA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237053>

I'm trying to clone an svn repository to git in preparation for a migration to git, including all branches and tags.

The clone is taking a long time, and it looks like every time it detects a possible branch point it backs up and reprocesses a bunch of old commits.  For example:

r43224 = f308bd7765f9923143f3883a903aebf9ac70aa42 (refs/remotes/tags/etl_app_project-2.1.3@43224)
Found branch parent: (refs/remotes/tags/etl_app_project-2.1.3) f308bd7765f9923143f3883a903aebf9ac70aa42
Following parent with do_switch
Successfully followed parent
r43225 = 0beb90a63bd0abb552ac3d36c304649dc03c402f (refs/remotes/tags/etl_app_project-2.1.3)
Found possible branch point: http://svn-server:81/svn/DevJava/trunk/ETL/etl_app => http://svn-server:81/svn/DevJava/trunk/etl_app, 44876
Initializing parent: refs/remotes/trunk@44876
r1296 = 39f1370bef9b75a5848c184befa47b999d0db73a (refs/remotes/trunk@44876)
W: +empty_dir: trunk/ETL/etl_app/src
r1697 = a68b473c64a80882c7b665fb128a12dfa8e9c355 (refs/remotes/trunk@44876)
W: +empty_dir: trunk/ETL/etl_app/src/main
r1698 = e18bd0b80ed9dd398d49bff04ca9650292f2f36d (refs/remotes/trunk@44876)

I don't understand why, for each possible branch/tag, it has to go all the way back to such an old commit and start over again.

Is this normal or is something amiss?
