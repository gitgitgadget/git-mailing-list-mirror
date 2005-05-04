From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Wed, 04 May 2005 07:38:53 -0700
Message-ID: <4278DE7D.3000005@zytor.com>
References: <20050503211527.42339.qmail@web41208.mail.yahoo.com> <20050503182850.GL18917@shell0.pdx.osdl.net> <20050503193536.GE5324@shell0.pdx.osdl.net> <20050503212142.GB15995@pasky.ji.cz> <20050503213216.GF5324@shell0.pdx.osdl.net> <20050503214401.GE15995@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Wright <chrisw@osdl.org>, Mark Allen <mrallen1@yahoo.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 16:34:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTKwH-0001VT-Ln
	for gcvg-git@gmane.org; Wed, 04 May 2005 16:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVEDOjr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 10:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVEDOjr
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 10:39:47 -0400
Received: from terminus.zytor.com ([209.128.68.124]:8851 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261860AbVEDOjf
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2005 10:39:35 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j44EcxMo024601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 May 2005 07:39:00 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050503214401.GE15995@pasky.ji.cz>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> 
> I wouldn't accept this neither. If git.spec is already version
> controlled, it should be up-to-date in the version control. Therefore,
> you need to update it at the time of release, not at the time of
> generating the tarball.
> 

What I usually do is to have a *.spec.in file, and have my release 
script generate the *.spec file.  I usually have a "version" file 
checked into the SCM from which all version information derives, 
including what to put in the *.spec file as well as what to name the 
subdirectory.

The release script then ends up being some variant on:

#!/bin/sh -xe
PACKAGE=pkgname
VERSION=`cat version`
scm-of-choice tag --force $PACKAGE-$VERSION
mkdir /var/tmp/$PACKAGE-$VERSION
cd /var/tmp/$PACKAGE-$VERSION
scm-of-choice export -r $PACKAGE-$VERSION
make release
cd ..
tar cvvfz $PACKAGE-$VERSION.tar.gz $PACKAGE-$VERSION
rm -rf $PACKAGE-$VERSION

... where "make release" creates the specfile and anything else that 
needs to be created (like autoconf files.)

	-hpa

