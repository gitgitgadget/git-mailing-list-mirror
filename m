From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Moving .git around
Date: Thu, 24 Jul 2008 11:02:02 +0930
Message-ID: <93c3eada0807231832o6b7689c4j2913253d7ced62ba@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 03:33:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLpha-0007vJ-Vl
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 03:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbYGXBcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 21:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbYGXBcG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 21:32:06 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:57078 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYGXBcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 21:32:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so592758and.103
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 18:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=0lOJhyQYQM1guCdVeVvz7ZW5dlqMozL8CRbd7MyDTmk=;
        b=DGzOc+2WnXRW8lwho5wQoiLiDAxvuaAvWsnJgcU5Aqf9fsJg5+nCVdKhm2qBnaRdKl
         z6yVYSqC7yTbPMmSf8s09EaKXJAIB5oaac0mR2xmCQJQVKMtbRYrEzARmo8mBH5ljNpf
         YbVoPTdDylvmF2V1+vcm8kU31bvQY8K4+e/9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=LcOZqtTmRzcW8GkwksLJhjxhkStP4sFw5rhjr9yrU4yZvI9nQjjya1ixbGWBaSMMTa
         405XyqS5x5vyaEFt2Bhf31tqPGsACQp32v6RndAXrspgVaQdoJ8Tfz3XWfys0fKnGnAD
         OIACfNKUdVkJQc57syH+WdfX+mz3biY5jI8a8=
Received: by 10.100.31.3 with SMTP id e3mr734483ane.21.1216863122873;
        Wed, 23 Jul 2008 18:32:02 -0700 (PDT)
Received: by 10.100.8.15 with HTTP; Wed, 23 Jul 2008 18:32:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89824>

For reasons which would take a while to explain, I'm building a repository
in a directory  using "--git-dir=xxxx/.git --work-tree=." and
then doing an "mv  xxxx/.git ./.git"  and then trying to work with
that repository  --- but can't

Below is a sample script. The last line (git add) fails with

fatal: unable to create
'/usr/local/AusTop/AuPrograms/AuServer/testgit/aaa/bbb/.git/index.lock':
No such file or directory

git doesn't seem to realise that there is a .git back up the tree.

I'm using 1.5.5.1

Cheers,
Geoff Russell

------------------------ sample script
#!/bin/sh
if [ -d "testgit" ] ; then
    echo "remove testgit"
    /bin/rm -rf testgit
fi
mkdir testgit && echo yyyy >testgit/sample.sh && cd testgit
mkdir aaa && mkdir aaa/bbb
echo xxxx > aaa/bbb/sample2.sh
mkdir xxx
git --git-dir=xxx/.git --work-tree=. init
git --git-dir=xxx/.git --work-tree=. add *.sh
git --git-dir=xxx/.git --work-tree=. commit  -m demo
mv xxx/.git .
cd aaa/bbb
git add sample2.sh
