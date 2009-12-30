From: David Reiss <dreiss@facebook.com>
Subject: Re: git fast-import not verifying commit author lines?
Date: Tue, 29 Dec 2009 22:04:22 -0800
Message-ID: <4B3AED66.3030803@facebook.com>
References: <4B304987.7030201@facebook.com> <20091222150649.GI10687@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 07:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPrgb-0000kb-P3
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 07:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbZL3GEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 01:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZL3GEb
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 01:04:31 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:36039 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbZL3GEb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 01:04:31 -0500
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.15] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id nBU64I4m008210
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 29 Dec 2009 22:04:18 -0800
Received: from [192.168.1.138] (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 29 Dec
 2009 22:04:25 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20091222150649.GI10687@spearce.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-12-30_02:2009-12-12,2009-12-30,2009-12-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0908210000 definitions=main-0912290277
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135862>

>> author <somename> 1261454209 +0000
>> committer <somename> 1261454209 +0000
> a foreign system where the data might not reasonably exist.
But shouldn't there still be an extra space?  One to separate "author"
from the empty name, and one to separate the empty name from the email?
If not, then I think this change should be made.  (I couldn't find any
authoritative documentation on what constitutes a valid commit object.)

(Sorry, this has been sitting in my outbox for a week.)

--David

diff --git i/Documentation/git-fast-import.txt w/Documentation/git-fast-import.txt
index 288032c..6917739 100644
--- i/Documentation/git-fast-import.txt
+++ w/Documentation/git-fast-import.txt
@@ -312,6 +312,6 @@ change to the project.
        'commit' SP <ref> LF
        mark?
-       ('author' SP <name> SP LT <email> GT SP <when> LF)?
-       'committer' SP <name> SP LT <email> GT SP <when> LF
+       ('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
+       'committer' (SP <name>)? SP LT <email> GT SP <when> LF
        data
        ('from' SP <committish> LF)?
