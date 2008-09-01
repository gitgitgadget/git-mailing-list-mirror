From: =?ISO-8859-1?Q?Jonas_Flod=E9n?= <jonas.floden@gmail.com>
Subject: Unexpected behaviour with git stash save --keep-index?
Date: Tue, 2 Sep 2008 01:14:10 +0200
Message-ID: <B1185033-36D7-4504-92A3-6F75B6CE90DF@gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 01:15:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIcN-0001EJ-Hh
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 01:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbYIAXOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbYIAXOO
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 19:14:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:14605 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbYIAXON (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 19:14:13 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1608515ugf.37
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=FeGP7tsa+8vrXa+YA6EHYVeKsP+Jtn+8gcwxfwJG0ic=;
        b=MxItjeZIo5pJKnXi3PGF5GVfltYZIfnjY7b+ACFl2c4BnvsMIwwZJfVgJOwPKCoCvf
         8fopyo0gIPfXfuF0zf2gJ/Mco/YFG1E29Ov05jFCmmzWfUBVIheldvKhGCa+4RswgZ4D
         N570YPwvrWrPTSL/CV9Tp6UfOUJKkmjgi4GEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=I0GCBQ3q/Maf9/1xflpQCWPAGKgY1HeAGYTSXOULo8K736mb/w7GsgaFZl7IG3a7En
         Y5+8M5Gvv5Hf8msvZze4wGO4ocIKx2/b1YhQ9KZcG5bRnLIPSaXYF5Q0g8vaRYhX505R
         3gIRbJTlAwjv1IXDe15f0DtAAuV0SEEwZxEbA=
Received: by 10.66.233.14 with SMTP id f14mr3260895ugh.12.1220310851889;
        Mon, 01 Sep 2008 16:14:11 -0700 (PDT)
Received: from ?192.168.98.16? ( [83.254.173.236])
        by mx.google.com with ESMTPS id 1sm5438040nfv.18.2008.09.01.16.14.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Sep 2008 16:14:11 -0700 (PDT)
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94626>

Hello all,

while I was using StGit for the first time and used git stash to split
the changes into different patches I noticed that git stash save -- 
keep-index
will stash also the changes that are already in the index. This was  
unexpected
atleast to me but maybe someone can explain why it's correct.

The following sequence should illustrate the problem. Notice how both  
the
b and c are popped from the stash.

git init
echo a > test.txt
git add test.txt
git commit -m "a"
echo b >> test.txt
git add test.txt
echo c >> test.txt
git stash save --keep-index
git commit -m "b"
git checkout -b new_branch HEAD^
git stash pop
git diff

Also maybe someone could someone recommend a way to split an unclean  
working dir
into several patches/commits?

With regards

Jonas
