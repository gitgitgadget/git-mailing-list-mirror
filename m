From: Szunti <szunti@gmail.com>
Subject: rebase with unknown -s parameter discards commits
Date: Sat, 15 Aug 2015 02:01:18 +0200
Message-ID: <55CE814E.1050603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 02:01:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQOub-0008UN-Jw
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 02:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbHOABV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 20:01:21 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36882 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbHOABU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 20:01:20 -0400
Received: by wibhh20 with SMTP id hh20so35395841wib.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=KSfNkkFEm6RW5qvfFtBM9wKdjWqQuFbchgVs20l1ot8=;
        b=pSAQwGtDDO1HaxfXNGivuGDshpdjH7KBexOT0An8xWCqqalJ9ilpAzdNApMdK8v4No
         fbbtEBmuvhAMIS3bffjOfplvRcCOmJRp1Wv4TdidBwVxEzwHqZB+R3ZPSiLJ89W685fd
         zYag+Qac4ppk4fE5xv77BIwydXFwb48XiscYXSICw5XzUgqcFRiou/+sN+plAF0nvPgi
         KEhxNrU4nGzs+tLI/EjXdNm4meHSUbYWFMMITKnrL65+NRE+O1352vnTzuFJa9eHmKVg
         Uwsl7nBH2D2RxgSP3x9CLP16sWogk8YLVC+kWcwik3L3cWWy6uicZVPQ1aOf0LWu/sXT
         03IQ==
X-Received: by 10.195.13.200 with SMTP id fa8mr4587921wjd.9.1439596879533;
        Fri, 14 Aug 2015 17:01:19 -0700 (PDT)
Received: from [192.168.1.101] (62-165-214-204.pool.digikabel.hu. [62.165.214.204])
        by smtp.googlemail.com with ESMTPSA id c3sm10468074wja.3.2015.08.14.17.01.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2015 17:01:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275977>

git version: 2.5.0
Archlinux

Hi,

'git rebase -s nonsense master' gives an error message but still changes 
the branch.

$git rebase -s nonsense master topic
First, rewinding head to replay your work on top of it...
/usr/lib/git-core/git-rebase--merge: line 70: git-merge-nonsense: 
command not found
Unknown exit code (127) from command: git-merge-nonsense 
3cf5c040ccda670cc103184a6d7e03fc20293b81^ -- HEAD 
3cf5c040ccda670cc103184a6d7e03fc20293b8

And topic is the same as master now.

If I try to continue
$git rebase --continue
Already applied: 0001 Topic
All done.

But still topic is the same as master.

-----------------------------------------------------
topic and master was created with these commands:

$git init
$echo orig > text
$git add text
$git commit -m Orig

$git checkout -b topic
$echo topic > text
$git commit -am Topic

$git checkout master
$echo master > text
$git commit -am Master

$git rebase -s nonsense master topic
$git rebase --continue

$git log --oneline
04d7f1d Master
0ac994c Orig
