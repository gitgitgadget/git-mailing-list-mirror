From: Jim Garrison <jim.garrison@nwea.org>
Subject: git svn clone with funky tags layout
Date: Tue, 5 Nov 2013 17:16:53 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E273041FD78E9@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 05 18:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdkFe-0007ke-62
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 18:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab3KERRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 12:17:09 -0500
Received: from gwo4.mbox.net ([165.212.64.24]:54778 "EHLO gwo4.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab3KERRH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Nov 2013 12:17:07 -0500
Received: from gwo4.mbox.net (localhost [127.0.0.1])
	by gwo4.mbox.net (Postfix) with ESMTP id 3dDcxZ1KmXzfjPXZ
	for <git@vger.kernel.org>; Tue,  5 Nov 2013 17:17:06 +0000 (UTC)
X-USANET-Received: from gwo4.mbox.net [127.0.0.1] by gwo4.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 554RkeRRa6656Mo4; Tue, 05 Nov 2013 17:17:00 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB4.EXCHPROD.USA.NET [165.212.120.254] by gwo4.mbox.net via smtad (C8.MAIN.3.93K) 
	with ESMTPS id XID837RkeRRa8941Xo4; Tue, 05 Nov 2013 17:17:00 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB4.EXCHPROD.USA.NET
X-USANET-MsgId: XID837RkeRRa8941Xo4
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.33]) by
 S1P5HUB4.EXCHPROD.USA.NET ([::1]) with mapi id 14.03.0158.001; Tue, 5 Nov
 2013 17:16:54 +0000
Thread-Topic: git svn clone with funky tags layout
Thread-Index: Ac7aSbEaPVaus6tlQN2Avx9V6f4W7w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237332>

I'm doing a one-time migration of an svn project.  For historical reasons our repo layout is weird:

    trunk/reporting/reporting_app

    tags/something_else
    ....
    tags/reporting_app-2.3.45
    tags/reporting_app-2.4.46
    tags/reporting_app-2.4.0
    tags/reporting_app-2.4.1
    ....
    tags/more_stuff

I want to migrate the trunk plus only the 2.4.* tags.  I tried giving a wildcard in the config

[svn-remote "svn"]
        noMetadata = 1
        url = http://subversion.tld.com/svn/DevJava
        fetch = trunk/Reporting/reporting_app:refs/remotes/trunk
        tags = tags/reporting_app-2.4.*:refs/remotes/tags/*

but this does not work:

    Invalid pattern in 'tags/reporting_app-2.4.*': reporting_app-2.4.*

On the off chance that it might work I also tried

            tags = tags/reporting_app-2.4.*:refs/remotes/tags/reporting_app-2.4.*

but that produces the same error message.

Is there a way to accomplish this or should I just move the tags I want to import into a separate directory in subversion first?  I'd rather not disturb svn but can do that if it's the only way.
