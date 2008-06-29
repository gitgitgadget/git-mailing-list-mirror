From: Lea Wiemann <lewiemann@gmail.com>
Subject: gitweb/gitk: empty merge diffs
Date: Sun, 29 Jun 2008 17:57:57 +0200
Message-ID: <4867B105.7070208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 17:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCzJR-0005pA-8e
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 17:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbYF2P6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 11:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYF2P6F
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 11:58:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:39394 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbYF2P6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 11:58:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so595515fgg.17
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=bNqrVALj6+NIRSsBIeBlxe5t7isFrsa/eMe0S5MjiW4=;
        b=HytCWnmdb6RC+TaBoUKmqBjrDmxKfuhfgeNqQ1hLX3RcEtLY8uNsmYoddw322In+xU
         HVOe07wLHgDtdd/01H69TCbAatt9VvEmgutY8xd1/PUPJ8rgawidi/lP9GS4wd+ezqzO
         TngN6r1bEySRNBsCZHMhHIeviDGhVONJjJjGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:from;
        b=bllSXR4F0xsSLUkBeqVFG4tw7KmE/goIf0WDrEb9n642XopB2ntlWC3SfKcI28zjmJ
         MiR6E6Il1LI7idbxCHPQqJw+aictc3m3jdPAQj9Mk3em4/Zu/ECrOEKlLsGKTLMbNHuX
         t+U22uPC6HOh4XUcHzOiQzgpNu5+T5+fhqKcc=
Received: by 10.86.60.15 with SMTP id i15mr3065653fga.8.1214755081173;
        Sun, 29 Jun 2008 08:58:01 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.203.119])
        by mx.google.com with ESMTPS id e11sm7084489fga.4.2008.06.29.08.57.58
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 08:58:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86811>

I'm trying to get the diff of a merge ("git diff master^1 master") with 
gitk and gitweb, but both of them only show empty diffs (you can try 
yourself using the test script below).

Gitk doesn't seem to allow me to view the merge diff at all.

Gitweb only shows "Trivial merge" in the commitdiff view.  In the commit 
view, I can get the merge diff I want by clicking the "diff" link behind 
the first parent.

Why is this a "trivial merge", and what's the reason for gitweb not 
displaying the diff to the first parent in the commitdiff view?  I'm 
kinda confused here.


===== Graph: =====

*   master      merge mybranch into master
|\
| * mybranch    change file2 on mybranch
| * mybranch~1  change file2 on mybranch
* | master~1    change file1 on master
* | master~2    change file1 on master
|/
* mybranch~2    initial commit


===== Script to set up the repository: =====

rm -rf test-repo.tmp
mkdir test-repo.tmp
cd test-repo.tmp

git init

echo File 1 > file1
echo File 2 > file2
git add file1 file2
git commit -m 'initial commit'

git branch mybranch

echo Addition to file 1 >> file1
git commit -a -m 'change file1 on master'
echo Another addition to file 1 >> file1
git commit -a -m 'change file1 on master'

git checkout mybranch
echo Addition to file 2 >> file2
git commit -a -m 'change file2 on mybranch'
echo Another addition to file 2 >> file2
git commit -a -m 'change file2 on mybranch'

git checkout master
git merge 'merge mybranch into master' HEAD mybranch
