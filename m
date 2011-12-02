From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Debugging git-commit slowness on a large repo
Date: Fri, 2 Dec 2011 23:17:10 +0000
Message-ID: <CAFE9C7B.2BFEC%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 03 00:44:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWcm4-0005k9-G5
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 00:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab1LBXoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 18:44:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37480 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751680Ab1LBXoG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2011 18:44:06 -0500
X-Greylist: delayed 1610 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Dec 2011 18:44:06 EST
Received: from pps.filterd (m0004060 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id pB2NHFS3004623
	for <git@vger.kernel.org>; Fri, 2 Dec 2011 15:17:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : subject : date
 : message-id : content-type : content-id : content-transfer-encoding :
 mime-version; s=facebook; bh=V6gnKBtrUVol/jJ0xOj1Q01L/zpo1DvLwlQS8g5ofbQ=;
 b=X94IpPfvdWMPgbkTKgAC4iKp04DBua+3HD9hai+BAPf37CBzjpsHANUtc60D83WztvI7
 QhHjlUGO4SgzZHKWcVuePJGJWyLddv43GHq5sDRbGandEWtqpRsufBl9pCZh1eOqXyms
 l7yNOx6vb+Uvv6wfrAgFSi1vvxePM6Mv49Q= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 11f56a88ym-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 02 Dec 2011 15:17:15 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0289.001; Fri,
 2 Dec 2011 15:17:11 -0800
Thread-Topic: Debugging git-commit slowness on a large repo
Thread-Index: AQHMsUiE0jGAmaiuRkyp0eiAE6mrRw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.13.0.110805
x-originating-ip: [192.168.18.252]
Content-ID: <C6AD6DAA6177704C904A888B8212791C@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-12-02_06:2011-12-02,2011-12-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186244>

Hi,
I have a git repo with about 300k commits,  150k files totaling maybe 7GB.
 Locally committing a small change - say touching fewer than 300 bytes
across 4 files - consistently takes over one second, which seems kinda
slow.  This is using git 1.7.7.4 on a linux 2.6 box.  The time does not
improve after doing a git-gc (my .git dir has maybe 250 files after a git
gc).  The same size commit on a brand new repo takes < 10ms.  Any thoughts
on why committing a small change seems to take a long time on larger repos?

Fwiw, I also tried doing the same test using libgit2 (via the pygit2
wrapper), and it was ever slower (about 6 seconds to commit the same small
change).

Thanks for any thoughts or places to look.

Cheers,
Josh
