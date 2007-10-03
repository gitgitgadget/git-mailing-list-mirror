From: Clark Williams <clark.williams@gmail.com>
Subject: Problems using StGit and -rt kernel patchset
Date: Wed, 03 Oct 2007 09:19:26 -0500
Message-ID: <4703A4EE.3000002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 16:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id551-0005aH-OH
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 16:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700AbXJCOTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 10:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756902AbXJCOTg
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 10:19:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:10578 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420AbXJCOTe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 10:19:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so131335ugc
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=27GLSXbnBaYqrKqJY94ZW1d5QmfTZ2Fr68lp/zCjjxo=;
        b=W1ZuUGTW8UoEB4YL/LISfu/ajw1bEvoa9dZECy2fjdSNmojj0mZYkuAFsG35nHXj5IBqqaryF9acbcu4HOvUu13qEtOtTPcLMF/ZRPHO9hKj/df1O3X4bHJnGyfGV18F5FuL+prZgo7iK14UctUNApAGAVnd97O7SzOG6agtJ64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=L9Mp2jzCEVm09VgLdUuXi8SvsJZPVGoxPg823P7eTQ8lrAOjRsplFuR0jI2T0/D+S0l1/mI1prsbq4avJHcpnWkY69jv7BlX1FdU5Uoytbus0sk9mfF4LRSRvsFo/sk8S8mtEBaHFaELm8zArA1RNs2RNIuSChzDuBW19UxY8gM=
Received: by 10.66.221.5 with SMTP id t5mr554891ugg.1191421172832;
        Wed, 03 Oct 2007 07:19:32 -0700 (PDT)
Received: from ?192.168.2.218? ( [72.146.36.176])
        by mx.google.com with ESMTPS id j4sm1573588ugf.2007.10.03.07.19.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Oct 2007 07:19:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59842>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

I've been working on the -rt patch series for the kernel and would like to to use
StGit to manage the patches. Unfortunately I've had limited success, so I thought I'd
ask the git/stgit community if what I'm doing is wrong.

I clone Linus's tree to a common directory, then clone it locally to work:

$ git clone -s -l /home/src/linux-2.6.git scratch.git
$ cd scratch.git
$ stg init
$ stg branch --create rt-2.6.23-rc8-rt1 v2.6.23-rc8
$ stg import --series --ignore --replace ../sources/patch-queue-2.6.23-rc8-rt1/series
<fix the things quilt lets through and stg barfs on, like malformed email addresses>
<watch 368 patches be applied and committed>
<work work work>
<get a new patch queue>
$ (cd /home/src/linux-2.6.git && git pull)
$ stg pull
$ stg branch --create rt-2.6.23-rc8-rt1 v2.6.23-rc9
$ stg import --series --ignore --replace ../sources/patch-queue-2.6.23-rc9-rt1/series
Checking for changes in the working directory ... done
stg import: env git-commit-tree 520b9d0db6a1142271a68b2b38cca002be40f6cb -p
da0a81e98c06aa0d1e05b9012c2b2facb1807e12 failed (fatal:
da0a81e98c06aa0d1e05b9012c2b2facb1807e12 is not a valid 'commit' object)

At this point I'm clueless as to:

1. What I've done wrong
2. How to recover/debug this

I really like using stgit to manage the patch queue with each patch as a commit, so
I'd prefer to figure out how to either use stgit properly, or fix whatevers going wrong.

Thanks,
Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHA6TuqA4JVb61b9cRAl12AJ0V3SNg9hO4cnFhefRS/mWdGF696ACeNspM
a+aLdBeFCHCPeyypUr6AwJQ=
=Z2eU
-----END PGP SIGNATURE-----
