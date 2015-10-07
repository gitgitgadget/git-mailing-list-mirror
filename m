From: Stijn De Ruyck <Stijn.DeRuyck@onsemi.com>
Subject: RE: Branch information (git branch/status) inconsistent when in
 detached HEAD state
Date: Wed, 7 Oct 2015 09:57:31 +0000
Message-ID: <247ABEF3B84FB7499C074A0FE8058694153CB1BE@ONWATER51M.ad.onsemi.com>
References: <247ABEF3B84FB7499C074A0FE8058694153CB176@ONWATER51M.ad.onsemi.com>
 <5614E0C0.7060805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 07 11:57:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjlTj-00043D-CC
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 11:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbbJGJ5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 05:57:39 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:60415 "EHLO
	mx0b-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751865AbbJGJ5h convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 05:57:37 -0400
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
	by mx0b-00183b01.pphosted.com (8.14.5/8.14.5) with SMTP id t979vZgJ008373;
	Wed, 7 Oct 2015 03:57:35 -0600
Received: from em2.onsemi.com (em2.onsemi.com [65.197.242.106])
	by mx0b-00183b01.pphosted.com with ESMTP id 1xay01592h-1
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 07 Oct 2015 03:57:35 -0600
Received: from dns1.onsemi.com (dns1 [10.253.118.1])
	by em2.onsemi.com (8.13.8/8.13.8) with ESMTP id t979vYEk032613;
	Wed, 7 Oct 2015 02:57:34 -0700
Received: from ONWATER53C.ad.onsemi.com (onwater53c.onsemi.com [10.253.116.147])
	by dns1.onsemi.com (8.13.8+Sun/8.11.6) with ESMTP id t979vXWg026040;
	Wed, 7 Oct 2015 02:57:34 -0700 (MST)
Received: from ONWATER51M.ad.onsemi.com ([fe80::70a7:46e:5e2f:c00d]) by
 ONWATER53C.ad.onsemi.com ([::1]) with mapi id 14.03.0224.002; Wed, 7 Oct 2015
 02:57:32 -0700
Thread-Topic: Branch information (git branch/status) inconsistent when in
 detached HEAD state
Thread-Index: AdEAN2M14NEzEpFyTRmqYaRTIrf/GAA4taIAAA1NHXA=
In-Reply-To: <5614E0C0.7060805@drmicha.warpmail.net>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.116.1]
x-esetresult: clean, is OK
x-esetid: E296D73E822878E9B1D286
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.14.151,1.0.33,0.0.0000
 definitions=2015-10-07_04:2015-10-06,2015-10-07,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279177>

Yes it is the tip. 
So all I'm doing is checking out the exact same commit (the tip of a branch), but in different ways and in different sequences. The result on disk is the same, but the issue is git branch/status doesn't always reflect what I just did...

If I do git checkout origin/develop, git branch might still say "detached at 545a36f", which, while true, feels wrong. How can I know afterwards what branch I actually tried to check out? "Detached at origin/develop" would make that clear.
(I use this information in a build script to embed version information (including the branch being built) into the binary.)

Best regards,

Stijn De Ruyck


-----Original Message-----
From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
Sent: Wednesday, October 07, 2015 11:07 AM
To: Stijn De Ruyck; git@vger.kernel.org
Subject: Re: Branch information (git branch/status) inconsistent when in detached HEAD state

Stijn De Ruyck venit, vidit, dixit 06.10.2015 15:03:
> Hello,
> 
> Consider a repository with a develop branch tracking origin/develop and where HEAD = 545a36f = develop = origin/develop.
> Tested with Git 2.4.3 and 1.8.3.4 on Linux.
> 
> 1) git checkout develop
> 2) git branch | head -1 (or git status)
> * develop
> 3) git checkout origin/develop
> Note: checking out 'origin/develop'.
> You are in 'detached HEAD' state.
> 4) git branch | head -1
> * (HEAD detached at origin/develop)
> 5) git checkout 545a36f
> 6) git branch | head -1
> * (HEAD detached at origin/develop)
> 7) git checkout develop
> 8) git branch | head -1 (or git status)
> * develop
> 9) git checkout 545a36f
> Note: checking out '545a36f'.
> You are in 'detached HEAD' state.
> 10) git branch | head -1 (or git status)
> * (HEAD detached at 545a36f)
> 11) git checkout origin/develop
> 12) git branch | head -1 (or git status)
> * (HEAD detached at 545a36f)
> 
> As you can see, checking out a revision by SHA1 after checking out a local branch tells you you are detached at that SHA1. Ok.
> But, checking out a revision by SHA1 after checking out a remote tracking branch tells you you are detached at that remote tracking branch.
> And checking out a remote tracking branch after checking out a revision by SHA1 tells you you are detached at that SHA1.
> 
> This is confusing. Is this by design?
> For a script I am writing, it would be great if the output would be consistent. Checkout origin/develop should always say "detached at origin/develop". Checkout 545a36f should always say "detached at 545a36f".
> 
> It looks like the detached head information is only updated when a detached head state is entered and not anymore when a checkout occurs "within" a detached head state.
> 
> Best regards,

Does 545a36f happen to be the tip (value) of origin/develop?

For a sha1 different from the tip, I can't reproduce the effect that you describe. There have been some changes in related code recently, but I don't think they should affect this scenario.

Michael
