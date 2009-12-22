From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Where did Documentation/perf_counter disappear from linux-2.6-tip.git
 ?
Date: Tue, 22 Dec 2009 11:04:21 +0100
Message-ID: <4B3099A5.6040808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 11:05:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN1bu-0000A0-8j
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 11:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbZLVKEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 05:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbZLVKEZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 05:04:25 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60150 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbZLVKEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 05:04:24 -0500
Received: by bwz27 with SMTP id 27so3997826bwz.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 02:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=8TJq5G+oskl1hrEXvDz1oQoMk2alL1A9UitrAa2w3cA=;
        b=TamAG7baMd/XyfOsJ8QyKk5U4UaZxwgGVodZ63dV/+Q8g8Hhl9Ksa4h0LO6BQr1A3x
         /xl4qo0JhisIF2+oTPVy6D0ZrA3AZLu12c5LCIzBEDM9MX3aze29Zt1FUUQK+cWDi8h+
         D3rfc3vubGAesHPZwl/PbIG637lc5HoUOUKrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=HEtUFvdDDe+dlYy1geAWvvxGNC4CV7HQjjk0Ug0W4KGs3IprsAwvkTB+NJXoxBGCWE
         6s+Bit/ORIsZaGX5B5hisfl4ozKRrrYmOCidlKHj4mPvtH6kXPzlL6QdKzmTDolAp+yI
         MkZLQkfhah7JsObTj5PLofwX7eUINGIzHCFCE=
Received: by 10.204.156.210 with SMTP id y18mr4518452bkw.37.1261476262424;
        Tue, 22 Dec 2009 02:04:22 -0800 (PST)
Received: from calvin.caurea.org (gw.ptr-62-65-141-13.customer.ch.netstream.com [62.65.141.13])
        by mx.google.com with ESMTPS id 16sm1838039bwz.3.2009.12.22.02.04.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 22 Dec 2009 02:04:21 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.3a1pre) Gecko/20091222 Lightning/1.1a1pre Shredder/3.1a1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135576>

  $ git --version
git version 1.6.6.rc4

# Documentation/perf_counter is missing from the master branch, so first 
let's find
# out what the last commit was that touched that subdirectory:
$ git log --all -1 -- Documentation/perf_counter
commit 436224a6d8bb3e29fe0cc18122f8d1f593da67b8
Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date:   Tue Jun 2 21:02:36 2009 +0200
...
M       Documentation/perf_counter/builtin-report.c

# Great, let's look in which branch that commit is
$ git branch --contains 436224a6d8bb3e29fe0cc18122f8d1f593da67b8
* master

# So, let's look at the log of master and limit it to that subdirectory:
$ git log master -- Documentation/perf_counter
$

# Damn, that doesn't make any sense. In commit 43622 there were files in 
that subdirectory, in master they have gone missing and yet log doesn't 
show any commit touching that subdirectory?
# Let's try something different:
$ git log --diff-filter=D --name-status --all -- Documentation/perf_counter
...

# Ah, now we're getting somewhere, but still no sight of a commit which 
removed for example Documentation/perf_counter/.gitignore
# I'm sure I'm probably just missing a tiny little switch for git-log. I 
also tried other combination of name-status, diff-filter etc, but soon 
after gave up.

tom
