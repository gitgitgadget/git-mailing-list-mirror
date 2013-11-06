From: Jim Garrison <jim.garrison@nwea.org>
Subject: RE: git svn clone with funky tags layout
Date: Wed, 6 Nov 2013 17:05:11 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E273041FD80AD@S1P5DAG3C.EXCHPROD.USA.NET>
References: <0C723FEB5B4E5642B25B451BA57E273041FD78E9@S1P5DAG3C.EXCHPROD.USA.NET>
 <527A4C0C.7090400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 06 18:05:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve6Xq-0000g5-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 18:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab3KFRF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 12:05:26 -0500
Received: from gwo5.mbox.net ([165.212.64.23]:54943 "EHLO gwo5.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011Ab3KFRF0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Nov 2013 12:05:26 -0500
Received: from gwo5.mbox.net (localhost [127.0.0.1])
	by gwo5.mbox.net (Postfix) with ESMTP id 3dFDdd2BFFzg1ZWv;
	Wed,  6 Nov 2013 17:05:25 +0000 (UTC)
X-USANET-Received: from gwo5.mbox.net [127.0.0.1] by gwo5.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 471RkFRFR0944Mo5; Wed, 06 Nov 2013 17:05:17 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB2.EXCHPROD.USA.NET [165.212.120.254] by gwo5.mbox.net via smtad (C8.MAIN.3.90S) 
	with ESMTPS id XID912RkFRFs1139Xo5; Wed, 06 Nov 2013 17:05:17 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB2.EXCHPROD.USA.NET
X-USANET-MsgId: XID912RkFRFs1139Xo5
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.33]) by
 S1P5HUB2.EXCHPROD.USA.NET ([10.120.223.32]) with mapi id 14.03.0158.001; Wed,
 6 Nov 2013 17:05:11 +0000
Thread-Topic: git svn clone with funky tags layout
Thread-Index: Ac7aSbEaPVaus6tlQN2Avx9V6f4W7wArzD4AAAZL0UA=
In-Reply-To: <527A4C0C.7090400@drmicha.warpmail.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237357>

> -----Original Message-----
> From: Michael J Gruber [mailto:git@drmicha.warpmail.net]
> Sent: Wednesday, November 06, 2013 6:03 AM
> To: Jim Garrison; git@vger.kernel.org
> Subject: Re: git svn clone with funky tags layout
> 
> Jim Garrison venit, vidit, dixit 05.11.2013 18:16:
> > I'm doing a one-time migration of an svn project.  For historical reasons
> our repo layout is weird:
> >
> >     trunk/reporting/reporting_app
> >
> >     tags/something_else
> >     ....
> >     tags/reporting_app-2.3.45
> >     tags/reporting_app-2.4.46
> >     tags/reporting_app-2.4.0
> >     tags/reporting_app-2.4.1
> >     ....
> >     tags/more_stuff
> >
> > I want to migrate the trunk plus only the 2.4.* tags.  I tried giving
> > a wildcard in the config
> >
> > [svn-remote "svn"]
> >         noMetadata = 1
> >         url = http://subversion.tld.com/svn/DevJava
> >         fetch = trunk/Reporting/reporting_app:refs/remotes/trunk
> >         tags = tags/reporting_app-2.4.*:refs/remotes/tags/*
> >
> > but this does not work:
> >
> >     Invalid pattern in 'tags/reporting_app-2.4.*': reporting_app-2.4.*
> >
> > On the off chance that it might work I also tried
> >
> >             tags =
> > tags/reporting_app-2.4.*:refs/remotes/tags/reporting_app-2.4.*
> >
> > but that produces the same error message.
> >
> > Is there a way to accomplish this or should I just move the tags I want to
> import into a separate directory in subversion first?  I'd rather not disturb
> svn but can do that if it's the only way.
> >
> 
> Depending on whether there are more tags to skip or more to include, you
> can
> 
> A) use the standard refspec (--tags=tags/) and remove the superfluous tag
> branches once git-svn is finished or
> 
> B) use multiple tag refspecs without wildcard:
> 
> tags = tags/reporting_app-2.4.0:refs/remotes/tags/2.4.0
> tags = tags/reporting_app-2.4.1:refs/remotes/tags/2.4.1
> 
> I may have mixed up A and B ;)

Thanks for the response. Since there was a lot of reorganization to be done I decided to just copy all the disparate directories into a new correctly structured  tree in svn first, and import from there.  Worked great.
