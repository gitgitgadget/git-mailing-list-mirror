From: Gene Czarcinski <gene@czarc.net>
Subject: Bug, feature, or pilot error: format-patch
Date: Mon, 28 Jan 2013 12:03:56 -0500
Message-ID: <5106AF7C.1010502@czarc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 18:12:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzsGK-0005CD-7U
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 18:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936Ab3A1RMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 12:12:31 -0500
Received: from eastrmfepi204.cox.net ([68.230.241.208]:45032 "EHLO
	eastrmfepi204.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab3A1RMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 12:12:30 -0500
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2013 12:12:29 EST
Received: from eastrmimpo110 ([68.230.241.223]) by eastrmfepo102.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20130128170357.WSPI7113.eastrmfepo102.cox.net@eastrmimpo110>
          for <git@vger.kernel.org>; Mon, 28 Jan 2013 12:03:57 -0500
Received: from [192.168.18.148] ([68.100.144.189])
	by eastrmimpo110 with cox
	id tV3w1k00H45PsQc01V3wMG; Mon, 28 Jan 2013 12:03:57 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020204.5106AF7D.002D,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=Ybc/Fntf c=1 sm=1
 a=xiXiwr23JuvKlkj6ngz4TA==:17 a=IUyNvTVCZWAA:10 a=j1HrP9d4hxIA:10
 a=103jMkqsgCkA:10 a=8nJEP1OIZ-IA:10 a=BIJj-m-0AAAA:8 a=6y9iLSimWqUA:10
 a=6tQWiZNZeTwwd-J4LrUA:9 a=wPNLvfGTeEIA:10 a=xiXiwr23JuvKlkj6ngz4TA==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (CRAM-MD5)
 smtp.auth=gczarcinski@cox.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214840>

I am not on the mailing list so please CC me.  I am running git 1.8.1 on 
Fedora 18.

I aam having what appears to be a problem.  Here is the sequence which 
generally describes what I did and what happened:

     git  checkout  -b  test1  master
     git  am  0001-simple-1.patch
     git  checkout  -b  test2  master
     git  am  0001-simple-2.patch        ### this is known to conflict 
with 0001-simple-1.patch
     git  checkout  test1
     git  merge  test2
[here git-merge detects a conflict]
     git  mergetool                               ###to resolve the conflict
[conflict resolved]
     git  commit  -a -s
     git  log
[shows two commits -- one for simple-2 and one for the merge]
     git  format-patch  master..HEAD
[two patch files created: 0001-simple-1.patch and 0002-simple-2.patch]
[0002-simple-2.patch and 0001-simple-2.patch are exactly equal and do 
not reflect the resolved conflict]

If you do git-diff between <commit-patch-1> and HEAD, you get something 
different that you got from format-patch.

1. Bug ... format-patch is broken

2. Feature ... that is the way it works

3. Pilot error ... ??

I can create a good version of patch-2 manually but should I have to?

Color me foolish but I assumed I could do git-format-patch in one branch 
and then use git-am to recreate that branch elsewhere.

Gene
