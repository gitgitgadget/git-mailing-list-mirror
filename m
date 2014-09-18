From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: git svn's performance issue and strange pauses, and other thing
Date: Thu, 18 Sep 2014 08:39:53 +0100
Message-ID: <1411025993.80693.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 09:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUWQJ-0000DU-9i
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 09:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbaIRHqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 03:46:35 -0400
Received: from nm16-vm8.bullet.mail.ir2.yahoo.com ([212.82.96.214]:49816 "EHLO
	nm16-vm8.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754936AbaIRHqe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 03:46:34 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Sep 2014 03:46:34 EDT
Received: from [212.82.98.126] by nm16.bullet.mail.ir2.yahoo.com with NNFMP; 18 Sep 2014 07:39:53 -0000
Received: from [212.82.98.93] by tm19.bullet.mail.ir2.yahoo.com with NNFMP; 18 Sep 2014 07:39:53 -0000
Received: from [127.0.0.1] by omp1030.mail.ir2.yahoo.com with NNFMP; 18 Sep 2014 07:39:53 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 272787.95409.bm@omp1030.mail.ir2.yahoo.com
Received: (qmail 3011 invoked by uid 60001); 18 Sep 2014 07:39:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1411025993; bh=Lh0+e7O9x/FQnEGvs90RpANf7WMrmO3Vj+MdZ59mzms=; h=Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=bMo+9lBocgYB2+ivTQiQr/iUB+5ru2i/+ZEXiRyyRCr3+2X04VSUguLgeXadGW5fqHuNT6S2PqkWN4lH0CmRVtHMJBTaOYEDGaM4BbHYe531ETn3/VA6Ia+yMB/M7jBqwgxBvwjokrC4QbQOUjmvlkA6mOaY5fDe7De+SGnsE3w=
X-YMail-OSG: RPeiT8QVM1m63DmAT94zrqPc5q3QiGCW9sv5HDK8K33kZLH
 XO6QYXJsykVivvoBuyaPjqbYzs2IlTyFYguxs10zaUx3LOF2oxfC89DfIl87
 _vgpA5EqNSYHn_VQya7TSv7rhzgkqEhY8Kbjw2JMEpSMnzw52uHZak5M191P
 SS7VCEfC._mOTCRcE0BvYQk60OAnsdVHcQI2qSIiVKTi4m9JHMqYBk6EZA7O
 WLgjQGhh__ecnw40rCtykcqyuTYXTe9VKl3RR8PTF98wUodd2wzsjDX.iX18
 pXlT4yMeOWtNFhLR3ClR7Mv5ALtFBkz298GZ.v6LVNm.b4i8mbOhlOO0jL3N
 jQSYHgMSsHVzVkNZlJOpr1yv_qercq15NqlW0Kel6VrRZm5wqe74ZeGe3w94
 c8ERd04vq4NFWWj5vJ9EgQbkZiclIMjpt_Qh1qfK_fR0UXwlV7nV8UUQEDrB
 S7r.XKrVOoQS8MMchzCyBE0fMMSGIlEQv1HVxwochuagEBr1W_ukyLfrXgmh
 4_mqc4rGYxvNxdWEka.Dv5fkvR384OibzMoNujd4KRRT5JcqzFdekPncF3FA
 alF.ZrRfEMOsJITn9OxqOIs6pYg4NEOaf.sFIlw.kjgpjGJcfPucV9phJm.i
 VHhdEg3LtsVI-
Received: from [86.30.137.134] by web172304.mail.ir2.yahoo.com via HTTP; Thu, 18 Sep 2014 08:39:53 BST
X-Rocket-MIMEInfo: 002.001,KEkgYW0gbm90IG9uIHRoZSBsaXN0IC0gcGxlYXNlIENDKQ0KDQpUaGFua3MgZm9yIGdpdC1zdm4gLSBJIHVzZSBpdCBpbnN0ZWFkIG9mIHN1YnZlcnNpb24gaXRzZWxmIGZvciBtYW55IHllYXJzIG5vdy4NCg0KSnVzdCB0aG91Z2h0IEknZCBhc2svcmVwb3J0IGEgZmV3IGlzc3VlcyBJIG5vdGljZWQgZm9yIHNvbWUgdGltZQ0Kbm93LCBvZiB0cmFja2luZyBkZXZlbG9wbWVudCBvZiBhIHBhcnRpY3VsYXIgc3VidmVyc2lvbi1iYXNlZA0KZGV2ZWxvcG1lbnQgcHJvamVjdC4gQnJvYWRseSBzcGVha2luZywgSSABMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/735 YahooMailWebService/0.8.201.700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257254>

(I am not on the list - please CC)

Thanks for git-svn - I use it instead of subversion itself for many years now.

Just thought I'd ask/report a few issues I noticed for some time
now, of tracking development of a particular subversion-based
development project. Broadly speaking, I think there are 3 problems,
especially noticeable against a particular repository, but 
to a lesser extent with some others too.

- just doing "git svn fetch --all" seems to consume a lot of memory,
for very little actual fetched changes. (in the 2GB+ region, sometimes).

- "git svn fetch --all" also seems to take a long time too, for certain
fetched changes. (in the minutes region).

-  I know I can probably just "read the source", but I'd like to know
why .git/svn/.caches is even larger than .git/objects (which supposedly
contains everything that's of interest)? I hope this can be documented
towards the end of the man-page, for example, of important parts
of .git/svn (and what not to do with them...), without needing to
'read the source'. Here is part of "du" from a couple of days ago:

254816	.git/objects
307056	.git/svn/.caches
332452	.git/svn
588064	.git

The actual .git/config is here - this should be sufficient info for
somebody looking into experiencing the issues I mentioned above.

--------
$ more .git/config 
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[svn-remote "svn"]
	url = https://svn.r-project.org/R
	fetch = trunk:refs/remotes/trunk
	branches = branches/*:refs/remotes/*
	tags = tags/*:refs/remotes/tags/*
[pack]
	threads = 1
------------
