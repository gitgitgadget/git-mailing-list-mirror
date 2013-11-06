From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn clone with funky tags layout
Date: Wed, 06 Nov 2013 15:02:52 +0100
Message-ID: <527A4C0C.7090400@drmicha.warpmail.net>
References: <0C723FEB5B4E5642B25B451BA57E273041FD78E9@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 06 15:02:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve3gy-0006nx-3U
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 15:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab3KFOCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 09:02:39 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38092 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756541Ab3KFOCi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Nov 2013 09:02:38 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 96CEC22404;
	Wed,  6 Nov 2013 09:02:37 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 06 Nov 2013 09:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Tz9epjVLifGkjaA0kXnWIw
	QHhuQ=; b=UD7ZKtholnfR1YspVIxhVSJ09uZKkPCw2cr8bkdIoiLfxEFEf8ap5J
	yZj39a6zCivZ3krA+i4mNT0QOgU0nRomJWRI4RC98IDWtj5bEe2J3BvIj2ZMFsAT
	dVUsZMKa0p0vj47dx14YiZSyDpbfHojNzdpkGrKEfLaQx5xi5/vO0=
X-Sasl-enc: 4vWCTTRWATw9oae4zUEPR6WcMRWtlQ9ghWBI+rxM2o7m 1383746557
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C5EA1C00E80;
	Wed,  6 Nov 2013 09:02:36 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E273041FD78E9@S1P5DAG3C.EXCHPROD.USA.NET>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237351>

Jim Garrison venit, vidit, dixit 05.11.2013 18:16:
> I'm doing a one-time migration of an svn project.  For historical reasons our repo layout is weird:
> 
>     trunk/reporting/reporting_app
> 
>     tags/something_else
>     ....
>     tags/reporting_app-2.3.45
>     tags/reporting_app-2.4.46
>     tags/reporting_app-2.4.0
>     tags/reporting_app-2.4.1
>     ....
>     tags/more_stuff
> 
> I want to migrate the trunk plus only the 2.4.* tags.  I tried giving a wildcard in the config
> 
> [svn-remote "svn"]
>         noMetadata = 1
>         url = http://subversion.tld.com/svn/DevJava
>         fetch = trunk/Reporting/reporting_app:refs/remotes/trunk
>         tags = tags/reporting_app-2.4.*:refs/remotes/tags/*
> 
> but this does not work:
> 
>     Invalid pattern in 'tags/reporting_app-2.4.*': reporting_app-2.4.*
> 
> On the off chance that it might work I also tried
> 
>             tags = tags/reporting_app-2.4.*:refs/remotes/tags/reporting_app-2.4.*
> 
> but that produces the same error message.
> 
> Is there a way to accomplish this or should I just move the tags I want to import into a separate directory in subversion first?  I'd rather not disturb svn but can do that if it's the only way.
> 

Depending on whether there are more tags to skip or more to include, you can

A) use the standard refspec (--tags=tags/) and remove the superfluous
tag branches once git-svn is finished or

B) use multiple tag refspecs without wildcard:

tags = tags/reporting_app-2.4.0:refs/remotes/tags/2.4.0
tags = tags/reporting_app-2.4.1:refs/remotes/tags/2.4.1

I may have mixed up A and B ;)

Michael
