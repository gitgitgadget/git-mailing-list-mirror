From: Christian Holtje <docwhat@gmail.com>
Subject: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 12:40:27 -0400
Message-ID: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 19:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBvSD-0001Ka-2d
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 19:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbYFZRjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 13:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbYFZRjN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 13:39:13 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:6465 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYFZRjM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 13:39:12 -0400
Received: by py-out-1112.google.com with SMTP id p76so8919pyb.10
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=mVTtUkQoHaY70t/LLu52m0WoCBUXkHl9FS4V7tvrVuk=;
        b=QqMBtqlJSz33OYzX4QqNUyC0gy4rxJOKsu+BHddEkd78q/QHjEp86UrjnyyFavgKIb
         Wm5SwqqwHCyHBt63F8kf6shbHLPa21QAYqiLlHL2oZb+L2tEewJLC0QcnEuWDf4vEaxJ
         lQHAQHu/tjjNFOQ7CGdbZ0dTD5Xi5ZKSu6Lrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=xZRqnCOzuozMGvNRfjDO/V6UJdyrdsiMTtOc0gliZDxFaiMi5hXPs3yidT+Wbd7DD4
         fipHJP92aaEPbKfYraDl+r6hxKUVeGVvr+7jrRNEsnj6s97htv0iyVCybXUmx18obPL9
         xmt64HsMoSBzy50t8fHmVQpUMDni3E3vf9jqE=
Received: by 10.114.177.1 with SMTP id z1mr206026wae.37.1214498429423;
        Thu, 26 Jun 2008 09:40:29 -0700 (PDT)
Received: from ?192.168.0.161? ( [206.210.75.84])
        by mx.google.com with ESMTPS id i18sm465778wxd.16.2008.06.26.09.40.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 09:40:28 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86463>

I have read all the threads on git having trouble with pread() and I  
didn't see anything to help.

Situation:
   git commands run on system "dev2" which is Linux 2.6.9-42.0.8.ELsmp  
on an NFS mounted directory.
   The NFS server is "dev1" which is Linux 2.4.28

I get the following output from git when doing a fetch:
   remote: Counting objects: 406, done.
   remote: Compressing objects: 100% (198/198), done.
   remote: Total 253 (delta 127), reused 150 (delta 55)
   Receiving objects: 100% (253/253), 5.27 MiB | 9136 KiB/s, done.
   fatal: cannot pread pack file: No such file or directory
   fatal: index-pack failed

The end of the strace looks like so:
pread(3, "", 205, 1373)                 = 0
write(2, "fatal: cannot pread pack file: N"..., 57) = 57

I have ran strace -o /somedir/q -ff git fetch and have the straces  
available at:
http://docwhat.gerf.org/files/tmp/git-strace-20080626.tgz

I have worked around the problem by running the fetch from the nfs  
server.

It looks like I can recreate this at will and I'm willing to help  
figure this out.

Thanks!

Ciao!
