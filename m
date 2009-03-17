From: Toby White <toby.o.h.white@googlemail.com>
Subject: Mirroring repository state, with branches and submodules.
Date: Tue, 17 Mar 2009 15:21:40 +0000
Message-ID: <623D3837-E899-49AF-9A37-F667A311EE58@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 16:23:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljb8j-0006H1-Vi
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbZCQPWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbZCQPWA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:22:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:47369 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbZCQPV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 11:21:59 -0400
Received: by nf-out-0910.google.com with SMTP id d21so13586nfb.21
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=Hc39YurirFZHUv1n36a9AcGeNurutYXYM+LjYLuD29Q=;
        b=hOCUJe9dF67wGdZxsul6TxIBcXbO3gg7MFciusyE34sKLxPrl6/aidhsQlSEMT7flf
         Qt+mbZpJ2GCIXSo1sLfxrb1tIAfCSrPNdc3wUXsOjMAWQ1gkyw/cJ+ijJrlL28Ts9ZWu
         C4Ak8/int9yjpoa9zgco2lFspKvwx/VIVBJNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=tMbFNMi6tx92xEUXcKHmdIfiBGd3v1giBqgSHu3R1zMTg6iGf/eTeqkGwnj61Nfybs
         b0uHRi5i3D+QppYz3dJ8pr7AcAviKLTuwOeRUtDeCtuh2/vJThPwXyeF0rt74W9EI5px
         9ax6+aFx6vQcMmjJ8PdjOFSwpPsUn9CJDQQ54=
Received: by 10.216.0.79 with SMTP id 57mr91851wea.48.1237303316711;
        Tue, 17 Mar 2009 08:21:56 -0700 (PDT)
Received: from ?192.168.1.102? ([213.104.11.10])
        by mx.google.com with ESMTPS id d23sm6163295nfh.39.2009.03.17.08.21.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Mar 2009 08:21:55 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113479>

I have a short script which does the following for a remote git  
rpository:

Clones it (checking out a working tree)
Makes tracking local branches for all remote branches
Init/updates all submodules.

This gives me an up-to-date mirror of a remote repository. I treat  
this as essentially read-only.

What I now want to do is have some command which will update this  
local mirror to reflect exactly the state of the remote mirror;
even when the remote mirror may have rebased history.

So far, I'm doing the following:

git fetch
for BRANCH in $(git branch -r | cut -d / -f 2); do
   git checkout $BRANCH
   git reset --hard origin/$BRANCH
done
git submodule update --init

but I'm not sure if that's actually the right way to do it, or if I'm  
missing any corner cases. Am I safe to use it?

Thanks,
Toby
